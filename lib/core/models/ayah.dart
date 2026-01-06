class Ayah {
  final int number;
  final String arabicText;
  final String englishTranslation;
  final SurahInfo surah;
  final int numberInSurah;
  final bool isBookmarked;

  Ayah({
    required this.number,
    required this.arabicText,
    required this.englishTranslation,
    required this.surah,
    required this.numberInSurah,
    this.isBookmarked = false,
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
        isBookmarked: arabicData['isBookmarked'] ?? false,
      );
    } else {
      // From cache (Map)
      return Ayah(
        number: data['number'],
        arabicText: data['arabicText'],
        englishTranslation: data['englishTranslation'],
        surah: SurahInfo.fromJson(data['surah']),
        numberInSurah: data['numberInSurah'],
        isBookmarked: data['isBookmarked'] ?? false,
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
      'isBookmarked': isBookmarked,
    };
  }

  Ayah copyWith({
    int? number,
    String? arabicText,
    String? englishTranslation,
    SurahInfo? surah,
    int? numberInSurah,
    bool? isBookmarked,
  }) {
    return Ayah(
      number: number ?? this.number,
      arabicText: arabicText ?? this.arabicText,
      englishTranslation: englishTranslation ?? this.englishTranslation,
      surah: surah ?? this.surah,
      numberInSurah: numberInSurah ?? this.numberInSurah,
      isBookmarked: isBookmarked ?? this.isBookmarked,
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

  factory SurahDetail.fromJson(dynamic data) {
    if (data is List) {
      // From API
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
            page: arabicAyahs[i]['page'],
            surahName: arabicSurah['englishName'],
            surahNumber: arabicSurah['number'],
            isBookmarked: false,
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
    } else {
      // From cache (Map)
      return SurahDetail(
        number: data['number'],
        name: data['name'],
        englishName: data['englishName'],
        englishNameTranslation: data['englishNameTranslation'],
        revelationType: data['revelationType'],
        numberOfAyahs: data['numberOfAyahs'],
        ayahs: (data['ayahs'] as List)
            .map((e) => AyahDetail.fromJson(e))
            .toList(),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'revelationType': revelationType,
      'numberOfAyahs': numberOfAyahs,
      'ayahs': ayahs.map((e) => e.toJson()).toList(),
    };
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
  final String? surahName;
  final int? surahNumber;
  final bool isBookmarked;

  AyahDetail({
    required this.number,
    required this.text,
    required this.translation,
    required this.numberInSurah,
    required this.juz,
    this.page,
    this.audio,
    this.audioSecondary,
    this.surahName,
    this.surahNumber,
    this.isBookmarked = false,
  });

  factory AyahDetail.fromJson(Map<String, dynamic> json) {
    return AyahDetail(
      number: json['number'],
      text: json['text'],
      translation: json['translation'],
      numberInSurah: json['numberInSurah'],
      juz: json['juz'],
      page: json['page'],
      audio: json['audio'],
      audioSecondary: json['audioSecondary'],
      surahName: json['surahName'],
      surahNumber: json['surahNumber'],
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
      'translation': translation,
      'numberInSurah': numberInSurah,
      'juz': juz,
      'page': page,
      'audio': audio,
      'audioSecondary': audioSecondary,
      'surahName': surahName,
      'surahNumber': surahNumber,
      'isBookmarked': isBookmarked,
    };
  }

  AyahDetail copyWith({
    int? number,
    String? text,
    String? translation,
    int? numberInSurah,
    int? juz,
    int? page,
    String? audio,
    String? audioSecondary,
    String? surahName,
    int? surahNumber,
    bool? isBookmarked,
  }) {
    return AyahDetail(
      number: number ?? this.number,
      text: text ?? this.text,
      translation: translation ?? this.translation,
      numberInSurah: numberInSurah ?? this.numberInSurah,
      juz: juz ?? this.juz,
      page: page ?? this.page,
      audio: audio ?? this.audio,
      audioSecondary: audioSecondary ?? this.audioSecondary,
      surahName: surahName ?? this.surahName,
      surahNumber: surahNumber ?? this.surahNumber,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
