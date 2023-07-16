import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:taste_me_app/models/dish.dart';
import 'package:taste_me_app/view/screens/all_item_screen.dart';
import 'package:taste_me_app/view/screens/utils/custom_drawer.dart';
import 'package:taste_me_app/view/screens/utils/info_card.dart';
import 'package:taste_me_app/view/screens/utils/dish_card.dart';
import 'package:taste_me_app/view/screens/view_item.dart';
import 'package:taste_me_app/view/screens/view_orders_screen.dart';
import 'package:taste_me_app/controller/meal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DishModel> dish = [];
  late Timer _timer;

  void checkifLoggedIn() async {
    var authTokenBox = await Hive.openBox('authTokenBox');
    if (authTokenBox.containsKey('isLoggedIn')) {
      var kungNakeLogIn = authTokenBox.get('isLoggedIn') as String;

      if (kungNakeLogIn == 'true') {
        const duration = Duration(milliseconds: 10000);
        _timer = Timer.periodic(duration, (_) {
          fetchDish();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDish();
    checkifLoggedIn();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: DrawerNavigationWidget(),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          const Duration(milliseconds: 3000),
        ),
        color: const Color(0xFFB70404),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: height * 0.19,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                child: Container(
                  color: const Color(0xFFB70404),
                  child: SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "Welcome back, Waiter",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Graciella Waiter Portal",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: Builder(builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                // do something here
                                Scaffold.of(context).openDrawer();
                              },
                              child: Image.asset(
                                "assets/avatar.png",
                              ),
                            );
                          }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.20,
              left: 0,
              right: 0,
              child: SizedBox(
                height: height * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        left: 25,
                        right: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Popular dishes inside",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OrderScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => Future.delayed(
                            const Duration(milliseconds: 3000), () {}),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 17,
                                ),
                                for (int i = 0; i < dish.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ViewItem(
                                            dish: dish[i],
                                          ),
                                        ),
                                      );
                                    },
                                    child: DishCard(
                                      dish: dish[i],
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 8,
                        left: 25,
                        right: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Exciting Information",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InfoCard(
                              image: "assets/pancit.jpg",
                              icon: Icons.star,
                              text: "Checkout more interesting meals",
                            ),
                            InfoCard(
                              image: "assets/burger unlimited.jpg",
                              icon: Icons.star,
                              text: "Checkout more interesting meals",
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
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
        backgroundColor: const Color(0xFFB70404).withOpacity(
          0.80,
        ),
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
