import 'package:flutter/material.dart';
import 'package:mock_store/models/cart.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
