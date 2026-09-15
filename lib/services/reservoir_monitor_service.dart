import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlantReservoir {
  final String id;
  final String plantName;
  final String location;
  double waterLevelPercent;
  final int reservoirCapacityMl;
  final int daysUntilEmpty;

  PlantReservoir({
    required this.id,
    required this.plantName,
    required this.location,
    required this.waterLevelPercent,
    required this.reservoirCapacityMl,
    required this.daysUntilEmpty,
  });

  bool get needsRefill => waterLevelPercent <= 25.0;
}

class ReservoirMonitorService extends ChangeNotifier {
  final List<PlantReservoir> _plants = [
    PlantReservoir(
      id: 'r1',
      plantName: 'Monstera Deliciosa',
      location: 'Living Room Bay Window',
      waterLevelPercent: 78.0,
      reservoirCapacityMl: 1500,
      daysUntilEmpty: 8,
    ),
    PlantReservoir(
      id: 'r2',
      plantName: 'Fiddle Leaf Fig',
      location: 'Office Corner (East Facing)',
      waterLevelPercent: 18.0,
      reservoirCapacityMl: 2000,
      daysUntilEmpty: 2,
    ),
    PlantReservoir(
      id: 'r3',
      plantName: 'Peace Lily (Spathiphyllum)',
      location: 'Bedroom Bookshelf',
      waterLevelPercent: 45.0,
      reservoirCapacityMl: 800,
      daysUntilEmpty: 5,
    ),
    PlantReservoir(
      id: 'r4',
      plantName: 'Zanzibar Gem (ZZ Plant)',
      location: 'Hallway Console',
      waterLevelPercent: 92.0,
      reservoirCapacityMl: 600,
      daysUntilEmpty: 21,
    ),
  ];

  int _totalRefillActions = 12;

  ReservoirMonitorService() {
    _loadPrefs();
  }

  List<PlantReservoir> get plants => _plants;
  int get totalRefillActions => _totalRefillActions;
  int get urgentAlertsCount => _plants.where((p) => p.needsRefill).length;

  void refillReservoir(String id) {
    final plant = _plants.firstWhere((p) => p.id == id);
    plant.waterLevelPercent = 100.0;
    _totalRefillActions++;
    _savePrefs();
    notifyListeners();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _totalRefillActions = prefs.getInt('pelkora_refills') ?? 12;
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pelkora_refills', _totalRefillActions);
  }
}
