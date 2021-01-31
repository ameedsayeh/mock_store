import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mock_store/models/cart.dart';
import 'package:mock_store/models/store_item.dart';
import 'package:mock_store/screens/item_screen/item_screen.dart';
import 'package:mock_store/services/store_service.dart';
import 'package:shimmer/shimmer.dart';

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
            return buildListTile(item, _cart.products[index].quantity);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return buildShimmerTile();
          } else {
            return ListTile(
              title: Text("Cannot Fetch Item"),
            );
          }
        },
      ),
    );
  }

  Widget buildListTile(StoreItem item, int quantity) {
    return CartItem(
      item: item,
      quantity: quantity,
    );
  }

  ListTile buildShimmerTile() {
    return ListTile(
      contentPadding: EdgeInsets.all(16.0),
      leading: Shimmer.fromColors(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey[300],
        ),
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[350],
      ),
      title: Shimmer.fromColors(
        child: Text("⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️\n⬜️⬜️⬜️⬜️⬜️⬜️⬜️"),
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[350],
      ),
      subtitle: Shimmer.fromColors(
        child: Text("⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️\n⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️"),
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[350],
      ),
    );
  }

  _fetchItem(productID) async {
    return StoreService().getItem(productID);
  }
}

class CartItem extends StatelessWidget {
  final StoreItem item;
  final int quantity;

  const CartItem({Key key, this.item, this.quantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildListTile(context);
  }

  ListTile buildListTile(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemScreen(
              item: item,
            ),
          ),
        );
      },
      contentPadding: EdgeInsets.all(16.0),
      leading: SizedBox(
        width: 100,
        height: 100,
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
      title: Text(
        item.title,
        maxLines: 2,
      ),
      subtitle: Text(
        item.description,
        maxLines: 4,
      ),
    );
  }
}

class QuantitySelector extends StatefulWidget {
  final int initialQuantity;

  const QuantitySelector({Key key, this.initialQuantity}) : super(key: key);
  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int _quantity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Row(
        children: [
          FlatButton(
            onPressed: () {
              if (widget.initialQuantity > 1) {
                setState(() {
                  _quantity -= 1;
                });
              }
            },
            child: Text(
              '-',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: CircleBorder(),
            color: Colors.black87,
          ),
          Center(
            child: Text(
              _quantity.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          FlatButton(
            onPressed: () {
              if (_quantity < 99) {
                setState(() {
                  _quantity += 1;
                });
              }
            },
            child: Text(
              '+',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: CircleBorder(),
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}
