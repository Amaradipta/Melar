import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Pastikan Anda mengimpor WelcomeScreen
import 'forgot_screen.dart';
import '../main_app/home_page.dart';  // Pastikan Anda mengimpor ForgotScreen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false; // Variabel state untuk visibilitas password
  bool _rememberMe = false; // Variabel state untuk checkbox "Remember Me"

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
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => WelcomeScreen()),
                                (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Color(0xFF132A13),
                    ),
                  ),
                  Text(
                    'Log in to your account',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Color(0xFF132A13),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  _buildInputField('Username / Email', screenWidth),
                  _buildInputField('Password', screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _rememberMe = !_rememberMe;
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _rememberMe ? Color(0xFF3B8132) : Colors.transparent,
                            border: Border.all(
                              color: Color(0xFF3B8132),
                              width: 2,
                            ),
                          ),
                          child: _rememberMe
                              ? Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          )
                              : Opacity(
                            opacity: 0,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Remember Me',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          color: Color(0xFF132A13),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotScreen()),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: Color(0xFF326F2A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()), // Mengarah ke HomePage
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3B8132),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFFCCE7C9),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New to Melar? ',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Color(0xBF132A13),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: Color(0xFF326F2A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey, thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Or Continue with',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: Color(0xFF132A13),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey, thickness: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon('assets/images/google_icon.png'),
                      SizedBox(width: 20),
                      _buildSocialIcon('assets/images/facebook_icon.png'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat input field
  Widget _buildInputField(String label, double screenWidth) {
    final radius = screenWidth * 0.15;

    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: TextField(
        obscureText: label == 'Password' && !_isPasswordVisible,
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
          suffixIcon: label == 'Password'
              ? IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Color(0xFF132A13),
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
        ),
      ),
    );
  }

  // Fungsi untuk membuat tombol sosial media
  Widget _buildSocialIcon(String assetPath) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 25,
      child: Image.asset(
        assetPath,
        width: 30,
        height: 30,
      ),
    );
  }
}
