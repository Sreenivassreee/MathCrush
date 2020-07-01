import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathcrush/Services/FormuleFire/FormuleFirebase.dart';
import 'package:mathcrush/pages/Formule/ShowFormuleScreen.dart';

import 'package:theme_provider/theme_provider.dart';

class FormuleMainPage extends StatefulWidget {
  @override
  _FormuleMainPageState createState() => _FormuleMainPageState();
}

class _FormuleMainPageState extends State<FormuleMainPage>
    with AutomaticKeepAliveClientMixin {
  bool keepAlive = true;
  bool isLoading;
  var formuleData;
  int lenght = 0;
  List myList = [];
  bool get wantKeepAlive => true;
  @override
  void initState() {
    isLoading = true;
    FormuleFire.getMainFormule().then((value) {
      formuleData = value;
      // print(formuleData[1][formuleData[1]["Top"]]);
      // print(formuleData[1]);
      // print(formuleData);
      FormuleFire.dataLenght().then((value) {
        setState(() {
          lenght = value;
          if (formuleData != null) {
            setState(() {
              isLoading = false;
            });
          }
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              automaticallyImplyTitle: true,
              heroTag: "Hero2",
              automaticallyImplyLeading: true,
              backgroundColor: Theme.of(context).dividerColor,
              largeTitle: Text(
                'Formules',
                style: TextStyle(
                  fontFamily: "arial",
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ];
        },
        body: isLoading == true
            ? Center(child: CupertinoActivityIndicator())
            : ListView.builder(
                physics: ScrollPhysics(),
                itemCount: lenght,
                itemBuilder: (context, i) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    elevation: 0,
                    color: Theme.of(context).dividerColor,
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Center(
                          child: Text(
                            "${i + 1}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      title: new Text(
                        formuleData[i]["Top"],
                      ),
                      children: <Widget>[
                        Column(
                          children: tile(
                            formuleData[i][formuleData[i]["Top"]],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  tile(data) {
    List<Widget> list = [];
    try {
      for (var i = 0; data[i]["topic"] != null; i++) {
        // print(i);
        // print(data[i]);

        list.add(
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: GestureDetector(
              onTap: () {
                // print(data[i]["url"]);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context2) => ThemeConsumer(
                      child: ShowFormuleScreen(data[i]),
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                color: Theme.of(context).dividerColor,
                child: Card(
                  elevation: 0.0,
                  color: Theme.of(context).dividerColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 15,
                          child: Center(
                            child: Text(
                              "${i + 1}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Expanded(
                            child: Text(
                              data[i]["topic"],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    } catch (e) {
      // print(e);
    }

    return list;
  }
}
// _myTile(formuleData[0][formuleData[0]["Top"]][i]),
