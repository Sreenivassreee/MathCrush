import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tables extends StatefulWidget {
  int table;
  String operation;
  Tables({this.table, this.operation});
  @override
  _TablesState createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  List tableList = List();
  @override
  void initState() {
    getTable(k: widget.table, ope: widget.operation);
    // print("widget.operation${widget.operation}");
    super.initState();
  }

  getTable({int k, String ope}) {
    switch (ope) {
      case "Multiplication":
        {
          print("Ope is $ope");
          print("k is $k");
          for (var i = 1; i <= 100; i++) {
            if (i < 10) {
              if (k < 10) {
                tableList.add("0$k  x  0$i  =  ${k * i}");
              } else {
                tableList.add("$k  x  0$i  =  ${k * i}");
              }
            } else {
              if (k < 10) {
                tableList.add("0$k  x  $i  =  ${k * i}");
              } else {
                tableList.add("$k  x  $i  =  ${k * i}");
              }
            }
          }
        }
        break;

      case "Division":
        {
          print("Ope is $ope");
          print("k is $k");
          for (var i = 1; i <= 100; i++) {
            if (i < 10) {
              if (k < 10) {
                tableList.add("0$k  /  0$i  =  ${(k / i).toStringAsFixed(3)}");
              } else {
                tableList.add("$k  /  0$i  =  ${(k / i).toStringAsFixed(3)}");
              }
            } else {
              if (k < 10) {
                tableList.add("0$k  /  $i  =  ${(k / i).toStringAsFixed(3)}");
              } else {
                tableList.add("$k  /  $i  =  ${(k / i).toStringAsFixed(3)}");
              }
            }
          }
        }
        break;

      case "Addition":
        {
          print("Ope is $ope");
          print("k is $k");
          for (var i = 1; i <= 100; i++) {
            if (i < 10) {
              if (k < 10) {
                tableList.add("0$k  +  0$i  =  ${(k + i)}");
              } else {
                tableList.add("$k  +  0$i  =  ${(k + i)}");
              }
            } else {
              if (k < 10) {
                tableList.add("0$k  +  $i  =  ${(k + i)}");
              } else {
                tableList.add("$k  +  $i  =  ${(k + i)}");
              }
            }
          }
        }
        break;

      case "Subtraction":
        {
          print("Ope is $ope");
          print("k is $k");
          for (var i = 1; i <= 100; i++) {
            if (i < 10) {
              if (k < 10) {
                tableList.add("0$k  -  0$i  =  ${(k - i)}");
              } else {
                tableList.add("$k  -  0$i  =  ${(k - i)}");
              }
            } else {
              if (k < 10) {
                tableList.add("0$k  -  $i  =  ${(k - i)}");
              } else {
                tableList.add("$k  -  $i  =  ${(k - i)}");
              }
            }
          }
          break;
        }
      // case "Power":
      //   {
      //     print("Opeh is $ope");
      //     print("k is $k");
      //     for (var i = 1; i <= 30; i++) {
      //       // var p = sqrt(i);
      //       // print(p);
      //       tableList.add("$k^$i  =  ${pow(k, i)}");
      //     }
      //     break;
      //   }
      // case "Square Root":
      //   {
      //     print("Ope is $ope");
      //     print("k is $k");
      //     for (var i = 1; i <= 20; i++) {
      //       var p = sqrt(i);
      //       print(p);
      //       tableList.add("$iv2  =  $p");
      //     }
      //   }
      //   break;

      // case "Square Cube":
      //   {
      //     print("Ope is $ope");
      //     print("k is $k");
      //   }
      //   break;

      // case "Cube Root":
      //   {
      //     print("Ope is $ope");
      //     print("k is $k");
      //   }
      //   break;
      // case "Factorial":
      //   {
      //     print("Ope is $ope");
      //     print("k is $k");
      //   }
      //   break;
      // default:
    }

    // for (var i = 1; i <= 20; i++) {
    //   if (i < 10) {
    //     if (k < 10) {
    //       tableList.add("0$k  x  0$i  =  ${k * i}");
    //     } else {
    //       tableList.add("$k  x  0$i  =  ${k * i}");
    //     }
    //   } else {
    //     if (k < 10) {
    //       tableList.add("0$k  x  $i  =  ${k * i}");
    //     } else {
    //       tableList.add("$k  x  $i  =  ${k * i}");
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context2, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              automaticallyImplyTitle: true,
              heroTag: "Hero",
              automaticallyImplyLeading: true,
              backgroundColor: Theme.of(context2).dividerColor,
              largeTitle: Text(
                widget.operation == "Power"
                    ? "Power :${widget.table} "
                    : "Table : ${widget.table}",
                style: TextStyle(
                  fontFamily: "arial",
                  color: Theme.of(context2).primaryColor,
                ),
              ),
            )
          ];
        },
        body: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ListView.builder(
                physics: RangeMaintainingScrollPhysics(),
                itemBuilder: (context, i) => Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          tableList[i],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                itemCount: tableList.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
