import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'collection.dart';
import 'database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'layout_selector.dart';
import 'styles.dart';

class AddCollection extends StatefulWidget {
  final DBProvider database;

  AddCollection({Key key, this.database}) : super(key: key);

  @override
  _AddCollectionState createState() => _AddCollectionState(database: database);
}

class _AddCollectionState extends State<AddCollection> {
  final DBProvider database;

  _AddCollectionState({this.database});

  TextEditingController collectionControllerName = new TextEditingController();
  TextEditingController collectionControllerDesc = new TextEditingController();
  TextEditingController collectionControllerTag = new TextEditingController();
  String name, description, tag, keyPhoto, layout;

  void _returnPage() {
    if (tag == null) {
      tag = collectionControllerTag.text;
    }
    var newCollection = Collection(
        name: collectionControllerName.text,
        description: collectionControllerDesc.text,
        tag: tag,
        keyPhoto: keyPhoto,
        layout: layout
    );
    DBProvider.db.insertCollection(newCollection);
    Navigator.pop(context);
  }

  Widget tagHandler() {
    return Container(
      child:
          CupertinoButton(child: Text("Pick Tag Type"), onPressed: _pickerMenu),
    );
  }

  _pickerMenu() => showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: Text("Date"),
                onPressed: () => {
                  Navigator.pop(context),
                  showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => Column(
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
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  color: CupertinoColors.white,
                                  child: CupertinoButton(
                                    child: Text("Cancel"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                color: CupertinoColors.white,
                                child: CupertinoButton(
                                  child: Text(
                                      "Done",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      )
                                  ),
                                  onPressed: () => Navigator.pop(context)
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
                                    tag = "${value.month}/${value.day}/${value.year}";
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
                  onPressed: () => {
                    Navigator.pop(context),
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => Center(
                          child: CupertinoAlertDialog(
                            content: CupertinoTextField(
                              placeholder: "Enter a short tag",
                              controller: collectionControllerTag,
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: Text("Cancel", style: TextStyle(color: CupertinoColors.systemRed),),
                                onPressed: () => Navigator.pop(context),
                              ),
                              CupertinoDialogAction(
                                  child: Text("Done", style: TextStyle(fontWeight: FontWeight.bold),),
                                  onPressed: () => Navigator.pop(context)
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
            'Add Collection',
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
                    controller: collectionControllerName,
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
                    controller: collectionControllerDesc,
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
                                        image.path.split("/").last;
                                    keyPhoto =
                                        "${directory.path}/$imageName";

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
