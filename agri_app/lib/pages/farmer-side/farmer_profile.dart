// farmer_profile.dart
import 'package:flutter/material.dart';

class FarmerProfile extends StatefulWidget {
  const FarmerProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FarmerProfileState createState() => _FarmerProfileState();
}

class _FarmerProfileState extends State<FarmerProfile> {
  // Simulated farmer data
  final Map<String, dynamic> farmerData = {
    'name': 'John Doe',
    'farmSize': 25.5, // hectares
    'crops': ['Wheat', 'Corn', 'Soybeans'],
    'lastHarvest': {
      'crop': 'Corn',
      'yield': 120, // bushels per acre
      'date': '2024-06-15'
    }
  };

  // Function to view crop details
  void _viewCropDetails(String crop) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crop Details: $crop'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Crop: $crop'),
              const Text('Current Status: Growing'),
              const Text('Estimated Harvest: 2 months'),
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

  // Function to update farm information
  void _updateFarmInfo() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Update Farm Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Farm Size (hectares)',
                  hintText: farmerData['farmSize'].toString(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Logic to save updated information
                  Navigator.pop(context);
                },
                child: const Text('Save Changes'),
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
        title: const Text('Farmer Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _updateFarmInfo,
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
                title: Text(farmerData['name']),
                subtitle: Text('Farm Size: ${farmerData['farmSize']} hectares'),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Crops',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: farmerData['crops'].length,
                itemBuilder: (context, index) {
                  String crop = farmerData['crops'][index];
                  return ListTile(
                    title: Text(crop),
                    trailing: ElevatedButton(
                      onPressed: () => _viewCropDetails(crop),
                      child: const Text('View Details'),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Last Harvest'),
                subtitle: Text(
                  'Crop: ${farmerData['lastHarvest']['crop']}\n'
                  'Yield: ${farmerData['lastHarvest']['yield']} bushels\n'
                  'Date: ${farmerData['lastHarvest']['date']}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
