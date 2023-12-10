import 'dart:io';

Future<Map<String, String>> getHeader() async {
  Map<String, String> headers = {};
  headers[HttpHeaders.acceptLanguageHeader] = "en";
  headers[HttpHeaders.acceptEncodingHeader] = "gzip, deflate, br";
  headers[HttpHeaders.contentTypeHeader] = "application/json";
  headers[HttpHeaders.authorizationHeader] =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2JoYXZpc2h5YWFzdHJvLmNvbS9hZG1pbi9hcGkvbG9naW5BcHBVc2VyIiwiaWF0IjoxNjk4NDIxNDY0LCJleHAiOjE2OTg2Mzc0NjQsIm5iZiI6MTY5ODQyMTQ2NCwianRpIjoiMzRMWkt6UDljekdCNzRWNyIsInN1YiI6IjU0NCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.uBe9ckcfh8Z_t8DvIEnvt1GLRB8Nful2hqgMkovq78I';

  return headers;
}
