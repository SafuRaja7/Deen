import 'package:deen/features/hadith/data/models/hadith.dart';
import 'package:deen/features/hadith/data/models/hadith_chapter.dart';
import 'package:equatable/equatable.dart';

enum HadithStatus { initial, loading, success, failure }

class HadithState extends Equatable {
  final HadithStatus status;
  final String? error;
  final List<HadithChapter> chapters;
  final String? selectedBookSlug;
  final List<Hadith> hadiths;
  final int currentPage;
  final bool hasMore;
  final bool loadingMore;

  const HadithState({
    this.status = HadithStatus.initial,
    this.error,
    this.chapters = const [],
    this.selectedBookSlug,
    this.hadiths = const [],
    this.currentPage = 1,
    this.hasMore = true,
    this.loadingMore = false,
  });

  HadithState copyWith({
    HadithStatus? status,
    String? error,
    List<HadithChapter>? chapters,
    String? selectedBookSlug,
    List<Hadith>? hadiths,
    int? currentPage,
    bool? hasMore,
    bool? loadingMore,
  }) {
    return HadithState(
      status: status ?? this.status,
      error: error ?? this.error,
      chapters: chapters ?? this.chapters,
      selectedBookSlug: selectedBookSlug ?? this.selectedBookSlug,
      hadiths: hadiths ?? this.hadiths,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }

  @override
  List<Object?> get props => [
    status,
    error,
    chapters,
    selectedBookSlug,
    hadiths,
    currentPage,
    hasMore,
    loadingMore,
  ];
}
