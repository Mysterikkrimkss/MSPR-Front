import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List bytes = Uint8List(0);
  TextEditingController _inputController;
  TextEditingController _outputController;

  @override
  initState() {
    super.initState();
    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan page',
      theme: ThemeData(
        primaryColor: Colors.grey.shade800,
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.grey.shade400,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Scannez vos QrCode'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getTextAccueil(_text),
            Text('$_text', style: TextStyle(fontSize: 30, color: Colors.black),),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 250, height: 100),
              child: ElevatedButton(
                child: Text('SCAN', style: TextStyle(fontSize: 30),),
                onPressed: _scan,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTextAccueil(_text){
    if(_text==""){
      return Text("Scannez votre Code", style: TextStyle(fontSize: 30),);
    }else {
      return Text("Voici votre coupon", style: TextStyle(fontSize: 30),);
    }
  }

  Future _scan() async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      setState(() {
        _text = barcode;
      });
    }
  }
}