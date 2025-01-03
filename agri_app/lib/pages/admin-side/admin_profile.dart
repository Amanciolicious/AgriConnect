import 'package:flutter/material.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  // Simulated admin data for AgriConnect
  final Map<String, dynamic> adminData = {
    'name': 'AgriConnect Admin',
    'email': 'admin@agriconnect.com',
    'totalFarmers': 150,
    'totalBuyers': 200,
    'totalTransactions': 450,
    'totalProductListings': 750,
    'recentActivities': [
      {'action': 'Approved Farmer Registration', 'date': '2024-06-20'},
      {'action': 'Resolved User Complaint', 'date': '2024-06-18'},
      {'action': 'Updated Platform Security', 'date': '2024-06-15'}
    ]
  };

  // Function to manage user registrations
  void _manageUserRegistrations() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Registrations'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total Farmers: ${adminData['totalFarmers']}'),
              Text('Total Buyers: ${adminData['totalBuyers']}'),
              const Text('Pending Approvals: 5'),
              ElevatedButton(
                onPressed: () {
                  // Logic to view and process pending registrations
                  Navigator.pop(context);
                },
                child: const Text('View Pending Registrations'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to generate platform reports
  void _generateReports() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Generate Reports',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Logic to generate farmer performance report
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Farmer Performance Report Generated')),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Farmer Performance Report'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Logic to generate transaction report
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transaction Report Generated')),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Transaction Report'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.report),
            onPressed: _generateReports,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                title: Text(adminData['name']),
                subtitle: Text('Email: ${adminData['email']}'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('Platform Overview'),
                subtitle: Text(
                  'Total Farmers: ${adminData['totalFarmers']}\n'
                  'Total Buyers: ${adminData['totalBuyers']}\n'
                  'Total Transactions: ${adminData['totalTransactions']}\n'
                  'Product Listings: ${adminData['totalProductListings']}',
                ),
                trailing: ElevatedButton(
                  onPressed: _manageUserRegistrations,
                  child: const Text('Manage Users'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Recent Platform Activities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: adminData['recentActivities'].length,
                itemBuilder: (context, index) {
                  var activity = adminData['recentActivities'][index];
                  return ListTile(
                    title: Text(activity['action']),
                    subtitle: Text('Date: ${activity['date']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}