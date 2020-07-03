import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database.dart';
import 'item_view.dart';
import 'item_edit.dart';
import 'styles.dart';
import 'itemLayoutWidget.dart';

class ItemsPage extends StatefulWidget {
  final String tableItems;
  final DBProvider database;

  ItemsPage({Key key, this.tableItems, this.database}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState(tableItems: tableItems, database: database);
}

class _ItemsPageState extends State<ItemsPage> {
  int _count;
  final String tableItems;
  final DBProvider database;
  _ItemsPageState({this.tableItems, this.database});

  double _rowHeight = 75;
  double _padding = 10;

  _nextPage(String itemName, String description, String tag, String keyPhoto) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => ItemView(itemName: itemName, description: description, tag: tag, keyPhoto: keyPhoto)),
    );
  }

  void _editItem() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => ItemEdit(tableItems: tableItems, database: database)),
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
              "No Items",
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
        var itemObject = snapshot.data[i];
        widgets.add(GestureDetector(
            onTap: () => _nextPage(itemObject.name, itemObject.description, itemObject.tag, itemObject.keyPhoto),
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
                child: itemLayoutWidget(
                  context: context,
                  item: itemObject,
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
            '$tableItems Collection',
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
                      future: database.getAllItems(tableItems),
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
                        child: Text("Items: $_count")
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(_padding,_padding/2,_padding,_padding),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(CupertinoIcons.add, size: 35),
                      onPressed: _editItem,
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
