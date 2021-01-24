import 'dart:ffi';

class StoreItem {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String imageURL;

  StoreItem({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.imageURL,
  });

  factory StoreItem.fromJson(Map<String, dynamic> map) {
    return StoreItem(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['description'],
      category: map['category'],
      imageURL: map['image'],
    );
  }
}
