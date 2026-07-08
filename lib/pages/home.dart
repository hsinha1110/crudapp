import 'package:crudapp/pages/read_data.dart';
import 'package:flutter/material.dart';
import 'package:crudapp/pages/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  uploadData() async {
    Map<String, dynamic> uploaddata = {
      "First Name": userfirstnamecontroller.text,
      "Last Name": userlastnamecontroller.text,
      "Age": useragecontroller.text,
    };
    await DatabaseMethods().addUserDetails(uploaddata);
    Fluttertoast.showToast(
      msg: "Data Uploaded Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    userfirstnamecontroller.clear();
    userlastnamecontroller.clear();
    useragecontroller.clear();

    FocusScope.of(context).unfocus(); // Keyboard hide
  }

  final TextEditingController userfirstnamecontroller = TextEditingController();
  final TextEditingController userlastnamecontroller = TextEditingController();
  final TextEditingController useragecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    // TODO: implement createState
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create/Write Data",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "First Name",
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
              controller: userfirstnamecontroller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Your First Name',
                hintStyle: TextStyle(color: Colors.white60),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Last Name",
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
                hintText: 'Your Last Name',
                hintStyle: TextStyle(color: Colors.white60),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Age",
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
              controller: useragecontroller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Your Age',
                hintStyle: TextStyle(color: Colors.white60),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 60.0),
          GestureDetector(
            onTap: () async {
              await uploadData();
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
                    "Create",
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
          SizedBox(height: 60.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReadData()),
              );
            },
            child: Container(
              width: 150,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Read",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
