import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class PelkoraStore extends ChangeNotifier {
  List<dynamic> reservoirs = [];
  List<dynamic> logs = [];
  List<dynamic> tips = [];

  PelkoraStore() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('pelkora_data');
    if (data != null) {
      final json = jsonDecode(data);
      reservoirs = json['reservoirs'] ?? [];
      logs = json['logs'] ?? [];
      tips = json['tips'] ?? [];
      notifyListeners();
    } else {
      _loadDefault();
    }
  }

  Future<void> _loadDefault() async {
    try {
      final jsonStr = await rootBundle.loadString('content.json');
      final json = jsonDecode(jsonStr);
      reservoirs = json['reservoirs'] ?? [];
      logs = json['logs'] ?? [];
      tips = json['tips'] ?? [];
      save();
    } catch (e) {
      // fallback
    }
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pelkora_data', jsonEncode({
      'reservoirs': reservoirs,
      'logs': logs,
      'tips': tips,
    }));
    notifyListeners();
  }

  void refill(int index) {
    reservoirs[index]['level'] = 100;
    logs.insert(0, {
      'plant': reservoirs[index]['name'],
      'date': DateTime.now().toIso8601String(),
      'moisture': 100
    });
    save();
  }
}
