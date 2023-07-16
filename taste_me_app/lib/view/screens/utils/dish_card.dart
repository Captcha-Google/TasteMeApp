import 'package:flutter/material.dart';
import 'package:taste_me_app/models/dish.dart';
import 'package:taste_me_app/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DishCard extends StatelessWidget {
  final DishModel dish;

  const DishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 15,
        bottom: 5,
        top: 5,
      ),
      child: Material(
        // color: const Color(0xFFB70404).withOpacity(0.80),
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
                  width: 125,
                  height: MediaQuery.of(context).size.height * 0.60 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      key: UniqueKey(),
                      imageUrl: "$domain${dish.dishImage}",
                      height: 135,
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
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                      right: 10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                        vertical: 2.0,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB70404),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        "₱ ${dish.dishPrice}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 1,
                  right: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.star,
                      size: 16,
                      color: Color(0xFFB70404),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  left: 10,
                ),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  dish.dishName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 4,
                left: 10,
              ),
              child: Text(
                dish.type.dishType,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 4,
                left: 10,
              ),
              child: Text(
                dish.cusineName.cusineName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
