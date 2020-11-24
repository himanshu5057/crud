import 'package:crud/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ScreenDetails extends StatelessWidget {
  String name;
  String email;
  int contact;
  String id;
  ScreenDetails(this.id,this.name, this.email, this.contact);
  @override
  Widget build(BuildContext context) {
    final val=Provider.of<Details>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Padding(padding: EdgeInsets.all(10)),
            Text(
              "Name: $name",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              "Email: $email",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              "Contact: $contact",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ),
                    onPressed: () {Navigator.of(context).pushNamed('./form',arguments: id);}),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {val.delete(id);})
              ],
            )
          ],
        ),
      ),
    );
  }
}
