import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc()
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getUserInfo(String lastname) async {
    return await FirebaseFirestore.instance.collection("users").get();
  }
  Future updateUserData(String age, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({
      "Age": age,
    });
  }
  Future deleteData(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .delete();
  }
}
