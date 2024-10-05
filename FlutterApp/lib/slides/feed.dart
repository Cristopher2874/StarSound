import 'package:flutter/services.dart' show rootBundle;
import 'package:soundpool/soundpool.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';

class Feed extends StatelessWidget{
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarSound',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FeedPage(title: 'SS'),
    );
  }
}

class FeedPage extends StatefulWidget {
  const FeedPage({super.key, required this.title});
  final String title;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final String imagePath = "assets/img/e6.jpg";
  final double originalImageWidth = 1452; // Real image
  final double originalImageHeight = 2000; // Real image

  List<List<int>> _buttonCoordinates = [];
  final List<String> _availableSounds = [
    'assets/audio/audio_sample1.mp3'
  ];

  // Create a list to store the randomly assigned sounds for each button
  List<String> _assignedSounds = [];

  @override
  void initState() {
    super.initState();
    _loadCoordinatesFromJson();
  }

  // get the coordinates from the json assets files
  Future<void> _loadCoordinatesFromJson() async {
    final String response = await rootBundle.loadString('assets/json/e6.json');
    final data = await json.decode(response);

    setState(() {
      _buttonCoordinates = List<List<int>>.from(data["centros"].map((coord) => List<int>.from(coord)));

      // Randomly assign sounds to each button
      _assignRandomSoundsToButtons();
    });
  }

  // Function to assign random sounds to each button
  void _assignRandomSoundsToButtons() {
    Random random = Random();
    _assignedSounds = _buttonCoordinates.map((_) {
      int randomIndex = random.nextInt(_availableSounds.length);
      return _availableSounds[randomIndex];
    }).toList();
  }

  // Play sound when the button is pressed
  Future<void> _playSound(String soundPath) async {
    // ignore: deprecated_member_use
    Soundpool pool = Soundpool();
    int soundId = await rootBundle
        .load(soundPath)
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    await pool.play(soundId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // get available width
                final double finalWidth = constraints.maxWidth;
                // calculate height for the available space
                final double finalHeight = finalWidth * (originalImageHeight / originalImageWidth);

                // scale for the button coordinates
                final double scaleX = finalWidth / originalImageWidth;
                final double scaleY = finalHeight / originalImageHeight;

                // Create buttons list
                List<Widget> buttons = List<Widget>.generate(_buttonCoordinates.length, (index) {
                  final coord = _buttonCoordinates[index];
                  final String soundPath = _assignedSounds[index];
                  
                  final double scaledX = coord[0] * scaleX;
                  final double scaledY = coord[1] * scaleY;

                  return Positioned(
                    left: scaledX,
                    top: scaledY,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          _playSound(soundPath);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          padding: EdgeInsets.zero,
                          elevation: 0,
                        ),
                        child: const Text(""),
                      ),
                    ),
                  );
                });

                return Stack(
                  children: <Widget>[
                    Image.asset(
                      "assets/img/e6.jpg",
                      width: finalWidth,
                      height: finalHeight,
                      fit: BoxFit.contain,
                    ),
                    // Create the corresponding buttons
                    ...buttons,
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
/*
class Feed extends StatelessWidget{
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarSound',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FeedPage(title: 'SS'),
    );
  }
}

class FeedPage extends StatefulWidget {
  const FeedPage({super.key, required this.title});
  final String title;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final String imagePath = "assets/img/e6.jpg";
  final double originalImageWidth = 1452; // Real image
  final double originalImageHeight = 2000; // Real image

  List<List<int>> _buttonCoordinates = [];
  List<String> _availableSounds = [
    'assets/audio/audio_sample1.mp3',
    'assets/audio/audio_sample2.mp3',
    'assets/audio/audio_sample3.mp3',
    // Add more sound paths as needed
  ];

  // Create a list to store the randomly assigned sounds for each button
  List<String> _assignedSounds = [];

  @override
  void initState() {
    super.initState();
    _loadCoordinatesFromJson();
  }

  // get the coordintaes from the json assets files
  Future<void> _loadCoordinatesFromJson() async {
    final String response = await rootBundle.loadString('assets/json/e6.json');
    final data = await json.decode(response);

    setState(() {
      _buttonCoordinates = List<List<int>>.from(data["centros"].map((coord) => List<int>.from(coord)));

      _assignRandomSoundsToButtons();
    });
  }

  // Function to assign random sounds to each button
  void _assignRandomSoundsToButtons() {
    Random random = Random();
    _assignedSounds = _buttonCoordinates.map((_) {
      int randomIndex = random.nextInt(_availableSounds.length);
      return _availableSounds[randomIndex];
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // get available with
                  final double finalWidth = constraints.maxWidth;
                  // calculate height for the available space TODO: FIX
                  final double finalHeight = finalWidth * (originalImageHeight / originalImageWidth);

                  // scale for the button coordinates
                  final double scaleX = finalWidth / originalImageWidth;
                  final double scaleY = finalHeight / originalImageHeight;

                  // Create buttons list
                  List<Widget> buttons = _buttonCoordinates.map((coord) {
                    final double scaledX = coord[0] * scaleX;
                    final double scaledY = coord[1] * scaleY;

                    final String soundPath = _assignedSounds[index];

                    return Positioned(
                      left: scaledX,
                      top: scaledY,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: ElevatedButton(
                          onPressed: () {
                            _playSound();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            padding: EdgeInsets.zero,
                            elevation: 0,
                          ),
                          child: const Text(""),
                        ),
                      ),
                    );
                  }
                ).toList();
                return Stack(
                  children: <Widget>[
                    Image.asset(
                        "assets/img/e6.jpg",
                        width: finalWidth,
                        height: finalHeight,
                        fit: BoxFit.contain,
                      ),
                    // Create the corresponding buttons
                    ...buttons,
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{
          Navigator.pop(context)
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Play sound when the button is pressed
Future<void> _playSound(String soundPath) async {
  Soundpool pool = Soundpool();
  int soundId = await rootBundle
      .load(soundPath)
      .then((ByteData soundData) {
    return pool.load(soundData);
  });
  await pool.play(soundId);
}*/