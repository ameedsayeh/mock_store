import 'package:flutter/material.dart';
import 'package:mock_store/models/store_category.dart';
import 'package:mock_store/services/store_service.dart';
import 'package:mock_store/extensions/string_extensions.dart';

class CategoriesList extends StatefulWidget {
  final Function didSelectItem;
  const CategoriesList({Key key, this.didSelectItem}) : super(key: key);
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List<StoreCategory> _categories = [
    StoreCategory(title: "all"),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                  right: 16.0, left: 16.0, top: 12.0, bottom: 0),
              scrollDirection: Axis.horizontal,
              itemCount: _categories != null ? _categories.length : 0,
              itemBuilder: (context, index) =>
                  categoryItemBuilder(context, index),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _fetchCategories();
  }

  _fetchCategories() async {
    _categories.addAll(await StoreService().getCategories());
    setState(() {});
  }

  categoryItemBuilder(context, int index) {
    return GestureDetector(
      onTap: () {
        _selectedIndex = index;
        if (_selectedIndex == 0) {
          widget.didSelectItem(null);
        } else {
          widget.didSelectItem(_categories[index]);
        }
        setState(() {});
      },
      child: Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              _categories[index].title.capitalize(),
              style: TextStyle(
                  color:
                      index == _selectedIndex ? Colors.black87 : Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 2.0),
              width: 20.0,
              height: 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  color: index == _selectedIndex
                      ? Colors.black
                      : Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }
}
