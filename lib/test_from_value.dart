void main() {
  dynamic m = {"key": null};
  try {
    var y = Map<String, dynamic>.from(m);
    print("Success");
  } catch (e) {
    print("Test 1: $e");
  }
}
