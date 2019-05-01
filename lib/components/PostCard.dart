import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  PostCard({Key key}) : super(key: key);

  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: Text("post widget"),
       ),
    );
  }
}