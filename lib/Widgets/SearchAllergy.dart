import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getcure_doctor/Database/HabitsTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:provider/provider.dart';

class SearchAllergy extends StatefulWidget {
  final String pId;
  final int docId;
  SearchAllergy({Key key, this.pId, this.docId}) : super(key: key);

  @override
  _SearchAllergyState createState() => _SearchAllergyState();
}

class _SearchAllergyState extends State<SearchAllergy> {
  String query = '';

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<HabitDB>(context);
    final patientsVisit = Provider.of<PatientsVisitDB>(context);

    return SingleChildScrollView(
      child: AlertDialog(
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Container(child: Text('Allergies')),
        //     InkWell(
        //         onTap: () => Navigator.pop(context), child: Icon(Icons.close))
        //   ],
        // ),
        titlePadding: EdgeInsets.zero,
        scrollable: true,
        title: Container(
          alignment: Alignment.center,
          color: orangep,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Allergies',
                  style: TextStyle(color: white),
                ),
                IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
        actions: <Widget>[
          _buildTaskListGrid2(
              context, query, database, patientsVisit, widget.pId),
          Stack(
            // fit: StackFit.expand,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.green[50],
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.green[100],
                            labelText: 'search',
                            labelStyle: TextStyle(color: blue),
                            border: InputBorder.none),
                        onChanged: (val) {
                          setState(() {
                            query = val;
                          });
                        },
                        // onSubmitted: (val) {
                        //   setState(() {
                        //     query = val;
                        //   });
                        // },
                      ),
                    ),
                    _buildTaskList(context, query, database, patientsVisit,
                        widget.pId, widget.docId),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddAllergies(
                          docId: widget.docId,
                          database: database,
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: white,
                    size: 40,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

StreamBuilder<List<Habit>> _buildTaskList(BuildContext context, String query,
    HabitDB database, PatientsVisitDB pv, String pId, int docId) {
  return StreamBuilder(
    stream: database.watchAllTasks(query,HType.Allergy),
    builder: (context, AsyncSnapshot<List<Habit>> snapshot) {
      //print(query);
      final tasks = snapshot.data ?? List();
      return Container(
        alignment: Alignment.topLeft,
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.6,
        child: ListView.builder(
          // separatorBuilder: (_, index) {
          //   return Divider();
          // },
          scrollDirection: Axis.vertical,
          itemCount: tasks.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final itemTask = tasks[index];
            return GestureDetector(
              onTap: () async {
                List<AllergyData> bhd = [
                  AllergyData(
                    title: itemTask.title,
                    doctorId: docId,
                    type: itemTask.type.toString(),
                  )
                ];
                Allergy al = Allergy(data: bhd);
                var p = await pv.checkPatient(pId);
                pv.updateAllergy(p.last, al);
                Fluttertoast.showToast(
                    msg: "${itemTask.title} added to list",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER ,
                    timeInSecForIosWeb: 1,
                    backgroundColor: green,
                    textColor: white,
                    fontSize: 16.0);
                // Navigator.pop(context);
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: Text(itemTask.title),
              ),
            );
          },
        ),
      );
    },
  );
}

StreamBuilder<List<PatientsVisitData>> _buildTaskListGrid2(BuildContext context,
    String query, HabitDB database, PatientsVisitDB pv, String pId) {
  return StreamBuilder(
    stream: pv.getAllergies(pId),
    builder: (context, AsyncSnapshot<List<PatientsVisitData>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return CircularProgressIndicator();
          break;
        default:
          return Container(
            height: (snapshot.data.last.allergies == null)?
            0:(snapshot.data.last.allergies.data.length==0)?
            0:(snapshot.data.last.allergies.data.length<=3)?60:120,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 5.0,
                children: List.generate(
                    snapshot.data.last.allergies == null
                        ? 0
                        : snapshot.data.last.allergies.data.length,
                        (index) => GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:
                              Text("Are you sure you want to remove it?"),
                              actions: [
                                FlatButton(
                                  child: Text("Yes"),
                                  color: red,
                                  onPressed: () {
                                    pv.deleteallergy(
                                        snapshot.data.last,
                                        snapshot.data.last.allergies
                                            .data[index].title);
                                    //  pv.deleteDiagnosis(
                                    //      snapshot.data.last,
                                    //      snapshot.data.last.diagnosis
                                    //          .data[index].title);
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text("No"),
                                  color: green,
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        child: Chip(
                          elevation: 4,
                          shadowColor: Colors.grey[50],
                          padding: EdgeInsets.all(4),
                          // clipBehavior: Clip.antiAlias,
                          backgroundColor: orangef,
                          label: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              //  width: 60.0,
                              //  height: 20,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: snapshot.data.last.allergies
                                            .data[index].title,
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 5.0)
                                    ),
                                    RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: "X",
                                          style: TextStyle(
                                            color: black,
                                            fontSize: 14,
                                          ),
                                        )),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          );
          break;
      }
    },
  );
}

class AddAllergies extends StatefulWidget {
  final int docId;
  final HabitDB database;
  AddAllergies({Key key, this.docId, this.database}) : super(key: key);

  @override
  _AddAllergiesState createState() => _AddAllergiesState();
}

class _AddAllergiesState extends State<AddAllergies> {
  String allergyName;

  @override
  Widget build(BuildContext context) {
    // final database = Provider.of<HabitDB>(context);

    return SingleChildScrollView(
      child: AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Container(
          alignment: Alignment.center,
          color: orangep,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add Allergy',
                  style: TextStyle(color: white),
                ),
                IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () => Navigator.pop(context))
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .75,
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter Allergy Name',
                      border: OutlineInputBorder(),

                      // suffixIcon: Icon(Icons.search)
                    ),
                    onChanged: (val) {
                      setState(() {
                        allergyName = val;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 150,
            child: RaisedButton(
                color: pcolor,
                child: Text(
                  'Add',
                  style: TextStyle(color: white),
                ),
                onPressed: () {
                  widget.database.insertAllergy(allergyName, widget.docId);
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }
}
