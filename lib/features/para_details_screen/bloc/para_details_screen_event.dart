import 'package:equatable/equatable.dart';

abstract class ParaDetailsScreenEvent extends Equatable {
  const ParaDetailsScreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadParaDetailsScreenData extends ParaDetailsScreenEvent {
  final int paraNumber;

  const LoadParaDetailsScreenData(this.paraNumber);

  @override
  List<Object?> get props => [paraNumber];
}
