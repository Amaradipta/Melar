import 'package:flutter/material.dart';
import 'bookmark_page.dart';
import 'cart_page.dart';
import 'notification_page.dart';
import 'account_page.dart';
import 'order/Product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/cars.png', height: 150),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'What do you want to rent?',
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) {
                              // Handle search logic here
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'Suggested for you',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildProductCard(context, 'assets/images/tent.png', 'Rp. 140.000', 'Outdoor', 'S'),
                  _buildProductCard(context, 'assets/images/backpack.png', 'Rp. 80.000', 'Outdoor', 'All Size'),
                  _buildProductCard(context, 'assets/images/suit.png', 'Rp. 50.000', 'Clothes', 'M'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Tambahkan logika jika tombol ">" ditekan
                    },
                    child: const Text(
                      'Recommended Store >',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 3,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 2,
              itemBuilder: (context, index) {
                final stores = [
                  {'name': 'Asep Jibar', 'rating': 4.5},
                  {'name': 'Dadang Kupling', 'rating': 4.5},
                ];
                return _buildStoreCard(stores[index]['name'] as String, stores[index]['rating'] as double);
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Tambahkan logika jika tombol ">" ditekan
                    },
                    child: const Text(
                      'Recently Viewed >',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildProductCard(context, 'assets/images/suit.png', 'Rp. 50.000', 'Clothes', 'M'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Index untuk halaman Home
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BookmarkPage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          } else if (index == 2) {
            // Tetap di halaman Home
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          } else if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AccountPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmark'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String imagePath, String price, String category, String size) {
    return GestureDetector(
      onTap: () {
        // Navigate to the product page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage()), // Implement ProductPage
        );
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, height: 60, fit: BoxFit.cover),
            const SizedBox(height: 8),
            Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(category),
            Text(size, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreCard(String storeName, double rating) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          const Icon(Icons.store, size: 32, color: Colors.green),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(storeName, style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.yellow),
                  Text('$rating', style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
