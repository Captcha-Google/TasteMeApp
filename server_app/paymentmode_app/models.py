from django.db import models

class Payment(models.Model):
    payment_mode = models.CharField(max_length=5)
    payment_mode_date_added = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "Payment Mode"
        verbose_name_plural = "Payment Mode"

    def __str__ (self):
        return self.payment_mode
