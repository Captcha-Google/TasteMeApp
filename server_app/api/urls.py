from django.urls import path,include
from . import views

urlpatterns = [
    path("", views.endpoints, name="orders_endpoints"),
    path("auth/", include("authentication.urls")),
    path("order/", views.get_orders, name="get_orders"),
    path("order/create", views.create_order, name="create_order"),
    # path("order/detail/<int:pk>/", views.detail_order, name="detail_order"),
    # path("order/delete/<int:pk>/", views.delete_order, name="delete_order"),
    path("order/checkout", views.checkout, name="checkout"),
    path("menu/", views.menus, name="menu"),
    path("menu/<int:pk>", views.view_menu, name="view_info"),
    path("cusine/",views.cusines, name="cusines"),
    path("table/",views.tables, name="tables"),
    path("mode/",views.modes, name="mode"),
]

