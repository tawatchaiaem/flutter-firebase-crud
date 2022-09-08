import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class PhotoUploadScreen extends StatefulWidget {
  // const PhotoUploadScreen({required Key key}) : super(key: key);

  @override
  _PhotoUploadScreenState createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  // ตัวแปรไว้อ่าน path ไฟล์ในเครื่อง
  late File _imageFile;

  // สร้าง Oject สำหรับเลือกรูปภาพ
  final picker = ImagePicker();

  // ตัวแปรไว้แสดง Loading
  bool isLoading = false;

  // ฟังก์ชันเปิดแกเลอรี่
  _openGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No Image selected');
      }
    });
    // ปิดหน้าต่าง popup
    Navigator.of(context).pop();
  }

  // ฟังก์ชันเปิดกล้องถ่ายภาพ
  _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No Image selected');
      }
    });
    // ปิดหน้าต่าง popup
    Navigator.of(context).pop();
  }

  // สร้างหน้าต่าง popup เลือกช่องทางในการดึงรูป
  Future<void> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('แกเลอรี่'),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('กล้องถ่ายภาพ'),
                  onTap: () {
                    _openCamera(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image to Firebase'),
      ),
      body: Container(
          child: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _imageFile == null
                      ? Text('ยังไม่มีการเลือกรูป')
                      : Image.file(
                          _imageFile,
                          width: 400,
                          height: 400,
                        ),
                  _imageFile != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: uploadImage,
                              child: Text('Upload to firebase'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                clearImage();
                              },
                              child: Text('Clear Image'),
                            ),
                          ],
                        )
                      : Container(),
                  ElevatedButton(
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                      child: Text(
                        'เลือกรูปภาพ',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
      )),
    );
  }

  // ฟังก์ชันอัพโหลดไฟล์รูปขึ้น firebase
  Future uploadImage() async {
    setState(() {
      isLoading = true;
    });

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profile/${Path.basename(_imageFile.path)}');
    firebase_storage.UploadTask task = ref.putFile(_imageFile);
    await task.whenComplete(() {
      setState(() {
        isLoading = false;
        print('Upload Success');
      });
    });
    clearImage();
  }

  // ฟังก์ชันเคลียร์รูปภาพออก
  void clearImage() {
    setState(() {
      _imageFile = null!;
    });
  }
}
