import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taste_me_app/controller/login.dart';
import 'package:taste_me_app/view/screens/home_screen.dart';
import 'package:hive/hive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          closeIconColor: Colors.white,
          backgroundColor: Color(0xFFB70404),
          duration: Duration(milliseconds: 5000),
          content: Text(
            "Email & Password fields are required",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    } else {
      var data = {
        'email': email,
        'password': password,
      };

      try {
        var res = await LoginController().login(data);

        var body = json.decode(res.body);

        if (body.containsKey('non_field_errors')) {
          List<dynamic> errorList = body['non_field_errors'];
          String errorMessage = errorList[0];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              animation: kAlwaysDismissedAnimation,
              showCloseIcon: true,
              closeIconColor: Colors.white,
              backgroundColor: const Color(0xFFB70404),
              duration: const Duration(milliseconds: 5000),
              content: Text(
                errorMessage,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        }
        if (body.containsKey('auth_token')) {
          var authTokenBox = await Hive.openBox('authTokenBox');
          await authTokenBox.put('authToken', body['auth_token']);
          await authTokenBox.put('isLoggedIn', 'true');
          if (authTokenBox.containsKey('authToken')) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                animation: kAlwaysDismissedAnimation,
                showCloseIcon: true,
                closeIconColor: Colors.white,
                backgroundColor: Color(0xFFB70404),
                duration: Duration(milliseconds: 5000),
                content: Text(
                  "Redirecting to main page...",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );

            Future.delayed(
              const Duration(milliseconds: 4000),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            animation: kAlwaysDismissedAnimation,
            showCloseIcon: true,
            closeIconColor: Colors.white,
            backgroundColor: const Color(0xFFB70404),
            duration: const Duration(milliseconds: 5000),
            content: Text(
              "Error: $e",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xFFB70404),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Graciella grillery and seafoods restaurant",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color:
                                          Color.fromRGBO(123, 123, 123, 0.298),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        showCursor: true,
                                        controller: emailController,
                                        cursorColor: Colors.grey,
                                        autocorrect: false,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: const InputDecoration(
                                          hintText: "Enter email address",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        showCursor: true,
                                        controller: passwordController,
                                        obscureText: true,
                                        cursorColor: Colors.grey,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: const InputDecoration(
                                          hintText: "Enter your password",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  login(emailController.text.toString(),
                                      passwordController.text.toString());
                                },
                                child: Container(
                                  height: 45,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: const Color(0xFFB70404),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              GestureDetector(
                                onTap: () => {debugPrint("Forgot Password")},
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
