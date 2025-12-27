part of '../presentation/home_screen.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PrayerRepository _prayerRepository;
  final VerseOfTheDayRepository _verseRepository;
  final ReflectionRepository _reflectionRepository;
  Timer? _timer;

  HomeBloc({
    required PrayerRepository prayerRepository,
    required VerseOfTheDayRepository verseRepository,
    required ReflectionRepository reflectionRepository,
  }) : _prayerRepository = prayerRepository,
       _verseRepository = verseRepository,
       _reflectionRepository = reflectionRepository,
       super(const HomeState()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<UpdatePrayerTimer>(_onUpdatePrayerTimer);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final address = await _prayerRepository.getCurrentAddress();

      // Fetch data in parallel
      final results = await Future.wait([
        _prayerRepository.fetchPrayerTimings(address),
        _verseRepository.getVerseOfTheDay(),
        _reflectionRepository.getReflectionOfTheDay(),
      ]);

      final timings = results[0] as dynamic; // PrayerTimings
      final verse = results[1] as dynamic; // Ayah
      final reflection = results[2] as dynamic; // Ayah

      emit(
        state.copyWith(
          status: HomeStatus.success,
          address: address,
          timings: timings,
          verseOfTheDay: verse,
          reflectionOfTheDay: reflection,
        ),
      );

      _startTimer();
      add(UpdatePrayerTimer());
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, error: e.toString()));
    }
  }

  void _onUpdatePrayerTimer(UpdatePrayerTimer event, Emitter<HomeState> emit) {
    if (state.timings == null) return;

    final now = DateTime.now();
    final format = DateFormat("HH:mm");
    final keys = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

    DateTime? nextTime;
    String current = "Isha";

    for (int i = 0; i < keys.length; i++) {
      final timeStr = state.timings!.timings[keys[i]];
      if (timeStr == null) continue;

      final time = format.parse(timeStr);
      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      if (now.isBefore(dateTime)) {
        nextTime = dateTime;
        if (i > 0) {
          current = keys[i - 1];
        } else {
          current = "Isha";
        }
        break;
      }
    }

    if (nextTime == null) {
      final fajrStr = state.timings!.timings['Fajr']!;
      final time = format.parse(fajrStr);
      nextTime = DateTime(
        now.year,
        now.month,
        now.day + 1,
        time.hour,
        time.minute,
      );
      current = "Isha";
    }

    emit(
      state.copyWith(
        currentPrayer: current,
        timeLeft: nextTime.difference(now),
      ),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(UpdatePrayerTimer());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
