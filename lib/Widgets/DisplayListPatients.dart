import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';

class DisplayLists extends StatefulWidget {
  final TokenDB token;
  final PageController pageController;
  final int tokenNo;
  final Function changePages;
  final DateTime date;
  DisplayLists(
      {Key key,
        this.token,
        this.pageController,
        this.tokenNo,
        this.changePages, this.date})
      : super(key: key);

  @override
  _DisplayListsState createState() => _DisplayListsState();
}

class _DisplayListsState extends State<DisplayLists> {
  List<Token> ans = [];
  @override
  void initState() {
    super.initState();
    getAllEntries();
  }

  void getAllEntries() async {
    List<Token> lists =
    await widget.token.getAllBookedTokens().then((value) => ans = value);
    //print(ans);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          color: orange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(child: Text('Patients List')),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close))
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  color: orangef,
                  child: ExpansionTile(
                      leading: Text("Completed Appointments"),
                      backgroundColor: white,
                      children: [
                        StreamBuilder(
                          stream: widget.token.watchAllCompletedTasks(widget.date),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Token>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                                break;
                              default:
                                return ListView.builder(
                                  itemCount: snapshot.data == null
                                      ? 1
                                      : (snapshot.data.length+1),
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(color: grey))),
                                      child: ListTile(
                                        onTap: index==0?(){}:() async{
                                          List<Token> checkList = await widget.token.getAllbookedTasks(widget.date);
                                          int iWantIndex = checkList.indexOf(snapshot.data[index-1]);
                                          widget.changePages(iWantIndex);
                                        },
                                        title: index==0?Text("Patient Name",style: TextStyle(fontWeight: FontWeight.bold), ) :
                                        Text(snapshot.data[index-1].name,
                                            style: TextStyle(
                                                color: (snapshot
                                                    .data[index-1].isOnline)
                                                    ? (green)
                                                    : (snapshot.data[index-1]
                                                    .cancelled ==
                                                    (true)
                                                    ? (grey)
                                                    : (snapshot.data[index-1]
                                                    .appointmenttype ==
                                                    ('emergency')
                                                    ? (red)
                                                    : (snapshot
                                                    .data[
                                                index-1]
                                                    .bookedtype ==
                                                    ('on call')
                                                    ? orangef
                                                    : blueGrey))))),
                                        trailing:index==0?Text("Address",style: TextStyle(fontWeight: FontWeight.bold),)
                                            : Text(
                                            snapshot.data[index-1].address
                                                .toString(),
                                            style: TextStyle(
                                                color: (snapshot
                                                    .data[index-1].isOnline)
                                                    ? (green)
                                                    : (snapshot.data[index-1]
                                                    .cancelled ==
                                                    (true)
                                                    ? (grey)
                                                    : (snapshot.data[index-1]
                                                    .appointmenttype ==
                                                    ('emergency')
                                                    ? (red)
                                                    : (snapshot
                                                    .data[
                                                index-1]
                                                    .bookedtype ==
                                                    ('on call')
                                                    ? orangef
                                                    : blueGrey))))),
                                        leading:index==0?Text("T.No.",style: TextStyle(fontWeight: FontWeight.bold),) :  Text(
                                            snapshot.data[index].tokenno
                                                .toString(),
                                            style: TextStyle(
                                                color: (snapshot
                                                    .data[index-1].isOnline)
                                                    ? (green)
                                                    : (snapshot.data[index-1]
                                                    .cancelled ==
                                                    (true)
                                                    ? (grey)
                                                    : (snapshot.data[index-1]
                                                    .appointmenttype ==
                                                    ('emergency')
                                                    ? (red)
                                                    : (snapshot
                                                    .data[
                                                index-1]
                                                    .bookedtype ==
                                                    ('on call')
                                                    ? orangef
                                                    : blueGrey))))),
                                      ),
                                    );
                                  },
                                );

                                break;
                            }
                          },
                        ),
                      ]),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  color: orangef,
                  child: ExpansionTile(
                      backgroundColor: white,
                      leading: Text("Present Patients"),
                      children: [
                        StreamBuilder(
                          stream: widget.token.watchAllPresentTasks(widget.date),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Token>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                                break;
                              default:
                                return ListView.builder(
                                  itemCount: snapshot.data == null
                                      ? 1
                                      : (snapshot.data.length+1),
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: index==0?(){}: () async{
                                        List<Token> checkList = await widget.token.getAllbookedTasks(widget.date);
                                        int iWantIndex = checkList.indexOf(snapshot.data[index-1]);
                                        widget.changePages(iWantIndex);
                                      },
                                      title: index==0?Text("Patient Name",style: TextStyle(fontWeight: FontWeight.bold), )
                                          :Text(snapshot.data[index-1].name,
                                          style: TextStyle(
                                              color: (snapshot
                                                  .data[index-1].isOnline)
                                                  ? (green)
                                                  : (snapshot.data[index-1]
                                                  .cancelled ==
                                                  (true)
                                                  ? (grey)
                                                  : (snapshot.data[index-1]
                                                  .appointmenttype ==
                                                  ('emergency')
                                                  ? (red)
                                                  : (snapshot
                                                  .data[index-1]
                                                  .bookedtype ==
                                                  ('on call')
                                                  ? orangef
                                                  : blueGrey))))),
                                      trailing:index==0?Text("Address",style: TextStyle(fontWeight: FontWeight.bold),) :Text(
                                          snapshot.data[index-1].address
                                              .toString(),
                                          style: TextStyle(
                                              color: (snapshot
                                                  .data[index-1].isOnline)
                                                  ? (green)
                                                  : (snapshot.data[index-1]
                                                  .cancelled ==
                                                  (true)
                                                  ? (grey)
                                                  : (snapshot.data[index-1]
                                                  .appointmenttype ==
                                                  ('emergency')
                                                  ? (red)
                                                  : (snapshot
                                                  .data[
                                              index-1]
                                                  .bookedtype ==
                                                  ('on call')
                                                  ? orangef
                                                  : blueGrey))))),
                                      leading:index==0?Text("T.No.",style: TextStyle(fontWeight: FontWeight.bold),) : Text(
                                          snapshot.data[index-1].tokenno
                                              .toString(),
                                          style: TextStyle(
                                              color: (snapshot
                                                  .data[index-1].isOnline)
                                                  ? (green)
                                                  : (snapshot.data[index-1]
                                                  .cancelled ==
                                                  (true)
                                                  ? (grey)
                                                  : (snapshot.data[index-1]
                                                  .appointmenttype ==
                                                  ('emergency')
                                                  ? (red)
                                                  : (snapshot
                                                  .data[
                                              index-1]
                                                  .bookedtype ==
                                                  ('on call')
                                                  ? orangef
                                                  : blueGrey))))),
                                    );
                                  },
                                );
                                break;
                            }
                          },
                        ),
                      ]),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  color: orangef,
                  child: ExpansionTile(
                      backgroundColor: white,
                      leading: Text("Booked Appointments"),
                      children: [
                        StreamBuilder(
                          stream: widget.token.watchAllbookedTasks(widget.date),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Token>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                                break;
                              default:
                                return ListView.builder(
                                  itemCount: snapshot.data == null
                                      ? 1
                                      : (snapshot.data.length+1),
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: () {
                                        widget.changePages(index-1);
                                      },
                                      title: index==0?Text("Patient Name",style: TextStyle(fontWeight: FontWeight.bold), )
                                          :Text(snapshot.data[index-1].name,
                                          style: TextStyle(
                                              color: (snapshot
                                                  .data[index-1].isOnline)
                                                  ? (green)
                                                  : (snapshot.data[index-1]
                                                  .cancelled ==
                                                  (true)
                                                  ? (grey)
                                                  : (snapshot.data[index-1]
                                                  .appointmenttype ==
                                                  ('emergency')
                                                  ? (red)
                                                  : (snapshot
                                                  .data[index-1]
                                                  .bookedtype ==
                                                  ('on call')
                                                  ? orangef
                                                  : blueGrey))))),
                                      trailing:index==0?Text("Address",style: TextStyle(fontWeight: FontWeight.bold),) :Text(
                                          snapshot.data[index-1].address
                                              .toString(),
                                          style: TextStyle(
                                              color: (snapshot
                                                  .data[index-1].isOnline)
                                                  ? (green)
                                                  : (snapshot.data[index-1]
                                                  .cancelled ==
                                                  (true)
                                                  ? (grey)
                                                  : (snapshot.data[index-1]
                                                  .appointmenttype ==
                                                  ('emergency')
                                                  ? (red)
                                                  : (snapshot
                                                  .data[
                                              index-1]
                                                  .bookedtype ==
                                                  ('on call')
                                                  ? orangef
                                                  : blueGrey))))),
                                      leading:index==0?Text("T.No.",style: TextStyle(fontWeight: FontWeight.bold),) : Text(
                                          snapshot.data[index-1].tokenno
                                              .toString(),
                                          style: TextStyle(
                                              color: (snapshot
                                                  .data[index-1].isOnline)
                                                  ? (green)
                                                  : (snapshot.data[index-1]
                                                  .cancelled ==
                                                  (true)
                                                  ? (grey)
                                                  : (snapshot.data[index-1]
                                                  .appointmenttype ==
                                                  ('emergency')
                                                  ? (red)
                                                  : (snapshot
                                                  .data[
                                              index-1]
                                                  .bookedtype ==
                                                  ('on call')
                                                  ? orangef
                                                  : blueGrey))))),
                                    );
                                  },
                                );

                                break;
                            }
                          },
                        ),
                      ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
