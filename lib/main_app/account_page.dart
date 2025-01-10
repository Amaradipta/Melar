import 'package:flutter/material.dart';
import 'package:melar/main_app/order/orderHistory_page.dart';
import 'bookmark_page.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'notification_page.dart';
 // Import halaman OrderHistoryPage

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account', style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileCard(context),
              const SizedBox(height: 16),
              _buildRentingSection(context),
              const SizedBox(height: 16),
              _buildMenuOptions(context),
              const SizedBox(height: 16),
              _buildSupportOptions(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, // Index untuk halaman Account
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          } else if (index == 4) {
            // Tetap di halaman Account
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

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.green.shade200,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Melar', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('See your profile', style: TextStyle(color: Colors.black54)),
                ],
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildRentingSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Start Renting!', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Renting', style: TextStyle(color: Colors.green)),
            ],
          ),
          Container(
            height: 60,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: const DecorationImage(
                image: AssetImage('assets/camping.jpg'), // Replace with actual image path
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOptions(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem('Edit profile', Icons.info),
        _buildMenuItem(
          'My order', 
          Icons.history, 
          onTap: () {
            // Arahkan ke halaman OrderHistoryPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderHistoryPage()),
            );
          }
        ),
        _buildMenuItem('Settings', Icons.settings),
        _buildMenuItem('Address', Icons.location_on),
        _buildMenuItem('Share shop', Icons.share),
      ],
    );
  }

  Widget _buildSupportOptions(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem('Help center', Icons.help),
        _buildMenuItem('Contact Support', Icons.support),
      ],
    );
  }

  Widget _buildMenuItem(String title, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.green),
                const SizedBox(width: 16),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
