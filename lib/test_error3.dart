void main() {
  dynamic json = {"id": null};
  try {
    String id = json["id"] ?? "";
    print("Success: $id");
  } catch (e) {
    print("Test 5: $e");
  }
}
