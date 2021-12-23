
import 'dart:io';

import 'package:ciapp/constants.dart';
import 'package:ciapp/screens/dashboard/components/profile/firestorage_uploader.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectorDialog extends StatefulWidget {
  String uid;

  ImageSelectorDialog({Key key, this.uid}) : super(key: key);

  @override
  _ImageSelectorDialogState createState() => _ImageSelectorDialogState();
}

class _ImageSelectorDialogState extends State<ImageSelectorDialog> {
  File _imageFile;
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    PickedFile selectedImage = await picker.getImage(source: source);

    if (selectedImage != null) {
      setState(() {
        _imageFile = File(selectedImage.path);
      });
    }
  }

  Future<void> _cropImage() async {
    File croppedFile =
        await ImageCropper.cropImage(sourcePath: _imageFile.path);

    setState(() {
      _imageFile = croppedFile ?? _imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kBackgroundColor,
      child: SizedBox(
        width: 200,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(_imageFile, width: 256, height: 256)
                : Text("Please select an image!"),
            Spacer(),
            _imageFile != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FireStorageUploader(file: _imageFile, uid: widget.uid),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildInkWell(
                            icon: Icon(Icons.crop, color: kBackgroundColor),
                            onTap: () {
                              _cropImage();
                            },
                          ),
                          buildInkWell(
                            icon: Icon(Icons.cancel, color: kBackgroundColor),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          // buildInkWell(
                          //   icon: Icon(Icons.cancel, color: kBackgroundColor),
                          //   onTap: (){}, ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildInkWell(
                        icon: Icon(Icons.camera, color: kBackgroundColor),
                        onTap: () {
                          _pickImage(ImageSource.camera);
                        },
                      ),
                      buildInkWell(
                          icon: Icon(Icons.image, color: kBackgroundColor),
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                          }),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  InkWell buildInkWell({Icon icon, Function onTap}) {
    return InkWell(
      // splashColor: kBackgroundCol,
      onTap: onTap,
      child:
          Container(width: 140, height: 60, color: kPrimaryColor, child: icon),
    );
  }
}
