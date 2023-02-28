
import 'package:flutter/material.dart';

import 'details.dart';
import 'global.dart';

class ListPage extends StatefulWidget {
  int index;
  String category;

  ListPage({super.key, required this.index, required this.category});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(onTap: (){
          setState(() {
            Navigator.pop(context);
          });
        },child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        title: Text('List of ${widget.category}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => (widget.category ==
            list[index]['Category'])
            ? Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      name: list[index]['Name'],
                    ),
                  ));
            },
            child: Column(
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
                Text(
                  list[index]['Name'],
                  style:
                  const TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        )
            : Container(),
      ),

      // Column(
      //   children: [
      //     Container(
      //       height: 246,
      //       width: 186,
      //       decoration: BoxDecoration(
      //         color: const Color(0xffFFFFFF),
      //         borderRadius: BorderRadius.circular(20),
      //         image: DecorationImage(
      //             image: NetworkImage(
      //               list[widget.index]['Image'],
      //             ),
      //             fit: BoxFit.cover),
      //       ),
      //     ),
      //     Text(
      //       list[widget.index]['Name'],
      //       style: const TextStyle(color: Colors.white),
      //     )
      //   ],
      // ),
      backgroundColor: Colors.white,
    );
  }
}