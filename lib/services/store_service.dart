import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mock_store/models/store_category.dart';
import 'package:mock_store/models/store_item.dart';

class StoreService {
  StoreService._privateConstructor();

  static final _instance = StoreService._privateConstructor();

  factory StoreService() {
    return _instance;
  }

  final String _apiBaseURL = "https://fakestoreapi.com";

  Future<List<StoreCategory>> getCategories() async {
    final String endpointURL = _apiBaseURL + "/products/categories";

    final response = await http.get(endpointURL);

    if (response.statusCode == 200) {
      Iterable iter = json.decode(response.body);

      return List<StoreCategory>.from(
          iter.map((obj) => StoreCategory(title: obj)));
    } else {
      return [];
    }
  }

  Future<List<StoreItem>> getItems() async {
    final String endpointURL = _apiBaseURL + "/products";

    final response = await http.get(endpointURL);

    if (response.statusCode == 200) {
      Iterable iter = json.decode(response.body);

      return List<StoreItem>.from(iter.map((obj) => StoreItem.fromJson(obj)));
    } else {
      return [];
    }
  }

  Future<List<StoreItem>> getCategoryItems(String category) async {
    final String endpointURL = _apiBaseURL + "/products/category/$category";

    final response = await http.get(endpointURL);

    if (response.statusCode == 200) {
      Iterable iter = json.decode(response.body);

      return List<StoreItem>.from(iter.map((obj) => StoreItem.fromJson(obj)));
    } else {
      return [];
    }
  }
}
