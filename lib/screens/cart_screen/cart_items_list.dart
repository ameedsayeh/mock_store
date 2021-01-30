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

  Future<Cart> _fetchCart() {
    return StoreService().getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: _fetchCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            _cart = snapshot.data;

            return buildListView();
          } else {
            return buildTryAgain();
          }
        },
      ),
    );
  }

  Widget buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.black87),
      ),
    );
  }

  Widget buildTryAgain() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.report_problem,
            size: 48,
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Some error happened, please try again"),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
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
              trailing: Column(
                children: [
                  Text(
                    "X ${_cart.products[index].quantity}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "${item.price} \$",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
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
    );
  }

  _fetchItem(productID) async {
    return StoreService().getItem(productID);
  }
}
