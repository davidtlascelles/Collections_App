import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'layouts.dart';
import 'styles.dart';
import 'database.dart';

class EditCollectionsPage extends StatefulWidget {
  final DBProvider database;
  EditCollectionsPage({Key key, this.database}) : super(key: key);

  @override
  _EditCollectionsPageState createState() => _EditCollectionsPageState(database: database);
}

class _EditCollectionsPageState extends State<EditCollectionsPage> {
  final DBProvider database;
  _EditCollectionsPageState({this.database});
  int _count;
  double _rowHeight = 75;
  double _padding = 10;

  _deleteCollection(id) {
    _deleteCollection(id);
  }

  void _doneButton() {
    Navigator.pop(context);
  }

  List<Widget> _getListData(AsyncSnapshot snapshot) {
    _count = snapshot.data.length;
    print(_count);

    List<Widget> widgets = [];

    for (int i = 0; i < _count; i++) {
      widgets.add(Container(
              height: _rowHeight,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 1
                      )
                  )
              ),
              child:
                  IconButton(
                    icon: Icon(CupertinoIcons.minus_circled),
                    onPressed: _deleteCollection(i),
                  ),

              )
      );
    }
    return widgets;
  }

  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            'Collections',
            style: DefinedTextStyle.largeTitle,
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text("Done"),
            onPressed: _doneButton,
          ),
        ),
        resizeToAvoidBottomInset: true,
        child: Column(
          children: [
            Expanded(
              child: SafeArea(
                  bottom: false,
                  child: FutureBuilder(
                      future: database.getAllCollections(),
                      builder: (context, AsyncSnapshot snapshot){
                        int currentCount = snapshot.data.length;
                        if (!snapshot.hasData) {
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        } else {
                          return CupertinoScrollbar(
                              child: ListView(
                                children: _getListData(snapshot),
                              )
                          );
                        }
                      }
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(_padding,_padding/2,_padding,_padding),
              child: Row(
                children: [
                  Container(
                    width: 35,
                    margin: EdgeInsets.fromLTRB(_padding,_padding/2,_padding,_padding),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Text("Collections: $_count")
                    ),
                  ),
                  Container(
                    width: 35,
                    margin: EdgeInsets.fromLTRB(_padding,_padding/2,_padding,_padding),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}
