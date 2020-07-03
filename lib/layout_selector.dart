import 'package:flutter/cupertino.dart';

import 'styles.dart';

class LayoutSelector extends StatefulWidget {

  LayoutSelector({Key key, }) : super(key: key);

  @override
  _LayoutSelectorState createState() => _LayoutSelectorState();
}

class _LayoutSelectorState extends State<LayoutSelector> {
  
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            'Layout Selection',
            style: DefinedTextStyle.largeTitle,
          ),
        ),
        resizeToAvoidBottomInset: true,
      child: ListView(
        children: [
          Expanded(
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/icon_title_description.png"),
              ),
              onTap: () => {
                Navigator.pop(context, "icon_title_description")
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/icon_title_tag.png"),
              ),
              onTap: () => {
                Navigator.pop(context, "icon_title_tag")
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/icon_title.png"),
              ),
              onTap: () => {
                Navigator.pop(context, "icon_title")
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/title_description.png"),
              ),
              onTap: () => {
                Navigator.pop(context, "title_description")
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/title_tag.png"),
              ),
              onTap: () => {
                Navigator.pop(context, "title_tag")
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/title.png"),
              ),
              onTap: () => {
                Navigator.pop(context, "title")
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/iconCollection_title.png"),
              ),
              onTap: () => {
                Navigator.pop(context, "iconCollection_title")
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/image_title.png"),
              ),
              onTap: () => {
                Navigator.pop(context, "image_title")
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/iconCollection.png"),
              ),
              onTap: () => {
                Navigator.pop(context, "iconCollection")
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/image.png"),
              ),
              onTap: () => {
                Navigator.pop(context, "image")
              },
            ),
          ),
        ],
      ),
    );
  }
}
