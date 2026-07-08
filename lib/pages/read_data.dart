import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudapp/pages/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReadData extends StatefulWidget {
  const ReadData({super.key});

  @override
  State<StatefulWidget> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  String? firstname, lastname, age, id;
  Future<void> readData(String name) async {
    QuerySnapshot snapshot = await DatabaseMethods().getUserInfo(name);

    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      var data = doc.data() as Map<String, dynamic>;

      setState(() {
        id = doc.id;
        firstname = data["First Name"];
        lastname = data["Last Name"];
        age = data["Age"];
      });

      print("Document ID: $id");
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No Data Found")));
    }
  }

  Future<void> deleteData() async {
    if (id == null) return;

    await DatabaseMethods().deleteData(id!);

    setState(() {
      firstname = null;
      lastname = null;
      age = null;
      id = null;
    });

    Fluttertoast.showToast(
      msg: "User Data Deleted Successfully!!!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  final TextEditingController updateAgeController = TextEditingController();
  final TextEditingController userlastnamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create/Write Data",style: TextStyle(fontWeight: FontWeight.bold),)),
      body: (Column(
        children: [
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Write User First Name",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),

          Container(
            padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Color(0xFF4c59a5),
              borderRadius: BorderRadius.circular(22),
            ),
            child: TextField(
              controller: userlastnamecontroller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Your First Name',
                hintStyle: TextStyle(color: Colors.white60),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Update Age",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF4c59a5),
              borderRadius: BorderRadius.circular(22),
            ),
            child: TextField(
              controller: updateAgeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter New Age",
                hintStyle: TextStyle(color: Colors.white60),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              await readData(userlastnamecontroller.text);
            },
            child: Center(
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Search",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              if (id == null) {
                Fluttertoast.showToast(msg: "Please search user first");
                return;
              }

              if (updateAgeController.text.trim().isEmpty) {
                Fluttertoast.showToast(msg: "Please enter new age");
                return;
              }

              await DatabaseMethods().updateUserData(
                updateAgeController.text.trim(),
                id!,
              );
              Fluttertoast.showToast(
                msg: "Data Updated Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              readData(userlastnamecontroller.text);
            },
            child: Center(
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              await deleteData();
            },
            child: Center(
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          if (firstname != null)
            Column(
              children: [
                Text(
                  "First Name : $firstname",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  "Last Name : $lastname",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  "Age : $age",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      )),
    );
  }
}
