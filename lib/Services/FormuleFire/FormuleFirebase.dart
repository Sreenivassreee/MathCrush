import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

final formuleRef = Firestore.instance.collection("Formules");
var dataL;
var lenght;

class FormuleFire {
  static Future getMainFormule() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var rowdata = _preferences.getString("Formule");
    if (rowdata == null) {
      try {
        print("get");
        DocumentSnapshot snap = await formuleRef.document("Formule").get();
        // print(snap.data["F"]["1"][0]["1"]["TOPIC"]);
        print(snap.data["ha"].length);
        dataL = snap.data["ha"].length;
        print("hitting formule server");
        saveFormulePref(snap.data["ha"]);
        return snap.data["ha"];
      } catch (e) {
        print(e);
      }
    } else {
      var data = jsonDecode(rowdata);
      print("hitting Pref server");
      dataL = data.length;
      return data;
    }
  }

  static getMainFormuleRefresh() async {
    DocumentSnapshot snap = await formuleRef.document("Formule").get();
    // print(snap.data["F"]["1"][0]["1"]["TOPIC"]);
    print(snap.data["ha"].length);
    lenght = snap.data["ha"].length;
    saveFormulePref(snap.data["ha"]);
    return snap.data["ha"];
  }

  static saveFormulePref(var data) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    print("saving formule server");

    _preferences.setString("Formule", json.encode(data));
    // print("Setting data is $data");
    // getFormulePref();
  }

  // static getFormulePref() async {
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();
  //   var rowdata = _preferences.getString("Formule");
  //   var data = jsonDecode(rowdata);
  //   print("Getting Data is $data");
  // }

  static Future dataLenght() async {
    print("data.lenght");
    print(dataL);
    return await dataL;
  }

  static Future dataFormuleLenght() async {
    print("data.lenght");

    return await lenght;
  }
}
