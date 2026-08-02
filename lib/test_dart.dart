import 'dart:convert';
import 'package:giftpose/screens/authentication/models/signin_response.dart';

void main() {
  String responseText = '''
{"status":true,"message":"Login successful","data":{"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNTAxYmY1M2RlZTk3NDliMTA5ZDFkMSIsImVtYWlsIjoiZm9sYXRlQG1haWxpbmF0b3IuY29tIiwiaWF0IjoxNzgzNjM4Nzg2LCJleHAiOjE3ODQ1MDI3ODZ9.sKpS18on72gk_Cgi8t5rQ5nXs0NWXBypdgklW5YLsXM","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNTAxYmY1M2RlZTk3NDliMTA5ZDFkMSIsImlhdCI6MTc4MzYzODc4NiwiZXhwIjoxNzg0MjQzNTg2fQ.fgWnSmoc3bqH9v69MMB_-EJdt-2rLVgtKlaLKK_ixOI","user":{"id":"6a501bf53dee9749b109d1d1","fullname":"Folaranmi","email":"folate@mailinator.com","username":"Folar"}}}
''';

  try {
    var decoded = jsonDecode(responseText);
    var response = SignInResponse.fromJson(decoded);
    print("Success: ${response.message}");
  } catch (e, stack) {
    print("Error: $e");
    print("Stack: $stack");
  }
}
