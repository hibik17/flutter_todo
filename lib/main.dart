// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textcontroller = TextEditingController();
  // sample データの作成
  List<String> todolists = ["起きる", "寝る", "食べる"];
  String todo = "";

  // データを取り出す処理を作成
  initdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList("todo");
    if (result != null) {
      setState(() {
        todolists = result;
      });
    }
  }

  // todoのupdateを作成

  // +buttonが押された際に、ダイアログを出す処理のクラス
  displaydialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                title: Text(todo),
                content: TextField(
                    controller: textcontroller,
                    onChanged: (v) {
                      setState(() {
                        todo = v;
                      });
                    }),
                actions: [
                  ElevatedButton(
                      onPressed: todo.isEmpty
                          ? null
                          : () {
                              setState(() {
                                todolists.add(todo);
                                textcontroller.clear();
                                Navigator.pop(context);
                              });
                            },
                      child: Text("追加"))
                ]);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("ToDoApp"),
        elevation: 0,
      ),
      body: Center(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: ListView.builder(
              // itemCountは何回繰り返しをするかの指定
              itemCount: todolists.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        secondaryActions: [
                          IconSlideAction(
                            caption: "delete",
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {},
                          ),
                        ],
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            child: Text(
                              todolists[index],
                              style: TextStyle(fontSize: 30),
                            ))));
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            displaydialog(context);
          },
          child: Icon(Icons.add)),
    );
  }
}
