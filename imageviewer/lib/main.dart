import 'package:flutter/material.dart';
import 'package:local_image_provider/local_image_provider.dart' as lip;
import 'package:local_image_provider/local_image.dart' as lip;

void main() {
  runApp(MyApp());
  test(10);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Album(),
    );
  }
}

class Album extends StatefulWidget {
  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  // final _images = <lip.LocalImage>[];

  // Widget _buildImageThumbnails() {
  //   return GridView.builder(
  //     padding: EdgeInsets.all(2.0),
  //     itemBuilder: (context, i) {
  //       if (i.isOdd) return Divider();

  //       final index = i ~/2;
  //       if (index >= _images.length) {
  //         _images.addAll(getLatest(10))
  //       }
  //     },
  //     );
  // }

  Widget _getHome() {
    return Scaffold(
      body: Center(child: Text("check logs"),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Viewer"),
      ),
      body: _getHome(),
    );
  }
}

void test(int number) async {
  lip.LocalImageProvider imageProvider = lip.LocalImageProvider();
  bool hasPermission = await imageProvider.initialize();
  if ( hasPermission ) {
    List<lip.LocalImage> images = await imageProvider.findLatest(10);
    images.forEach((image) => print(image.id));
  } else {
    print("The user has denied access to images on their device");
  }
}


