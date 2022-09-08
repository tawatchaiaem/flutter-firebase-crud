import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCRUD {
  late Map datas;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  // สร้างฟังก์ชันสำหรับเพิ่มข้อมูลใหม่
  addUser() async {
    Map<String, dynamic> mapData = {
      "id": "2",
      "firstname": "Wichai",
      "lastname": "Jaidee",
      "age": "35"
    };
    collectionReference.add(mapData);
  }

  // สร้างฟังก์ชันสำหรับอ่านข้อมูล
  fetchUser() async {
    collectionReference.snapshots().listen((event) {
      Object? datas = event.docs[1].data();
      print(datas);
    });
  }

  // สร้างฟังก์ชันสำหรับแก้ไขข้อมูล
  updateUser() async {
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference
        .update({"firstname": "Somboon", "lastname": "PoonSuk", "age": "25"});
  }

  // สร้างฟังก์ชันสำหรับลบข้อมูล
  deleteUser() async {
    QuerySnapshot querySnapshot = await collectionReference.get();
  }
}
