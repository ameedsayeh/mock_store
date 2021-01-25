import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mock_store/models/store_item.dart';

class ItemCard extends StatelessWidget {
  final StoreItem item;
  final Function onTap;
  const ItemCard({Key key, this.item, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                blurRadius: 20.0,
                spreadRadius: 0.0,
                offset: Offset(
                  5.0,
                  5.0,
                ),
              )
            ]),
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 4,
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
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item.price.toString() + " \$",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
