class HadithChapter {
  final int id;
  final String chapterNumber;
  final String chapterEnglish;
  final String chapterUrdu;
  final String chapterArabic;
  final String bookSlug;

  HadithChapter({
    required this.id,
    required this.chapterNumber,
    required this.chapterEnglish,
    required this.chapterUrdu,
    required this.chapterArabic,
    required this.bookSlug,
  });

  factory HadithChapter.fromJson(Map<String, dynamic> json) {
    return HadithChapter(
      id: json['id'] as int,
      chapterNumber: json['chapterNumber'] as String,
      chapterEnglish: json['chapterEnglish'] as String,
      chapterUrdu: json['chapterUrdu'] as String,
      chapterArabic: json['chapterArabic'] as String,
      bookSlug: json['bookSlug'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chapterNumber': chapterNumber,
      'chapterEnglish': chapterEnglish,
      'chapterUrdu': chapterUrdu,
      'chapterArabic': chapterArabic,
      'bookSlug': bookSlug,
    };
  }
}
