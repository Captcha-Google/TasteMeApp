from django.contrib import admin
from .models import DishModel,DishType


class DishAdmin(admin.ModelAdmin):
    list_display = ('dish_name','dish_type','dish_price')


class DishTypeAdmin(admin.ModelAdmin):
    list_display = ('dish_typename','dish_type_added')


admin.site.register(DishType,DishTypeAdmin)
admin.site.register(DishModel, DishAdmin)
