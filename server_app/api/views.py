from datetime import datetime
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from order_app.models import Order,OrderInformation
from dish_app.models import DishModel
from cusine_app.models import Cusine
from table_app.models import Table
from paymentmode_app.models import Payment
from .serializers import OrderSerializer,AvailableDishSerializer,CusineSerializer,TableSerializer,OrderInformationSerializer,CreateOrderSerializer,PaymentSerializer


@api_view(["GET"])
def endpoints(request):
    current_datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    api_urls = [{
        'Check Server': 'api/',
        'Authentication': 'api/auth/',
        'List Order': 'api/order/',
        'Create Order': 'api/order/create/',
        # 'Detail Order': 'api/order/detail/<int:pk>',
        # 'Update Order': 'api/order/update/<int:pk>',
        # 'Delete Order': 'api/order/delete/<int:pk>',
        'List Menu': 'api/menu/',
        'Cusine Menu': 'api/cusine/',
        'List Table': 'api/table/',
        'Available Dish': 'api/dish/',
        'Order Information': 'api/order/info',
    },{
        "Server API":"Server is running in this current time: " + current_datetime,
    }]
    return Response(api_urls,status=status.HTTP_200_OK)

@api_view(["GET"])
def get_orders(request):
    queryset = Order.objects.filter(order_status="Pending")
    order_serializer = OrderSerializer(queryset,many=True)
    return Response({"order":order_serializer.data})

@api_view(["POST", "GET"])
def create_order(request):
    if request.method == "POST":
        serializer = CreateOrderSerializer(data=request.data)
        if serializer.is_valid():

            serializer.save()

            return Response({"message":"success"}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    elif request.method == "GET":
        orders = Order.objects.filter(order_status="Pending")
        serializer = OrderSerializer(orders, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(["GET"])
def detail_order(request,pk):
    try:
        order = Order.objects.get(id=pk)
        serializer = OrderSerializer(order)
        return Response(serializer.data, status=status.HTTP_200_OK)

    except Order.DoesNotExist:
        return Response({'error': 'Order not found.'}, status=status.HTTP_404_NOT_FOUND)
    

@api_view(["DELETE"])
def delete_order(request, pk):
    try:
        order = Order.objects.get(id=pk)
        order.delete()
        return Response({'message': 'success'}, status=status.HTTP_204_NO_CONTENT)
    except Order.DoesNotExist:
        return Response({'message': 'not_found'}, status=status.HTTP_400_BAD_REQUEST)
    
@api_view(["GET","POST"])
def checkout(request):
    if request.method == "POST":
        order_info_serializer = OrderInformationSerializer(data=request.data)
        if order_info_serializer.is_valid():
            order_info_serializer.save()

            # Update order status
            order_id = request.data['order_info_id']
            order = Order.objects.get(order_id=order_id)
            order.order_status = 'Checkout'
            order.save()

            # Update table status
            table_id = request.data['table']
            table = Table.objects.get(id=table_id)
            table.table_status = 'Occupied'
            table.save()

            return Response({"message":"success"},status=status.HTTP_201_CREATED)
        return Response(order_info_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == "GET":
        orders = OrderInformation.objects.all()
        serializer = OrderInformationSerializer(orders, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


####################################MENU###########################################

@api_view(["GET"])
def menus(request):
    # [:10]
    queryset = DishModel.objects.all()
    serializer = AvailableDishSerializer(queryset,many=True)

    return Response({"meal":serializer.data},status=status.HTTP_200_OK)

@api_view(["GET"])
def view_menu(request,pk):
    queryset = DishModel.objects.get(pk=pk)
    serializer = AvailableDishSerializer(queryset,many=False)

    return Response({"meal":serializer.data},status=status.HTTP_200_OK)


####################################CUSINE###########################################

@api_view(["GET"])
def cusines(request):
    queryset = Cusine.objects.all()
    serializer = CusineSerializer(queryset,many=True)

    return Response(serializer.data,status=status.HTTP_200_OK)


####################################TABLE###########################################

@api_view(["GET"])
def tables(request):
    queryset = Table.objects.all()
    serializer = TableSerializer(queryset,many=True)
    return Response({"table":serializer.data},status=status.HTTP_200_OK)


####################################MODE###########################################

@api_view(["GET"])
def modes(request):
    queryset = Payment.objects.all()
    serializer = PaymentSerializer(queryset,many=True)
    return Response({"mode":serializer.data},status=status.HTTP_200_OK)










