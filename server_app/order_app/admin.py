from django.contrib import admin
from .models import Order,OrderInformation
from csvexport.actions import csvexport


class OrderAdmin(admin.ModelAdmin):
    list_display = ("order_dishname","order_quantity","order_status",)
    list_filter = ("order_quantity",)
    actions = [csvexport]


class OrderInformationAdmin(admin.ModelAdmin):
    list_display = ("customer_name","table","grand_total","payment_mode","payment_status",)
    list_filter = ("payment_mode","payment_status","table","date_order",)
    actions = [csvexport]

admin.site.register(Order, OrderAdmin)
admin.site.register(OrderInformation, OrderInformationAdmin)