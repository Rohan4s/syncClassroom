import 'package:flutter/material.dart';
import 'package:sync_classroom/data/user_data.dart';
import 'package:sync_classroom/models/teacher.dart';
import 'package:sync_classroom/screens/live_class/class_search/teacher_list.dart';
import 'package:sync_classroom/styles/app_texts.dart';

class ClassDetailsScreen extends StatefulWidget {
  const ClassDetailsScreen({super.key});

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  final ValueNotifier<String> errorMessage = ValueNotifier<String>('');
  final ValueNotifier<String?> tagController = ValueNotifier<String?>('');
  ValueNotifier<String?> selectedTeacher = ValueNotifier<String>('');
  ValueNotifier<bool> teacherListLoaded = ValueNotifier<bool>(false);
  late List<Teacher> teacherList;

  final TextStyle inputTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  final TextStyle textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Search Teacher',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      // body: Container(),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: tagController,
            builder: (context, value, child) {
              if (value == '' || value == null) {
                return Center(
                  child: TextButton.icon(
                    onPressed: () async {
                      tagController.value = await showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(
                          LocalData.interests, // List of teachers
                        ),
                      );
                      if (tagController.value != null) {
                        teacherList = await getTeacherList(tagController.value??'');
                        teacherListLoaded.value = true;
                      }
                    },
                    label: const Text(
                      'Your Desired Topic',
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: const Icon(Icons.search),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'Selected Topic: $value',
                    style: textStyle,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: teacherListLoaded,
            builder: (context, value, child) {
              if (value) {
                return Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: teacherList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          selectedTeacher.value = 'Teacher $index';
                          Navigator.of(context).pushNamed(AppTexts.classScreenRoute);
                        },
                        child: Card(
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              const CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage('assets/user.png'),
                              ),
                              const Expanded(child: SizedBox()),
                              Column(
                                children: [
                                  Text(
                                    teacherList[index].name,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    teacherList[index].email,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Experience: ${teacherList[index].experience}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Hourly Rate: ${teacherList[index].hourlyRate}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> items;

  CustomSearchDelegate(this.items);

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the search bar (e.g., clear query button)
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the search bar (e.g., back button)
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        print(
            '---------------------------------------------------------------------');
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the search results based on the query
    final List<String> results = items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            // Handle the selected result

            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions that are shown while the user types
    final List<String> suggestions = items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            // Handle the selected suggestion
            close(context, suggestions[index]);
          },
        );
      },
    );
  }
}

// ValueListenableBuilder(
// valueListenable: selectedTeacher,
// builder: (context, value, child) => (value == '' || value == null)
// ? const SizedBox()
//     : IconButton(
// onPressed: () async {
// selectedTeacher.value = await showSearch(
// context: context,
// delegate: CustomSearchDelegate(
// List.generate(50,
// (index) => 'Teacher $index'), // List of teachers
// ),
// );
// },
// icon: const Icon(Icons.search),
// ),
// ),
// Expanded(
// child: ListView.builder(
// // shrinkWrap: true,
// itemCount: 50,
// itemBuilder: (context, index) {
// return ListTile(
// title: Text('Teacher $index'),
// onTap: () {
// selectedTeacher.value = 'Teacher $index';
// },
// );
// },
// ),
// ),
