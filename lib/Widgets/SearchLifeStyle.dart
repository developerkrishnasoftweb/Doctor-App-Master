import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getcure_doctor/Database/HabitsTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:provider/provider.dart';

class SearchLifeStyle extends StatefulWidget {
  final String pId;
  final int docId;

  SearchLifeStyle({Key key, this.pId, this.docId}) : super(key: key);

  @override
  _SearchLifeStyleState createState() => _SearchLifeStyleState();
}

class _SearchLifeStyleState extends State<SearchLifeStyle> {
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
        //     Container(child: Text('LifeStyle')),
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
                  'LifeStyle',
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
          _buildTaskListGrid3(
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
                        return AddLife(
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
    stream: database.watchAllTasks(query,HType.LifeStyle),
    builder: (context, AsyncSnapshot<List<Habit>> snapshot) {
      print(query);
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
                List<LifeStyleData> bhd = [
                  LifeStyleData(
                    title: itemTask.title,
                    doctorId: docId,
                    type: itemTask.type.toString(),
                  ),
                ];
                LifeStyle ls = LifeStyle(data: bhd);
                var p = await pv.checkPatient(pId);
                pv.updateLifeStyle(p.last, ls);
                Fluttertoast.showToast(
                    msg: "${itemTask.title} added to list",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER ,
                    timeInSecForIosWeb: 1,
                    backgroundColor: green,
                    textColor: white,
                    fontSize: 16.0);
                // Navigator.pop(context);
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return GetTimings(
                //       briefTitle: itemTask.title,
                //       pId: pId,
                //       pv: pv,
                //       type: "lifestyle",
                //       allergyOrLifeType: itemTask.type.toString(),
                //       docId: docId,
                //     );
                //   },
                // );
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

StreamBuilder<List<PatientsVisitData>> _buildTaskListGrid3(BuildContext context,
    String query, HabitDB database, PatientsVisitDB pv, String pId) {
  return StreamBuilder(
    stream: pv.getLifeStyle(pId),
    builder: (context, AsyncSnapshot<List<PatientsVisitData>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return CircularProgressIndicator();
          break;
        default:
          return Container(
            height: (snapshot.data.last.lifestyle == null)?0:(snapshot.data.last.lifestyle.data.length==0)?0:(snapshot.data.last.lifestyle.data.length<=3)?50:120,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 5.0,
                children: List.generate(
                    snapshot.data.last.lifestyle == null
                        ? 0
                        : snapshot.data.last.lifestyle.data.length,
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
                                    pv.deleteLifeStyle(
                                        snapshot.data.last,
                                        snapshot.data.last.lifestyle
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
                                        text: snapshot.data.last.lifestyle
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

class AddLife extends StatefulWidget {
  final int docId;
  final HabitDB database;
  AddLife({Key key, this.docId, this.database}) : super(key: key);

  @override
  _AddLifeState createState() => _AddLifeState();
}

class _AddLifeState extends State<AddLife> {
  String lifeName;

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
                  'Add LifeStyle',
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
                      labelText: 'Enter LifeStyle Name',
                      border: OutlineInputBorder(),

                      // suffixIcon: Icon(Icons.search)
                    ),
                    onChanged: (val) {
                      setState(() {
                        lifeName = val;
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
                  widget.database.insertLifeStyle(lifeName, widget.docId);
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }
}
