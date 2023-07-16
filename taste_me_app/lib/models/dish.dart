class DishModel {
  final int id;
  final Cusine cusineName;
  final String dishName;
  final String dishImage;
  final DishType type;
  final String dishDescription;
  final String dishPrice;
  final String dishDateCreated;

  DishModel({
    required this.id,
    required this.cusineName,
    required this.dishName,
    required this.dishImage,
    required this.type,
    required this.dishDescription,
    required this.dishPrice,
    required this.dishDateCreated,
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
