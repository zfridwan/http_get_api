import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApiScreen(),
    );
  }
}

class MyApiScreen extends StatefulWidget {
  @override
  _MyApiScreenState createState() => _MyApiScreenState();
}

class _MyApiScreenState extends State<MyApiScreen> {
  List<dynamic> postsData = [];

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      setState(() {
        postsData = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'API Data:',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: postsData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Title: ${postsData[index]["title"]}'),
                    subtitle: Text('Body: ${postsData[index]["body"]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
