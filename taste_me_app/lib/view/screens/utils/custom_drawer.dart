import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taste_me_app/view/screens/all_item_screen.dart';
import 'package:taste_me_app/view/screens/login_screen.dart';
import 'package:taste_me_app/view/screens/profile.dart';
import 'package:taste_me_app/view/screens/view_orders_screen.dart';
import 'package:taste_me_app/controller/logout.dart';

class DrawerNavigationWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  DrawerNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Material(
        color: const Color(0xFFB70404),
        child: ListView(
          padding: padding,
          children: [
            const SizedBox(
              height: 50,
            ),
            buildMenuItem(
              name: "Home",
              icon: Icons.home_outlined,
              onClicked: () => {Navigator.pop(context)},
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuItem(
              name: "Menu",
              icon: Icons.menu_book_outlined,
              onClicked: () => {
                Navigator.pop(context),
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrderScreen(),
                  ),
                )
              },
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuItem(
              name: "Orders",
              icon: Icons.list_alt_outlined,
              onClicked: () => {
                Navigator.pop(context),
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ViewOrders(),
                  ),
                )
              },
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuItem(
              name: "Sync to database",
              icon: Icons.sync,
              onClicked: () => {
                Navigator.pop(context),
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    showCloseIcon: true,
                    closeIconColor: Colors.white,
                    backgroundColor: Color(0xFFB70404),
                    duration: Duration(milliseconds: 7000),
                    content: Text(
                      "Please wait syncing to the database.",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    showCloseIcon: true,
                    closeIconColor: Colors.white,
                    backgroundColor: Color(0xFFB70404),
                    duration: Duration(milliseconds: 7000),
                    content: Text(
                      "Synced successfully..",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuItem(
              name: "Profile",
              icon: Icons.account_circle_outlined,
              onClicked: () => {
                Navigator.pop(context),
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyProfile(),
                  ),
                )
              },
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuItem(
              name: "Sign out",
              icon: Icons.logout,
              onClicked: () async {
                Navigator.pop(context);
                var authTokenBox = await Hive.openBox('authTokenBox');
                authTokenBox.clear();

                LogoutController().logout();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String name,
    required IconData icon,
    required VoidCallback onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white54;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: color,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
