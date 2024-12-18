import 'package:flutter/material.dart';
import 'package:agri_app/pages/login_page.dart'; // Import the login page

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  // Logout method
  void _logout(BuildContext context) {
    // Clear session or authentication data here if necessary
    // Example: SharedPreferences, FirebaseAuth, or any other session management

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
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade700),
              child: const Text(
                "Admin Panel",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                // Navigate to dashboard (if needed)
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                // Navigate to profile page (if needed)
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                // Navigate to settings page (if needed)
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildOverviewCard(
                      title: "Total Sales",
                      value: "\$12,345",
                      color: Colors.green),
                  _buildOverviewCard(
                      title: "Active Users", value: "234", color: Colors.blue),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildOverviewCard(
                      title: "Products Listed",
                      value: "45",
                      color: Colors.orange),
                  _buildOverviewCard(
                      title: "Pending Orders", value: "8", color: Colors.red),
                ],
              ),
              const SizedBox(height: 24),
              // Recent Orders Section
              Text(
                "Recent Orders",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildRecentOrdersList(),
              const SizedBox(height: 24),
              // Quick Links
              Text(
                "Manage",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildQuickLinks(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Overview Cards
  Widget _buildOverviewCard(
      {required String title, required String value, required Color color}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 160,
        height: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // ignore: deprecated_member_use
          color: color.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 14, color: color, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                  fontSize: 20, color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Recent Orders
  Widget _buildRecentOrdersList() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        3,
        (index) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text((index + 1).toString(),
                style: const TextStyle(color: Colors.white)),
          ),
          title: Text("Order #${index + 12345}"),
          subtitle: Text("Customer: User ${index + 1}"),
          trailing: const Text("\$120"),
        ),
      ),
    );
  }

  // Widget for Quick Links
  Widget _buildQuickLinks() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.inventory, color: Colors.blue),
          title: const Text("Manage Products"),
          onTap: () {
            // Navigate to Product Management
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_cart, color: Colors.green),
          title: const Text("View Orders"),
          onTap: () {
            // Navigate to Orders Page
          },
        ),
        ListTile(
          leading: const Icon(Icons.people, color: Colors.orange),
          title: const Text("Manage Users"),
          onTap: () {
            // Navigate to User Management
          },
        ),
      ],
    );
  }
}
