import 'dart:io';

import 'package:ciapp/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStorageUploader extends StatefulWidget {
  final File file;
  final String uid;

  FireStorageUploader({Key key, this.file, this.uid}) : super(key: key);

  @override
  _FireStorageUploaderState createState() => _FireStorageUploaderState();
}

class _FireStorageUploaderState extends State<FireStorageUploader> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  UploadTask _uploadTask;
  String filePath;

  void _startUpload() {
    filePath = '${widget.uid}/profile.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<TaskSnapshot>(
          stream: _uploadTask.snapshotEvents,
          builder: (context, snapshots) {
            if (snapshots == null)
              return Container(child: CircularProgressIndicator());

            TaskSnapshot data = snapshots.data;
            TaskState state = data?.state;

            return Column(
              children: [
                if (state == TaskState.running)
                  Column(
                    children: [
                      Text(
                          "${(data.bytesTransferred / data.totalBytes * 100).toStringAsFixed(2)} % Uploading",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: kPrimaryColor)),
                      LinearProgressIndicator(
                          value: data.bytesTransferred / data.totalBytes),
                    ],
                  ),
                if (state == TaskState.running)
                  IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () => _uploadTask.cancel()),
                if (state == TaskState.success)
                  Column(
                    children: [
                      Text("Profile changed successfully!",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.greenAccent)),
                      IconButton(
                          icon: Icon(Icons.check, color: Colors.redAccent),
                          onPressed: () async => Navigator.pop(
                              context,
                              await _storage
                                  .ref()
                                  .child("$filePath")
                                  .getDownloadURL())),
                    ],
                  )
              ],
            );
          });
    } else {
      return InkWell(
        onTap: () {
          _startUpload();
        },
        child: Container(
          width: 140,
          height: 60,
          color: kPrimaryColor,
          child: Icon(Icons.upload_file, color: kBackgroundColor),
        ),
      );
    }
  }
}
