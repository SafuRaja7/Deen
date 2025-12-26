class Ayah {
  final int number;
  final String arabicText;
  final String englishTranslation;
  final SurahInfo surah;
  final int numberInSurah;

  Ayah({
    required this.number,
    required this.arabicText,
    required this.englishTranslation,
    required this.surah,
    required this.numberInSurah,
  });

  factory Ayah.fromJson(List<dynamic> data) {
    // First item is Arabic (quran-uthmani)
    final arabicData = data[0];
    // Second item is English translation
    final englishData = data[1];

    return Ayah(
      number: arabicData['number'],
      arabicText: arabicData['text'],
      englishTranslation: englishData['text'],
      surah: SurahInfo.fromJson(arabicData['surah']),
      numberInSurah: arabicData['numberInSurah'],
    );
  }
}

class SurahInfo {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;

  SurahInfo({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
  });

  factory SurahInfo.fromJson(Map<String, dynamic> json) {
    return SurahInfo(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
    );
  }
}
