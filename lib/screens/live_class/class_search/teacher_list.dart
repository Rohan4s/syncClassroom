import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_classroom/models/teacher.dart';
import 'package:sync_classroom/styles/app_texts.dart';

Future<List<Teacher>> getTeacherList(String course) async {
  final dio = Dio();
  List<Teacher> teachers = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';

  try {
    final Response response =
        await dio.get('${AppTexts.apiBaseUrl}/search/teacher?tag=$course',
            options: Options(headers: {
              'Authorization': 'Bearer $token',
            }));
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['teachers'];
      for (int i = 0; i < data.length; i++) {
        String name = data[i]['user_info']['name'];
        String email = data[i]['user_info']['email'];
        double experience = data[i]['experience'];
        int hourlyRate = data[i]['hourly_rate'];
        Teacher teacher = Teacher(
          name: name,
          email: email,
          experience: experience,
          hourlyRate: hourlyRate,
        );
        teachers.add(teacher);
      }
      return teachers;
    }
  } on DioError catch (e) {
    if (e.response != null) {
      print(e.response!.data['status']);
    } else {
      print('An error occurred');
    }
    return teachers;
  }
  return teachers;
}
