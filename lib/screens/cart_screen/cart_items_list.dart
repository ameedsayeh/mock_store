import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mock_store/models/cart.dart';
import 'package:mock_store/models/store_item.dart';
import 'package:mock_store/services/store_service.dart';

class CartItemsList extends StatefulWidget {
  @override
  _CartItemsListState createState() => _CartItemsListState();
}

class _CartItemsListState extends State<CartItemsList> {
  Cart _cart;

  @override
  void initState() {
    super.initState();

    _fetchCart();
  }

  _fetchCart() async {
    _cart = await StoreService().getCartItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _cart != null ? _cart.products.length : 0,
        itemBuilder: (context, index) => FutureBuilder(
          future: _fetchItem(_cart.products[index].productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final item = snapshot.data as StoreItem;

              return ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: SizedBox(
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl: item.imageURL,
                    placeholder: (context, url) => Text("loading image"),
                    fadeInDuration: Duration(),
                    fit: BoxFit.contain,
                  ),
                ),
                title: Text(
                  item.title,
                  maxLines: 2,
                ),
                subtitle: Text(
                  item.description,
                  maxLines: 4,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            } else {
              return ListTile(
                title: Text("Cannot Fetch Item"),
              );
            }
          },
        ),
      ),
    );
  }

  _fetchItem(productID) async {
    return StoreService().getItem(productID);
  }
}
