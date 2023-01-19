import 'dart:convert';

import 'package:cfc/utils/cfc_utils.dart';
import 'package:http/http.dart';

class CFCApiClient {
  final Client _client = Client();
  final String _baseUrl = 'https://us-central1-cfc-trublo-b47e5.cloudfunctions.net/app';
  final String _accessTokenBaseUrl = 'https://identitytoolkit.googleapis.com/v1';
  final String _nftBaseUrl = 'http://51.138.184.126:5001/v1';
  final Map<String, String> _headers = {"Content-Type": "application/json"};

  Map<String, String> _getHeader(String token) {
    return {'Content-Type': 'application/json', 'Authorization': "Bearer $token"};
  }

  Future<Map<String, dynamic>> sendOTP({required String emailId}) async {
    var tokenResponse = await getToken();
    Map<String, String> jsonObject = {'email': emailId};
    Uri url = Uri.parse('$_baseUrl/send-otp');
    var response = await _client.post(url, headers: _getHeader(tokenResponse['idToken']), body: jsonEncode(jsonObject));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw 'Response status code: ${response.statusCode}';
    }
  }

  Future<Map<String, dynamic>> verifyOTP({required String emailId, required String otp}) async {
    var tokenResponse = await getToken();
    Map<String, String> jsonObject = {'email': emailId, 'otp': otp};
    Uri url = Uri.parse('$_baseUrl/verify-otp');
    var response = await _client.post(url, headers: _getHeader(tokenResponse['idToken']), body: jsonEncode(jsonObject));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw 'Response status code: ${response.statusCode}';
    }
  }

  Future<Map<String, dynamic>> getToken() async {
    Uri url = Uri.parse('$_accessTokenBaseUrl/accounts:signInWithPassword');
    var response = await _client.post(url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"}, body: CFCHelper.getAccessTokenCredential);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw 'Response status code: ${response.statusCode}';
    }
  }

  Future<Map<String, dynamic>> getPopNFT() async {
    Uri url = Uri.parse('$_nftBaseUrl/get-popNFT');
    var response = await _client.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw 'Response status code: ${response.statusCode}';
    }
  }

  Future<Map<String, dynamic>> getLearningNFT() async {
    Uri url = Uri.parse('$_nftBaseUrl/get-learningNFT');
    var response = await _client.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw 'Response status code: ${response.statusCode}';
    }
  }
}
