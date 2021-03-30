import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';

class IconBuilderAppointment extends StatelessWidget {
  final String icon;
  final int units;
  final String title;
  IconBuilderAppointment(this.icon, this.units, this.title);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.black12,
        height: 100,
        width: 100,
        child: Stack(
          // fit: StackFit.passthrough,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          "images/$icon",
                          fit: BoxFit.cover,
                        )),
                  ),
                  Center(child: Text(title))
                ],
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: grey, offset: Offset(2, 2), blurRadius: 3)
                    ]),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      units.toString(),
                      style: TextStyle(
                          fontSize: 10,
                          color: white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
