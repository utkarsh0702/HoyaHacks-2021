import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'helper/column_data_seperator.dart';

// ignore: must_be_immutable
class Spline extends StatefulWidget {
  List<List<String>> data;
  Spline({@required this.data});
  @override
  _SplineState createState() => _SplineState();
}

class _SplineState extends State<Spline> {
  int rows;
  bool plot = false;
  List<double> xData = [];
  List<double> yData1 = [], yData2 = [], yData3 = [];
  String stringX = '',
      stringY = '',
      stringW = '',
      stringZ = '',
      select1,
      select2,
      select3,
      select4;
  //---------------Color Chart ---------------------//
  bool isSwitched = false, isSwitched1 = false, isSwitched2 = false;

  @override
  Widget build(BuildContext context) {
    _showDialog(title, text) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                )
              ],
            );
          });
    }

    List<String> columns = column(widget.data);
    List<String> copy = List<String>.from(columns);
    List<String> copy1 = List<String>.from(columns);
    List<String> copy2 = List<String>.from(columns);
    rows = rowCount(widget.data);
    if (select1 == null &&
        select2 == null &&
        select3 == null &&
        select4 == null) {
      select1 = columns[0];
      select3 = copy[2];
      select2 = copy[1];
      select4 = copy[3];
    }

    dynamic getSplineData1() {
      List<PlotData> columnData = [];
      for (int i = 0; i < rows - 1; i++) {
        columnData.add(PlotData(xData[i], yData1[i]));
      }
      return columnData;
    }

    dynamic getSplineData2() {
      List<PlotData> columnData = [];
      for (int i = 0; i < rows - 1; i++) {
        columnData.add(PlotData(xData[i], yData2[i]));
      }
      return columnData;
    }

    dynamic getSplineData3() {
      List<PlotData> columnData = [];
      for (int i = 0; i < rows - 1; i++) {
        columnData.add(PlotData(xData[i], yData3[i]));
      }
      return columnData;
    }

    return Scaffold(
        body: (plot == false)
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Spline Chart',
                  style: TextStyle(
                      fontSize: 50.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                      fontFamily: 'Cartoonish'),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: 180,
                        padding: EdgeInsets.only(left: 7.0, right: 2.0),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton(
                          iconEnabledColor: Colors.white,
                          dropdownColor: Theme.of(context).primaryColor,
                          elevation: 10,
                          style: TextStyle(
                              fontSize: 20.0,
                              decoration: TextDecoration.none,
                              textBaseline: TextBaseline.alphabetic),
                          items: columns.map((con) {
                            return DropdownMenuItem(
                              value: con,
                              child: Center(
                                child: Text(
                                  con,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Bosk',
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newCon) {
                            if ((newCon == select2) &&
                                (newCon == select3) &&
                                (newCon == select4)) {
                              _showDialog(
                                  'Column Error', 'No Two Columns can be same');
                            } else {
                              setState(() {
                                select1 = newCon;
                              });
                            }
                          },
                          value: select1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 180,
                        padding: EdgeInsets.only(left: 7.0, right: 2.0),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton(
                          iconEnabledColor: Colors.white,
                          dropdownColor: Theme.of(context).primaryColor,
                          elevation: 10,
                          style: TextStyle(
                              fontSize: 20.0,
                              decoration: TextDecoration.none,
                              textBaseline: TextBaseline.alphabetic),
                          items: copy.map((con) {
                            return DropdownMenuItem(
                              value: con,
                              child: Center(
                                child: Text(
                                  con,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Bosk',
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newCon) {
                            if ((newCon == select1) &&
                                (newCon == select3) &&
                                (newCon == select4)) {
                              _showDialog(
                                  'Column Error', 'No Two Columns can be same');
                            } else {
                              setState(() {
                                select2 = newCon;
                              });
                            }
                          },
                          value: select2,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0, right:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add a Third Column',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Bosk',
                          )),
                      Switch(
                        value: isSwitched1,
                        onChanged: (value) {
                          setState(() {
                            isSwitched1 = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (isSwitched1 == true)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 180,
                      padding: EdgeInsets.only(left: 7.0, right: 2.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton(
                        iconEnabledColor: Colors.white,
                        dropdownColor: Theme.of(context).primaryColor,
                        elevation: 10,
                        style: TextStyle(
                            fontSize: 20.0,
                            decoration: TextDecoration.none,
                            textBaseline: TextBaseline.alphabetic),
                        items: copy1.map((con) {
                          return DropdownMenuItem(
                            value: con,
                            child: Center(
                              child: Text(
                                con,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Bosk',
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newCon) {
                          if ((newCon == select2) &&
                              (newCon == select1) &&
                              (newCon == select4)) {
                            _showDialog(
                                'Column Error', 'No Two Columns can be same');
                          } else {
                            setState(() {
                              select3 = newCon;
                            });
                          }
                        },
                        value: select3,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0, right:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add a Fourth Column',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Bosk',
                          )),
                      Switch(
                        value: isSwitched2,
                        onChanged: (value) {
                          setState(() {
                            isSwitched2 = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (isSwitched2 == true)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 180,
                      padding: EdgeInsets.only(left: 7.0, right: 2.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton(
                        iconEnabledColor: Colors.white,
                        dropdownColor: Theme.of(context).primaryColor,
                        elevation: 10,
                        style: TextStyle(
                            fontSize: 20.0,
                            decoration: TextDecoration.none,
                            textBaseline: TextBaseline.alphabetic),
                        items: copy2.map((con) {
                          return DropdownMenuItem(
                            value: con,
                            child: Center(
                              child: Text(
                                con,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Bosk',
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newCon) {
                          if ((newCon == select2) &&
                              (newCon == select1) &&
                              (newCon == select3)) {
                            _showDialog(
                                'Column Error', 'No Two Columns can be same');
                          } else {
                            setState(() {
                              select4 = newCon;
                            });
                          }
                        },
                        value: select4,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 20.0, left: 30.0, right: 30.0),
                  child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width - 50,
                      height: 60.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Plot',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontFamily: 'Oraqle-Script'),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          stringX = select1;
                          stringW = (isSwitched1 == true) ? select3 : null;
                          stringY = select2;
                          stringZ = (isSwitched2 == true) ? select4 : null;
                          try {
                            xData = colY(widget.data, stringX);
                            yData1 = colY(widget.data, stringY);
                            if (isSwitched1 == true) {
                              yData2 = colY(widget.data, stringW);
                            }
                            if (isSwitched2 == true) {
                              yData3 = colY(widget.data, stringZ);
                            }
                            plot = true;
                          } catch (_) {
                            _showDialog('Column Error',
                                'All the dropdown should have columns having numeric data');
                          }
                        });
                      }),
                ),
              ])
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Zoomed X-Axis View',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Bosk',
                            )),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0),
                    child: Text('Use two fingers on the Plot to zoom it.....',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'Bosk',
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 20.0, left: 30.0, right: 30.0),
                    child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width - 50,
                        height: 50.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Return',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontFamily: 'Oraqle-Script'),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            plot = false;
                          });
                        }),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height - 100,
                      child: SfCartesianChart(
                        title: ChartTitle(
                            text:
                                ((isSwitched1 == true) || (isSwitched2 == true))
                                    ? 'MultiPlot'
                                    : '$stringX vs $stringY'),
                        primaryXAxis:
                            CategoryAxis(title: AxisTitle(text: stringX)),
                        primaryYAxis:
                            NumericAxis(title: AxisTitle(text: ((isSwitched1 == true) || (isSwitched2 == true))
                                    ? 'Data' : stringY)),
                        legend: Legend(isVisible: true),
                        trackballBehavior: TrackballBehavior(
                            enable: true,
                            activationMode: ActivationMode.singleTap),
                        zoomPanBehavior: ZoomPanBehavior(
                            enablePanning: true,
                            enablePinching: true,
                            zoomMode: (isSwitched == true)
                                ? ZoomMode.x
                                : ZoomMode.xy),
                        series: <ChartSeries>[
                          SplineSeries<PlotData, double>(
                            dataSource: getSplineData1(),
                            name: stringY,
                            xValueMapper: (PlotData sales, _) => sales.x,
                            yValueMapper: (PlotData sales, _) => sales.y,
                          ),
                          if (isSwitched1 == true)
                            SplineSeries<PlotData, double>(
                              dataSource: getSplineData2(),
                              color: Colors.red,
                              name: stringW,
                              xValueMapper: (PlotData sales, _) => sales.x,
                              yValueMapper: (PlotData sales, _) => sales.y,
                            ),
                          if (isSwitched2 == true)
                            SplineSeries<PlotData, double>(
                              dataSource: getSplineData3(),
                              color:Colors.green,
                              name: stringZ,
                              xValueMapper: (PlotData sales, _) => sales.x,
                              yValueMapper: (PlotData sales, _) => sales.y,
                            ),
                        ],
                      )),
                ],
              ));
  }
}

class PlotData {
  double x;
  double y;

  PlotData(this.x, this.y);
}
