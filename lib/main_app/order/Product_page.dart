import 'package:flutter/material.dart';
import 'package:melar/main_app/order/checkout_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<String> productImages = [
    'assets/images/tent.png',
    'assets/images/suit.png',
    'assets/images/backpack.png',
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.green),
            onPressed: () {
              // Navigasi ke halaman cart
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: productImages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(productImages[index]),
                            fit: BoxFit.cover
                          ),
                        ),
                      );
                    },
                  ),


                  Positioned(
                  bottom: 10, // Jarak dari bawah
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Memastikan indikator berada di tengah
                    children: productImages.map((url) {
                      int index = productImages.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Colors.green
                              : Colors.grey.shade400,
                        ),
                      );
                    }).toList(),
                  ),
                ),


                  Positioned(
                    top: 10,
                    right: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildActionIcon(Icons.share, "Share"),
                        _buildActionIcon(Icons.bookmark_border, "Bookmark"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Informasi Toko
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: const AssetImage('assets/images/store.png'),
                        radius: 20,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'OnDaGround',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'London',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCustomButton(
                        text: "See Profile",
                        onPressed: () {},
                        backgroundColor: Colors.green.shade50,
                        textColor: Colors.green,
                      ),
                      _buildCustomButton(
                        text: "Message",
                        onPressed: () {},
                        backgroundColor: Colors.green.shade50,
                        textColor: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),

            // Informasi Produk
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '[RENTAL] Tent outdoor for 4 people, 1 week duration [FREE SHIPPING]',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Outdoor',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rp. 140,000',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'This section is the description about the product that you want to rent, explanation about the product condition, how to use, detailed information about the product are written in this section with maximum 500 words.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const Divider(),

            // Produk Terkait
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'You might also like',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildRelatedProduct(
                            context, 'assets/images/tent.png', 'Rp. 140,000'),
                        _buildRelatedProduct(
                            context, 'assets/images/backpack.png', 'Rp. 80,000'),
                        _buildRelatedProduct(
                            context, 'assets/images/suit.png', 'Rp. 50,000'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCustomButton(
              text: "Add to Cart",
              onPressed: () {},
              backgroundColor: Colors.green,
              textColor: Colors.white,
            ),
            _buildCustomButton(
              text: "Checkout",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutPage()),
                );
              },
              backgroundColor: Colors.white,
              textColor: Colors.green,
              borderColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, String tooltip) {
    return IconButton(
      tooltip: tooltip,
      icon: Icon(icon, color: Colors.green),
      onPressed: () {
        // Aksi terkait
      },
    );
  }

  Widget _buildCustomButton({
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(140, 36),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        side: borderColor != null ? BorderSide(color: borderColor) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRelatedProduct(
      BuildContext context, String imagePath, String price) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman produk terkait
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16.0),
        width: 100,
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
