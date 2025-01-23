import 'package:dialink/src/core/utils/enums.dart';
import 'package:flutter/material.dart';

class AppointmentNotifier extends ChangeNotifier {
  String? _error;
  List<dynamic> _data = [];
  AppState _state = AppState.data;

  AppState get state => _state;
  List<dynamic> get data => _data;
  String? get error => _error;

  void getADate(Map<String, dynamic> payload) {
    _state = AppState.loading;
    notifyListeners();

    _data = [..._data, payload];

    _state = AppState.data;
    notifyListeners();
  }
}
