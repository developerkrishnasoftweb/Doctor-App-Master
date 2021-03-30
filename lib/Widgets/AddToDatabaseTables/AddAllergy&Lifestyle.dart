import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/HabitsTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:provider/provider.dart';

class AddAllergyLifestyle extends StatefulWidget {
  final int docId;

  const AddAllergyLifestyle({Key key, this.docId}) : super(key: key);
  @override
  _AddAllergyLifestyleState createState() => _AddAllergyLifestyleState();
}

class _AddAllergyLifestyleState extends State<AddAllergyLifestyle> {

  String query = '';
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<HabitDB>(context);

    return SingleChildScrollView(
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(child: Text('Allergies And Lifestyle')),
            InkWell(
                onTap: () => Navigator.pop(context), child: Icon(Icons.close))
          ],
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
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
                        
                      ),
                    ),
                    _buildTaskList(context, query, database,widget.docId),
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
    HabitDB database, int docId) {
  return StreamBuilder(
    stream: database.watchAllTask(query),
    builder: (context, AsyncSnapshot<List<Habit>> snapshot) {
      print(query);
      final tasks = snapshot.data ?? List();
      return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.6,
        child: ListView.separated(
          separatorBuilder: (_, index) {
            return Divider();
          },
          scrollDirection: Axis.vertical,
          itemCount: tasks.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final itemTask = tasks[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: Text(itemTask.title),
            );
          },
        ),
      );
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
