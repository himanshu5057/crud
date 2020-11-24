import 'package:crud/adddetails.dart';
import 'package:crud/model/model.dart';
import 'screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Details())],
          child: MaterialApp(
        title: 'CRUD',
        home: Screen(),
        routes: {
          './form':(context)=>AddDet()
        }
      ),
    );
  }
}