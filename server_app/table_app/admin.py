from django.contrib import admin
from .models import Table

class TableAdmin(admin.ModelAdmin):
    list_display = ("table_name","table_status","table_date_added")

admin.site.register(Table,TableAdmin)
