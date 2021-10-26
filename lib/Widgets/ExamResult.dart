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
                rows: widget.exmdata.parameters
                    .map<DataRow>((p) => DataRow(
                            color: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (p.result != null && p.result.length != 0) {
                                if (p.type == 'numeric' &&
                                    ((double.tryParse('${p.result[0]}') ??
                                                0.0) <
                                            double.parse(p.references[0]) ||
                                        (double.tryParse('${p.result[0]}') ??
                                                0.0) >
                                            double.parse(p.references.last))) {
                                  return Colors.red[100];
                                  // } else {
                                  //   return blue;
                                  // }
                                } else if (p.bioReference != null &&
                                    p.bioReference.length != 0 &&
                                    p.type == 'radio' &&
                                    (p.result[0] != p.bioReference.first)) {
                                  return Colors.red[100];
                                }
                              }
                              return grey;
                            }),
                            cells: [
                              DataCell(Text(p.title), onTap: () {}),
                              DataCell(
                                  p.type == 'numeric'
                                      ? TextFormField(
                                          initialValue: p.result?.length == 0
                                              ? ""
                                              : (p?.result?.last != null
                                                  ? p.result.last
                                                  : ""),
                                          keyboardType: TextInputType.number,
                                          onChanged: (val) async {
                                            String tex = "";
                                            setState(() {
                                              tex = val;
                                            });
                                            ParameterData pd = ParameterData(
                                                title: p.title,
                                                type: "numeric",
                                                unit: p.unit,
                                                bioReference: p.bioReference,
                                                references: p.references,
                                                method: p.method,
                                                sample: p.sample);

                                            var x = await patientsVisit
                                                .checkPatient(widget.pid);
                                            patientsVisit
                                                .updateExaminationParams(
                                                    x.last,
                                                    widget
                                                        .exmdata.examinationId,
                                                    pd,
                                                    tex);
                                          },
                                        )
                                      : DropdownButton<String>(
                                          items:
                                              p.references.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          hint: Text('result'),
                                          value: p.result.length == 0
                                              ? null
                                              : p.result[0],
                                          elevation: 5,
                                          isExpanded: true,
                                          onChanged: (val) async {
                                            setState(() {
                                              _category = val;
                                              if (p.result.isNotEmpty) {
                                                p.result[0] = val;
                                              }
                                            });
                                            ParameterData pd = ParameterData(
                                                title: p.title,
                                                type: "radio",
                                                unit: p.unit,
                                                bioReference: p.bioReference,
                                                references: p.references,
                                                method: p.method,
                                                sample: p.sample);

                                            var x = await patientsVisit
                                                .checkPatient(widget.pid);
                                            patientsVisit
                                                .updateExaminationParams(
                                                    x.last,
                                                    widget
                                                        .exmdata.examinationId,
                                                    pd,
                                                    _category);
                                          },
                                        ),
                                  onTap: () {}),
                              DataCell(
                                  Text(p.type == 'numeric'
                                      ? '${p.references[0]} - ${p.references.last}'
                                      : p.bioReference.length == 0
                                          ? ''
                                          : p.bioReference.first),
                                  onTap: () {}),
                              DataCell(Text(p.unit), onTap: () {}),
                            ]))
                    .toList()),
          ),
        )
      ],
    );
  }
}
