import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_classroom/screens/profile/user_interests.dart';

class ShowProfile extends StatefulWidget {
  const ShowProfile({super.key});

  @override
  State<ShowProfile> createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  late SharedPreferences prefs;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);
  final dio = Dio();
  List<String> interests = [];
  bool flag = false;
  String role = '';

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      role = prefs.getString('role') == 'admin' ? 'Teacher' : 'Student';
      if (!flag) {
        flag = true;
      } else {
        isLoading.value = false;
      }
    });
    getInterests().then((value) {
      interests = value;
      print(interests);
      if (!flag) {
        flag = true;
      } else {
        isLoading.value = false;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Center(
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width / 4,
                backgroundImage: const AssetImage('assets/user.png'),
              ),
            ),
            const SizedBox(height: 50),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                if (value) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  '${prefs.getString('name')}',
                  style: style,
                );
              },
            ),
            // const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                if (value) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  '${prefs.getString('email')}',
                  style: style,
                );
              },
            ),
            // const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                if (value) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  role,
                  style: style,
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                if (value) {
                  return const SizedBox();
                }
                return Text(
                  'Area Of Expertise:',
                  style: style,
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                if (value) {
                  return const CircularProgressIndicator();
                }
                return SizedBox(
                  height: 200,
                  child: Wrap(
                    spacing: 10,
                    children: interests
                        .map(
                          (e) => Chip(
                            label: Text(e),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
