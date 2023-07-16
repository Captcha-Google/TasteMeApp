class OrdersModel {
  final int orderId;
  final DishInfo dishInfo;
  final Cusine dishCusine;
  final DishType dishType;
  final int orderQuantity;

  OrdersModel({
    required this.orderId,
    required this.dishInfo,
    required this.dishCusine,
    required this.dishType,
    required this.orderQuantity,
  });
}

class DishInfo {
  final int dishId;
  final String dishImage;
  final String dishName;
  final String dishPrice;

  DishInfo({
    required this.dishId,
    required this.dishImage,
    required this.dishName,
    required this.dishPrice,
  });
}

class Cusine {
  final String cusineName;

  Cusine({
    required this.cusineName,
  });
}

class DishType {
  final String dishType;

  DishType({
    required this.dishType,
  });
}
