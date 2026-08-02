class MyClass {
  String myStr;
  MyClass(this.myStr);
}

void testMap(Map<String, dynamic> map) {
}

void main() {
  dynamic str = "hello";
  try {
    testMap(str);
  } catch (e) {
    print("Test 1: $e");
  }

  dynamic nullStr = null;
  try {
    String x = nullStr;
  } catch(e) {
    print("Test 2: $e");
  }

  try {
    testMap(nullStr);
  } catch(e) {
    print("Test 3: $e");
  }
}
