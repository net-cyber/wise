import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(false) bool isLoading,
    @Default(false) bool showPassword,
    @Default(false) bool showConfirmPassword,
    @Default(false) bool isEmailInvalid,
    @Default(false) bool isNameInvalid,
    @Default(false) bool isUserNameInvalid,
    @Default(false) bool isPasswordInvalid,
    @Default(false) bool isConfirmPasswordInvalid,
    @Default('') String email,
    @Default('') String name,
    @Default('') String userName,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default({}) Map<String, String> validationErrors,
  }) = _RegisterState;

  const RegisterState._();
}