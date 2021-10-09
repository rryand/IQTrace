class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class UnauthorizedHttpError extends CustomException {
  UnauthorizedHttpError(String message)
  : super(message, "Unauthorized: ");
}

class BadRequestHttpError extends CustomException {
  BadRequestHttpError(String message)
  : super(message, "Bad Request: ");
}

class ForbiddenHttpError extends CustomException {
  ForbiddenHttpError(String message)
  : super(message, "Forbidden: ");
}

class FetchDataHttpError extends CustomException {
  FetchDataHttpError(String message)
  : super(message, "Error: ");
}

class InvalidTokenType extends CustomException {
  InvalidTokenType(String message) 
  : super(message, "InvalidTokenType: ");
}
