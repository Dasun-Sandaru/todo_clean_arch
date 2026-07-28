// core base exceptions for application
abstract class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

// thrown when server/API returns an error status code
class ServerException extends AppException {
  ServerException([super.message = 'Server Error']);
}

// thrown when local database/cache oprations fail
class DatabaseException extends AppException {
  DatabaseException([super.message = 'Database Error']);
}

// thrown when core Domain Business rules are violated
class DomainException extends AppException {
  DomainException([super.message = 'Business Error']);
}

class NetworkException extends AppException {
  NetworkException({required String message}) : super(message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException({required String message}) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException({required String message}) : super(message);
}

class NotFoundException extends AppException {
  NotFoundException({required String message}) : super(message);
}

class RequestCancelledException extends AppException {
  RequestCancelledException({required String message}) : super(message);
}

class UnknownException extends AppException {
  UnknownException({required String message}) : super(message);
}

class ConflictException extends AppException {
  ConflictException({required String message}) : super(message);
}

class ForbiddenException extends AppException {
  ForbiddenException({required String message}) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException({required String message}) : super(message);
}

class CacheException extends AppException {
  CacheException([super.message = 'Cache Error']);
}
