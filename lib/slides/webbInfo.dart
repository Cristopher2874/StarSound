import 'package:flutter/material.dart';
import 'package:starsound/main.dart';

class WebbInfo extends StatelessWidget {
  const WebbInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarSound',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const WebbInfoPage(title: 'James Webb Space Telescope'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildInfoSection(
            "Looking into the past",
            "Even if light is the fastest thing in our universe, it takes time to reach us. When you see the sunset, you're actually seeing the sun as it was about 8 minutes ago. With Webb, we can see thousands of years into the past!",
          ),
          _buildInfoSection(
            "Seeing the Invisible",
            "Webb captures infrared light that our eyes can't see. Scientists then convert that data into colorful images. Imagine what space would sound like if we turned those invisible signals into music!",
          ),
          _buildInfoSection(
            "Exploring Exoplanets",
            "Webb studies the atmospheres of distant exoplanets, searching for elements that might indicate the possibility of life beyond Earth.",
          ),
          _buildInfoSection(
            "Powerful Teamwork",
            "Webb works alongside Hubble, with each telescope capturing different types of light to give us a more complete picture of the universe.",
          ),
          _buildInfoSection(
            "The Origins of Stars",
            "Webb can observe the full life cycle of stars, from their birth to their transformation into black holes or white dwarfs.",
          ),
          _buildInfoSection(
            "Infrared Heat Sensitivity",
            "Webb operates in extreme cold—around minus 370°F (minus 223°C)—to detect faint heat signals from distant objects.",
          ),
          _buildInfoSection(
            "Learn more:",
            "Data and facts retrieved from: https://webbtelescope.org/quick-facts and https://science.nasa.gov/mission/webb/",
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            child: const Text("Go Back", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  // Método para crear una sección de información con título y contenido.
  Widget _buildInfoSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.blueGrey),
        ],
      ),
    );
  }
}
