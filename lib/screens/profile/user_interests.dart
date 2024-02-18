import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_classroom/data/user_data.dart';
import 'package:sync_classroom/screens/auth/login/login.dart';
import 'package:sync_classroom/styles/app_texts.dart';

Future<List<String>> getInterests() async {
  final dio = Dio();
  List<String> interests = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';

  try {
    final Response response =
        await dio.get('${AppTexts.apiBaseUrl}/experties/get-all',
            options: Options(headers: {
              'Authorization': 'Bearer $token',
            }));
    print(response.data);
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['experties'];
      for (int i = 0; i < data.length; i++) {
        // print(data[i]['name']);
        interests.add(data[i]['name']);
        // print(interests[interests.length - 1]);
      }
      LocalData.interests = interests;

      // interests = response.data['interests'].cast<String>();
    }
  } on DioError catch (e) {
    if (e.response != null) {
      print(e.response!.data['status']);
    } else {
      print('An error occurred');
    }
  }
  print(interests);
  return interests;
}

