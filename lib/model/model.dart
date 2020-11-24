import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Model {
  final String id;
  final String name;
  final int num;
  final String email;
  Model(
      {@required this.id,
      @required this.name,
      @required this.email,
      @required this.num});
}

class Details with ChangeNotifier {
  List<Model> det = [];

  List<Model> get details {
    return [...det];
  }

  void delete(String id) {
    final url='https://crud-fe36f.firebaseio.com/details/$id.json';
    http.delete(url);
    det.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> fetchDetails() async {
    const url = 'https://crud-fe36f.firebaseio.com/details.json';
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Model> loadedData = [];
      extractedData.forEach((key, value) {
        loadedData.add(Model(
            id: key,
            email: value['email'],
            name: value['name'],
            num: value['num']));
      });
      det = loadedData;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addDetail(Model detail) async {
    const url = 'https://crud-fe36f.firebaseio.com/details.json';
    final response = await http.post(url,
        body: json.encode(
            {'name': detail.name, 'email': detail.email, 'num': detail.num}));
    print(json.decode(response.body));
    final _details = Model(
        id: json.decode(response.body)["name"],
        name: detail.name,
        email: detail.email,
        num: detail.num);
    det.add(_details);
    notifyListeners();
  }

  Model findbyId(String id) {
    return details.firstWhere((element) => element.id == id);
  }

  Future<void> updateDetails(String id, Model personDetails) async{
    final index = det.indexWhere((element) => element.id == id);
    final url='https://crud-fe36f.firebaseio.com/details/$id.json';
    await http.patch(url,body: json.encode({
      'name':personDetails.name,
      'email':personDetails.email,
      'num':personDetails.num
    }));
    det[index] = personDetails;
    notifyListeners();
  }
}
