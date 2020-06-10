// import 'dart:math';

// import 'package:SteveBrains/Mysql1/connection.dart';
// import 'package:SteveBrains/models/FeedModel.dart';
// import 'package:SteveBrains/models/alreadyDataFromServer.dart';
// import 'package:SteveBrains/models/leaderProfile.dart';
// import 'package:SteveBrains/resources/Keys.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:mysql1/mysql1.dart';

// var settings;

// class SQLServices {
//   static String host = 'remotemysql.com',
//       user = 'yJe8J7bxgh',
//       password = 'b2VweJPMSQ',
//       db = 'yJe8J7bxgh';
//   static int port = 3306;

// //  static String ROOT = "https://campylotropous-stic.000webhostapp.com/";
//   // static String INITIALSAVE = "InitialSave";
//   // static String UPDDATESCOREANDLEVEL = "UpdateScoreANDLevel";
//   // static String INITIALCHECKSAVE = "initialCheckSave";
//   // static String UPDATEPERSENTAGE = "UpdatePersentage";
//   // static String UPDATEPERSENTAGEATFIRST = "UpdatePersentageAtFirst";

// //   static Future<alreadyDataFromServer> SQLinitialSave(
// //       {String id, String displayName, String email, String photoUrl}) async {
// //     alreadyDataFromServer datafromserver = alreadyDataFromServer();
// //     alreadyDataFromServer alreadyUserStatus = alreadyDataFromServer();

// //     try {
// //       var map = Map<String, dynamic>();
// //       map['action'] = INITIALCHECKSAVE;
// //       map['id'] = id;
// //       map['name'] = displayName;
// //       map['email'] = email;
// //       map['photoUrl'] = photoUrl;
// // //      print("map is:: $map");
// //       var response = await http.post(ROOT, body: map);

// //       if (200 == response.statusCode) {
// //         if (response.body == "  NewUser") {
// //           print("NewUser");
// //           alreadyUserStatus.Status = "NewUser";
// //           return alreadyUserStatus;
// //         } else {
// //           final data = jsonDecode(response.body);

// //           datafromserver.id = data[0]['id'];
// //           datafromserver.Name = data[0]['Name'];
// //           datafromserver.Email = data[0]['Email'];
// //           datafromserver.gmailId = data[0]['gmailId'];
// //           datafromserver.PhotoUrl = data[0]['PhotoUrl'];
// //           datafromserver.Mobile = data[0]['Mobile'];
// //           datafromserver.State = data[0]['State'];
// //           datafromserver.current_level = data[0]['current_level'];
// //           datafromserver.current_score = data[0]['current_score'];
// //           datafromserver.Qualification = data[0]['Qualification'];

// // //        List<alreadyDataFromServer> list = parseData(response.body);

// //           return datafromserver;
// //         }
// //       } else {
// //         return alreadyDataFromServer();
// //       }
// //     } catch (e) {
// //       return alreadyDataFromServer();
// //     }
// //   }

//   static Future<alreadyDataFromServer> sqlInitialSave(
//       {String id, String displayName, String email, String photoUrl}) async {
//     alreadyDataFromServer datafromserver = alreadyDataFromServer();

//     // try {

//     //   } else {
//     //     for (var row in results) {
//     //       // print(row['pinCode']);
//     //       datafromserver.id = row['id'].toString();
//     //       datafromserver.Name = row['Name'];
//     //       datafromserver.Email = row['Email'];
//     //       datafromserver.gmailId = row['gmailId'];
//     //       datafromserver.PhotoUrl = row['PhotoUrl'];
//     //       datafromserver.Mobile = row['Mobile'];
//     //       datafromserver.State = row['State'];
//     //       datafromserver.current_level = row['current_level'].toString();
//     //       datafromserver.current_score = row['current_score'].toString();
//     //       datafromserver.Qualification = row['Qualification'];
//     //       datafromserver.pin = row['pinCode'].toString();
//     //       datafromserver.about = row['About'];
//     //       datafromserver.uStatus = "AlreadyUser";
//     //     }
//     //   }

//     //   await conn.close();
//     //   // return datafromserver;

//     // } catch (e) {
//     //   datafromserver.uStatus = "Error";
//     //   return datafromserver;
//     // }
//     // print("about in server");
//     // print(datafromserver.about);
//     return datafromserver;
//   }

// //  static List<alreadyDataFromServer> parseData(String parsedData) {
// //    final data = jsonDecode(parsedData).cast<Map<String, dynamic>>();
// //    print(data
// //        .map<alreadyDataFromServer>(
// //            (json) => alreadyDataFromServer.fromJson(json))
// //        .toList());
// //    return data
// //        .map<alreadyDataFromServer>(
// //            (json) => alreadyDataFromServer.fromJson(json))≤
// //        .toList();
// //  }

//   static Future<String> UpdateScoreANDLevel(
//       String userId, String upLevel, String upScore, String percentage) async {
//     String _mess;
//     try {
//       var settings = new ConnectionSettings(
//           host: host, port: port, user: user, password: password, db: db);
//       var conn = await MySqlConnection.connect(settings);
//       var res = await conn.query(
//           "UPDATE usersTable SET current_level=?,current_score= ? where id= ?",
//           // UPDATE `levelDetails` SET `$level2`='$percentage' WHERE userid=$id";
//           [upLevel, upScore, userId]);
//       // print(res);
//       // print("Res isss $res");
//       _mess = "Sucess";
//       await conn.close();

// //      print(responce.body);

//       //   return responce.body;
//       // } else {
//       //   return "Failed";
//       // }
//     } catch (e) {
//       _mess = "Failed";
//     }

//     return _mess;
//   }

// //   static Future<String> UpdateScoreANDLevel2(
// //       String userId, String upLevel, String upScore, String percentage) async {
// //     try {
// //       var map = Map<String, dynamic>();
// //       map['action'] = UPDDATESCOREANDLEVEL;
// //       map['userId'] = userId;
// //       map['updatedLevel'] = upLevel;
// //       map['updatedScore'] = upScore;
// //       map['percentage'] = percentage;

// //       var responce = await http.post(ROOT, body: map);

// // //      print(responce.body);
// //       if (responce.statusCode == 200) {
// //         return responce.body;
// //       } else {
// //         return "Failed";
// //       }
// //     } catch (e) {
// //       return "Failed";
// //     }
// //   }

// //   static Future<String> UpdatePersentage2(
// //       String userId, String Level, String percentage) async {
// //     try {
// //       var map = Map<String, dynamic>();
// //       map['action'] = UPDATEPERSENTAGE;
// //       map['userId'] = userId;
// //       map['updatedLevel'] = Level;
// //       map['percentage'] = percentage;

// //       var responce = await http.post(ROOT, body: map);

// // //      print(responce.body);
// //       if (responce.statusCode == 200) {
// //         return responce.body;
// //       } else {
// //         return "Failed";
// //       }
// //     } catch (e) {
// //       return "Failed";
// //     }
// //   }

//   static Future<String> insertPersentage(
//       int userId, int Level, int percentage) async {
//     String _mess;

//     try {
//       var settings = new ConnectionSettings(
//           host: host, port: port, user: user, password: password, db: db);
//       var conn = await MySqlConnection.connect(settings);
//       var res = await conn.query(
//           "INSERT INTO EachLevelData(userid,level,percentage) VALUES(?,?,?)",
//           [userId, Level, percentage]);
//       _mess = "Sucess";
//       await conn.close();
//     } catch (e) {
//       _mess = "Failed";
//     }
//     return _mess;
//   }

//   static Future<String> updatePersentage(
//       int userId, int Level, int percentage) async {
//     String _mess;

//     try {
//       var settings = new ConnectionSettings(
//           host: host, port: port, user: user, password: password, db: db);
//       var conn = await MySqlConnection.connect(settings);
//       var res = await conn.query(
//           "UPDATE EachLevelData SET level=?,percentage=? where userid=? and level=?",
//           [Level, percentage, userId, Level]);
//       _mess = "Sucess";
//       await conn.close();
//     } catch (e) {
//       _mess = "Failed";
//     }
//     return _mess;
//   }

//   //  "UPDATE levelDetails SET ?=? WHERE userid=?",
//   // [Level, percentage, userId]);

// //   static Future<String> UpdatePersentageAtFirst(
// //       String userId, String Level, String percentage) async {
// //     try {
// //       var map = Map<String, dynamic>();
// //       map['action'] = UPDATEPERSENTAGEATFIRST;
// //       map['userId'] = userId;
// //       map['updatedLevel'] = Level;
// //       map['percentage'] = percentage;

// //       var responce = await http.post(ROOT, body: map);

// // //      print(responce.body);
// //       if (responce.statusCode == 200) {
// //         return responce.body;
// //       } else {
// //         return "Failed";
// //       }
// //     } catch (e) {
// //       return "Failed";
// //     }
// //   }

//   static Future<String> UpdatePersentageAtFirst(
//       String userId, String Level, String percentage) async {
//     String _mess;

//     try {
//       var settings = new ConnectionSettings(
//           host: host, port: port, user: user, password: password, db: db);
//       var conn = await MySqlConnection.connect(settings);
//       var res = await conn
//           .query("INSERT INTO levelDetails(userid) VALUES (?)", [userId]);
//       // print("Res issssssssss $res");
//       //  await UpdatePersentage(userId, Level, percentage);
//       await conn.close();

//       _mess = "Sucess";

// //      print(responce.body);

//       //   return responce.body;
//       // } else {
//       //   return "Failed";
//       // }
//     } catch (e) {
//       _mess = "Failed";
//     }
//     return _mess;
//   }

// //   static Future<String> updateProfile(
// //       {String userId,
// //       String name,
// //       String mobile,
// //       String pin,
// //       String state,
// //       String quali}) async {
// //     String _mess;
// //     try {
// //       var settings = new ConnectionSettings(
// //           host: host, port: port, user: user, password: password, db: db);
// //       var conn = await MySqlConnection.connect(settings);
// //       var res = await conn.query(
// //           "UPDATE usersTable SET Name=?,Mobile=?,State=?,Qualification=?,pinCode=? WHERE id=?",
// //           [name, mobile, state, quali, pin, userId]);
// //       // print("Res issssssssss $res");
// //       //  await UpdatePersentage(userId, Level, percentage);
// //       await conn.close();

// //       _mess = "Sucess";

// // //      print(responce.body);

// //       //   return responce.body;
// //       // } else {
// //       //   return "Failed";
// //       // }
// //     } catch (e) {
// //       _mess = "Failed";
// //     }
// //     return _mess;
// //   }

// //   static Future<String> saveAbout({String userId, String about}) async {
// //     String _mess;
// //     try {
// //       var settings = new ConnectionSettings(
// //           host: host, port: port, user: user, password: password, db: db);
// //       var conn = await MySqlConnection.connect(settings);
// //       var res = await conn.query(
// //           "UPDATE usersTable SET About =? WHERE usersTable.id = ?",
// //           [about, userId]);
// //       // print("about issssssssss $about");
// //       //  await UpdatePersentage(userId, Level, percentage);

// //       _mess = "Sucess";
// //       await conn.close();

// // //      print(responce.body);

// //       //   return responce.body;
// //       // } else {
// //       //   return "Failed";
// //       // }
// //     } catch (e) {
// //       _mess = "Failed";
// //     }
// //     return _mess;
// //   }

//   static Future<List<leaderProfile>> profilePersonData() async {
//     List<leaderProfile> list = List();

//     try {
//       var settings = new ConnectionSettings(
//           host: host, port: port, user: user, password: password, db: db);
//       var conn = await MySqlConnection.connect(settings);
//       var res = await conn.query(
//           "select t.Name,t.PhotoUrl,t.current_level,t.current_score,t.About from usersTable as t INNER JOIN (SELECT DISTINCT current_score FROM usersTable order by current_score desc limit 1) as t2 ON t.current_score = t2.current_score ORDER BY t.current_score DESC");
//       // print(res);
//       for (var row in res) {
//         list.add(
//           leaderProfile(
//             name: row['Name'],
//             photoUrl: row['PhotoUrl'],
//             current_level: row['current_level'].toString(),
//             current_score: row['current_score'].toString(),
//             about: row['About'],
//           ),
//         );
//       }
//       await conn.close();

//       // print(list.length);

//     } catch (e) {}
//     return list;
//   }

//   static Future<List<FeedModel>> getFeed() async {
//     List<FeedModel> list = List();

//     try {
//       var settings = new ConnectionSettings(
//           host: host, port: port, user: user, password: password, db: db);
//       var conn = await MySqlConnection.connect(settings);
//       var res = await conn.query("SELECT * FROM Feed");
//       // print(res);
//       for (var row in res) {
//         list.add(
//           FeedModel(
//             url: row['url'],
//             quotes: row['quotes'],
//           ),
//         );
//         list.shuffle();
//       }
//       print(list.length);
//       await conn.close();
//     } catch (e) {}
//     return list;
//   }

// //  Future<List> fetchLevels() async {
// //
// //    var map=Map<String,dynamic>();
// //    map['userId']
// //    final response = await http
// //        .post(ROOT,body:map);
// //
// //    if (response.statusCode == 200) return json.decode(response.body);
// //    return [];
// //  }

// }
