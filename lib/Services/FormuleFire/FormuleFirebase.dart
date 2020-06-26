import 'package:cloud_firestore/cloud_firestore.dart';

final formuleRef = Firestore.instance.collection("Formules");
var dataL;

class FormuleFire {
  static Future getMainFormule() async {
    try {
      print("get");
      DocumentSnapshot snap = await formuleRef.document("Formule").get();
      // print(snap.data["F"]["1"][0]["1"]["TOPIC"]);
      print(snap.data["ha"].length);

      dataL = snap.data["ha"].length;
      return snap.data["ha"];
    } catch (e) {
      print(e);
    }
  }

  static Future dataLenght() async {
    print("data.lenght");
    print(dataL);
    return await dataL;
  }
}
