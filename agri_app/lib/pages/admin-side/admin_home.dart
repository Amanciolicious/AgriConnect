// admin_home.dart
import 'package:agri_app/pages/admin-side/admin_feedback.dart';
import 'package:agri_app/pages/admin-side/view_farm_screen.dart';
import 'package:flutter/material.dart';
import 'package:agri_app/pages/login_page.dart';
import 'package:agri_app/pages/admin-side/admin_profile.dart';
// Add this new import

import 'package:agri_app/pages/admin-side/add_farm_screen.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

// Add this method in the AdminHome class
void _navigateToViewFarms(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ViewFarmsScreen()),
  );
}

  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminProfile()),
    );
  }

  void _navigateToAddFarm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddFarmScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AgriConnect Admin Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle platform notifications
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green.shade700),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "AgriConnect Admin",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Platform Management",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminHome()),);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pop(context);
                _navigateToProfile(context);
              },
            ),
            // Add new Farm Management tile
            ListTile(
              leading: const Icon(Icons.agriculture),
              title: const Text("Farm Management"),
              onTap: () {
                Navigator.pop(context);
                _navigateToAddFarm(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text("Feedback"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminFeedback()),);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("User Management"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Product Listings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
             // Update the Farm Management ListTile in the drawer to include a subtitle and onTap
ListTile(
  leading: const Icon(Icons.agriculture),
  title: const Text("Farm Management"),
  subtitle: const Text("Add & View Farms"),
  onTap: () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Farm Management'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add_location),
              title: const Text('Add New Farm'),
              onTap: () {
                Navigator.pop(context);
                _navigateToAddFarm(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('View Farm Locations'),
              onTap: () {
                Navigator.pop(context);
                _navigateToViewFarms(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  },
),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text("Logout"),
              onTap: () => _logout(context),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildOverviewCard(
                    title: "Total Farmers",
                    value: "150",
                    color: Colors.green,
                  ),
                  _buildOverviewCard(
                    title: "Total Buyers",
                    value: "200",
                    color: Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildOverviewCard(
                    title: "Product Listings",
                    value: "750",
                    color: Colors.orange,
                  ),
                  _buildOverviewCard(
                    title: "Total Farms",  // Added new card
                    value: "45",
                    color: Colors.purple,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                "Recent Transactions",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildRecentTransactionsList(),
              const SizedBox(height: 24),
              Text(
                "Platform Management",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildPlatformManagementLinks(context),
            ],
          ),
        ),
      ),
      // Add FAB for quick access to add farm
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddFarm(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_location_alt),
      ),
    );
  }

  Widget _buildOverviewCard({
    required String title,
    required String value,
    required Color color,
  }) {
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
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactionsList() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        3,
        (index) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text(
              (index + 1).toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text("Transaction #${index + 12345}"),
          subtitle: const Text("Farmer: John Doe, Buyer: Jane Smith"),
          trailing: const Text("\$120"),
        ),
      ),
    );
  }

  Widget _buildPlatformManagementLinks(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.people, color: Colors.blue),
          title: const Text("User Registrations"),
          onTap: () {},
        ),
        // Add Farm Management link
        ListTile(
          leading: const Icon(Icons.agriculture, color: Colors.green),
          title: const Text("Farm Management"),
          onTap: () => _navigateToAddFarm(context),
        ),
        ListTile(
          leading: const Icon(Icons.list_alt, color: Colors.green),
          title: const Text("Product Listings"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.feedback, color: Colors.orange),
          title: const Text("Feedback"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminFeedback()),
            );
          },
        ),
      ],
    );
  }
}