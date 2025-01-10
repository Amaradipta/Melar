import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import for FilteringTextInputFormatter
import 'ResetPasswordScreen.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email; // Constructor to receive email

  // Constructor to accept email from Forgot Screen
  VerifyEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  // Controllers for 4 digit inputs
  TextEditingController _digit1Controller = TextEditingController();
  TextEditingController _digit2Controller = TextEditingController();
  TextEditingController _digit3Controller = TextEditingController();
  TextEditingController _digit4Controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Focus next input when typing a digit
    _digit1Controller.addListener(() {
      if (_digit1Controller.text.length == 1) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: Color(0x5A46932C),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Color(0xFF132A13)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    'Verify Your Email',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Color(0xFF132A13),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFC2D4BF),
                    child: Image.asset(
                      'assets/images/email.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Please enter the 4 digit code sent to\n${widget.email}', // Show the email passed from Forgot Screen
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Color(0xFF132A13),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDigitInput(_digit1Controller),
                      SizedBox(width: 10),
                      _buildDigitInput(_digit2Controller),
                      SizedBox(width: 10),
                      _buildDigitInput(_digit3Controller),
                      SizedBox(width: 10),
                      _buildDigitInput(_digit4Controller),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () {
                      // Resend code action
                    },
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Color(0xFF326F2A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        // Verify action
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ResetPasswordScreen()), // Mengarah ke HomePage
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3B8132),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFFCCE7C9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to create input fields for the 4 digit code
  Widget _buildDigitInput(TextEditingController controller) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only allow digits
        decoration: InputDecoration(
          counterText: '',
          hintText: '_',
          hintStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            color: Color(0xBF132A13),
          ),
          filled: true,
          fillColor: Color(0xFF46932C).withOpacity(0.35),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF46932C), width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF46932C), width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus(); // Move focus to next input
          }
        },
      ),
    );
  }
}
