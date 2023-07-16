from rest_framework import serializers
from order_app.models import Order,OrderInformation
from table_app.models import Table
from paymentmode_app.models import Payment
from cusine_app.models import Cusine
from dish_app.models import DishType,DishModel
from table_app.models import Table


class CusineSerializer(serializers.ModelSerializer):
    cusine_name = serializers.CharField(max_length=255)
    date_added = serializers.DateTimeField(read_only=True)

    class Meta:
        model = Cusine
        fields = ['cusine_name','date_added']

class TableSerializer(serializers.ModelSerializer):

    table_name = serializers.CharField(max_length=255)

    class Meta:
        model = Table
        fields = ["id","table_name","table_status"]

class DishTypeSerializer(serializers.ModelSerializer):
    dish_typename = serializers.CharField(max_length=255)
    dish_type_added = serializers.DateTimeField(read_only=True)

    class Meta:
        model = DishType
        fields = '__all__'

class AvailableDishSerializer(serializers.ModelSerializer):
    dish_id = serializers.IntegerField()
    cusine = CusineSerializer(source='cusine_id', read_only=True)
    dish_name = serializers.CharField(max_length=255)
    dish_image = serializers.ImageField(allow_empty_file=False, use_url=True)
    dish_type = DishTypeSerializer(read_only=True)
    dish_description = serializers.CharField(max_length=255)
    dish_price = serializers.DecimalField(decimal_places=2, max_digits=20)
    date_added = serializers.DateTimeField()

    class Meta:
        model = DishModel
        fields = '__all__'

class OrderInformationSerializer(serializers.ModelSerializer):
    order_info_id = serializers.PrimaryKeyRelatedField(queryset=Order.objects.all())
    customer_name = serializers.CharField(max_length=255)
    table = serializers.PrimaryKeyRelatedField(queryset=Table.objects.all())
    payment_mode = serializers.PrimaryKeyRelatedField(queryset=Payment.objects.all())

    class Meta:
        model = OrderInformation
        fields = ["order_info_id","customer_name","table","payment_mode","grand_total"]

class CreateOrderSerializer(serializers.ModelSerializer):
    order_dishname = serializers.PrimaryKeyRelatedField(queryset=DishModel.objects.all())
    order_quantity = serializers.IntegerField(default=0)
    order_status = serializers.CharField(max_length=50)
    
    class Meta:
        model = Order
        fields = ['order_dishname','order_quantity','order_status']

class OrderSerializer(serializers.ModelSerializer):
    order_dishname = serializers.SerializerMethodField()
    order_quantity = serializers.IntegerField(default=0)
    
    class Meta:
        model = Order
        fields = ['order_id','order_dishname','order_quantity','order_status']

    def get_order_dishname(self, obj):
        dish = obj.order_dishname
        serializer = AvailableDishSerializer(dish)
        return serializer.data

class PaymentSerializer(serializers.ModelSerializer):
    payment_mode = serializers.CharField(max_length=50)
    
    class Meta:
        model = Payment
        fields = ['id','payment_mode']

