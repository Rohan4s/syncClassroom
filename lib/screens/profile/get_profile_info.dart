import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_classroom/styles/app_texts.dart';

Future<List<String>> getUserProfile() async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  String role = prefs.getString('role') ?? '';
  String url = '';
  List<String> interests = [];
  if (role == 'admin') {
    url = '${AppTexts.apiBaseUrl}/teacher/get-profile';
  } else {
    url = '${AppTexts.apiBaseUrl}/student/get-profile';
  }
  try {
    final Response response = await dio.get(
      url,
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
    if (response.statusCode == 200) {
      interests = response.data['profile']['interests'];
      print(interests);
      return interests;
    }
  } catch (e) {
    if (e is DioError) {
      print(e.response?.data['error']);
    }
    print(e);
  }
  return interests;
}
