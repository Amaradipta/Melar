import 'dart:async';
import 'package:flutter/material.dart';

class PackingPage extends StatefulWidget {
  final String orderId;
  final Function(String orderId) onOrderUpdated; // Callback function to update status in orderHistory_page.dart

  const PackingPage({
    Key? key,
    required this.orderId,
    required this.onOrderUpdated, // Accept the callback function
  }) : super(key: key);

  @override
  _PackingPageState createState() => _PackingPageState();
}

class _PackingPageState extends State<PackingPage> {
  late DateTime packingStartTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    packingStartTime = DateTime.now();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (DateTime.now().isAfter(packingStartTime.add(Duration(hours: 48)))) {
        _timer.cancel(); // Stop the timer when the countdown reaches zero
      }
      setState(() {}); // Update the UI every second
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.green),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 8),
            Text('Sedang Dikemas', style: TextStyle(color: Colors.green)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 0,
        leading: SizedBox(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Section
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          'Order Summary',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.green),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Countdown Timer Section
            Center(
              child: Text(
                'Menunggu Seller mengirim pesanan anda',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                _getCountdown(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            SizedBox(height: 20),

            // Price Section
            Center(
              child: Text(
                'Rp 140,000', // Replace with dynamic price
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            SizedBox(height: 20),

            // Green Divider
            Divider(color: Colors.green, thickness: 2),
            SizedBox(height: 20),

            // Payment Status Section
            Center(
              child: Text(
                'Pembayaran: Sudah Dibayar', // Update with actual payment status
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            SizedBox(height: 20),

            // Button to update order status
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Trigger the callback to update the status of the order
                  widget.onOrderUpdated(widget.orderId);  // Call the callback function
                  Navigator.pop(context);  // Go back to the previous page
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pesanan berhasil diselesaikan!')));
                },
                child: Text('Selesaikan Pesanan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCountdown() {
    final DateTime now = DateTime.now();
    final Duration countdown = packingStartTime.add(Duration(hours: 48)).difference(now);

    if (countdown.isNegative) {
      return 'Time is up!';
    }

    final int hours = countdown.inHours;
    final int minutes = countdown.inMinutes % 60;
    final int seconds = countdown.inSeconds % 60;

    return '$hours:$minutes:$seconds remaining';
  }
}