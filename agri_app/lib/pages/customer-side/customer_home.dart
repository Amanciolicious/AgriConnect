import 'package:agri_app/pages/customer-side/data/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:agri_app/pages/customer-side/cart_page.dart';
import 'package:agri_app/pages/customer-side/customer_profile.dart';
import 'package:agri_app/pages/customer-side/services_page.dart';
import 'package:agri_app/pages/customer-side/widgets/product_card.dart';
import 'package:agri_app/pages/login_page.dart'; // Add the login page import

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  int currentIndex = 0;

  // List of pages corresponding to the bottom navigation items
  final List<Widget> _pages = [
    const HomePage(),  // Home Page (Customer Home)
    const ServicesPage(),  // Services Page
    const CartPage(cartItems: []),  // Cart Page
    ProfilePage(),  // Profile Page
  ];

  // Logout function
  void _logout(BuildContext context) {
    // Clear session or authentication data if necessary
    // Example: SharedPreferences, FirebaseAuth, or other session management

    // Navigate to the login page and clear navigation stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Home"),
        actions: [
          IconButton(
            icon: const Icon(IconlyLight.search),
            onPressed: () {},
          ),
        ],
      ),
      // Drawer for the sidebar navigation
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade700),
              child: const Text(
                "Customer Panel",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(IconlyLight.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(IconlyLight.call),
              title: const Text("Services"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ServicesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(IconlyLight.buy),
              title: const Text("Cart"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage(cartItems: [])),
                );
              },
            ),
            ListTile(
              leading: const Icon(IconlyLight.profile),
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text("Logout"),
              onTap: () => _logout(context), // Logout on tap
            ),
          ],
        ),
      ),
      body: _pages[currentIndex], // Displays the page based on the currentIndex
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // Highlight the selected tab
        onTap: (index) {
          setState(() {
            currentIndex = index; // Change the page based on the index
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.home),
            activeIcon: Icon(IconlyBold.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.call),
            activeIcon: Icon(IconlyBold.call),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.buy),
            activeIcon: Icon(IconlyBold.buy),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.profile),
            activeIcon: Icon(IconlyBold.profile),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Filter and Search Text Field
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search here...",
                    isDense: true,
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(99)),
                    ),
                    prefixIcon: const Icon(IconlyLight.search),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(IconlyLight.filter),
                ),
              ),
            ],
          ),
        ),
        // Consultation Card
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: SizedBox(
            height: 170,
            child: Card(
              color: Colors.green.shade50,
              elevation: 0.1,
              shadowColor: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Texts Statement
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Free Consultation",
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.green.shade700,
                            ),
                          ),
                          const Text("Get free support from our customer service"),
                          FilledButton(onPressed: () {}, child: const Text("Call now")),
                        ],
                      ),
                    ),
                    // Image
                    Image.asset('contactus.png', width: 140),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Featured Products
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured Products",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () {},
              child: const Text("See all"),
            ),
          ],
        ),
        // Feature Products Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ],
    );
  }
}
