import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp2/MainPage/settings.dart';
import 'package:myapp2/NewLogin/Login/shared/firebase_authentication.dart';

import '../colors.dart';

// TODO: CHANGE USERNAME, PHONE NUMB FUNCTIONALITY / CHANGE NULL IN PHONE NUMBER TO SOME DEFAULT VALUE // ADD ABOUT ME

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late PickedFile imageFile;
  final ImagePicker picker = ImagePicker();
  final myController = TextEditingController();
  bool showPassword = false;
  FirebaseAuthentication auth = FirebaseAuthentication();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget userInfoPanel(
      String labelText, String userInfo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText + " : ",
            style: TextStyle(
                color: Colors.white, fontSize: 15
            ),
          ),
          Text(
            userInfo,
            style: TextStyle(
              color: yellow, fontSize: 24
            )
          ),
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: topaz,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        color: (cllii.click == false) ? Colors.white : dark,
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: (cllii.click == false) ? Colors.white : dark,
                          ),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color:
                                  (cllii.click == false) ? Colors.white : dark,
                            ),
                            color: Colors.green,
                          ),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // TODO ADD ABOUT ME AND DO A PFP'S
              // Expanded(
              //   child: Container(
              //     height: 120,
              //     decoration: BoxDecoration(border: Border.all()),
              //     padding: EdgeInsets.all(8),
              //     alignment: Alignment.topLeft,
              //     child: SelectableText(
              //       "ABOUT ME: ",
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              userInfoPanel("User Name", auth.getUserName().toString()),
              userInfoPanel("E-mail", auth.getUserEmail().toString()),
              userInfoPanel("Joined Us", auth.getCreationTime().toString().substring(0,10)),
              userInfoPanel("Phone Number", auth.getPhoneNumber().toString()),

            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Choose Profile photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageFile = pickedFile!;
    });
  }

  Widget buildTextFieldName(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: myController,
        style: TextStyle(
            color: (cllii.click == false) ? Colors.black : Colors.white),
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
                color: (cllii.click == false) ? Colors.black : Colors.white),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              color: (cllii.click == false) ? Colors.black26 : Colors.white38,
            )),
      ),
    );
  }
}
