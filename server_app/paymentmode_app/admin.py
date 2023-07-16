from django.contrib import admin
from .models import Payment

class PaymentModeAdmin(admin.ModelAdmin):
    list_display = ("payment_mode",)
    list_filter = ("payment_mode",)

admin.site.register(Payment,PaymentModeAdmin)


