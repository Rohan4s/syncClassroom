import 'package:flutter/material.dart';
import 'package:sync_classroom/data/user_data.dart';
import 'package:sync_classroom/screens/auth/logout.dart';
import 'package:sync_classroom/screens/profile/user_interests.dart';
import 'package:sync_classroom/styles/app_texts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // logout();
    LocalData.updateData().then((value) {
      if (LocalData.email == '') {
        Future.delayed(Duration.zero, () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppTexts.loginRoute,
            (route) => false,
          );
        });
      } else {
        print('Email: ${LocalData.email}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sync Classroom',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              logout();
              var pushNamedAndRemoveUntil = Navigator.pushNamedAndRemoveUntil(
                context,
                AppTexts.loginRoute,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
          GestureDetector(
            onTap: () async {
              // List<String> interests = await getUserInterests();
              // if (context.mounted) {
              //   Navigator.pushNamed(
              //     context,
              //     AppTexts.profileInfoRoute,
              //     arguments: interests,
              //   );
              // }
              Navigator.pushNamed(context, AppTexts.showProfileRoute);
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/user.png'),
            ),
          ),

          const SizedBox(width: 16),
        ],
      ),
      body: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        padding: const EdgeInsets.all(10),
        children: [
          Card(
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                AppTexts.classDetailRoute,
              ),
              child: const Center(
                child: Text('Live Class'),
              ),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(context, AppTexts.manageVideoRoute);
              },
              child: const Center(
                child: Text('Manage Video'),
              ),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(context, AppTexts.manageAudioRoute);
              },
              child: const Center(
                child: Text('Manage Audio'),
              ),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(context, AppTexts.manageDocumentRoute);
              },
              child: const Center(
                child: Text('Manage Document'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
