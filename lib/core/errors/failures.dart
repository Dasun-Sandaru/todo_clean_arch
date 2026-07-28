// abstract failure class for application
abstract class Failures {
  final String message;
  Failures(this.message);

  @override
  String toString() => message;
}

// failure for server-related issues
class ServerFailure extends Failures {
  ServerFailure([super.message = 'Server Failure']);
}

// failure for database-related issues
class DatabaseFailure extends Failures {
  DatabaseFailure([super.message = 'Database Failure']);
}

// failure for domain/business rule related issues
class DomainFailure extends Failures {
  DomainFailure([super.message = 'Domain Failure']);
}
