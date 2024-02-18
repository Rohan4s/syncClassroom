import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_classroom/data/user_data.dart';
import 'package:sync_classroom/styles/app_texts.dart';

Future<String> login(String email, String password, BuildContext context) async {
  var dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    Response response =
        await dio.post('${AppTexts.apiBaseUrl}/auth/login', data: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      print(response);
      prefs.setString('email', email);
      prefs.setString('role', response.data['data']['role']);
      prefs.setString('name', response.data['data']['name']);
      prefs.setString('token', response.data['token']);
      LocalData.email = email;
      LocalData.role = response.data['data']['role'];
      LocalData.name = response.data['data']['name'];
      LocalData.token = response.data['token'];
      print(response.data['data']['role']);
      return 'success';
    }
    print(response);
    return response.data['message'];
  } catch (error) {
    if (error is DioError) {
      print(error);
      if (error.response?.statusCode == 403) {
        print('error 2= ${error.response?.data['error']}');
        return error.response?.data['error'];
      }
    }
    print('error asd = $error');
    return error.toString();
  }
}
