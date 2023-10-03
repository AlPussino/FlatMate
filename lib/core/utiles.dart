import 'dart:io';

const Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: 'application/json'
};

Map<String, String> authHeaders({required String token}) {
  return {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
}
