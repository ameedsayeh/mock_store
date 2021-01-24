import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mock_store/screens/store_screen/components/categories_list.dart';
import 'package:mock_store/screens/store_screen/components/items_list.dart';

class StoreScreen extends StatelessWidget {
  final GlobalKey<ItemsListState> _itemListStateKey = GlobalKey();

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
            onPressed: null),
        actions: [
          IconButton(
              icon: SvgPicture.asset(
                "assets/icons/search.svg",
                color: Colors.black87,
              ),
              onPressed: null),
          IconButton(
              icon: SvgPicture.asset(
                "assets/icons/cart.svg",
                color: Colors.black87,
              ),
              onPressed: null),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Store Categories",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            CategoriesList(
              didSelectItem: _updateShownItemsFor,
            ),
            ItemsList(key: _itemListStateKey),
          ],
        ),
      ),
    );
  }

  _updateShownItemsFor(category) {
    if (category == null) {
      _itemListStateKey.currentState.fetchItems();
    } else {
      _itemListStateKey.currentState.fetchCategoryItems(category.title);
    }
  }
}
