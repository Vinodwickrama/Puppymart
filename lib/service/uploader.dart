import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

/*
class Uploader extends StatefulWidget {
  final File file;
  final String user;
  Uploader(this.file, this.user);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _firebaseStorage =
      FirebaseStorage(storageBucket: 'gs://puppymart-23f43.appspot.com');

  StorageUploadTask _storageUploadTask;

  void _startUpload() {
    String filePath = '/images/posts/${widget.user}/${DateTime.now()}.jpg';

    setState(() {
      _storageUploadTask =
          _firebaseStorage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_storageUploadTask != null) {
      return Scaffold(
        body: StreamBuilder<StorageTaskEvent>(
          stream: _storageUploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;
            double progressPercent = (event != null)
                ? (event.bytesTransferred / event.totalByteCount)
                : 0;
            return Center(
              child: Container(
                width: 100,
                height: 100,
                child: Column(
                  children: [
                    if (_storageUploadTask.isComplete)
                      Image.file(
                        widget.file,
                        fit: BoxFit.fill,
                      ),
                    if (_storageUploadTask.isInProgress)
                      FlatButton(
                        child: Text('Pause'),
                        onPressed: () {
                          _storageUploadTask.pause();
                        },
                      ),
                    if (_storageUploadTask.isPaused)
                      FlatButton(
                        child: Text('Resume'),
                        onPressed: () {
                          _storageUploadTask.resume();
                        },
                      ),
                    CircularProgressIndicator(
                      value: progressPercent,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: FlatButton.icon(
            onPressed: _startUpload,
            icon: Icon(Icons.cloud_upload),
            label: Text('Upload'),
          ),
        ),
      );
    }
  }
}
*/
