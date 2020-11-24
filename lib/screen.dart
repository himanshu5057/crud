import 'package:crud/model/model.dart';
import 'package:crud/screendetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  bool init=true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(init){
      Provider.of<Details>(context).fetchDetails();
    }
    init=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final val = Provider.of<Details>(context).det;
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD"),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed('./form');
              })
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: val
            .map((e) => ScreenDetails(e.id, e.name, e.email, e.num))
            .toList(),
      )),
    );
  }
}
