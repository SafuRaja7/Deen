class Hadith {
  final int id;
  final String hadithNumber;
  final String englishNarrator;
  final String hadithEnglish;
  final String hadithUrdu;
  final String urduNarrator;
  final String hadithArabic;
  final String? headingArabic;
  final String? headingUrdu;
  final String? headingEnglish;
  final String chapterId;
  final String bookSlug;
  final String volume;
  final String status;

  Hadith({
    required this.id,
    required this.hadithNumber,
    required this.englishNarrator,
    required this.hadithEnglish,
    required this.hadithUrdu,
    required this.urduNarrator,
    required this.hadithArabic,
    this.headingArabic,
    this.headingUrdu,
    this.headingEnglish,
    required this.chapterId,
    required this.bookSlug,
    required this.volume,
    required this.status,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      id: json['id'] as int,
      hadithNumber: json['hadithNumber'] as String,
      englishNarrator: json['englishNarrator'] ?? "",
      hadithEnglish: json['hadithEnglish'] ?? "",
      hadithUrdu: json['hadithUrdu'] ?? "",
      urduNarrator: json['urduNarrator'] ?? "",
      hadithArabic: json['hadithArabic'] ?? "",
      headingArabic: json['headingArabic'] as String?,
      headingUrdu: json['headingUrdu'] as String?,
      headingEnglish: json['headingEnglish'] as String?,
      chapterId: json['chapterId'] as String,
      bookSlug: json['bookSlug'] as String,
      volume: json['volume'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hadithNumber': hadithNumber,
      'englishNarrator': englishNarrator,
      'hadithEnglish': hadithEnglish,
      'hadithUrdu': hadithUrdu,
      'urduNarrator': urduNarrator,
      'hadithArabic': hadithArabic,
      'headingArabic': headingArabic,
      'headingUrdu': headingUrdu,
      'headingEnglish': headingEnglish,
      'chapterId': chapterId,
      'bookSlug': bookSlug,
      'volume': volume,
      'status': status,
    };
  }
}
