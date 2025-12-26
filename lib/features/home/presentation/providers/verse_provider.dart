import 'package:deen/core/models/ayah.dart';
import 'package:deen/features/home/data/verse_repository.dart';
import 'package:flutter/material.dart';

class VerseProvider extends ChangeNotifier {
  final VerseOfTheDayRepository _repository = VerseOfTheDayRepository();

  Ayah? _verseOfTheDay;
  bool _isLoading = false;
  String? _error;

  Ayah? get verseOfTheDay => _verseOfTheDay;
  bool get isLoading => _isLoading;
  String? get error => _error;

  VerseProvider() {
    fetchVerseOfTheDay();
  }

  Future<void> fetchVerseOfTheDay() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _verseOfTheDay = await _repository.getVerseOfTheDay();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
