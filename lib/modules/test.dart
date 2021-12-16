import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

late List snap;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Center(
        child: FutureBuilder(
          initialData: 1,
          future: fetch_photos(),
          builder: (ctx, a) {
            if (a.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Image.network('${snap.toList()[index]['url']}'),
                    ),
                    title: Text('${snap.toList()[index]['id']}'),
                    subtitle: Text('${snap.toList()[index]['title']}'),
                  );
                },
                itemCount: 12,
              );
            }
          },
        ),
      ),
    );
  }
}

Future fetch_photos() async {
  //إ
  var url = "https://jsonplaceholder.typicode.com/photos";
  var res = await http.get(Uri.parse(url));
  if (res.statusCode == 200) {
    var obj = await json.decode(res.body);
    snap = obj;
  }
}
