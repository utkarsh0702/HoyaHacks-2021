import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'excel.dart';
import 'bar.dart';
import 'line.dart';
import 'spline.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String>> number;

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Excel(),
        ));

    // after the SecondScreen result comes back update the List widget with it
    setState(() {
      number = result;
    });
  }

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

    Widget circularMenu(String image, String address) {
      return GestureDetector(
        onTap: () {
          if (address == 'upload') {
            _awaitReturnValueFromSecondScreen(context);
          } 
          else if (address == 'bar') {
            if (number == null) {
              _showDialog(
                  'Data Upload', 'Please upload the data before visualizing..');
            } else {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Bar(data: number)));
            }
          } 
          else if (address == 'line') {
            if (number == null) {
              _showDialog(
                  'Data Upload', 'Please upload the data before visualizing..');
            } else {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Line(data: number)));
            }
          }
          else if (address == 'spline') {
            if (number == null) {
              _showDialog(
                  'Data Upload', 'Please upload the data before visualizing..');
            } else {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Spline(data: number)));
            }
          }
        },
        child: Container(
          height: 80.0,
          width: 80.0,
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: Theme.of(context).accentColor, width: 5),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.contain,
              )),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FabCircularMenu(
          fabOpenColor: Colors.white,
          fabCloseColor: Colors.white,
          fabOpenIcon:
              Icon(LineAwesomeIcons.bar_chart, color: Colors.black, size: 30),
          fabCloseIcon: Icon(Icons.close, color: Colors.black, size: 30),
          fabMargin: EdgeInsets.only(bottom: 50.0),
          ringColor: Color.fromRGBO(255, 255, 255, 0.1),
          ringWidth: 70.0,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            circularMenu('assets/images/bar.png', 'bar'),
            circularMenu('assets/images/line.png', 'line'),
            circularMenu('assets/images/upload.png', 'upload'),
            circularMenu('assets/images/spline.jpg', 'spline'),
            circularMenu('assets/images/pie.jpg', 'pie'),
          ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: SafeArea(
            child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/back.gif'),
                fit: BoxFit.contain,
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'VIZ',
                    style: TextStyle(
                        fontSize: 100.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Cartoonish'),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
