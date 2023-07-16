import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:intl/intl.dart';
import 'package:taste_me_app/constants/constants.dart';
import 'package:taste_me_app/controller/order.dart';
import 'package:taste_me_app/models/dish.dart';

class ViewItem extends StatefulWidget {
  final DishModel dish;

  const ViewItem({
    super.key,
    required this.dish,
  });

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  @override
  Widget build(BuildContext context) {
    DateTime parsedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS")
        .parse(widget.dish.dishDateCreated);
    String dateTime = DateFormat.jm().format(parsedDateTime);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.dish.dishName,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: const Color.fromRGBO(225, 87, 34, .9),
            expandedHeight: 240,
            flexibleSpace: FlexibleSpaceBar(
              background: Builder(
                builder: (context) {
                  return CachedNetworkImage(
                    key: UniqueKey(),
                    imageUrl: "$domain${widget.dish.dishImage}",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  );
                },
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(
                    0.25,
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(
                  0.25,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.anglesDown,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(
                    0.25,
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.check,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 4.0,
                      ),
                      child: Text(
                        dateTime,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                        vertical: 2.0,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 4.0,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFB70404),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Text(
                        "₱ ${widget.dish.dishPrice}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    bottom: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ExpandableText(
                    widget.dish.dishDescription,
                    expandText: 'show more',
                    collapseText: 'show less',
                    animation: true,
                    animationDuration: const Duration(milliseconds: 2000),
                    expanded: false,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    maxLines: 7,
                    linkColor: const Color(0xFFB70404),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    bottom: 10.0,
                    top: 15.0,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Dish",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    bottom: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.dish.cusineName.cusineName,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    bottom: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Cusine",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    bottom: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.dish.type.dishType,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            showDragHandle: true,
            isScrollControlled: false,
            isDismissible: false,
            useSafeArea: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(35), // Adjust the radius as needed
              ),
            ),
            context: context,
            builder: (BuildContext context) {
              int quantity = 1;

              void addOrder(int quantity, int dishId) async {
                var data = {
                  "order_dishname": dishId,
                  "order_quantity": quantity,
                  "order_status": "Pending"
                };
                try {
                  var res = await OrderController().addOrder(data);
                  var message = json.decode(res.body);

                  if (message['message'] == 'success') {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        showCloseIcon: true,
                        closeIconColor: Colors.white,
                        backgroundColor: Color(0xFFB70404),
                        duration: Duration(milliseconds: 6000),
                        content: Text(
                          "You have successfully added customer order.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  debugPrint("Error: $e");
                }
              }

              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: SizedBox(
                            height: 102,
                            // decoration: BoxDecoration(color: Colors.grey),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          "$domain${widget.dish.dishImage}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 2.0,
                                    bottom: 5.0,
                                    left: 25.0,
                                    right: 25.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 110,
                                        child: Text(
                                          widget.dish.dishName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 3.0,
                                          vertical: 2.0,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFB70404),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                        ),
                                        child: Text(
                                          "₱ ${widget.dish.dishPrice}",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (quantity > 1) {
                                                  quantity--;
                                                }
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 23,
                                                padding:
                                                    const EdgeInsets.all(3),
                                                margin: const EdgeInsets.only(
                                                  right: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0xFFB70404),
                                                ),
                                                child: const Center(
                                                  child: FaIcon(
                                                    FontAwesomeIcons.minus,
                                                    color: Colors.white,
                                                    size: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "$quantity",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                quantity++;
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 23,
                                                padding:
                                                    const EdgeInsets.all(3),
                                                margin: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0xFFB70404),
                                                ),
                                                child: const FaIcon(
                                                  FontAwesomeIcons.plus,
                                                  color: Colors.white,
                                                  size: 17,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            addOrder(quantity, widget.dish.id);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              padding: const EdgeInsets.all(13.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFB70404),
                              ),
                              width: double.infinity,
                              child: const Center(
                                child: Text(
                                  "Add to Order",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MaterialButton(
                          padding: const EdgeInsets.all(13.0),
                          minWidth: double.infinity,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(
                              color: Color(0xFFB70404),
                              width: 2,
                            ),
                          ),
                          child: const Text(
                            'Abort this order',
                            style: TextStyle(
                              color: Color(0xFFB70404),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
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
          FontAwesomeIcons.plus,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
