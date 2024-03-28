import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();
  List list = [];

  Future<void> readData() async {
    var url = "http://192.168.64.1/project/readData.php";
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      try {
        var red = jsonDecode(res.body);
        setState(() {
          list.addAll(red);
        });
        print(list);
      } catch (e) {
        print("Error decoding JSON: $e");
      }
    } else {
      print("Failed to load data. Status code: ${res.statusCode}");
    }
  }

  Future<void> addData() async {
    var url = "http://192.168.64.1/project/addData.php";
    var res = await http.post(Uri.parse(url), body: {
      'name': name.text,
      'email': email.text,
      'age': age.text,
    });

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);
      print(red);
    } else {
      print("Failed to add data. Status code: ${res.statusCode}");
    }
  }

  Future<void> EditData(id) async {
    var url = "http://192.168.64.1/project/editData.php";
    var res = await http.post(Uri.parse(url), body: {
      'name': name.text,
      'email': email.text,
      'age': age.text,
      'id': id,
    });

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);
      print(red);
      print(id);
    } else {
      print("Failed to add data. Status code: ${res.statusCode}");
    }
  }

  getData() async {
    await readData();
  }

  addUsers() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 500,
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextField(
                  controller: age,
                  decoration: InputDecoration(
                    hintText: 'Age',
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    addData();
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.blue,
                    child: Center(
                      child: Text('Submit'),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

// udpdate user
  EditUsers(id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 500,
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextField(
                  controller: age,
                  decoration: InputDecoration(
                    hintText: 'Age',
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    EditData(id);
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.blue,
                    child: Center(
                      child: Text('Submit'),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "U S E R S",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                addUsers();
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            )
          ]),
      drawer: Drawer(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    color: Colors.grey[400],
                    child: ListTile(
                      title: Text(list[i]["name"]),
                      leading: CircleAvatar(
                        child: Text(list[i]["name"]
                            .toString()
                            .substring(0, 2)
                            .toUpperCase()),
                      ),
                      subtitle: Text(list[i]["email"]),
                      trailing: SizedBox(
                        // Wrap Row with SizedBox
                        width: 50, // Set a fixed width for the Row
                        child: Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    EditUsers(list[i]["id"]);
                                  },
                                  icon: Icon(Icons.edit, color: Colors.green)),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete, color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
