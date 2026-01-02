import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/para_details_screen/bloc/para_details_screen_event.dart';
import 'package:deen/features/para_details_screen/bloc/para_details_screen_state.dart';
import 'package:deen/features/para_details_screen/data/para_repository.dart';

class ParaDetailsScreenBloc
    extends Bloc<ParaDetailsScreenEvent, ParaDetailsScreenState> {
  final ParaRepository _repository = ParaRepository();

  ParaDetailsScreenBloc() : super(const ParaDetailsScreenState()) {
    on<LoadParaDetailsScreenData>(_onLoadParaDetailsScreenData);
  }

  Future<void> _onLoadParaDetailsScreenData(
    LoadParaDetailsScreenData event,
    Emitter<ParaDetailsScreenState> emit,
  ) async {
    emit(state.copyWith(status: ParaDetailsScreenStatus.loading));
    try {
      final ayahs = await _repository.fetchPara(event.paraNumber);

      emit(
        state.copyWith(status: ParaDetailsScreenStatus.success, ayahs: ayahs),
      );

      // Save Last Read (use first ayah of the Para as the bookmark)
      if (ayahs.isNotEmpty) {
        await _repository.saveLastRead(
          surahNumber: ayahs.first.surahNumber ?? 1,
          surahName: ayahs.first.surahName ?? "Al-Fatihah",
          ayahNumber: ayahs.first.numberInSurah,
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ParaDetailsScreenStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
