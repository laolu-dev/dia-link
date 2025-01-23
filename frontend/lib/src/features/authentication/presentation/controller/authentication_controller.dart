import 'package:dialink/src/core/utils/enums.dart';
import 'package:flutter/material.dart';

class AuthenticationNotifier extends ChangeNotifier {
  dynamic _data;
  String? _error;
  AppState _state = AppState.data;

  AppState get state => _state;
  dynamic get data => _data;
  String? get error => _error;

  void signup(Map<String, dynamic> payload) {
    _state = AppState.loading;
    notifyListeners();
  }

  void login(Map<String, dynamic> payload) {
    _state = AppState.loading;
    notifyListeners();
  }

  void verifyEmail(Map<String, dynamic> payload) {
    _state = AppState.loading;
    notifyListeners();
  }
}
