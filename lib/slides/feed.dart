import 'package:flutter/services.dart' show rootBundle;
import 'package:soundpool/soundpool.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:starsound/main.dart';
import 'package:starsound/slides/audio_manager.dart';
import 'package:path/path.dart' as path;

class Feed extends StatelessWidget {
  final String imageUrl;
  const Feed({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarSound',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: FeedPage(title: 'SS', imageUrl: imageUrl),
    );
  }
}

class FeedPage extends StatefulWidget {
  const FeedPage({super.key, required this.title, required this.imageUrl});
  final String title;
  final String imageUrl;
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  String imagePath = "";
  String image_name = "";
  int originalImageWidth = 1452; // Real image
  int originalImageHeight = 2000; // Real image

  List<List<int>> _buttonCoordinates = [];
  List<String> _availableSounds = [];

  // Create a list to store the randomly assigned sounds for each button
  List<String> _assignedSounds = [];
  // ignore: deprecated_member_use, prefer_final_fields
  Soundpool _soundPool = Soundpool();
  List<int> _playingSounds = []; // Store IDs of currently playing sounds

  @override
  void initState() {
    super.initState();
    imagePath = widget.imageUrl;
    image_name = getFileNameFromUrl(imagePath);
    _loadSoundsFromJson();
    _loadCoordinatesFromJson();
  }

  @override
  void dispose() {
    // Stop any playing sounds
    _stopAllSounds();
    //AudioManager().dispose();
    super.dispose();
  }

  // Function to stop all currently playing sounds
  Future<void> _stopAllSounds() async {
    for (int soundId in _playingSounds) {
      await _soundPool.stop(soundId); // Stop each sound
    }
    _playingSounds.clear(); // Clear the list after stopping
  }

  // get the coordinates from the json assets files
  Future<void> _loadCoordinatesFromJson() async {
    final String response = await rootBundle.loadString('assets/json/$image_name.json');
    final data = await json.decode(response);

    setState(() {
      _buttonCoordinates = List<List<int>>.from(
          data["centers"].map((coord) => List<int>.from(coord)));
      originalImageHeight = data["height"];
      originalImageWidth = data["width"];
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

  Future<void> _playSound(String soundPath) async {
    int soundId = await AudioManager().loadSound(soundPath); // Usa AudioManager
    await AudioManager().playSound(soundId); // Usa AudioManager
    _playingSounds.add(soundId);
  }

  String getFileNameFromUrl(String url) {
    String temp = path.basename(url.split('?')[0]);
    String fileNameWithoutExtension = temp.replaceAll('.png', '');
    fileNameWithoutExtension = fileNameWithoutExtension.replaceAll('.jpg', '');
    fileNameWithoutExtension = fileNameWithoutExtension.toLowerCase();
    return fileNameWithoutExtension.replaceAll('%20', ' ');
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
                    Image.network(
                      widget.imageUrl,
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
            child: Text(image_name),
            onPressed: () => {
              _stopAllSounds(), // Stop all sounds before navigating
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
