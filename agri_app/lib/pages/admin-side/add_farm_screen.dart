import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFarmScreen extends StatefulWidget {
  const AddFarmScreen({super.key});

  @override
  State<AddFarmScreen> createState() => _AddFarmScreenState();
}

class _AddFarmScreenState extends State<AddFarmScreen> {
  final _formKey = GlobalKey<FormState>();
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  // Updated initial position to center of Southeast Asia (roughly around central Thailand)
  final LatLng _initialPosition = const LatLng(12.0, 105.0);

  // Define Southeast Asia boundaries
  final LatLngBounds _seaBounds = LatLngBounds(
    southwest: const LatLng(-11.0, 92.0), // Covers Indonesia
    northeast:
        const LatLng(29.0, 142.0), // Covers Philippines and northern regions
  );

  LatLng? _selectedLocation;

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  double _rating = 0.0; // Rating variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Add New Farm'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 300, // Increased height for better visibility
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _initialPosition,
                        zoom: 5.0, // Reduced zoom to show more area
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        setState(() {
                          _mapController = controller;
                          // Set map boundaries when created
                          controller.animateCamera(
                            CameraUpdate.newLatLngBounds(_seaBounds, 50.0),
                          );
                        });
                      },
                      markers: _markers,
                      onTap: _handleMapTap,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      minMaxZoomPreference:
                          const MinMaxZoomPreference(4, 18), // Set zoom limits
                      cameraTargetBounds:
                          CameraTargetBounds(_seaBounds), // Restrict panning
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _latitudeController,
                        decoration: InputDecoration(
                          labelText: 'Latitude',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.my_location),
                            onPressed: _selectedLocation != null
                                ? () => _latitudeController.text =
                                    _selectedLocation!.latitude.toString()
                                : null,
                          ),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter latitude';
                          }
                          final lat = double.tryParse(value);
                          if (lat == null ||
                              lat < _seaBounds.southwest.latitude ||
                              lat > _seaBounds.northeast.latitude) {
                            return 'Latitude must be within Southeast Asia';
                          }
                          return null;
                        },
                        onChanged: (value) => _updateMapFromCoordinates(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _longitudeController,
                        decoration: InputDecoration(
                          labelText: 'Longitude',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.my_location),
                            onPressed: _selectedLocation != null
                                ? () => _longitudeController.text =
                                    _selectedLocation!.longitude.toString()
                                : null,
                          ),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter longitude';
                          }
                          final lng = double.tryParse(value);
                          if (lng == null ||
                              lng < _seaBounds.southwest.longitude ||
                              lng > _seaBounds.northeast.longitude) {
                            return 'Longitude must be within Southeast Asia';
                          }
                          return null;
                        },
                        onChanged: (value) => _updateMapFromCoordinates(),
                      ),
                    ),
                  ],
                ),
                // Rest of the form fields remain the same
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Farm Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter farm name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Rating Slider
                Row(
                  children: [
                    const Text('Rating:'),
                    Expanded(
                      child: Slider(
                        value: _rating,
                        min: 0,
                        max: 5,
                        divisions: 5,
                        label: _rating.toStringAsFixed(1),
                        onChanged: (double value) {
                          setState(() {
                            _rating = value;
                          });
                        },
                      ),
                    ),
                    Text('${_rating.toStringAsFixed(1)}'),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add Farm',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMapTap(LatLng position) {
    // Check if the tapped position is within bounds
    if (!_seaBounds.contains(position)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a location within Southeast Asia')),
      );
      return;
    }

    setState(() {
      _selectedLocation = position;
      _markers = {
        Marker(
          markerId: const MarkerId('selected_location'),
          position: position,
          infoWindow: const InfoWindow(title: 'Selected Location'),
        ),
      };
      _latitudeController.text = position.latitude.toStringAsFixed(6);
      _longitudeController.text = position.longitude.toStringAsFixed(6);
    });
  }

  void _updateMapFromCoordinates() {
    final lat = double.tryParse(_latitudeController.text);
    final lng = double.tryParse(_longitudeController.text);

    if (lat != null && lng != null) {
      final newPosition = LatLng(lat, lng);

      // Check if the position is within bounds
      if (!_seaBounds.contains(newPosition)) {
        return;
      }

      setState(() {
        _selectedLocation = newPosition;
        _markers = {
          Marker(
            markerId: const MarkerId('selected_location'),
            position: newPosition,
            infoWindow: const InfoWindow(title: 'Selected Location'),
          ),
        };
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLng(newPosition),
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final lat = double.parse(_latitudeController.text);
        final lng = double.parse(_longitudeController.text);

        final farmData = {
          'name': _nameController.text,
          'address': _addressController.text,
          'description': _descriptionController.text,
          'location': GeoPoint(lat, lng),
          'rating': _rating, // Add rating to the data
          'timestamp': FieldValue.serverTimestamp(),
        };

        await FirebaseFirestore.instance.collection('farms').add(farmData);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Farm added successfully')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding farm: $e')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _mapController?.dispose();
    super.dispose();
  }
}
