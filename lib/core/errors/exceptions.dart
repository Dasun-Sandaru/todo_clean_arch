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
