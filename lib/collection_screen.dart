import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'layouts.dart';
import 'styles.dart';
import 'add_collection.dart';
import 'items_screen.dart';
import 'database.dart';

class MyApp extends StatelessWidget {

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    DBProvider.db.initDB();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return CupertinoApp(
      theme: CupertinoThemeData(brightness: _darkModeDetector()),
      home: CollectionsPage(database: DBProvider.db),
    );
  }

  _darkModeDetector() {
    if (WidgetsBinding.instance.window.platformBrightness == Brightness.dark) {
      return Brightness.dark;
    } else {
      return Brightness.light;
    }
  }
}

class CollectionsPage extends StatefulWidget {
  final DBProvider database;
  CollectionsPage({Key key, this.database}) : super(key: key);

  @override
  _CollectionsPageState createState() => _CollectionsPageState(database);
}

class _CollectionsPageState extends State<CollectionsPage> {
  final DBProvider database;
  _CollectionsPageState(this.database);
  int _count = 0;
  double _rowHeight = 75;
  double _padding = 10;

  _nextPage(String tableItems) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => ItemsPage(tableItems: tableItems, database: database)),
    );
  }

  void _addCollection() {
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => AddCollection())
    ).then((value) {
      setState(() {
        build(context);
      });
    });
  }

  _ellipsisMenu() => showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text("Edit"),
            onPressed: () {
              Navigator.pop(context, 'Edit');
              //; // CREATE EDIT FUNCTIONALITY
            },
          ),
          CupertinoActionSheetAction(
            child: Text("Sort"),
            onPressed: () {
              Navigator.pop(context, 'Sort');
              //; // CREATE SORT FUNCTIONALITY
            },
          ),
          CupertinoActionSheetAction(
            child: Text("Filter"),
            onPressed: () {
              Navigator.pop(context, 'Filter');
              //; // CREATE FILTER FUNCTIONALITY
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
        )
      ),
    );

 List<Widget> _getListData(AsyncSnapshot snapshot) {
    _count = snapshot.data.length;
    List<Widget> widgets = [];

    if (_count == 0) {
      widgets.add(Container(
        padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
        alignment: Alignment.center,
        child: Text(
          "No Collections",
          style: TextStyle(
              color: CupertinoColors.inactiveGray,
              fontSize: 20
          ),
        ),
      )
      );
      return widgets;
    } else {
      for (int i = 0; i < _count; i++) {
        var collectionObject = snapshot.data[i];
        widgets.add(GestureDetector(
            onTap: () => _nextPage(collectionObject.name),
            child: Container(
                height: _rowHeight,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: CupertinoColors.inactiveGray,
                            width: 1
                        )
                    )
                ),
                child: layoutWidget(
                  context: context,
                  collection: collectionObject,
                  database: database,
                  padding: _padding,
                  rowHeight: _rowHeight,
                )
            )
        )
        );
      }
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
            child: Icon(CupertinoIcons.ellipsis, size: 35),
            onPressed: _ellipsisMenu,
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
                    margin: EdgeInsets.fromLTRB(_padding,_padding/2,_padding,_padding),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(CupertinoIcons.add, size: 35),
                      onPressed: _addCollection,
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}
