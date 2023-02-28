
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'global.dart';

class Details extends StatefulWidget {
  String name;

  Details({super.key, required this.name});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: (){
          setState(() {
            Navigator.pop(context);
          });
        },child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(widget.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => (widget.name == list[index]['Name'])
              ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 246,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                          list[index]['Image'],
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 15),
                Text("Details",
                  style:
                  const TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                AutoSizeText(
                  list[index]['Detail'],
                  minFontSize: 20,
                  maxFontSize: 50,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          )
              : Container(),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}