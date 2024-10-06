//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:starsound/slides/feed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarSound',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'StarSound'),
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

  //final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    //_audioPlayer.setReleaseMode(ReleaseMode.loop);
    //_audioPlayer.setVolume(1.0);
    //_audioPlayer.play('assets/audio/lockdown-by-sascha-ende-from-filmmusic-io.mp3' as Source);
  }

  @override
  void dispose() {
    // Stop any playing sounds
    //_audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,  // Set the background color to black
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          widget.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Exploring the cosmos, uncovering the secrets of the universe...",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, // White text for better contrast on the black background
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),  // Space between text and the image button
            GestureDetector(
              onTap: () =>{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Feed()),
                )
              },
              child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Webb_1.png?alt=media&token=d028699f-b51f-4c0a-b46b-f0d04f33b2e5",
                fit: BoxFit.contain,
                height: 250,  // Adjust the size of the image as per your preference
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "James Webb Telescope",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
