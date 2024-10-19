class CustomException implements Exception {
  final String message;
  final int? statusCode;

  CustomException(this.message, {this.statusCode});

  @override
  String toString() {
    if (statusCode != null) {
      return 'Error $statusCode: $message';
    }
    return message;
  }
}
