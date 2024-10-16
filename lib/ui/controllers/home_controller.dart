import 'package:brian_test/domain/model/lat_long.dart';
import 'package:brian_test/domain/model/weather.dart';
import 'package:brian_test/domain/use_case/get_current_position_use_case.dart';
import 'package:brian_test/domain/use_case/get_weather_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

enum PositionState { none, loading, success, disabled, denied, error }

class HomeController {
  HomeController._();

  static final _getIt = GetIt.instance;

  static final instance = _getIt.get<HomeController>();

  static void setup() {
    _getIt.registerLazySingleton<HomeController>(
      HomeController._,
      dispose: (d) => d.dispose(),
    );
  }

  final _getCurrentPositionUseCase = GetCurrentPosition();
  final _getWeatherUseCase = GetWeather();

  final positionState = signal(PositionState.none);
  String? errorPosition;

  final weather = signal<Weather?>(null);

  void initSettings() {
    if (positionState.value == PositionState.success) {
      return;
    }

    positionState.value = PositionState.loading;

    _getCurrentPositionUseCase.call(
      onSuccess: (value) {
        positionState.value = PositionState.success;

        callWeather(value);
      },
      onServiceDisabled: () {
        positionState.value = PositionState.disabled;
      },
      onPermissionDenied: () {
        positionState.value = PositionState.denied;
      },
      onError: (value) {
        errorPosition = value;
        positionState.value = PositionState.error;
      },
    );
  }

  void callWeather(LatLong latLong) {
    weather.value = null;

    _getWeatherUseCase.call(
      latLong: latLong,
      onSuccess: (value) {
        weather.value = value;
      },
      onError: (value) {},
    );
  }

  void dispose() {}
}
