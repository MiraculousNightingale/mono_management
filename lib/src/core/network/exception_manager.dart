class UnauthorizedException implements Exception {
  UnauthorizedException(this.msg);

  String msg;
}

class ForbiddenException implements Exception {
  ForbiddenException(this.msg);

  String msg;
}

class NotFoundException implements Exception {
  NotFoundException(this.msg);

  String msg;
}

class InternalServerErrorException implements Exception {
  InternalServerErrorException(this.msg);

  String msg;
}

class BadRequestException implements Exception {
  BadRequestException(this.msg);

  String msg;
}

class PaymentRequiredException implements Exception {
  PaymentRequiredException(this.msg);

  String msg;
}

class TooManyRequestsException implements Exception {
  TooManyRequestsException(this.msg);

  String msg;
}

class NotAcceptableException implements Exception {
  NotAcceptableException(this.msg);

  String msg;
}

class ConflictException implements Exception {
  ConflictException(this.msg);

  dynamic msg;
}

final Map<int, dynamic> exceptions = {
  400: (String msg) => BadRequestException(msg),
  401: (String msg) => UnauthorizedException(msg),
  402: (String msg) => PaymentRequiredException(msg),
  403: (String msg) => ForbiddenException(msg),
  404: (String msg) => NotFoundException(msg),
  406: (String msg) => NotAcceptableException(msg),
  409: (dynamic msg) => ConflictException(msg),
  429: (String msg) => TooManyRequestsException(msg),
  500: (String msg) => InternalServerErrorException(msg),
};

/// Exception that throws when API call is failed
class FetchingDataException implements Exception {
  /// Constructor, [msg] is optional
  FetchingDataException({this.msg = ''});

  String msg;
}