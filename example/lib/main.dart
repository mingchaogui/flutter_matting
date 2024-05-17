import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_matting/flutter_matting.dart';
import 'package:flutter_matting_example/extensions/iterable_ext.dart';

import 'assets/r.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterMatting _flutterMattingPlugin = FlutterMatting();

  final List<String> _assets = <String>[
    R.origin,
    R.mask,
  ];
  File? _resultFile;

  @override
  void initState() {
    super.initState();

    _maskImage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: <Widget>[
            ..._assets.map((e) => Image(image: AssetImage(e))),
            if (_resultFile != null) Image(image: FileImage(_resultFile!)),
          ].divide(const SizedBox(height: 10)),
        ),
        backgroundColor: Colors.amber,
      ),
    );
  }

  Future<void> _maskImage() {
    return _flutterMattingPlugin
        .cutout(_assets.first, _assets[1])
        .then((String value) {
      if (!mounted) return;

      final file = File(value);
      setState(() {
        _resultFile = file;
      });
    }).catchError((dynamic error, StackTrace stackTrace) {
      debugPrint('Failed to cutout image: $error');
    });
  }
}
