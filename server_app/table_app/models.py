from django.db import models

class Table(models.Model):

    STATUS_CHOICES = (
        ('Vacant', 'Vacant'),
        ('Occupied', 'Occupied'),
    )
     
    table_name = models.CharField(max_length=255,unique=True,blank=False)
    table_status = models.CharField(max_length=10,choices=STATUS_CHOICES,default="Vacant",blank=True)
    table_date_added = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "Dining Table"
        verbose_name_plural = "Dining Tables"

    def __str__(self):
        return self.table_name
    
