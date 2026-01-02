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

  factory Ayah.fromJson(dynamic data) {
    if (data is List) {
      final arabicData = data[0];
      final englishData = data[1];

      return Ayah(
        number: arabicData['number'],
        arabicText: arabicData['text'],
        englishTranslation: englishData['text'],
        surah: SurahInfo.fromJson(arabicData['surah']),
        numberInSurah: arabicData['numberInSurah'],
      );
    } else {
      // From cache (Map)
      return Ayah(
        number: data['number'],
        arabicText: data['arabicText'],
        englishTranslation: data['englishTranslation'],
        surah: SurahInfo.fromJson(data['surah']),
        numberInSurah: data['numberInSurah'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'arabicText': arabicText,
      'englishTranslation': englishTranslation,
      'surah': surah.toJson(),
      'numberInSurah': numberInSurah,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
    };
  }
}

class SurahDetail {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final int numberOfAyahs;
  final List<AyahDetail> ayahs;

  SurahDetail({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
    required this.ayahs,
  });

  factory SurahDetail.fromJson(List<dynamic> data) {
    final arabicSurah = data[0];
    final englishSurah = data[1];

    final List<dynamic> arabicAyahs = arabicSurah['ayahs'];
    final List<dynamic> englishAyahs = englishSurah['ayahs'];

    final List<AyahDetail> combinedAyahs = [];
    for (int i = 0; i < arabicAyahs.length; i++) {
      combinedAyahs.add(
        AyahDetail(
          number: arabicAyahs[i]['number'],
          text: arabicAyahs[i]['text'],
          translation: englishAyahs[i]['text'],
          numberInSurah: arabicAyahs[i]['numberInSurah'],
          juz: arabicAyahs[i]['juz'],
        ),
      );
    }

    return SurahDetail(
      number: arabicSurah['number'],
      name: arabicSurah['name'],
      englishName: arabicSurah['englishName'],
      englishNameTranslation: arabicSurah['englishNameTranslation'],
      revelationType: arabicSurah['revelationType'],
      numberOfAyahs: arabicSurah['numberOfAyahs'],
      ayahs: combinedAyahs,
    );
  }
}

class AyahDetail {
  final int number;
  final String text;
  final String translation;
  final int numberInSurah;
  final int juz;
  final int? page;
  final String? audio;
  final String? audioSecondary;

  AyahDetail({
    required this.number,
    required this.text,
    required this.translation,
    required this.numberInSurah,
    required this.juz,
    this.page,
    this.audio,
    this.audioSecondary,
  });
}
