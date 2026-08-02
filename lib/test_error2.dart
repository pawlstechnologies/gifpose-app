void main() {
  dynamic json = {"id": null};
  try {
    String id = json["id"];
  } catch (e) {
    print("Test 4: $e");
  }
}
