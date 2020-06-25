// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mathcrush/Services/Preferences.dart';
// import 'package:mathcrush/pages/intro.dart';
// //import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rxdart/rxdart.dart';

// class AuthService {
//   // Dependencies
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   _login() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (err) {
//       print(err);
//     }
//   }

// //  final Firestore _db = Firestore.instance;

//   // Shared State for Widgets
//   Observable<FirebaseUser> user; // firebase user

//   Observable<Map<String, dynamic>> profile; //
//   // custom user data in Firestore
//   PublishSubject loading = PublishSubject();

// //  // constructor
// //  AuthService() {
// //    user = Observable(_auth.onAuthStateChanged);
// //
// //    profile = user.switchMap((FirebaseUser u) {
// //      if (u != null) {
// //        return _db
// //            .collection('users')
// //            .document(u.uid)
// //            .snapshots()
// //            .map((snap) => snap.data);
// //      } else {
// //        return Observable.just({});
// //      }
// //    });
// //  }

// //  get getUser => null;
//   Future<FirebaseUser> get getUser => _auth.currentUser();

//   Future<FirebaseUser> googleSignIn() async {
//     // Start
//     loading.add(true);

//     // Step 1
//     GoogleSignInAccount googleUser = await _googleSignIn.signIn();

//     GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
// //    FirebaseUser user = await _auth.signInWithCredential(credential);

//     // Step 3
// //    updateUserData(user);

//     // Done
// //    loading.add(false);
// //    print("signed in " + user.displayName);
// //    return user;
// //  }

// //  void updateUserData(FirebaseUser user) async {
// //    DocumentReference ref = _db.collection('users').document(user.uid);
// //
// //    return ref.setData({
// //      'uid': user.uid,
// //      'email': user.email,
// //      'photoURL': user.photoUrl,
// //      'displayName': user.displayName,
// //      'lastSeen': DateTime.now()
// //    }, merge: true);
// //  }
//   }

//   Future<String> signOut(BuildContext context) {
//     Pref.signOutPref().then(
//       (value) {
//         print("Value is $value");
//         if (value == "Sucess") {
//           Pref.saveLoginStatusPrifFalse().then((value) {
//             if (value == "Sucess") {
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (contaxt) => Intro()),
//                 (route) => false,
//               );
//               _auth.signOut();
//             }
//           });
//         }
//       },
//     );
//   }
// }

// final AuthService authService = AuthService();
