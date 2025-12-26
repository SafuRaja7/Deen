import 'package:deen/core/models/ayah.dart';
import 'package:deen/features/home/data/reflection_repository.dart';
import 'package:flutter/material.dart';

class ReflectionProvider extends ChangeNotifier {
  final ReflectionRepository _repository = ReflectionRepository();

  Ayah? _reflectionOfTheDay;
  bool _isLoading = false;
  String? _error;

  Ayah? get reflectionOfTheDay => _reflectionOfTheDay;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ReflectionProvider() {
    fetchReflectionOfTheDay();
  }

  Future<void> fetchReflectionOfTheDay() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _reflectionOfTheDay = await _repository.getReflectionOfTheDay();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
