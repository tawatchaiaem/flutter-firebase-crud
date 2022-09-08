import 'package:firebase_crud/screens/PhotoUploadScreen.dart';
import 'package:firebase_crud/services/firebaseCRUD.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PhotoUploadScreen()));
            },
            icon: Icon(Icons.photo_camera),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                FirebaseCRUD().addUser();
              },
              child: Text(
                'เพิ่มข้อมูล',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.yellow, // foreground
              ),
              onPressed: () async {
                FirebaseCRUD().fetchUser();
              },
              child: Text(
                'อ่านข้อมูล',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                primary: Colors.cyan, // background
                onPrimary: Colors.yellow, // foreground
              ),
              onPressed: () async {
                FirebaseCRUD().updateUser();
              },
              child: Text(
                'แก้ไขข้อมูล',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.yellow, // foreground
              ),
              onPressed: () async {
                FirebaseCRUD().deleteUser();
              },
              child: Text(
                'ลบข้อมูล',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
