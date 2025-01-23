import 'package:freezed_annotation/freezed_annotation.dart';


part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool isDarkMode,
  }) = _AppState;

  const AppState._();
}
