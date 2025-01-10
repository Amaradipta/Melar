import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'orderHistory_page.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int itemQuantity = 1;
  double pricePerDay = 140000;
  DateTime? rentalStartDate;
  DateTime? rentalEndDate;
  TimeOfDay? rentalTime = TimeOfDay.now();
  String shippingAddress = "Jl. Kebon Jeruk No. 24, Jakarta";
  String paymentMethod = "Bank Transfer";

  double get totalPrice {
    if (rentalStartDate == null || rentalEndDate == null) {
      return pricePerDay * itemQuantity;
    }

    int rentalDays = rentalEndDate!.difference(rentalStartDate!).inDays;

    rentalDays = rentalDays > 0 ? rentalDays : 1;

    return pricePerDay * itemQuantity * rentalDays;
  }

  Future<void> selectRentalDates(BuildContext context) async {
    DateTimeRange? selectedRange = await showDateRangePicker(
      context: context,
      initialDateRange: rentalStartDate != null && rentalEndDate != null
          ? DateTimeRange(start: rentalStartDate!, end: rentalEndDate!)
          : null,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedRange != null) {
      setState(() {
        rentalStartDate = selectedRange.start;
        rentalEndDate = selectedRange.end;
      });
    }
  }

  Future<void> selectRentalTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: rentalTime ?? TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        rentalTime = selectedTime;
      });
    }
  }

  Future<void> editShippingAddress(BuildContext context) async {
    TextEditingController controller = TextEditingController(text: shippingAddress);
    String? editedAddress = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Shipping Address"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter new address"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text("Save"),
            ),
          ],
        );
      },
    );

    if (editedAddress != null && editedAddress.isNotEmpty) {
      setState(() {
        shippingAddress = editedAddress;
      });
    }
  }

  void selectPaymentMethod(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Bank Transfer"),
              onTap: () {
                setState(() {
                  paymentMethod = "Bank Transfer";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Cash on Delivery (COD)"),
              onTap: () {
                setState(() {
                  paymentMethod = "COD";
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Rental Period Section
            ListTile(
              title: const Text("Rental Period"),
              subtitle: Text(rentalStartDate == null || rentalEndDate == null
                  ? "Select rental period"
                  : "${DateFormat('dd MMM yyyy').format(rentalStartDate!)} - ${DateFormat('dd MMM yyyy').format(rentalEndDate!)}"),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => selectRentalDates(context),
            ),
            // Rental Time Section
            ListTile(
              title: const Text("Rental Time"),
              subtitle: Text(rentalTime == null
                  ? "Select rental time"
                  : "${rentalTime!.format(context)}"),
              trailing: const Icon(Icons.access_time),
              onTap: () => selectRentalTime(context),
            ),
            // Item Quantity Section
            ListTile(
              title: const Text("Quantity"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (itemQuantity > 1) {
                        setState(() {
                          itemQuantity--;
                        });
                      }
                    },
                  ),
                  Text(itemQuantity.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        itemQuantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
            // Shipping Address Section
            ListTile(
              title: const Text("Shipping Address"),
              subtitle: Text(shippingAddress),
              trailing: const Icon(Icons.edit),
              onTap: () => editShippingAddress(context),
            ),
            // Payment Method Section
            ListTile(
              title: const Text("Payment Method"),
              subtitle: Text(paymentMethod),
              trailing: const Icon(Icons.payment),
              onTap: () => selectPaymentMethod(context),
            ),
            const Divider(),
            // Total Price Section
            ListTile(
              title: const Text("Total Price"),
              subtitle: Text("Rp ${totalPrice.toStringAsFixed(0)}"),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Order"),
                      content: const Text("Are you sure you want to place this order?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Pass order details to the OrderHistoryPage
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderHistoryPage(
                                  newOrder: {
                                    'title': 'Order #${DateTime.now().millisecondsSinceEpoch}',
                                    'description': 'Rental for ${itemQuantity} item(s)',
                                    'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                    'status': 'Belum Dibayar',
                                  },
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Order placed successfully!")),
                            );
                          },
                          child: const Text("Confirm"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}
