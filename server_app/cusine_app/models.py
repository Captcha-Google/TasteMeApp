from django.db import models
import time

class Cusine(models.Model):
    cusine_name = models.CharField(max_length=255,unique=True)
    date_added = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "Cusine"
        verbose_name_plural = "Cusines"

    def __str__(self):
        return self.cusine_name
    

