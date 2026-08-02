void main() {
  dynamic m = {null: "value"};
  try {
    var x = Map<String, dynamic>.from(m);
  } catch (e) {
    print("Test 1: $e");
  }

  dynamic m2 = {"key": null};
  try {
    var y = Map<String, dynamic>.from(m2);
  } catch (e) {
    print("Test 2: $e");
  }
}
