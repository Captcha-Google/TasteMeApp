import 'dart:async';
import 'dart:convert';
import 'package:taste_me_app/controller/payment.dart';
import 'package:taste_me_app/controller/table.dart';
import 'package:flutter/material.dart';
import 'package:taste_me_app/models/orders.dart';
import 'package:taste_me_app/models/table.dart';
import 'package:taste_me_app/models/payment.dart';
import 'package:taste_me_app/view/screens/utils/customAppBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taste_me_app/controller/order.dart';
import 'package:taste_me_app/view/screens/utils/order_card.dart';
import 'package:taste_me_app/view/screens/utils/buildForm.dart';

class ViewOrders extends StatefulWidget {
  const ViewOrders({super.key});

  @override
  State<ViewOrders> createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  List<OrdersModel> orders = [];
  List<PaymentModel> methods = [];
  List<TableModel> tables = [];
  int? tableOption = 1;
  int? paymentMethod = 1;
  TextEditingController customerName = TextEditingController();

  void checkoutOrder(String name, int table, int method) async {
    var response;

    if (orders.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          animation: kAlwaysDismissedAnimation,
          showCloseIcon: true,
          closeIconColor: Colors.white,
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 5000),
          content: Text(
            "No customer order yet!",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          animation: kAlwaysDismissedAnimation,
          showCloseIcon: true,
          closeIconColor: Colors.white,
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 5000),
          content: Text(
            "Customer name should not be empty!",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    } else {
      for (var order in orders) {
        var data = {
          "order_info_id": order.orderId,
          "customer_name": customerName.text.toString(),
          "table": tableOption,
          "payment_mode": paymentMethod,
          "grand_total":
              double.parse(order.dishInfo.dishPrice) * order.orderQuantity,
        };
        response = await OrderController().checkOutOrder(data);
      }

      final responseBody = json.decode(response.body);
      if (responseBody["message"] == "success") {
        customerName.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            animation: kAlwaysDismissedAnimation,
            showCloseIcon: true,
            closeIconColor: Colors.white,
            backgroundColor: Color(0xFFB70404),
            duration: Duration(milliseconds: 5000),
            content: Text(
              "You have successfully added new order",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
        Timer.periodic(Duration(milliseconds: 5000), (timer) {
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
    fetchTable();
    fetchPaymentMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Customer Order"),
      body: Column(
        children: [
          Expanded(
            child: orders.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderCard(
                        order: orders[index],
                      );
                    },
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No customer",
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                            fontSize: 21,
                          ),
                        ),
                        Text(
                          "order yet",
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                            fontSize: 21,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "Customer Information",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 15,
                        ),
                        child: MyBuilderForm(
                          name: "Customer Name",
                          controller: customerName,
                          inputType: TextInputType.name,
                          icon: Icons.people_outline,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 15,
                        ),
                        child: DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 6.0,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFB70404),
                                width: 6.0,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            hintStyle: const TextStyle(
                              color: Color.fromRGBO(225, 87, 34, .9),
                            ),
                            prefixIcon: const Icon(
                              Icons.table_bar_outlined,
                              color: Color(0xFFB70404),
                            ),
                            filled: true,
                            fillColor:
                                const Color(0xFFB70404).withOpacity(0.20),
                          ),
                          value: tableOption,
                          onChanged: (int? newValue) {
                            setState(() {
                              tableOption = newValue!;
                            });
                          },
                          items: [
                            for (int i = 0; i < tables.length; i++)
                              DropdownMenuItem<int>(
                                value: tables[i].id,
                                child: Text('Select ${tables[i].tableName}'),
                              ),
                          ],
                          style: const TextStyle(
                            color: Color(0xFFB70404),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 15,
                        ),
                        child: DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 6.0,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFB70404),
                                width: 6.0,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            hintStyle: const TextStyle(
                              color: Color(0xFFB70404),
                            ),
                            prefixIcon: const Icon(
                              Icons.card_membership_rounded,
                              color: Color(0xFFB70404),
                            ),
                            filled: true,
                            fillColor:
                                const Color(0xFFB70404).withOpacity(0.20),
                          ),
                          value: paymentMethod,
                          onChanged: (int? newValue) {
                            setState(() {
                              paymentMethod = newValue!;
                            });
                          },
                          items: [
                            for (int i = 0; i < methods.length; i++)
                              DropdownMenuItem<int>(
                                value: methods[i].paymentId,
                                child: Text(methods[i].paymentName),
                              ),
                          ],
                          style: const TextStyle(
                            color: Color(0xFFB70404),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkoutOrder(
              customerName.text.toString(), tableOption!, paymentMethod!);
        },
        isExtended: true,
        backgroundColor: const Color(0xFFB70404).withOpacity(
          0.90,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20), // Adjust the radius as needed
          ),
        ),
        tooltip: "Checkout all order",
        child: const FaIcon(
          FontAwesomeIcons.bowlFood,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  void fetchOrders() async {
    final response = await OrderController.fetchOrders();
    setState(() {
      orders = response;
    });
  }

  void fetchTable() async {
    final response = await TableController.fetchTable();
    setState(() {
      tables = response;
    });
  }

  void fetchPaymentMethod() async {
    final response = await PaymentController.fetchPaymentMode();
    setState(() {
      methods = response;
    });
  }
}
