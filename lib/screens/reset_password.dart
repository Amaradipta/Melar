import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Color(0xFF132A13),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: Color(0xFFC2D4BF),
                    child: Image.asset(
                      'assets/images/reset_password.png',
                      width: 90,
                      height: 90,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Your new password must be different from previously used password',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Color(0xFF132A13),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  _buildInputField('New Password', _newPasswordController, screenWidth),
                  _buildInputField('Confirm Password', _confirmPasswordController, screenWidth),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: _saveNewPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3B8132),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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

  Widget _buildInputField(String label, TextEditingController controller, double screenWidth) {
    final radius = screenWidth * 0.15;

    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            color: Color(0xBF132A13),
          ),
          filled: true,
          fillColor: Color(0xFF46932C).withOpacity(0.35),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF46932C), width: 1.0),
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF46932C), width: 2.0),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }

  void _saveNewPassword() {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showErrorMessage('Please fill in both fields.');
      return;
    }

    if (newPassword != confirmPassword) {
      _showErrorMessage('Passwords do not match.');
      return;
    }

    // Simulate saving new password
    _showSuccessMessage('Password successfully reset!');
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}