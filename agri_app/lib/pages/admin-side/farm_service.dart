// lib/services/farm_service.dart
import 'package:agri_app/pages/admin-side/farm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FarmService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'farms';

  Future<void> addFarm(Farm farm) async {
    try {
      await _firestore.collection(_collection).doc(farm.id).set(farm.toMap());
    } catch (e) {
      throw Exception('Failed to add farm: $e');
    }
  }

  Future<void> updateFarm(Farm farm) async {
    try {
      await _firestore.collection(_collection).doc(farm.id).update(farm.toMap());
    } catch (e) {
      throw Exception('Failed to update farm: $e');
    }
  }

  Future<void> deleteFarm(String farmId) async {
    try {
      await _firestore.collection(_collection).doc(farmId).delete();
    } catch (e) {
      throw Exception('Failed to delete farm: $e');
    }
  }

  Stream<List<Farm>> getFarms() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Farm.fromMap(doc.data())).toList();
    });
  }

  Future<Farm?> getFarmById(String farmId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(farmId).get();
      if (doc.exists) {
        return Farm.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get farm: $e');
    }
  }
}