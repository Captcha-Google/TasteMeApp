from django.contrib import admin
from .models import Cusine
from django.utils.html import format_html
from django.utils.safestring import mark_safe


class CusineAdmin(admin.ModelAdmin):
    list_display = ('cusine_name', 'date_added')


admin.site.register(Cusine, CusineAdmin)
