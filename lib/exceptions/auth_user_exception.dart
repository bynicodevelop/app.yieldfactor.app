class AuthUserException implements Exception {
  static const String unauthorized = 'Unauthorized';

  final String code;

  AuthUserException({
    required this.code,
  });
}
