import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sync_classroom/screens/home/home_screen.dart';
import 'package:sync_classroom/screens/profile/user_interests.dart';
import 'package:sync_classroom/styles/app_texts.dart';
import 'package:sync_classroom/utils/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getInterests();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
