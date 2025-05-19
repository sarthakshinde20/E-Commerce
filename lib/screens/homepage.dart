import 'package:ecommerce/screens/cartpage.dart';
import 'package:ecommerce/screens/productspage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> products = [
    {
      'name': 'Organic Wheat Flour',
      'image': 'assets/images/Organic wheat flour.jpg',
      'price': '\u20B920.00',
      'short description': 'Per KG',
      'description': 'Fresh and organic wheat flour for healthy living.'
    },
    {
      'name': 'Premium Flour',
      'image': 'assets/images/Wheat-Flour5.jpg',
      'price': '\u20B935.00',
      'short description': 'Per KG',
      'description': 'Premium quality flour for all your cooking needs.'
    },
    {
      'name': 'Golden Wheat Flour',
      'image': 'assets/images/Wheat-Flour5.jpg',
      'price': '\u20B950.00',
      'short description': 'Per KG',
      'description': 'Golden wheat flour for soft and fluffy bread.'
    },
    {
      'name': 'Organic Flour',
      'image': 'assets/images/Organic wheat flour.jpg',
      'short description': 'Per KG',
      'price': '\u20B970.00',
      'description': '100% organic flour for healthy eating habits.'
    },
    {
      'name': 'Healthy Wheat',
      'image': 'assets/images/Wheat-Flour5.jpg',
      'short description': 'Per KG',
      'price': '\u20B990.00',
      'description': 'Stay healthy with our premium wheat flour.'
    },
  ];

  final List<Map<String, dynamic>> cartItems = [];
  final Map<int, int> productQuantities = {};
  final Set<int> addedToCartIndexes = {};

  void updateCartQuantity(int index) {
    String name = products[index]['name']!;
    int quantity = productQuantities[index] ?? 0;

    for (var item in cartItems) {
      if (item['name'] == name) {
        item['quantity'] = quantity;
        break;
      }
    }
  }

  void increaseQuantity(int index) {
    setState(() {
      productQuantities[index] = (productQuantities[index] ?? 1) + 1;
      if (addedToCartIndexes.contains(index)) {
        updateCartQuantity(index);
      }
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if ((productQuantities[index] ?? 1) > 0) {
        productQuantities[index] = productQuantities[index]! - 1;
        if (addedToCartIndexes.contains(index)) {
          updateCartQuantity(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('Shop Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3 / 5,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            final quantity = productQuantities[index] ?? 0;
            final isInCart = addedToCartIndexes.contains(index);

            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              product: product,
                              cartItems: cartItems,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                        child:
                            Image.asset(product['image']!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product['name']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product['short description']!,
                                style: const TextStyle(fontSize: 14)),
                            Text(product['price']!,
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (quantity > 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => decreaseQuantity(index),
                              ),
                              Text('$quantity',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  increaseQuantity(index);
                                  // If product not in cart yet, add it when quantity is increased from 0
                                  if (!addedToCartIndexes.contains(index)) {
                                    final cartItem = {
                                      'name': product['name'],
                                      'image': product['image'],
                                      'price': double.parse(product['price']!
                                          .replaceAll('₹', '')
                                          .replaceAll('\u20B9', '')),
                                      'quantity': productQuantities[index],
                                    };

                                    setState(() {
                                      cartItems.add(cartItem);
                                      addedToCartIndexes.add(index);
                                    });
                                  }
                                },
                              ),
                            ],
                          )
                        else
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final cartItem = {
                                  'name': product['name'],
                                  'image': product['image'],
                                  'price': double.parse(product['price']!
                                      .replaceAll('₹', '')
                                      .replaceAll('\u20B9', '')),
                                  'quantity': 1,
                                };

                                setState(() {
                                  cartItems.add(cartItem);
                                  productQuantities[index] = 1;
                                  addedToCartIndexes.add(index);
                                });

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Item Added"),
                                    content: Text(
                                        "${product['name']} (x1) has been added to your cart."),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("OK"),
                                      )
                                    ],
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: (cartItems.length > 0)
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 125, 206, 127),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(
                          cartItems: cartItems,
                          onCartUpdated: () {
                            setState(
                                () {}); // refresh UI, including FAB visibility
                          },
                        ),
                      ),
                    );
                  },
                  child: const Icon(Icons.shopping_cart),
                ),
                Positioned(
                  right: -5,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
