import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mock_store/models/store_item.dart';
import 'package:mock_store/services/store_service.dart';

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
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.green),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            _items = snapshot.data;

            return GridView.count(
              padding: EdgeInsets.only(
                  right: 16.0, left: 16.0, top: 16.0, bottom: 24.0),
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 0.75,
              crossAxisCount: 2,
              children: _items.map((e) => _itemBuilder(e)).toList(),
            );
          } else {
            return buildTryAgain();
          }
        },
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
              Text("Some error happened, please "),
              InkWell(
                onTap: () {
                  _fetchItems();
                },
                child: Text(
                  "try again",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(StoreItem item) {
    return Container(
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
              child: CachedNetworkImage(
                imageUrl: item.imageURL,
                placeholder: (context, url) => Text("loading image"),
                fadeInDuration: Duration(),
                fit: BoxFit.contain,
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
    );
  }

  @override
  void initState() {
    super.initState();

    _fetchItems();
  }

  _fetchItems() {
    _itemsFuture = StoreService().getItems();
  }
}
