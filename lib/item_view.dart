import 'package:flutter/cupertino.dart';

import 'styles.dart';

class ItemView extends StatefulWidget {
  final String itemName;
  final String description;
  final String tag;
  final String keyPhoto;

  ItemView({Key key,
    this.itemName,
    this.description,
    this.tag,
    this.keyPhoto,
  }
  )
      : super(key: key);

  @override
  _ItemViewState createState() => _ItemViewState(
      itemName,
      description,
      tag,
      keyPhoto
  );
}

class _ItemViewState extends State<ItemView> {
  String itemName;
  String description;
  String tag;
  String keyPhoto;

  _ItemViewState(this.itemName,
      this.description,
      this.tag,
      this.keyPhoto);

  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            '$itemName',
            style: DefinedTextStyle.largeTitle,
          ),
        ),
        resizeToAvoidBottomInset: true,
        child: SafeArea(
            bottom: false,
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                      keyPhoto,
                      fit: BoxFit.fill
                  ),
                  Text(
                      description
                  ),
                  Text(
                      tag
                  ),
                ],
              ),
            )
        )
    );
  }
}
