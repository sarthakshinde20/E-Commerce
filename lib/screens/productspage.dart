import 'package:ecommerce/screens/cartpage.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final Map<String, String> product;
  final List<Map<String, dynamic>> cartItems;

  const ProductPage({required this.product, required this.cartItems, Key? key})
      : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product['name']!,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(
                        cartItems: widget.cartItems,
                        onCartUpdated: () {
                          setState(
                              () {}); // refresh UI, including FAB visibility
                        },
                      ),
                    ),
                  );
                },
              ),
              if (widget.cartItems.isNotEmpty)
                Positioned(
                  right: 10,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 15,
                      minHeight: 15,
                    ),
                    child: Text(
                      '${widget.cartItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[100],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    widget.product['image']!,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.product['name']!,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.product['price']!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.product['description']!,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove,
                              color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) quantity--;
                            });
                          },
                        ),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      final cartItem = {
                        'name': widget.product['name']!,
                        'image': widget.product['image']!,
                        'price': double.parse(
                            widget.product['price']!.replaceAll('₹', '')),
                        'quantity': quantity,
                      };

                      setState(() {
                        widget.cartItems.add(cartItem);
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            cartItems: widget.cartItems,
                            onCartUpdated: () {
                              setState(
                                  () {}); // refresh UI, including FAB visibility
                            },
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Add to Cart',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
