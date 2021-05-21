import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SlotTimings extends StatefulWidget {
  SlotTimings({Key key}) : super(key: key);

  @override
  _SlotTimingsState createState() => _SlotTimingsState();
}

class _SlotTimingsState extends State<SlotTimings> {
  DateTime val = DateTime.now();
  DateTime start;
  List<DateTime> slots = new List();
  generateSlot() {
    start = DateTime.parse(
        DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
            " 08:00:00");
    for (int i = 0; i <=12; i++) {
      slots.add(start.add(Duration(hours: i)));
    }
  }

  @override
  void initState() {
    generateSlot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slot Timings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text("Select Time Slot",style: TextStyle(fontWeight: FontWeight.bold),),
                  DropdownButton<DateTime>(
                    items: slots.map((DateTime value) {
                      return DropdownMenuItem<DateTime>(
                        value: value,
                        child: Text(DateFormat.jm().format(value)),
                      );
                    }).toList(),
                    hint: Text(DateFormat.jm().format(val)),
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                  ),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
