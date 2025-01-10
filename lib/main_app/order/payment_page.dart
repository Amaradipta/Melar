import 'dart:async';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String orderId;
  final Function(String orderId) onOrderPlaced; // Callback function to update status in orderHistory_page.dart

  const PaymentPage({
    Key? key,
    required this.orderId,
    required this.onOrderPlaced, // Accept the callback function
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentOption;
  late DateTime orderTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    orderTime = DateTime.now();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (DateTime.now().isAfter(orderTime.add(Duration(hours: 24)))) {
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
            Text('Checkout', style: TextStyle(color: Colors.green)),
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
                'Pay before 24 hours from order placement',
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
                'Rp 250,000', // Replace with dynamic price
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            SizedBox(height: 20),

            // Green Divider
            Divider(color: Colors.green, thickness: 2),
            SizedBox(height: 20),

            // Payment Options Section
            _buildPaymentOptionRow(
              icon: Icons.account_balance_wallet,
              label: 'Transfer Bank',
              value: 'Transfer Bank',
            ),
            _buildPaymentOptionRow(
              icon: Icons.credit_card,
              label: 'Kartu Kredit/Debit',
              value: 'Kartu Kredit/Debit',
            ),
            _buildPaymentOptionRow(
              icon: Icons.storefront,
              label: 'Bayar Tunai di Mitra/Agen',
              value: 'Bayar Tunai di Mitra/Agen',
            ),
            _buildPaymentOptionRow(
              icon: Icons.money_off,
              label: 'COD',
              value: 'COD',
            ),
            SizedBox(height: 20),

            // Place Order Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Trigger the callback to update the status of the order
                  widget.onOrderPlaced(widget.orderId);  // Call the callback function
                  Navigator.pop(context);  // Go back to the previous page
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order placed successfully!')));
                },
                child: Text('Place Order'),
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

  Widget _buildPaymentOptionRow({required IconData icon, required String label, required String value}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentOption = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: selectedPaymentOption == value ? Colors.green.shade100 : Colors.white,
          border: Border.all(
            color: selectedPaymentOption == value ? Colors.green : Colors.green.shade300,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(icon, color: selectedPaymentOption == value ? Colors.green : Colors.black),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: selectedPaymentOption == value ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCountdown() {
    final DateTime now = DateTime.now();
    final Duration countdown = orderTime.add(Duration(hours: 24)).difference(now);

    if (countdown.isNegative) {
      return 'Time is up!';
    }

    final int hours = countdown.inHours;
    final int minutes = countdown.inMinutes % 60;
    final int seconds = countdown.inSeconds % 60;

    return '$hours:$minutes:$seconds remaining';
  }
}
