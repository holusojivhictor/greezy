extension StringExtensions on String? {
  bool get isNullEmptyOrWhitespace => this == null || this!.isEmpty || this!.trim().isEmpty;
  bool get isNotNullEmptyOrWhitespace => !isNullEmptyOrWhitespace;

  bool get isNullEmptyOrWhitespaceOrHasNull => this == null || this!.isEmpty || this!.contains('null');
  bool get isNotNullEmptyOrWhitespaceNorHasNull => !isNullEmptyOrWhitespaceOrHasNull;

  bool isValidLength({int minLength = 0, int maxLength = 255}) => isNotNullEmptyOrWhitespace ||this!.length > maxLength || this!.length < minLength;
}

extension NonNullStringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}