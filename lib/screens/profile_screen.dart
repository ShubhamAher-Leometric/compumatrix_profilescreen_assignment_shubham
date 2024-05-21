import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_screen_task_shubham/constants/color_constants.dart';
import 'package:profile_screen_task_shubham/screens/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profilePic = 'assets/avatars/avatar10.png';
  List<String> avatarImages = [
    'assets/avatars/avatar1.png',
    'assets/avatars/avatar2.png',
    'assets/avatars/avatar3.png',
    'assets/avatars/avatar4.png',
    'assets/avatars/avatar5.png',
    'assets/avatars/avatar6.png',
    'assets/avatars/avatar7.png',
    'assets/avatars/avatar8.png',
    'assets/avatars/avatar9.png',
    'assets/avatars/avatar10.png',
    'assets/avatars/avatar11.png',
    'assets/avatars/avatar12.png',
    'assets/avatars/avatar13.png',
    'assets/avatars/avatar14.png',
    'assets/avatars/avatar15.png',
    'assets/avatars/avatar16.png',
  ];
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  List<int> yearsList = List<int>.generate(50, (index) => DateTime.now().year - index);

  int? selectedYear;

  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    selectedYear = DateTime.now().year;
    _loadProfile();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _updateProfilePic(String imagePath) {
    setState(() {
      profilePic = imagePath;
    });
  }




  _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstNameController.text = prefs.getString('firstName') ?? 'John';
      _lastNameController.text = prefs.getString('lastName') ?? 'Blake';
      selectedYear = prefs.getInt('birthYear') ?? 1980;
      profilePic = prefs.getString('profilePic') ?? 'assets/avatars/avatar10.png';
    });
  }


  _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstName', _firstNameController.text);
    prefs.setString('lastName', _lastNameController.text);
    prefs.setInt('birthYear', selectedYear!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Let’s get to know you',
                      style: TextStyle(
                        fontFamily: 'Abel',
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        height: 1.7,
                      ),
                    ),
                    Text(
                      'Let us get to know you a bit better so you can get the best out of us',
                      style: TextStyle(
                        fontFamily: 'Abel',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 160,
                                  width: 160,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                  child: profilePic.startsWith('assets/')
                                      ? Image.asset(
                                    profilePic,
                                    fit: BoxFit.fill,
                                  )
                                      : Image.file(
                                    File(profilePic),
                                    fit: BoxFit.fill,
                                  ),
                    ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 35),
                                child: Container(
                                  height: 32,
                                  // width: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap:(){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditProfile(
                                            profilePic: profilePic,
                                            onUpdateProfilePic: _updateProfilePic,
                                          ),
                                        ),
                                      );

                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.camera_alt_outlined, size: 20),
                                        Text(
                                          'Edit',
                                          style: TextStyle(
                                            color: appPrimaryTextColor,
                                            fontSize: 14,
                                            fontFamily: 'Abel',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'First name',
                              style: TextStyle(
                                color: appSecondaryTextColor,
                                fontFamily: 'Abel',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.7,
                              ),
                            ),
                            Text(
                              '*',
                              style: TextStyle(
                                color: apperrorColor,
                                fontFamily: 'Abel',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.7,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 49,
                              width: MediaQuery.of(context).size.width-40,
                              decoration: BoxDecoration(
                                color: appBagroundColor,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  controller: _firstNameController,
                                  style: TextStyle(
                                    color: appSecondaryTextColor,
                                    fontFamily: 'Abel',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    height: 1.7,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter your first name',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: appSecondaryTextColor,
                                      fontFamily: 'Abel',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      height: 1.7,
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Last name',
                              style: TextStyle(
                                color: appSecondaryTextColor,
                                fontFamily: 'Abel',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.7,
                              ),
                            ),
                            Text(
                              '*',
                              style: TextStyle(
                                color: apperrorColor,
                                fontFamily: 'Abel',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.7,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 49,
                              width: MediaQuery.of(context).size.width-40,
                              decoration: BoxDecoration(
                                color: appBagroundColor,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  controller: _lastNameController,
                                  style: TextStyle(
                                    color: appSecondaryTextColor,
                                    fontFamily: 'Abel',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    height: 1.7,
                                  ),
                                  decoration: InputDecoration(
                                      hintText: 'Enter your last name',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: appSecondaryTextColor,
                                        fontFamily: 'Abel',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        height: 1.7,
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Year of birth',
                              style: TextStyle(
                                color: appSecondaryTextColor,
                                fontFamily: 'Abel',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.7,
                              ),
                            ),
                            Text(
                              '*',
                              style: TextStyle(
                                color: apperrorColor,
                                fontFamily: 'Abel',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.7,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 49,
                                decoration: BoxDecoration(
                                  color: appBagroundColor,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: DropdownButton<int>(
                                    isExpanded: true,
                                    value: selectedYear,
                                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                                    underline: SizedBox(),
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        selectedYear = newValue;
                                      });
                                    },
                                    items: yearsList.map<DropdownMenuItem<int>>((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(
                                          value.toString(),
                                          style: TextStyle(
                                            color: appSecondaryTextColor,
                                            fontFamily: 'Abel',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            height: 1.7,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomElevatedButton(
                text: 'Save',
                onPressed: () {
                _saveProfile();
              },
              ),
              Container(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

