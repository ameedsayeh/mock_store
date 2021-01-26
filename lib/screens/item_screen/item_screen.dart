import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mock_store/models/store_item.dart';
import 'package:mock_store/extensions/string_extensions.dart';
import 'package:mock_store/screens/item_screen/components/add_to_cart_sheet.dart';

class ItemScreen extends StatelessWidget {
  final StoreItem item;

  const ItemScreen({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/back.svg",
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(3.0),
                child: SvgPicture.asset(
                  "assets/icons/heart.svg",
                  color: Colors.black87,
                ),
              ),
              onPressed: () {}),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              height: MediaQuery.of(context).size.height * 2 / 5,
              child: Hero(
                tag: "image${item.id}",
                child: CachedNetworkImage(
                  imageUrl: item.imageURL,
                  placeholder: (context, url) => Text("loading image"),
                  fadeInDuration: Duration(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                item.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                item.category.capitalize(),
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Description",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "\$" + item.price.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Container(
              height: 80,
              color: Colors.black,
              child: Center(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => AddToCartSheet(
                            item: item,
                          ),
                        );
                      },
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
