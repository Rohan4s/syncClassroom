import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sync_classroom/styles/app_texts.dart';

Future<String> createAccount({
  required String name,
  required String email,
  required String password,
  required String confirmPassword,
  required String role,
  String about = '',
  required BuildContext context,
}) async {
  final dio = Dio();
  role = (role == 'Teacher') ? 'admin' : 'user';

  try {
    final response = await dio.post(
      '${AppTexts.apiBaseUrl}/auth/register',
      data: {
        'name': name,
        'email': email,
        'role': role,
        'password': password,
        'confirmPassword': confirmPassword,
        'about': about,
      },
    );

    print(response);

    if (response.statusCode == 201) {
      print(response);
      return 'success';
    } else {
      // Handle different status codes or other error cases
      print(response);
      return 'Error: ${response.statusCode}';
    }
  } catch (error) {
    // Handle DioError or general errors
    if(error is DioError) {
      print(error);
      if (error.response?.statusCode == 403) {
        return error.response?.data['error'];
      }
    }
    print('Error: $error');
    return error.toString();
  }
}
