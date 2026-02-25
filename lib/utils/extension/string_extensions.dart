extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }

    return substring(0, 1).toUpperCase() + substring(1);
  }

  String maskCardNumber() {
    int visibleLength = 4;
    String separator = ' ';
    final int totalLength = length;
    final int maskedLength = totalLength - visibleLength;
    final String maskedPart = '*' * maskedLength;
    final String visiblePart = substring(maskedLength);
    final String maskedCardNumber = maskedPart + separator + visiblePart;

    return maskedCardNumber.replaceAllMapped(
      RegExp('.{4}'),
      (match) => '${match.group(0)}$separator',
    );
  }
}
