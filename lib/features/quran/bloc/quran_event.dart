import 'package:equatable/equatable.dart';

abstract class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuranData extends QuranEvent {}

class ChangeQuranTab extends QuranEvent {
  final int index;
  const ChangeQuranTab(this.index);

  @override
  List<Object?> get props => [index];
}
