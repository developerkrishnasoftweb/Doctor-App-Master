// import 'package:flutter/material.dart';
// import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
// import 'package:getcure_doctor/Screens/Treatment/HomeConnector.dart';

// class CustomBoxes extends StatefulWidget {
//   final String label;
//   final String unit;
//   final String value;
//   final Icon icon;
//   CustomBoxes({this.label, this.value, this.unit, this.icon});

//   @override
//   _CustomBoxesState createState() => _CustomBoxesState();
// }

// class _CustomBoxesState extends State<CustomBoxes> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: [
//           Container(
//               height: 70.0,
//               width: 80.0,
//               color: white,
//               alignment: Alignment.center),
//           ClipRRect(
//             borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(70.0),
//             ),
//             clipBehavior: Clip.hardEdge,
//             child: Align(
//               heightFactor: 1.0,
//               widthFactor: 0.8,
//               alignment: Alignment.topRight,
//               child: Container(
//                 padding: const EdgeInsets.all(2.0),
//                 alignment: Alignment.center,
//                 color: Colors.grey[700],
//                 height: 30.0,
//                 width: 40.0,
//                 child: Text(widget.unit,
//                     style: TextStyle(color: white, fontSize: 11.0)),
//               ),
//             ),
//           ),
//           Positioned(top: 24.0, left: 20.0, child: widget.icon),
//           Positioned(
//             left: 33.0,
//             child: ClipOval(
//               child: Container(
//                 alignment: Alignment.center,
//                 height: 20.0,
//                 width: 45.0,
//                 decoration: BoxDecoration(
//                   color: orangef,
//                 ),
//                 child: Center(
//                   child: TextField(
//                     style: TextStyle(fontSize: 12.0),
//                     enabled: true,
//                     textAlign: TextAlign.center,
//                     onChanged: (val) {
//                       switch (widget.label) {
//                         case 'Temp':
//                           setState(() {
//                             temp = val;
//                           });

//                           break;
//                         case 'B.P':
//                           setState(() {
//                             bp = val;
//                           });
//                           break;
//                         case 'Pulse':
//                           setState(() {
//                             pulse = val;
//                           });
//                           break;
//                         case 'Weight':
//                           setState(() {
//                             weight = val;
//                           });
//                           break;
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//               top: 50.0,
//               left: 10.0,
//               child: Text(widget.label, style: TextStyle(fontSize: 20.0)))
//         ],
//       ),
//     );
//   }
// }
