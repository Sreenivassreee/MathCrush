import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tables extends StatefulWidget {
  int k;
  Tables(this.k);
  @override
  _TablesState createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  List tableList = List();
  @override
  void initState() {
    getTable(widget.k);
    super.initState();
  }

  getTable(int k) {
    for (var i = 1; i <= 20; i++) {
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
                "Table: ${widget.k}",
                style: TextStyle(
                  fontFamily: "arial",
                  color: Theme.of(context2).primaryColor,
                ),
              ),
            )
          ];
        },
        body: Scaffold(
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ListView.builder(
                  itemBuilder: (context, i) => Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            tableList[i],
                            style: TextStyle(
                              fontSize: 22,
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
      ),
    );
  }
}
