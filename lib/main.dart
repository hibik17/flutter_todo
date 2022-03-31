import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  // sample データの作成
  List<String> todolists = ["起きる", "寝る", "食べる"];

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
                return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: [
                      IconSlideAction(
                        caption: "aaa",
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {},
                      ),
                    ],
                    child: Text(
                      todolists[index],
                      style: TextStyle(fontSize: 80),
                    ));
              },
            )),
      ),
    );
  }
}
