import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mock_store/models/store_item.dart';

class AddToCartSheet extends StatefulWidget {
  final StoreItem item;

  const AddToCartSheet({Key key, this.item}) : super(key: key);
  @override
  _AddToCartSheetState createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      clipBehavior: Clip.hardEdge,
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        color: Colors.white.withAlpha(245),
      ),
      child: Column(
        children: [
          Text(
            'Quantity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          buildQuantitySelector(),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              children: [
                Text(
                  "1 x item",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${widget.item.price}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              children: [
                Text(
                  "$_quantity x item(s)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${(widget.item.price * _quantity).toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Spacer(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                height: 50,
                color: Colors.black87,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add to cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    SvgPicture.asset(
                      "assets/icons/add_to_cart.svg",
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row buildQuantitySelector() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: FlatButton(
            onPressed: () {
              if (_quantity > 1) {
                setState(() {
                  _quantity -= 1;
                });
              }
            },
            child: Text(
              '-',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: CircleBorder(),
            color: Colors.black87,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              _quantity.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: FlatButton(
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
        ),
      ],
    );
  }
}
