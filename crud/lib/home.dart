import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/services/database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream? EmployeeStream;

  getonReload() async {
    EmployeeStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getonReload();
    super.initState();
  }

  Widget allEmployeeStream() {
    return StreamBuilder(
        stream: EmployeeStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name : " + ds["Name"],
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              ),
                              Text(
                                "Age : " + ds["Age"],
                                style:
                                    TextStyle(color: Colors.green, fontSize: 18),
                              ),
                              Text(
                                "Location : " + ds["Location"],
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildUi(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/employeeform');
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
        title: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Flutter",
          style: TextStyle(
              color: Colors.blue, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "Firebase",
          style: TextStyle(
              color: Colors.green, fontSize: 30.0, fontWeight: FontWeight.bold),
        )
      ],
    ));
  }

  Widget _buildUi(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
      child: Column(
        children: [
          Expanded(child: allEmployeeStream())
        ],
      ),
    );
  }
}
