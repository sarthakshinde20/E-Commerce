// homepage.dart
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
      'name': 'Product 1',
      'image':
          'https://m.media-amazon.com/images/I/61Cn0YZ-JxL._AC_UF1000,1000_QL80_.jpg',
      'price': '\$20.00',
      'description': 'Description of Product 1.'
    },
    {
      'name': 'Product 2',
      'image':
          'https://m.media-amazon.com/images/I/61Cn0YZ-JxL._AC_UF1000,1000_QL80_.jpg',
      'price': '\$35.00',
      'description': 'Description of Product 2.'
    },
    {
      'name': 'Product 3',
      'image':
          'https://m.media-amazon.com/images/I/61Cn0YZ-JxL._AC_UF1000,1000_QL80_.jpg',
      'price': '\$50.00',
      'description': 'Description of Product 3.'
    },
    {
      'name': 'Product 4',
      'image':
          'https://m.media-amazon.com/images/I/61Cn0YZ-JxL._AC_UF1000,1000_QL80_.jpg',
      'price': '\$70.00',
      'description': 'Description of Product 4.'
    },
    {
      'name': 'Product 5',
      'image':
          'https://m.media-amazon.com/images/I/61Cn0YZ-JxL._AC_UF1000,1000_QL80_.jpg',
      'price': '\$90.00',
      'description': 'Description of Product 5.'
    },
  ];

  final List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 4,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(
                    product: product,
                    cartItems: cartItems, // Pass cart items to ProductPage
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        product['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          product['price']!,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
