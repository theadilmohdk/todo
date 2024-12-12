import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {


  Future<String> authenticateUser (String email, String password) async {
  try {
    final url = Uri.parse("https://erpbeta.cloudocz.com/api/auth/login");
    final headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
    };
    final body = json.encode({
      "email": email,
      "password": password,
    });

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      throw Exception("Invalid email or password");
    } else {
      throw Exception("An error occurred. Please try again.");
    }
  } catch (error) {
    throw Exception("An error occurred. Please try again.");
  }
}


  // Future<String> authenticateUser(String email, String password) async {
  //   try {
  //     final url = Uri.parse("https://erpbeta.cloudocz.com/api/auth/login");
  //     final headers = {
  //       "Content-Type": "application/json",
  //       "Accept": "*/*",
  //       "Accept-Encoding": "gzip, deflate, br",
  //       "Connection": "keep-alive",
  //     };
  //     final body = json.encode({
  //       "email": email,
  //       "password": password,
  //     });

  //     final response = await http.post(
  //       url,
  //       headers: headers,
  //       body: body,
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       print(response.body);
  //       return data['token'];
  //     } else if (response.statusCode == 401) {
  //       throw Exception("Invalid email or password");
  //     } else {
  //       throw Exception("An error occurred. Please try again.");
  //     }
  //   } catch (error) {
  //     throw Exception("An error occurred. Please try again.");
  //   }
  // }
}
