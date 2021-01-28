class Cart {
  final int id;
  final int userId;
  final DateTime date;
  final List<CartProduct> products;

  Cart({this.id, this.userId, this.date, this.products});

  factory Cart.fromJson(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      userId: map['userId'],
      date: map['date'],
      products: List<CartProduct>.from(
        map['products'].map(
          (p) => CartProduct.fromJson(p),
        ),
      ),
    );
  }
}

class CartProduct {
  final int productId;
  final int quantity;

  CartProduct({this.productId, this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> map) {
    return CartProduct(
      productId: map['productId'],
      quantity: map['quantity'],
    );
  }
}
