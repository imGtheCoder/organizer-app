import 'package:flutter/material.dart';

class WallpaperScreen extends StatelessWidget {
  const WallpaperScreen({super.key});

  static const pageRoute = '/wallpaper-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        title: const Text('Wallpaper & Quote'),
      ),
      body: null,
    );
  }
}
