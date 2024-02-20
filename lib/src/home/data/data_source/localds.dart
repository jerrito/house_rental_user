import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeLocalDatasource {
  Future<XFile> getProfileImageCamera();
  Future<XFile> getProfileImageGallery();
  Future<String> upLoadImage(Map<String, dynamic> params);
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  @override
  Future<XFile> getProfileImageCamera() async {
    final result = await ImagePicker().pickImage(source: ImageSource.camera);
    if (result != null) {
      XFile file = XFile(result.path);
      return file;
    } else {
      throw Exception("Error getting image");
    }
  }

  @override
  Future<XFile> getProfileImageGallery() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      XFile file = XFile(result.path);
      return file;
    } else {
      throw Exception("Error getting image");
    }
  }

  @override
  Future<String> upLoadImage(Map<String, dynamic> params) async {
    //Upload file
    final upLoadPath = FirebaseStorage.instance.ref().child(
          params["phone_number"],
        );

    final upLoadTask = upLoadPath.child(params["path"]).putFile(File(params["path"]));

    String? returnURL;
    await upLoadTask.whenComplete(
      () => upLoadPath.child(params["path"]).getDownloadURL().then((value) => 
      returnURL = value),
    );
    
    return returnURL!;
  }
}
