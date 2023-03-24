import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  // add-----------------------------------
  final MethodChannel _channel =
      const MethodChannel('com.example.flutter_sound_audio/music');

  void _incrementCounter() {
    getApplicationAssets('asibue.mp3')
        .then((value) => {_channel.invokeMethod(value)});
  }

  Future<String> getApplicationAssets(
    String path,
  ) async {
    final byteData = await rootBundle.load('assets/$path');
    Uint8List byteList = Uint8List.fromList(_byteUint8List(byteData));
    final file = File('${(await getApplicationSupportDirectory()).path}/$path');
    await file.writeAsBytes(byteList.buffer
        .asUint8List(byteList.offsetInBytes, byteList.lengthInBytes));
    return path;
  }

  Uint8List _byteUint8List(byteData) {
    ByteBuffer buffer = byteData.buffer;
    Uint8List unit8List =
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return unit8List;
  }
  //------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text(
          'You have pushed the button this many times:',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
