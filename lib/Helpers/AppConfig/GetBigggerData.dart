import 'package:flutter/material.dart';

class GetBiggerData extends StatelessWidget {

  final String val;
  final Color color;
  GetBiggerData(this.val, this.color);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 180.0,
        child: RichText(
        text: TextSpan(
          text: val,
          style: TextStyle(color: color)
        ),
      )),
    );
  }
}
