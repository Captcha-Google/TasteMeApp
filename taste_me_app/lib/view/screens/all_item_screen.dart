import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taste_me_app/constants/constants.dart';
import 'package:taste_me_app/controller/meal.dart';
import 'package:taste_me_app/models/dish.dart';
import 'package:taste_me_app/view/screens/view_item.dart';
import 'package:taste_me_app/view/screens/view_orders_screen.dart';
import 'package:taste_me_app/view/screens/utils/customAppBar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<DishModel> dish = [];

  @override
  void initState() {
    super.initState();
    fetchDish();
  }

  @override
  Widget build(BuildContext context) {
    if (dish.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFB70404),
          ),
        ),
      );
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(title: "Available Meals"),
      backgroundColor: Colors.white,
      body: dish.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () => Future.delayed(
                const Duration(milliseconds: 3000),
                () {
                  setState(() {
                    fetchDish();
                  });
                },
              ),
              color: const Color(0xFFB70404),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20.0),
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Available Meals",
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.cartPlus,
                          size: 22,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 4.0),
                    width: width,
                    height: height,
                    child: GridView.count(
                      crossAxisCount: 2,
                      primary: true,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.8,
                      children: <Widget>[
                        for (int i = 0; i < dish.length; i++)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewItem(dish: dish[i]),
                                ),
                              );
                            },
                            child: _DishCard(
                              dish: dish[i],
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/image_5.svg",
                        height: 260,
                      ),
                    ],
                  ),
                  const Text(
                    "Empty Meals",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFFB70404),
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewOrders(),
            ),
          );
        },
        backgroundColor: const Color(0xFFB70404),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20), // Adjust the radius as needed
          ),
        ),
        child: const FaIcon(
          FontAwesomeIcons.cartShopping,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  void fetchDish() async {
    final response = await MealController.fetchDish();

    setState(() {
      dish = response;
    });
  }
}

class _DishCard extends StatelessWidget {
  final DishModel dish;

  const _DishCard({required this.dish});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15, bottom: 5),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        elevation: 1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                SizedBox(
                  width: 150,
                  height: MediaQuery.of(context).size.height * 0.50 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      key: UniqueKey(),
                      imageUrl: "$domain${dish.dishImage}",
                      height: 130,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(40),
                        child: CircularProgressIndicator(
                          color: Color(0xFFB70404),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFB70404),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          "₱ ${dish.dishPrice}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 2,
                left: 10,
              ),
              child: Text(
                dish.dishName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 2,
                left: 10,
              ),
              child: Text(
                dish.type.dishType,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 2,
                      left: 10,
                    ),
                    child: Text(
                      dish.cusineName.cusineName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 5,
                    child: Icon(
                      Icons.star,
                      size: 16,
                      color: Color(0xFFB70404),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
