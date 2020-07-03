import 'package:demoapp/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'styles.dart';
import 'collection.dart';

@override
Widget layoutWidget(
    {
      BuildContext context,
      Collection collection,
      DBProvider database,
      double padding,
      double rowHeight
    }
    ) {
  String layoutStyle = collection.layout;
  var _padding = padding;
  var _rowHeight = rowHeight;
  double screenWidth = MediaQuery.of(context).size.width;

  switch (layoutStyle) {
    case "icon_title_description":
      {
        return Container(
          child: Row(
            children: [
              Container( // Icon
                  margin: EdgeInsets.fromLTRB(_padding, 0, 0, 0),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: _rowHeight - _padding,
                          maxHeight: _rowHeight - _padding,
                          maxWidth: _rowHeight - _padding
                      ),
                      child: Container(
                          child: Image.asset(collection.keyPhoto, fit: BoxFit.fill)
                      )
                  )
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(_padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        collection.name,
                        style: DefinedTextStyle.title,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        collection.description,
                        style: DefinedTextStyle.body,
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              ),
              Icon( // Forward Icon
                  CupertinoIcons.forward
              ),
            ],
          ),
        );
      }
      break;
    case "icon_title":
      {
        return Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent)
            ),
            child: Row(
              children: [
                Container( // Thumbnail
                    margin: EdgeInsets.fromLTRB(_padding, 0, 0, 0),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: _rowHeight - _padding,
                            maxHeight: _rowHeight - _padding,
                            maxWidth: _rowHeight - _padding
                        ),
                        child: Container(
                            child: Image.asset(collection.keyPhoto, fit: BoxFit.fill)
                        )
                    )
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(_padding),
                    child: Container(
                      child: Text(
                        collection.name,
                        style: DefinedTextStyle.largeTitle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                Icon(
                    CupertinoIcons.forward
                ),
              ],
            )
        );
      }
      break;
    case "icon_title_tag":
      {
        return Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent)
            ),
            child: Row(
              children: [
                Container( // Thumbnail
                    margin: EdgeInsets.fromLTRB(_padding, 0, 0, 0),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: _rowHeight - _padding,
                            maxHeight: _rowHeight - _padding,
                            maxWidth: _rowHeight - _padding
                        ),
                        child: Container(
                            child: Image.asset(collection.keyPhoto, fit: BoxFit.fill)
                        )
                    )
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(_padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          collection.name,
                          style: DefinedTextStyle.largeTitle,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          collection.tag,
                          style: DefinedTextStyle.tag,
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                ),
                Icon(
                    CupertinoIcons.forward
                ),
              ],
            )
        );
      }
      break;
    case "title_description":
      {
        return Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent)
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(_padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          collection.name,
                          style: DefinedTextStyle.title,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          collection.description,
                          style: DefinedTextStyle.body,
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                ),
                Icon(
                    CupertinoIcons.forward
                ),
              ],
            )
        );
      }
      break;
    case "title":
      {
        return Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent)
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(_padding),
                    child: Container(
                      child: Text(
                        collection.name,
                        style: DefinedTextStyle.largeTitle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                Icon(
                    CupertinoIcons.forward
                ),
              ],
            )
        );
      }
      break;
    case "title_tag":
      {
        return Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent)
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(_padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          collection.name,
                          style: DefinedTextStyle.largeTitle,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          collection.tag,
                          style: DefinedTextStyle.tag,
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                ),
                Icon(
                    CupertinoIcons.forward
                ),
              ],
            )
        );
      }
      break;
    case "iconCollection_title":
      {
        int numberOfImages = (screenWidth / _rowHeight).floor();
        double remainingWidth = screenWidth - (_rowHeight * numberOfImages);
        return Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent)
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: _rowHeight,
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _fillImages(
                        collection, database, numberOfImages, remainingWidth, _rowHeight),
                  ),
                ),
                Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(_padding),
                              child: Container(
                                child: Text(
                                  collection.name,
                                  style: DefinedTextStyle.largeTitle,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                              CupertinoIcons.forward
                          ),
                        ],
                      ),
                    )
                )
              ],
            )
        );
      }
      break;
    case "image_title":
      {
        return Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent)
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: _rowHeight,
                  width: screenWidth,
                  child: DecoratedBox(
                    child: Container(
                        child: Image.asset(collection.keyPhoto, fit: BoxFit.fitWidth)
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.white),
                    ),
                  ),
                ),
                Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(_padding),
                              child: Container(
                                child: Text(
                                  collection.name,
                                  style: DefinedTextStyle.largeTitle,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                              CupertinoIcons.forward
                          ),
                        ],
                      ),
                    )
                )
              ],
            )
        );
      }
      break;
    case "iconCollection":
      {
        int numberOfImages = (screenWidth / _rowHeight).floor();
        double remainingWidth = screenWidth - (_rowHeight * numberOfImages);
        return Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent)
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: _rowHeight,
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _fillImages(
                        collection, database, numberOfImages, remainingWidth, _rowHeight),
                  ),
                ),
                Container(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                          CupertinoIcons.forward
                      ),
                    )
                )
              ],
            )
        );
      }
      break;
    case "image":
      {
        return Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent)
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: _rowHeight,
                  width: screenWidth,
                  child: DecoratedBox(
                    child: Container(
                        child: Image.asset(collection.keyPhoto, fit: BoxFit.fitWidth)
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.white),
                    ),
                  ),
                ),
                Container(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                  CupertinoIcons.forward
                              ),
                            )
                        )
                    )
                )
              ],
            )
        );
      }
      break;
    default:
      return Container(
          child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: _rowHeight,
                width: screenWidth,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                          CupertinoIcons.forward
                      ),
                    )
                ),
              )
          )
      );
  }
}

_fillImages(collection, database, n, r, h){
  var imageAssets = database.getAllImages(collection);

  var imageList = [];
  for(int i = 0; i < n; i++){
    imageList.add(
        SizedBox(
          width: h,
          height: h,
          child: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    alignment: FractionalOffset.centerLeft,
                    image: AssetImage(
                        imageAssets[i]
                    )
                )
            ),
          ),
        )
    );
  }
  double finalWidth = r - 2;
  if(r == 0){
    imageList.removeLast();
    finalWidth = h - 2;
  }
  imageList.add(
      SizedBox(
        width: finalWidth,
        height: h,
        child: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  alignment: FractionalOffset.centerLeft,
                  image: AssetImage(
                      imageAssets[n]
                  )
              )
          ),
        ),
      )
  );
  return imageList;
}


