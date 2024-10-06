import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_application_1/slides/feed.dart';

//main class
void main() {
  runApp(const StarSound());
}

class StarSound extends StatelessWidget {
  const StarSound({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarSound',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        child: _swiper(),
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
  
  Widget _swiper(){
    List<String> _availableImg = [
      "assets/img/imagenes nasa/Abell 2744.png",
        "assets/img/imagenes nasa/Cartwheel Galaxy.png",
        "assets/img/imagenes nasa/Cassiopeia A.png",
        "assets/img/imagenes nasa/CEERS Crop.png",
        "assets/img/imagenes nasa/Crab Nebula.jpg",
        "assets/img/imagenes nasa/Digel Cloud 2S.png",
        "assets/img/imagenes nasa/Dwarf Galaxy WLM.png",
        "assets/img/imagenes nasa/ESO 137-001.png"
    ];
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.asset(
          _availableImg[index],
          fit: BoxFit.fill,
        );
      },
      itemCount: _availableImg.length,
      itemWidth: 300.0,
      layout: SwiperLayout.STACK,
      autoplay: true,
      loop: true,
    );
  }
}