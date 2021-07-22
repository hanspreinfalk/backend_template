import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    const MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   Map data = {};
   List usersData = [];
   
  Future getUsers() async {
    var url = Uri.parse('http://localhost:4000/api/users');
    http.Response response = await http.get(url, headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });
    debugPrint(response.body);
    data = json.decode(response.body);
    setState(() {
      usersData = data['users'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User list'),
        backgroundColor: Colors.indigo[900],
      ),
      body: ListView.builder(
        itemCount: usersData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(usersData[index]['avatar']),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('${usersData[index]['firstName']} ${usersData[index]['lastName']}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
