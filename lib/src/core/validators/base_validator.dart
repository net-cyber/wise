abstract class BaseValidator<T> {
  String? validate(T value);
  bool isValid(T value) => validate(value) == null;
}