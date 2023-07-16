from django.db import models
from table_app.models import Table
from paymentmode_app.models import Payment
from dish_app.models import DishModel

class Order(models.Model):
    STATUS = (
        ('Checkout','Checkout'),
        ('Pending','Pending'),
    )
    order_id = models.AutoField(primary_key=True)
    order_dishname = models.ForeignKey(DishModel,on_delete=models.CASCADE)
    order_quantity = models.IntegerField(default=0)
    order_status = models.TextField(choices=STATUS,default=STATUS[1])

    class Meta:
        verbose_name = "Customer Order"
        verbose_name_plural = "Customer Orders"

    def __str__(self):
        return self.order_dishname.dish_name
    


class OrderInformation(models.Model):

    STATUS = (
        ('Paid','Paid'),
        ('Unpaid','Unpaid')
    )
    
    order_info_id = models.ForeignKey(Order,on_delete=models.CASCADE)
    customer_name = models.CharField(max_length=255,blank=False)
    table = models.ForeignKey(Table, on_delete=models.CASCADE)
    payment_status = models.CharField(max_length=10, choices=STATUS)
    grand_total = models.DecimalField(max_digits=10,decimal_places=2)
    payment_mode = models.ForeignKey(Payment, on_delete=models.CASCADE)
    date_order = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "Order Information"
        verbose_name_plural = "Order Informations"

    def __str__(self):
        return str(self.customer_name + "'s order information")






