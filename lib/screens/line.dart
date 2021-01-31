import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'helper/column_data_seperator.dart';

// ignore: must_be_immutable
class Line extends StatefulWidget {
  List<List<String>> data;
  Line({@required this.data});
  @override
  _LineState createState() => _LineState();
}

class _LineState extends State<Line> {
  
  int selected = 10;
  bool plot = false;
  List<double> xData = [];
  List<double> yData = [];
  String stringX = '', stringY = '', select1, select2;
  int rows;
  //---------------Color Chart ---------------------//
  bool isSwitched1 = false;

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
    rows = rowCount(widget.data);
    if (select1 == null && select2 == null) {
      select1 = columns[0];
      select2 = copy[1];
    }

    List<int> doubleList = List<int>.generate(rows - 1, (int index) => index);
    List<DropdownMenuItem> menuItemList = doubleList
        .map((val) =>
            DropdownMenuItem(value: val + 1, child: Text('${val + 1}')))
        .toList();

    dynamic getLineData() {
      List<PlotData> columnData = [];
      for (int i = 0; i < selected; i++) {
        columnData.add(PlotData(xData[i], yData[i]));
      }
      return columnData;
    }

    return Scaffold(
        body: (plot == false)
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Line Chart',
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
                            if (newCon == select2) {
                              _showDialog('Column Error',
                                  'Both Columns cannot be same');
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
                            if (select1 == newCon) {
                              _showDialog('Column Error',
                                  'Both Columns cannot be same');
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
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    children: [
                      Text('No of Rows: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Bosk',
                          )),
                      DropdownButton(
                        value: selected,
                        onChanged: (val) => setState(() => selected = val),
                        items: menuItemList,
                      )
                    ],
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
                          stringY = select2;
                          try {
                            xData = colY(widget.data, stringX);
                            yData = colY(widget.data, stringY);
                            plot = true;
                          } catch (_) {
                            _showDialog('Column Error',
                                'Both the dropdown should have columns having numeric data');
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
                        title: ChartTitle(text: '$stringX vs $stringY'),
                        primaryXAxis:
                            NumericAxis(title: AxisTitle(text: stringX)),
                        primaryYAxis:
                            NumericAxis(title: AxisTitle(text: stringY)),
                        legend: Legend(isVisible: true),
                        trackballBehavior: TrackballBehavior(
                            enable: true,
                            activationMode: ActivationMode.singleTap),
                        zoomPanBehavior: ZoomPanBehavior(
                            enablePanning: true,
                            enablePinching: true,
                            zoomMode: (isSwitched1 == true)
                                ? ZoomMode.x
                                : ZoomMode.xy),
                        series: <ChartSeries>[
                          LineSeries<PlotData, double>(
                            dataSource: getLineData(),
                            name: stringY,
                            xValueMapper: (PlotData sales, _) => sales.x,
                            yValueMapper: (PlotData sales, _) => sales.y,
                          )
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
