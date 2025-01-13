// product_page.dart
import 'package:ecommerce/screens/cartpage.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final Map<String, String> product;
  final List<Map<String, dynamic>> cartItems;

  ProductPage({required this.product, required this.cartItems});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(widget.product['image']!),
            SizedBox(height: 16),
            Text(
              widget.product['name']!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.product['price']!,
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(widget.product['description']!),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                    ),
                    Text(quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add item to cart
                    final cartItem = {
                      'name': widget.product['name']!,
                      'image': widget.product['image']!,
                      'price': double.parse(
                          widget.product['price']!.replaceAll('\$', '')),
                      'quantity': quantity,
                    };

                    setState(() {
                      widget.cartItems.add(cartItem);
                    });

                    // Navigate to cart page with updated cartItems
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CartPage(cartItems: widget.cartItems),
                      ),
                    );
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
