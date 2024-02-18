import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_classroom/styles/app_texts.dart';

Future<String> createUserInfo({
  String enrolledClass = '',
  String institute = '',
  String presentAddress = '',
  List<String> interests = const [],
  String dp = '',
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final dio = Dio();

  String? role = prefs.getString('role');
  if (role != null && role == 'student') {
    String? token = prefs.getString('token');
    if (token != null) {
      try {
        final response = await dio.post(
          '${AppTexts.apiBaseUrl}/user/create-info',
          data: {
            'class': enrolledClass,
            'dp': dp,
            'institute': institute,
            'present_address': presentAddress,
            'interests': interests,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
        if (response.statusCode == 201) {
          return 'success';
        } else {
          return 'An error occurred';
        }
      } on DioError catch (e) {
        if (e.response != null) {
          return e.response!.data['error'];
        } else {
          return 'An error occurred';
        }
      }
    } else {
      throw Exception('Token not found');
    }
  } else {
    throw Exception('You are not a student');
  }
}
