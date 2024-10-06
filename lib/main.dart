import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:starsound/slides/feed.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  /*Firebase.initializeApp().then((value){
    runApp(MyApp());
  });*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarSound',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {  

  @override
  void initState(){
    super.initState();
    //_getUserData();
  }

  /*void _getUserData() async{
    CollectionReference test = FirebaseFirestore.instance.collection('Test');

    QuerySnapshot users = await test.get();

    if(users.docs.isNotEmpty){
      for(var doc in users.docs){
        print(doc.data());
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Image.network(
            "https://th.bing.com/th/id/OIP.BU_k2BwbaDSHdopS8o0G2AHaJI?rs=1&pid=ImgDetMain",
            fit: BoxFit.contain,
            )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Feed()),
          )
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
