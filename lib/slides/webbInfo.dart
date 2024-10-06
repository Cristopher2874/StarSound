import 'package:flutter/services.dart' show rootBundle;
import 'package:soundpool/soundpool.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:starsound/main.dart';
import 'package:starsound/slides/audio_manager.dart';
import 'package:path/path.dart' as path;

class WebbInfo extends StatelessWidget {
  const WebbInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarSound',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WebbInfoPage(title: 'SS'),
    );
  }
}

class WebbInfoPage extends StatefulWidget {
  const WebbInfoPage({super.key, required this.title});
  final String title;
  @override
  State<WebbInfoPage> createState() => _WebbInfoPageState();
}

class _WebbInfoPageState extends State<WebbInfoPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ElevatedButton(
            child: Text("image_name"),
            onPressed: () => {
               Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyApp()),
                  )
            }),
        ],
      ),
    );
  }
}
