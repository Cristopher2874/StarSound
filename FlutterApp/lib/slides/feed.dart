import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application_1/main.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';

class Feed extends StatelessWidget {
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
  List<String> _availableSounds = [];

  // Create a list to store the randomly assigned sounds for each button
  List<String> _assignedSounds = [];
  Soundpool _soundPool = Soundpool();

  @override
  void initState() {
    super.initState();
    _loadSoundsFromJson();
    _loadCoordinatesFromJson();
  }

  @override
  void dispose() {
    _soundPool.dispose(); // Liberar Soundpool al salir de la página
    super.dispose();
  }

  // get the coordinates from the json assets files
  Future<void> _loadCoordinatesFromJson() async {
    final String response = await rootBundle.loadString('assets/json/e6.json');
    final data = await json.decode(response);

    setState(() {
      _buttonCoordinates = List<List<int>>.from(
          data["centros"].map((coord) => List<int>.from(coord)));
      // Randomly assign sounds to each button
      _assignRandomSoundsToButtons();
    });
  }

  Future<void> _loadSoundsFromJson() async {
    // Cargar el archivo audio_manifest.json
    final String response = await rootBundle.loadString('assets/audio/sound_manifest.json');
    final data = await json.decode(response);

    setState(() {
      // Actualizar la lista de sonidos
      _availableSounds = List<String>.from(data["sounds"]);
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
    //Soundpool pool = Soundpool();
    int soundId = await rootBundle.load(soundPath).then((ByteData soundData) {
      return _soundPool.load(soundData);
    });
    await _soundPool.play(soundId);
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
                final double finalHeight =
                    finalWidth * (originalImageHeight / originalImageWidth);

                // scale for the button coordinates
                final double scaleX = finalWidth / originalImageWidth;
                final double scaleY = finalHeight / originalImageHeight;

                // Create buttons list
                List<Widget> buttons =
                    List<Widget>.generate(_buttonCoordinates.length, (index) {
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
          ElevatedButton(
            child: const Text("data"),
            onPressed: () => {
               Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StarSound()),
                  )
            }),
        ],
      ),
    );
  }
}
