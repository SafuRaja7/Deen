import 'package:equatable/equatable.dart';

abstract class HadithEvent extends Equatable {
  const HadithEvent();

  @override
  List<Object?> get props => [];
}

class LoadHadithData extends HadithEvent {}

class LoadHadithChapters extends HadithEvent {
  final String bookSlug;

  const LoadHadithChapters(this.bookSlug);

  @override
  List<Object?> get props => [bookSlug];
}

class LoadHadiths extends HadithEvent {
  final String bookSlug;
  final String chapterNumber;
  final bool loadMore;

  const LoadHadiths({
    required this.bookSlug,
    required this.chapterNumber,
    this.loadMore = false,
  });

  @override
  List<Object?> get props => [bookSlug, chapterNumber, loadMore];
}
