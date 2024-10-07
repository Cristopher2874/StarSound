import 'package:flutter/material.dart';
import 'package:starsound/main.dart';
import 'package:path/path.dart' as path;

class ScrollFeed extends StatelessWidget {
  const ScrollFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarSound Feed',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const ScrollFeedPage(),
    );
  }
}

class ScrollFeedPage extends StatefulWidget {
  const ScrollFeedPage({super.key});

  @override
  State<ScrollFeedPage> createState() => _ScrollFeedPageState();
}

class _ScrollFeedPageState extends State<ScrollFeedPage> {
  //TODO: fix to video not example
  final List<String> imageUrls = [
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

  String getFileNameFromUrl(String url) {
    String temp = path.basename(url.split('?')[0]);
    String fileNameWithoutExtension = temp.replaceAll('.png', '');
    fileNameWithoutExtension = fileNameWithoutExtension.replaceAll('.jpg', '');
    fileNameWithoutExtension = fileNameWithoutExtension.toLowerCase();
    return fileNameWithoutExtension.replaceAll('%20', ' ');
  }
  //TODO: fix the feed page with infinite scrolling
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Image Feed', style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return _buildScrollFeedItem(imageUrls[index], index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>{
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp()),
                        )
                      },
        child: const Icon(Icons.backspace),
      ),
    );
  }

  // Build each image feed item
  Widget _buildScrollFeedItem(String imageUrl, int index) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
            loadingBuilder: (context, child, progress) {
              return progress == null
                  ? child
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  'Failed to load image',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //getFileNameFromUrl(imageUrls[index]);
              Text(
                'User ${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {
                  //TODO: fix the item count
                },
              ),
            ],
          ),
        ),
        Divider(color: Colors.blueGrey.shade700),
      ],
    );
  }
}
