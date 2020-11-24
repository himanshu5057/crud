import 'package:crud/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDet extends StatefulWidget {
  @override
  _AddDet createState() => _AddDet();
}

class _AddDet extends State<AddDet> {
  bool init = true;
  bool isLoading = false;
  var initVal = {'id': '', 'name': '', 'email': '', 'num': ''};
  final _formKey = GlobalKey<FormState>();
  var _editedDetail = Model(id: null, name: '', email: '', num: null);
  Future<void> saveForm() async {
    final valid = _formKey.currentState.validate();
    if (!valid) {
      return;
    }

    setState(() {
      isLoading = true;
    });
    _formKey.currentState.save();
    if (_editedDetail.id != null) {
      Provider.of<Details>(context, listen: false)
          .updateDetails(_editedDetail.id, _editedDetail)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      });
    } else {
      isLoading = true;
      Provider.of<Details>(context, listen: false)
          .addDetail(_editedDetail)
          .then((_) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (init) {
      final id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        _editedDetail = Provider.of<Details>(context).findbyId(id);
        initVal = {
          'id': _editedDetail.id,
          'name': _editedDetail.name,
          'email': _editedDetail.email,
          'num': _editedDetail.num.toString()
        };
      }
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: Text("Add Details"),
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  saveForm();
                })
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
                  child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: initVal['name'],
                    decoration: InputDecoration(labelText: 'Name'),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    onSaved: (value) {
                      _editedDetail = Model(
                          id: _editedDetail.id,
                          name: value,
                          email: _editedDetail.email,
                          num: _editedDetail.num);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field can't be emtpy";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: initVal['email'],
                    decoration: InputDecoration(labelText: 'Email'),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      _editedDetail = Model(
                          id: _editedDetail.id,
                          name: _editedDetail.name,
                          email: value,
                          num: _editedDetail.num);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field can't be emtpy";
                      }
                      if (!value.contains('@')) {
                        return "This is invalid email address";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: initVal['num'],
                    decoration: InputDecoration(labelText: 'Number'),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      _editedDetail = Model(
                          id: _editedDetail.id,
                          name: _editedDetail.name,
                          email: _editedDetail.email,
                          num: int.parse(value));
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field can't be emtpy";
                      }
                      if (value.length != 10) {
                        return "Incorrect number";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      saveForm();
                    },
                  )
                ],
              )),
        ),
      ),
      if (isLoading)
        Align(alignment: Alignment.center, child: CircularProgressIndicator())
    ]);
  }
}
