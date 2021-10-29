import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';

class IconBuilder extends StatelessWidget {
  final IconData icon;
  final int units;
  final String title;

  IconBuilder(this.icon, this.units, this.title);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.black12,
        height: 100,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Icon(
                    icon,
                    size: 50,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      width: 25,
                      decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: grey,
                                offset: Offset(2, 2),
                                blurRadius: 3)
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
                  )
                ],
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
