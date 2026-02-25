extension BoolParsing on String? {
  bool? parseBool() {
    if (this?.toLowerCase() == 'true') {
      return true;
    } else if (this?.toLowerCase() == 'false') {
      return false;
    } else {
      return null;
    }
  }
}
