from django.db import models
from cusine_app.models import Cusine

class DishType(models.Model):
    dish_typename = models.CharField(max_length=255,unique=True)
    dish_type_added = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = 'Dish Type'
        verbose_name_plural = 'Dish Types'

    def __str__(self):
        return self.dish_typename

class DishModel(models.Model):
    dish_id = models.AutoField(primary_key=True,unique=True)
    cusine_id = models.ForeignKey(Cusine,on_delete=models.CASCADE)
    dish_name = models.CharField(max_length=255,unique=True)
    dish_image = models.ImageField(upload_to="uploads/",blank=False)
    dish_type = models.ForeignKey(DishType,on_delete=models.CASCADE)
    dish_description = models.TextField(max_length=255,blank=False,serialize=True)
    dish_price = models.DecimalField(decimal_places=2,max_digits=20)
    date_added = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "Dish"
        verbose_name_plural = "Dishes"

    def __str__(self):
        return self.dish_name

