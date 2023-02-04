class IncorrectException implements Exception {
  factory IncorrectException() =>
      _IncorrectException("Incorrect username or password");
}

class _IncorrectException implements IncorrectException {
  final dynamic message;

  _IncorrectException([this.message]);

  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}
