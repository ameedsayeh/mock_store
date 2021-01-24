import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mock_store/models/store_item.dart';
import 'package:mock_store/services/store_service.dart';

import 'item_card.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({Key key}) : super(key: key);
  @override
  ItemsListState createState() => ItemsListState();
}

class ItemsListState extends State<ItemsList> {
  Future<List<StoreItem>> _itemsFuture;
  List<StoreItem> _items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            _items = snapshot.data;

            return buildGridView();
          } else {
            return buildTryAgain();
          }
        },
      ),
    );
  }

  GridView buildGridView() {
    return GridView.count(
      padding:
          EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0, bottom: 24.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      childAspectRatio: 0.75,
      crossAxisCount: 2,
      children: _items.map((e) => _itemBuilder(e)).toList(),
    );
  }

  Center buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.black87),
      ),
    );
  }

  SafeArea buildTryAgain() {
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

  Widget _itemBuilder(StoreItem item) {
    return ItemCard(
      item: item,
    );
  }

  @override
  void initState() {
    super.initState();

    fetchItems();
  }

  fetchItems() {
    _itemsFuture = StoreService().getItems();
    setState(() {});
  }

  fetchCategoryItems(String category) {
    _itemsFuture = StoreService().getCategoryItems(category);
    setState(() {});
  }
}
