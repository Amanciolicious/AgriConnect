import 'package:agri_app/pages/admin-side/admin_home.dart';
import 'package:agri_app/pages/customer-side/customer_home.dart';
import 'package:agri_app/pages/farmer-side/farmer_home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String userRole = ''; // Variable to store the role (Admin, Customer, Farmer)
  bool _isPasswordVisible = false; // State for password visibility

  // Dummy login validation function
  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == "admin" && password == "admin123") {
      userRole = "admin";
    } else if (username == "farmer" && password == "farmer123") {
      userRole = "farmer";
    } else if (username == "customer" && password == "customer123") {
      userRole = "customer";
    } else {
      userRole = "";
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password')));
      return;
    }

    // Navigate to different home pages based on user role
    if (userRole == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminHome()),
      );
    } else if (userRole == "farmer") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FarmerHomePage()),
      );
    } else if (userRole == "customer") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CustomerHome()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.green],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Add spacing above the logo
                  // Logo
                  Image.asset(
                    'assets/agriconnect_logo.png',
                    height: 250, // Adjust size as needed
                    fit: BoxFit.contain,
                  ),
                // Add spacing below the logo
                  // Card for Login Form
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    shadowColor: Colors.green.shade700,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Text(
                            "Welcome to AgriConnect",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Login to continue",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Username TextField
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: "Username",
                              prefixIcon:
                                  const Icon(Icons.person, color: Colors.green),
                              filled: true,
                              fillColor: Colors.green.shade50,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.green.shade400),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.green.shade700),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Password TextField
                          TextField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.green),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.green.shade700,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: Colors.green.shade50,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.green.shade400),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.green.shade700),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Login Button
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 80),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.green.shade700,
                              shadowColor: Colors.green.shade300,
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
