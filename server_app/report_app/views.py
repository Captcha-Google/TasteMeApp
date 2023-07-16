from django.shortcuts import render,redirect
from django.http import HttpResponse, HttpResponseRedirect
from cusine_app.models import Cusine
from dish_app.models import DishModel
from order_app.models import Order,OrderInformation
from table_app.models import Table
from django.utils import timezone
from datetime import timedelta
from django.db.models import Sum
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout
from datetime import datetime
import random
import string
from decimal import Decimal
from wkhtmltopdf.views import render_pdf_from_template

@login_required(login_url="/admin")
def dashboard(request):
    count_cusine = Cusine.objects.count()
    count_dish = DishModel.objects.count()
    count_order = Order.objects.count()
    count_table = Table.objects.count()
    get_orders = OrderInformation.objects.all().order_by('payment_status')
    get_cusines = Cusine.objects.all()


    today_sales = OrderInformation.objects.filter(date_order__date=timezone.now().date())
    today_sales_amount_sum = today_sales.aggregate(total_amount=Sum('grand_total'))['total_amount']

    yesterday = timezone.now().date() - timedelta(days=1)
    yesterday_sales = OrderInformation.objects.filter(date_order__date=yesterday)
    yesterday_sales_amount_sum = yesterday_sales.aggregate(total_amount=Sum('grand_total'))['total_amount']

    last_week_start = timezone.now().date() - timedelta(days=7)
    last_week_end = timezone.now().date() - timedelta(days=1)
    last_week_sales = OrderInformation.objects.filter(date_order__date__range=[last_week_start, last_week_end])
    last_week_sales_amount_sum = last_week_sales.aggregate(total_amount=Sum('grand_total'))['total_amount']

    last_month_start = timezone.now().date().replace(day=1) - timedelta(days=1)
    last_month_end = last_month_start.replace(day=1)
    last_month_sales = OrderInformation.objects.filter(date_order__date__range=[last_month_end, last_month_start])
    last_month_sales_amount_sum = last_month_sales.aggregate(total_amount=Sum('grand_total'))['total_amount']

    context = {
        'total_cusines':count_cusine,
        'total_dish':count_dish,
        'total_orders':count_order,
        'total_tables':count_table,
        'today_sale':today_sales_amount_sum,
        'yesterday_sale':yesterday_sales_amount_sum,
        'last_week_sale':last_week_sales_amount_sum,
        'last_month_sale':last_month_sales_amount_sum,
        'orders': get_orders,
        'cusines': get_cusines,
    }

    return render(request,"dashboard.html",context)

@login_required(login_url="/admin")
def orders(request):
    today = timezone.now().date()
    get_today_orders = OrderInformation.objects.filter(date_order__date=today).all().order_by('customer_name')

    context = {
        'orders': get_today_orders,
    }

    return render(request,"orders.html",context)

def logout_view(request):
  logout(request)
  return HttpResponseRedirect('/admin')

@login_required(login_url="/admin")
def customers(request):
    from django.db.models import Count

    get_customers = OrderInformation.objects.values('customer_name','payment_mode').annotate(order_count=Count('order_info_id'))

    context = {
        'customers': get_customers,
    }

    return render(request,"list_customer.html",context)

def calculate_vat(amount, vat_rate):
    vat_amount = float(amount) * (vat_rate / 100)
    return round(vat_amount,2) 

def sum(val1, val2):
    sum = Decimal(val1) + Decimal(val2)
    return sum    

@login_required(login_url="/admin")
def view_receipt(request,name):
    if request.method == "GET":
        customer_name = name

        orders = OrderInformation.objects.filter(customer_name=customer_name)
        total_amount = OrderInformation.objects.filter(customer_name=customer_name).aggregate(total_amount_to_be_paid=Sum('grand_total'))
        amount_to_pay = total_amount['total_amount_to_be_paid']


        # current date for receipt 
        current_date = datetime.now()
        formatted_date = current_date.strftime("%m/%d/%Y")

        # to generate a random characters for receipt no. and pass it on the context
        random_number = ''.join(random.choices(string.digits, k=7))
        random_string = ''.join(random.choices(string.ascii_uppercase, k=3))
        vat = calculate_vat(amount_to_pay,12)

        context = {
            'customer_orders':orders,
            'customer_name':customer_name,
            'date': formatted_date,
            'receipt_number': f"{random_number}{random_string}",
            'vat_rate': vat,
            'total_amount': total_amount,
            'grand_total': round(Decimal(sum(amount_to_pay,vat)),2),
        }


    return render(request, "view_receipt.html",context)

@login_required(login_url="/admin")
def generate_pdf_receipt(request,name):
    if request.method == "GET":
        customer_name = name

        orders = OrderInformation.objects.filter(customer_name=customer_name)
        
        total_amount = OrderInformation.objects.filter(customer_name=customer_name).aggregate(total_amount_to_be_paid=Sum('grand_total'))
        amount_to_pay = total_amount['total_amount_to_be_paid']


        # current date for receipt 
        current_date = datetime.now()
        formatted_date = current_date.strftime("%m/%d/%Y")

        # to generate a random characters for receipt no. and pass it on the context
        random_number = ''.join(random.choices(string.digits, k=7))
        random_string = ''.join(random.choices(string.ascii_uppercase, k=3))
        vat = calculate_vat(amount_to_pay,12)

        context = {
            'customer_orders':orders,
            'customer_name':customer_name,
            'date': formatted_date,
            'receipt_number': f"{random_number}{random_string}",
            'vat_rate': vat,
            'total_amount': total_amount,
            'grand_total': round(Decimal(sum(amount_to_pay,vat)),2),
        }

        footer_template = 'pdf_template/footer_template.html'
        header_template = 'pdf_template/header_template.html'

        pdf = render_pdf_from_template(input_template='pdf_template/template.html',header_template=header_template,footer_template=footer_template,context=context)

        if pdf:
            response = HttpResponse(content_type='application/pdf')

            response['Content-Disposition'] = 'filename="generated_pdf.pdf"'

            response.write(pdf)

            return response

        return HttpResponse('PDF generation failed.')