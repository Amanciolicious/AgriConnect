// view_farms_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewFarmsScreen extends StatefulWidget {
  const ViewFarmsScreen({super.key});

  @override
  State<ViewFarmsScreen> createState() => _ViewFarmsScreenState();
}

class _ViewFarmsScreenState extends State<ViewFarmsScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFarms();
  }

  Future<void> _loadFarms() async {
    try {
      final farmsSnapshot = await FirebaseFirestore.instance.collection('farms').get();
      final markers = farmsSnapshot.docs.map((doc) {
        final data = doc.data();
        final GeoPoint location = data['location'];
        final position = LatLng(location.latitude, location.longitude);
        
        return Marker(
          markerId: MarkerId(doc.id),
          position: position,
          infoWindow: InfoWindow(
            title: data['name'],
            snippet: data['address'],
          ),
          onTap: () => _showFarmDetails(doc.id, data),
        );
      }).toSet();

      setState(() {
        _markers = markers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading farms: $e')),
        );
      }
    }
  }

  void _showFarmDetails(String farmId, Map<String, dynamic> farmData) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              farmData['name'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Address: ${farmData['address']}'),
            const SizedBox(height: 8),
            Text('Description: ${farmData['description']}'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _editFarm(farmId, farmData),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Edit Farm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editFarm(String farmId, Map<String, dynamic> farmData) {
    // Implement edit functionality
    // Navigate to edit farm screen with the farm data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Locations'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadFarms,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(12.0, 105.0), // Center of Southeast Asia
                    zoom: 5.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    setState(() => _mapController = controller);
                  },
                  markers: _markers,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
                if (_markers.isEmpty)
                  const Center(
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'No farms added yet',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}