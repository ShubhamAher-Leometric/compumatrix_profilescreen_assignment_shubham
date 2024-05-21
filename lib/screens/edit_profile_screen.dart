import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_screen_task_shubham/constants/color_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/custom_button.dart';
import 'dart:io';


class EditProfile extends StatefulWidget {
  final Function(String)? onUpdateProfilePic;
  final String profilePic;
  const EditProfile({Key? key, this.onUpdateProfilePic, required this.profilePic}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  int selectedImageIndex = -1;
  String? capturedImagePath;

  _saveProfilePic(String profilePicPath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profilePic', profilePicPath);
  }

  void _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      widget.onUpdateProfilePic?.call(pickedFile.path);
      _saveProfilePic(pickedFile.path);
      setState(() {
        capturedImagePath = pickedFile.path;
      });
    }
  }

  void _viewPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.onUpdateProfilePic?.call(pickedFile.path);
      _saveProfilePic(pickedFile.path);
      setState(() {
        capturedImagePath = pickedFile.path;
      });
    }
  }

  void _removePhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('profilePic');

    setState(() {
      capturedImagePath = '';
      widget.onUpdateProfilePic?.call('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children:[
            Center(
                 child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: appBagroundColor2,
                                ),
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Choose profile photo.',
                              style: TextStyle(
                                fontFamily: 'Abel',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                height: 1.7,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Choose a profile photo from your library or select an avatar to add to your profile',
                          style: TextStyle(
                            fontFamily: 'Abel',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.7,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: appBagroundColor2,
                          ),
                          child: TabBar(
                            indicatorWeight: 1,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: appPrimaryColor),
                            labelColor: Colors.white,
                            unselectedLabelColor: appPrimaryTextColor,
                            tabs: [
                              Tab(
                                child: Text(
                                  'Choose Photo',
                                  style: TextStyle(
                                    fontFamily: 'Abel',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Avatars',
                                  style: TextStyle(
                                    fontFamily: 'Abel',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 395,
                          width: 328,
                          child: TabBarView(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(200),
                                      child: Container(
                                        height: 328,
                                        width: 328,
                                        child: capturedImagePath != null
                                            ? Image.file(
                                          File(capturedImagePath!),
                                          fit: BoxFit.fill,
                                        )
                                            : widget.profilePic.startsWith('assets/')
                                            ? Image.asset(
                                          widget.profilePic,
                                          fit: BoxFit.fill,
                                        )
                                            : Image.file(
                                          File(widget.profilePic),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 43,
                                      width: 125,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF8FAFC),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.1),
                                          width: 1,
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          _showBottomSheet(context);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons.camera_alt_outlined,
                                                size: 22),
                                            Text(
                                              'Edit Photo',
                                              style: TextStyle(
                                                color: appPrimaryTextColor,
                                                fontSize: 16,
                                                fontFamily: 'Abel',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GridView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: avatarImages.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImageIndex = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: selectedImageIndex == index ? Colors.blue : Colors.transparent,
                                          width: selectedImageIndex == index ? 2 : 0,
                                        ),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: Image.asset(
                                          avatarImages[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomElevatedButton(
                    text: 'Save',
                    textColor: appPrimaryColor,
                    buttonColor: Colors.transparent,
                    onPressed: () {
                      if (selectedImageIndex != -1) {
                        if (selectedImageIndex < avatarImages.length) {
                          widget.onUpdateProfilePic!(avatarImages[selectedImageIndex]);
                        } else {
                          _saveProfilePic(widget.profilePic);
                        }
                      }
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
              ),
            // Positioned(
            //   top: 42,
            //   left: 20,
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //     child: Container(
            //       height: 44,
            //       width: 44,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: appBagroundColor2,
            //       ),
            //       padding: EdgeInsets.all(8),
            //       child: Icon(
            //         Icons.close,
            //         color: Colors.white,
            //         size: 24,
            //       ),
            //     ),
            //   ),
            // ),
            ]
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 32,
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      alignment: Alignment.center,
                      width: 40,
                      child: Divider(
                        thickness: 2,
                        color: appdisabledColor,
                        height: 4,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Upload Your Photo',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: appSecondaryTextColor,
                          fontFamily: 'Abel',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.asset(
                      'assets/icons/u_image-v.png',
                      height: 20,
                      width: 20,
                    ),
                    title: Text(
                      'View Photo Library',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: appSecondaryTextColor,
                        fontFamily: 'Abel',
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      _viewPhoto();
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.asset(
                      'assets/icons/u_camera.png',
                      height: 20,
                      width: 20,
                    ),
                    title: Text(
                      'Take a photo',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: appSecondaryTextColor,
                        fontFamily: 'Abel',
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      _takePhoto();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.asset(
                      'assets/icons/fi_trash-2.png',
                      height: 20,
                      width: 20,
                      color: apperrorColor,
                    ),
                    title: Text(
                      'Remove photo',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: apperrorColor,
                        fontFamily: 'Abel',
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      _removePhoto();
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
