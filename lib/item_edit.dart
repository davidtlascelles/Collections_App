import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'item.dart';
import 'layout_selector.dart';
import 'styles.dart';

class ItemEdit extends StatefulWidget {
  final DBProvider database;
  final String tableItems;

  ItemEdit({Key key, this.tableItems, this.database}) : super(key: key);

  @override
  _ItemEditState createState() => _ItemEditState(tableItems: tableItems, database: database);
}

class _ItemEditState extends State<ItemEdit> {
  final DBProvider database;
  final String tableItems;

  _ItemEditState({this.tableItems, this.database});

  TextEditingController itemControllerName = new TextEditingController();
  TextEditingController itemControllerDesc = new TextEditingController();
  TextEditingController itemControllerTag = new TextEditingController();
  String name, description, tag, keyPhoto, layout;

  void _returnPage() {
    var newItem = Item(
      name: itemControllerName.text,
      description: itemControllerDesc.text,
      tag: itemControllerTag.text,
      keyPhoto: keyPhoto,
      layout: layout,
    );
    DBProvider.db.insertItem(tableItems, newItem);
    Navigator.pop(context);
  }

  Widget tagHandler() {
    return Container(
      child:
      CupertinoButton(child: Text("Pick Tag Type"), onPressed: _pickerMenu),
    );
  }

  _pickerMenu() =>
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) =>
            CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      child: Text("Date"),
                      onPressed: () =>
                      {
                        Navigator.pop(context),
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) =>
                                Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            color: CupertinoColors.white,
                                            child: CupertinoButton(
                                              child: Text("Cancel"),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          color: CupertinoColors.white,
                                          child: CupertinoButton(
                                              child: Text(
                                                  "Done",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold
                                                  )
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context)
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: DateTime.now(),
                                        backgroundColor: CupertinoColors.white,
                                        onDateTimeChanged: (DateTime value) {
                                          setState(() {
                                            tag =
                                            "${value.month}/${value.day}/${value
                                                .year}";
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: Container(
                                          color: CupertinoColors.white,
                                          child: null
                                      ),
                                    )
                                  ],
                                )
                        ),
                      }
                  ),
                  CupertinoActionSheetAction(
                      child: Text("Text"),
                      onPressed: () =>
                      {
                        Navigator.pop(context),
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) =>
                                Center(
                                  child: CupertinoAlertDialog(
                                    content: CupertinoTextField(
                                      placeholder: "Enter a short tag",
                                      controller: itemControllerTag,
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text("Cancel", style: TextStyle(
                                            color: CupertinoColors.systemRed),),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      CupertinoDialogAction(
                                          child: Text("Done", style: TextStyle(
                                              fontWeight: FontWeight.bold),),
                                          onPressed: () =>
                                              Navigator.pop(context)
                                      )
                                    ],
                                  ),
                                )
                        ),
                      }
                  ),
                  CupertinoActionSheetAction(
                    child: Text("Rating"),
                    onPressed: () {
                      Navigator.pop(context, 'Rating');
                      //; // CREATE RATING FUNCTIONALITY
                    },
                  )
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: const Text('Cancel'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                )),
      );

  Widget displayImage(File file) {
    return SizedBox(
        height: 200,
        child: file == null
            ? new Image.asset("assets/placeholder-image.png")
            : new Image.file(file));
  }

  _navigateAndDisplayResult(BuildContext context) async {
    layout = await Navigator.push(context,
        CupertinoPageRoute(builder: (context) => LayoutSelector())
    );
    _returnPage();
  }

  File image;

  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            'Add Item',
            style: DefinedTextStyle.largeTitle,
          ),
        ),
        resizeToAvoidBottomInset: true,
        child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Name",
                    ),
                  ),
                  CupertinoTextField(
                    placeholder: "Enter Name",
                    controller: itemControllerName,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Description",
                    ),
                  ),
                  CupertinoTextField(
                    placeholder: "Enter Description",
                    controller: itemControllerDesc,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Tag",
                    ),
                  ),
                  tagHandler(),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Key Photo",
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) {
                          return Column(
                            children: [
                              displayImage(image),
                              CupertinoButton(
                                  child: Text("Edit Image"),
                                  onPressed: () async {
                                    image = await ImagePicker.pickImage(
                                      source: ImageSource.gallery,
                                    );

                                    final directory =
                                    await getApplicationDocumentsDirectory();

                                    String imageName =
                                        image.path
                                            .split("/")
                                            .last;
                                    keyPhoto =
                                    "${directory
                                        .path}/$imageName";

                                    File(image.path).copy(keyPhoto);

                                    setState(() {});
                                  })
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CupertinoButton.filled(
                          child: Text("Done"),
                          onPressed: () => _navigateAndDisplayResult(context)
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}