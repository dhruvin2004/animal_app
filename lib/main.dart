import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'global.dart';
import 'list.dart';

Future<void> copyDatabase() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, 'database.db');

  bool fileExists = await databaseExists(path);

  if (!fileExists) {
    ByteData data = await rootBundle.load(join('lib/database/Animals.db'));
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await copyDatabase();
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, 'database.db');
  Database database = await openDatabase(path);

  list = await database.rawQuery('SELECT * FROM Animals');

  for (var row in list) {
    // print(row);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Set<String> categories =
    Set<String>.from(list.map((item) => item['Category']));
    uniqueList = categories.map((category) => {'Category': category}).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Animals',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body : ListView.builder(itemCount: uniqueList.length,itemBuilder: (context,index)=>Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListPage(
                    index: index,
                    category: uniqueList[index]['Category'],
                  ),
                ));
          },
          child: Column(
            children: [
              Container(
                height: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(category[index].toString())),

                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),

              ),
              Text(
                (uniqueList[index]['Category']),
                style: const TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),),

      backgroundColor: Colors.white,
    );
  }
}