import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:local_image_provider/local_album.dart';
import 'package:local_image_provider/local_image.dart';
import 'package:local_image_provider/local_image_provider.dart';

class Albums extends StatefulWidget {
  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  bool _hasPermission = false;
  LocalImageProvider localImageProvider = LocalImageProvider();
  List<LocalAlbum> _localAlbums = [];
  
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool hasPermission = false;
    List<LocalAlbum> localAlbums = [];

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      hasPermission = await localImageProvider.hasPermission;
      if (hasPermission) {
        print('Already granted, initialize will not ask');
      }
      hasPermission = await localImageProvider.initialize();
      if (hasPermission) {
        localAlbums = await localImageProvider.findAlbums(LocalAlbumType.all);
      }
    } on PlatformException catch (e) {
      print('Local image provider failed: $e');
    }

    if (!mounted) return;

    setState(() {
      _localAlbums.addAll(localAlbums);
      _hasPermission = hasPermission;
    });
  }

  Widget _buildAlbums(List<LocalAlbum> las) {
    return ListView.builder(
      itemCount: las.length,
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        print("index: $i");
        if (i.isOdd) return Divider();

        return _buildRow(_localAlbums[i]);
      },
    );
  }

  Widget _buildRow(LocalAlbum la) {
    return ListTile(
      title: Text(
        la.title,
      ),
      leading: Image(
        image: DeviceImage(
          la.coverImg,
          scale: 1),
        fit: BoxFit.contain,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildAlbums(_localAlbums),
    );
  }
}