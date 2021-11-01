import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/ExaminationTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:provider/provider.dart';

class ExamResult extends StatefulWidget {
  final ExaminationData exmdata;
  final String pid;
  final VoidCallback fun;

  ExamResult({Key key, this.exmdata, this.pid, this.fun}) : super(key: key);

  @override
  _ExamResultState createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {
  List<String> numericResultList = [];
  String _category;

  @override
  Widget build(BuildContext context) {
    // final exam = Provider.of<ExaminationsDB>(context);
    final patientsVisit = Provider.of<PatientsVisitDB>(context);

    return SimpleDialog(
      title: Container(
        alignment: Alignment.center,
        color: orangep,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  widget.exmdata.title,
                  style: TextStyle(color: white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    widget.fun();
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
      titlePadding: EdgeInsets.zero,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          // width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Text('Test Name'),
                ),
                DataColumn(label: Text('Result'), numeric: true),
                DataColumn(label: Text('Bio Reference'), numeric: true),
                DataColumn(
                  label: Text('Unit'),
                ),
              ],
              rows: List.generate(
                widget.exmdata.parameters.length,
                (index) {
                  Parameters parameter = widget.exmdata.parameters[index];

                  return DataRow(
                      color: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return getColor(parameter);
                        },
                      ),
                      cells: [
                        DataCell(Text(parameter.title), onTap: () {}),
                        DataCell(
                            parameter.type == 'numeric'
                                ? TextFormField(
                                    initialValue: parameter.result.length == 0
                                        ? ""
                                        : parameter.result.last,
                                    keyboardType: TextInputType.number,
                                    onChanged: (val) async {
                                      String tex = "";
                                      setState(() {
                                        tex = val;
                                        //print("tex  : " +parameter.result.toString());
                                      });

                                      ParameterData pd = ParameterData(
                                          title: parameter.title,
                                          type: "numeric",
                                          unit: parameter.unit,
                                          bioReference: parameter.bioReference,
                                          references: parameter.references,
                                          method: parameter.method,
                                          sample: parameter.sample);

                                      var x = await patientsVisit
                                          .checkPatient(widget.pid);

                                      patientsVisit.updateExaminationParams(
                                          x.last,
                                          widget.exmdata.examinationId,
                                          pd,
                                          tex);

                                      setState(() {
                                        List<String> temp;
                                        temp.add(tex);
                                        parameter.result = temp;
                                        //print("tex  : " +parameter.result.toString());
                                        // print("Change  : " +parameter.result[0]);
                                      });
                                    },
                                  )
                                : DropdownButton<String>(
                                    items: parameter.references
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    hint: Text('result'),
                                    value: parameter.result.length == 0
                                        ? null
                                        : parameter.result[0],
                                    elevation: 5,
                                    isExpanded: true,
                                    onChanged: (val) async {
                                      setState(() {
                                        _category = val;
                                        if (parameter.result.isNotEmpty) {
                                          parameter.result[0] = val;
                                        }
                                      });
                                      ParameterData pd = ParameterData(
                                          title: parameter.title,
                                          type: "radio",
                                          unit: parameter.unit,
                                          bioReference: parameter.bioReference,
                                          references: parameter.references,
                                          method: parameter.method,
                                          sample: parameter.sample);

                                      var x = await patientsVisit
                                          .checkPatient(widget.pid);
                                      patientsVisit.updateExaminationParams(
                                          x.last,
                                          widget.exmdata.examinationId,
                                          pd,
                                          _category);
                                    },
                                  ),
                            onTap: () {}),
                        DataCell(
                            Text(parameter.type == 'numeric'
                                ? '${parameter.references[0]} - ${parameter.references.last}'
                                : parameter.bioReference.length == 0
                                    ? ''
                                    : parameter.bioReference.first),
                            onTap: () {}),
                        DataCell(Text(parameter.unit), onTap: () {}),
                      ]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color getColor(Parameters parameter) {
    if (parameter.result.length != 0) {
      if (parameter.type == 'numeric' &&
          (double.parse(parameter.result[0]) <
                  double.parse(parameter.references[0]) ||
              double.parse(parameter.result[0]) >
                  double.parse(parameter.references.last))) {
        // print('result : ${parameter.result.toString()}');
        //print('references : ${parameter.references.toString()}');
        return Colors.red[100];
      } else if (parameter.bioReference.length != 0 &&
          parameter.type == 'radio' &&
          (parameter.result[0] != parameter.bioReference.first)) {
        return Colors.red[100];
      } else {
        return Colors.white;
      }
    }
    return Colors.white;
  }
}
