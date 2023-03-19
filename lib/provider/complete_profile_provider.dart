import 'dart:io';

import 'package:chat/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileProvider extends ChangeNotifier {
  File? imageFile;
  final TextEditingController fullNameController = TextEditingController();
  bool isLoading = false;
  int progress = 0;
  UserModel currentUser = UserModel();

  changeProgress(int number) {
    progress = number;
    notifyListeners();
  }

  void loading(bool load) {
    isLoading = load;
    notifyListeners();
  }

  void showPickOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo_library),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                  const Text('Gallery'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  const Text('Camera'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void getImage(ImageSource imageSource) async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      cropImage(pickedFile.path);
      imageFile = File(pickedFile.path);
    }
  }

  void cropImage(String path) async {
    ImageCropper imageCropper = ImageCropper();
    CroppedFile? croppedIMage = await imageCropper.cropImage(
        compressFormat: ImageCompressFormat.png,
        sourcePath: path,
        compressQuality: 10);
    if (croppedIMage != null) {
      imageFile = File(croppedIMage.path);
      notifyListeners();
    }
  }

  Future<bool?> uploadData({required UserModel userModel}) async {
    loading(true);
    try {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('profilepictures')
          .child(userModel.uid.toString())
          .putFile(File(imageFile!.path));

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      String fullName = fullNameController.text.trim();

      currentUser = UserModel(
          uid: userModel.uid,
          name: fullName,
          profilePic: imageUrl,
          email: userModel.email);
      // userModel.profilePic = imageUrl;
      //  userModel.name = fullName;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userModel.uid)
          .set(currentUser.toMap());

      loading(false);

      Fluttertoast.showToast(msg: "profile completed");

      notifyListeners();

      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      loading(false);
      notifyListeners();
      return false;
    }
  }
}
