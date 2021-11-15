import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class imagePickFromMobile{
  XFile? _uploadimage;
  ImagePicker picker = new ImagePicker();
    void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      title: new Text('Gallery'),
                      leading: new Icon(Icons.photo_library),
                      onTap: () {
                        chooseBirthCertificateFromGalary();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    title: new Text('Camera'),
                    leading: new Icon(Icons.photo_camera),
                    onTap: () {
                      chooseBirthCertificateFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
   getFile(){
      return _uploadimage;
  }
  Future<void> chooseBirthCertificateFromGalary() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.gallery);
    _uploadimage = choosedimage!;
    //set source: ImageSource.camera to get image from camera
  }

  Future<void> chooseBirthCertificateFromCamera() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.camera);
    //set source: ImageSource.camera to get image from camera
    _uploadimage = choosedimage!;
  }
}