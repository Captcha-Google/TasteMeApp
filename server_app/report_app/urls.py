from django.urls import path
from . import views
from django.urls import re_path
from wkhtmltopdf.views import PDFTemplateView

import random

def generate_uuid_identifier(length=8):
    min_value = 10 ** (length - 1)
    max_value = (10 ** length) - 1
    numeric_identifier = random.randint(min_value, max_value)
    return numeric_identifier

numeric_identifier = generate_uuid_identifier(8)

urlpatterns = [
    path("",views.dashboard, name="dashboard"),
    path("orders/",views.orders, name="todays_order"),
    path("logout_me/",views.logout_view, name="logout_me"),
    path("customers/",views.customers, name="customers"),
    path("view-receipt/<str:name>",views.view_receipt, name="view_receipt"),
    path("generate-receipt/<str:name>",views.generate_pdf_receipt, name="generate-receipt"),
]