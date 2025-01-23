// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get showPassword => throw _privateConstructorUsedError;
  bool get isEmailNotValid => throw _privateConstructorUsedError;
  bool get isPasswordNotValid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  Map<String, String> get validationErrors =>
      throw _privateConstructorUsedError;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool showPassword,
      bool isEmailNotValid,
      bool isPasswordNotValid,
      String email,
      String password,
      Map<String, String> validationErrors});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? showPassword = null,
    Object? isEmailNotValid = null,
    Object? isPasswordNotValid = null,
    Object? email = null,
    Object? password = null,
    Object? validationErrors = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      showPassword: null == showPassword
          ? _value.showPassword
          : showPassword // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailNotValid: null == isEmailNotValid
          ? _value.isEmailNotValid
          : isEmailNotValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isPasswordNotValid: null == isPasswordNotValid
          ? _value.isPasswordNotValid
          : isPasswordNotValid // ignore: cast_nullable_to_non_nullable
              as bool,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      validationErrors: null == validationErrors
          ? _value.validationErrors
          : validationErrors // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
          _$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool showPassword,
      bool isEmailNotValid,
      bool isPasswordNotValid,
      String email,
      String password,
      Map<String, String> validationErrors});
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
      _$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? showPassword = null,
    Object? isEmailNotValid = null,
    Object? isPasswordNotValid = null,
    Object? email = null,
    Object? password = null,
    Object? validationErrors = null,
  }) {
    return _then(_$LoginStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      showPassword: null == showPassword
          ? _value.showPassword
          : showPassword // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailNotValid: null == isEmailNotValid
          ? _value.isEmailNotValid
          : isEmailNotValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isPasswordNotValid: null == isPasswordNotValid
          ? _value.isPasswordNotValid
          : isPasswordNotValid // ignore: cast_nullable_to_non_nullable
              as bool,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      validationErrors: null == validationErrors
          ? _value._validationErrors
          : validationErrors // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

class _$LoginStateImpl extends _LoginState {
  const _$LoginStateImpl(
      {this.isLoading = false,
      this.showPassword = false,
      this.isEmailNotValid = false,
      this.isPasswordNotValid = false,
      this.email = '',
      this.password = '',
      final Map<String, String> validationErrors = const {}})
      : _validationErrors = validationErrors,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool showPassword;
  @override
  @JsonKey()
  final bool isEmailNotValid;
  @override
  @JsonKey()
  final bool isPasswordNotValid;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String password;
  final Map<String, String> _validationErrors;
  @override
  @JsonKey()
  Map<String, String> get validationErrors {
    if (_validationErrors is EqualUnmodifiableMapView) return _validationErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_validationErrors);
  }

  @override
  String toString() {
    return 'LoginState(isLoading: $isLoading, showPassword: $showPassword, isEmailNotValid: $isEmailNotValid, isPasswordNotValid: $isPasswordNotValid, email: $email, password: $password, validationErrors: $validationErrors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.showPassword, showPassword) ||
                other.showPassword == showPassword) &&
            (identical(other.isEmailNotValid, isEmailNotValid) ||
                other.isEmailNotValid == isEmailNotValid) &&
            (identical(other.isPasswordNotValid, isPasswordNotValid) ||
                other.isPasswordNotValid == isPasswordNotValid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            const DeepCollectionEquality()
                .equals(other._validationErrors, _validationErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      showPassword,
      isEmailNotValid,
      isPasswordNotValid,
      email,
      password,
      const DeepCollectionEquality().hash(_validationErrors));

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState extends LoginState {
  const factory _LoginState(
      {final bool isLoading,
      final bool showPassword,
      final bool isEmailNotValid,
      final bool isPasswordNotValid,
      final String email,
      final String password,
      final Map<String, String> validationErrors}) = _$LoginStateImpl;
  const _LoginState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get showPassword;
  @override
  bool get isEmailNotValid;
  @override
  bool get isPasswordNotValid;
  @override
  String get email;
  @override
  String get password;
  @override
  Map<String, String> get validationErrors;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
