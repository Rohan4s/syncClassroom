import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sync_classroom/screens/profile/create_user_info.dart';

class ProfileInfoScreen extends StatefulWidget {
  List<String> interests = [];

  ProfileInfoScreen({
    super.key,
    required this.interests,
  });

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _presentAddressController =
      TextEditingController();
  final TextEditingController _permanentAddressController =
      TextEditingController();
  final MultiSelectController controller = MultiSelectController();
  List<ValueItem> _selectedOptions = [];
  List<String> interests = [];

  @override
  void initState() {
    interests = widget.interests;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Profile Info',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _classController,
                decoration: const InputDecoration(
                  labelText: 'Class',
                  hintText: 'Enter your class',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _instituteController,
                decoration: const InputDecoration(
                  labelText: 'Institute',
                  hintText: 'Enter your institute',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _presentAddressController,
                decoration: const InputDecoration(
                  labelText: 'Present Address',
                  hintText: 'Enter your present address',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _permanentAddressController,
                decoration: const InputDecoration(
                  labelText: 'Permanent Address',
                  hintText: 'Enter your permanent address',
                ),
              ),
              const SizedBox(height: 20),
              MultiSelectDropDown(
                onOptionSelected: (selectedOptions) {
                  _selectedOptions = selectedOptions;
                },
                options: interests
                    .map(
                      (e) => ValueItem(
                        label: e,
                        value: e,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  createUserInfo(
                    dp: '',
                    enrolledClass: _classController.text,
                    institute: _instituteController.text,
                    presentAddress: _presentAddressController.text,
                    interests: interests,
                  );
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}
