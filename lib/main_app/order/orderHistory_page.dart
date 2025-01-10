import 'package:flutter/material.dart';
import 'package:melar/main_app/bookmark_page.dart';
import 'package:melar/main_app/cart_page.dart';
import 'package:melar/main_app/home_page.dart';
import 'package:melar/main_app/account_page.dart';
import 'payment_page.dart'; // Import PaymentPage
import 'packing_page.dart'; // Import PackingPage

class OrderHistoryPage extends StatefulWidget {
  final Map<String, String>? newOrder;

  const OrderHistoryPage({Key? key, this.newOrder}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Map<String, String>> orders = [
    // Initial order list (with 'Belum Dibayar' status)
    {
      'title': 'Order #12345',
      'description': 'Deskripsi pesanan yang statusnya: Belum Dibayar',
      'date': '2025-01-09',
      'status': 'Belum Dibayar',
    },
    {
      'title': 'Order #12346',
      'description': 'Deskripsi pesanan yang statusnya: Belum Dibayar',
      'date': '2025-01-08',
      'status': 'Belum Dibayar',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Check if there is a new order and add it to the list
    if (widget.newOrder != null) {
      orders.insert(0, widget.newOrder!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Icon(Icons.arrow_back, color: Colors.green),
              const SizedBox(width: 8),
              const Text(
                'Order History',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 0,
          leading: const SizedBox(),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: TabBar(
              isScrollable: true,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.green,
              indicatorWeight: 2.0,
              tabs: const [
                Tab(text: 'Belum Dibayar'),
                Tab(text: 'Dikemas'),
                Tab(text: 'Dikirim'),
                Tab(text: 'Dikembalikan'),
                Tab(text: 'Selesai'),
              ],
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(context, 'Belum Dibayar'),
            _buildOrderList(context, 'Dikemas'),
            _buildOrderList(context, 'Dikirim'),
            _buildOrderList(context, 'Dikembalikan'),
            _buildOrderList(context, 'Selesai'),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3, // Start on Order History
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const BookmarkPage()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                break;
              case 4:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountPage()),
                );
                break;
              default:
              // Stay on Order History
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmark'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Order History'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, String status) {
    List<Widget> orderItems = orders
        .where((order) => order['status'] == status)
        .map((order) {
      return _buildOrderItem(
        context,
        title: order['title']!,
        description: order['description']!,
        date: order['date']!,
        status: order['status']!,
        orderId: order['title']!, // Use the title or an actual unique identifier
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: orderItems,
      ),
    );
  }

  Widget _buildOrderItem(
      BuildContext context, {
        required String title,
        required String description,
        required String date,
        required String status,
        required String orderId,
      }) {
    return GestureDetector(
      onTap: () {
        if (status == 'Dikemas') {
          // Navigate to PackingPage if status is 'Dikemas'
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PackingPage(
                orderId: orderId,
                onOrderUpdated: (updatedOrderId) {
                  setState(() {
                    orders.firstWhere((order) => order['title'] == updatedOrderId)['status'] = 'Selesai';
                  });
                },
              ),
            ),
          );
        } else {
          // Navigate to PaymentPage for other statuses
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentPage(
                orderId: orderId,
                onOrderPlaced: (String orderId) {
                  setState(() {
                    orders.firstWhere((order) => order['title'] == orderId)['status'] = 'Dikemas';
                  });
                },
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: _getStatusColor(status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Belum Dibayar':
        return Colors.red;
      case 'Dikemas':
        return Colors.orange;
      case 'Dikirim':
        return Colors.blue;
      case 'Dikembalikan':
        return Colors.purple;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
