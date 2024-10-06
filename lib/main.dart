import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:starsound/slides/audio_manager.dart';
import 'package:starsound/slides/feed.dart';
import 'package:starsound/slides/webbInfo.dart';

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
  Random random = Random();
  int? _backgroundSoundId;
  final List<String> _backgroundImages = [
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Abell%202744.png?alt=media&token=de2e07eb-6691-415d-8357-ade90d808690",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/CEERS%20Crop.png?alt=media&token=dfa9388b-3018-4c19-8ed3-ccf5f5649e73",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Cartwheel%20Galaxy.png?alt=media&token=475c7018-acf8-4f9f-bcd8-b550f8fd54d2",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Crab%20Nebula.jpg?alt=media&token=25d0467e-1c66-4d73-8571-28ab2da3e019",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Digel%20Cloud%202S.png?alt=media&token=ac879b42-1dc9-4e3d-b124-0fe3ca4328ba",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Dwarf%20Galaxy%20WLM.png?alt=media&token=a80bd705-24d3-4055-9557-2a7182f391d6",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/ESO%20137-001.png?alt=media&token=7a64b5c2-60fb-42d9-a026-1b4da7ec0def",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/GOODS-S_ERS2.png?alt=media&token=112fd99d-c857-4d52-adb1-8db28dcfeaad",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Galactic%20Center.png?alt=media&token=64c5897f-8e33-453d-aa32-7ac4b4a3ae58",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Galaxy%20Forming%20in%20the%20Early%20Universe.jpg?alt=media&token=321d5e80-12ca-4dbc-8221-8b8e44ca1b38",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Galaxy%20Forming%20in%20the%20Early%20Universe.png?alt=media&token=155e7211-0470-4bfc-8fcc-970184823e66",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Horsehead%20Nebula.png?alt=media&token=7431b1a7-f53a-441c-96dc-dfc50d5a157b",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/IC%20348.png?alt=media&token=5d7573af-ab6a-4b8e-a386-f1c2ed899d18",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/II%20Zw%20096.png?alt=media&token=b25527da-1afd-4955-b9a7-433956759b40",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/L1527%20and%20Protostar.png?alt=media&token=2a049eb7-1ac4-4651-8d04-4c5ebf2e0005",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/M82.png?alt=media&token=bf20a1be-8453-4cac-a69a-f73bc30fa901",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/MACS%20J0417.5-1154%20Wide%20Field.png?alt=media&token=79e3aa83-6226-425f-a863-304c528db24c",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Messier%2092.png?alt=media&token=0218fca6-a170-4697-86de-b9899f6b341f",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/NGC%2060.png?alt=media&token=b977f1c5-2b8f-48df-bc9f-666381405faf",
    "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Neptune.png?alt=media&token=f813fcb0-59fe-48c4-ade0-29f14e3755ef"
  ];

  int _currentImageIndex = 0;
  late Timer _timer; 
  String _currentImageUrl = "";
  bool _isTextVisible = false; // Control visibility
  late Timer _textTimer; // Timer for text visibility

  @override
  void initState() {
    super.initState();
    //_playBackgroundSound();
    _currentImageIndex = random.nextInt(_backgroundImages.length);
    _currentImageUrl = _backgroundImages[_currentImageIndex];
    _startImageRotation();
    _startTextVisibility();
  }

  Future<void> _playBackgroundSound() async {
    _backgroundSoundId = await AudioManager().loadSound('assets/audio/lockdown-by-sascha-ende-from-filmmusic-io.mp3');
    await AudioManager().playSound(_backgroundSoundId!);
  }

  void _startImageRotation() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex+1) % _backgroundImages.length;
        _currentImageUrl = _backgroundImages[_currentImageIndex]; // Actualiza la imagen actual
      });
    });
  }

  void _startTextVisibility() {
    _textTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _isTextVisible = !_isTextVisible; // Toggle visibility
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _textTimer.cancel();
    if(_backgroundSoundId!=null){
      AudioManager().stopSound(_backgroundSoundId!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Image.network(
            _currentImageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Go beyond borders, discover and have fun...",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Feed(imageUrl: _currentImageUrl)),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 0.85,
                        child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/starsoundtest.appspot.com/o/Webb_1.png?alt=media&token=d028699f-b51f-4c0a-b46b-f0d04f33b2e5",
                              fit: BoxFit.contain,
                              height: 250,
                            ),
                      ),
                      AnimatedOpacity(
                              opacity: _isTextVisible ? 0 : 1,
                              duration: Duration(milliseconds: 1500),
                              child: const Text("Press Me",style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                            )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "James Webb Telescope Model from: https://science.nasa.gov/mission/webb/",
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WebbInfo()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.info),
                      const SizedBox(width: 10),
                      const Text(
                        "Learn More About JWT",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}