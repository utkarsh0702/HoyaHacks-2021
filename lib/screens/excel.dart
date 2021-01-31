import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

class Excel extends StatefulWidget {
  @override
  _ExcelState createState() => _ExcelState();
}

class _ExcelState extends State<Excel> {
  Directory rootPath;
  List<StorageInfo> _storageInfo = [];

  @override
  void initState() {
    super.initState();

    _prepareStorage();
  }

  Future<void> _prepareStorage() async {
    List<StorageInfo> storageInfo;

    try {
      storageInfo = await PathProviderEx.getStorageInfo();
    } on PlatformException {}

    if (!mounted) return;

    setState(() {
      _storageInfo = storageInfo;
      rootPath = Directory(_storageInfo[0].rootDir + '/');
    });
  }

// ------------------------ DroupDown Items ----------------------------//
//   List<String> plots = [
//     'Scatter Plot',
//     'Line Plot',
//     'Bar Graph',
//     'Combo Plot',
//     'Pie Chart'
//   ];
//   String select1 = '', select2 = '', select3 = 'Scatter Plot';

//   int lookUp(String name){
//     int i=0;
//   for(i=0; i<columns.length; i++){
//     if(columns[i] == name)
//       break;
//   }
//   return i;
// }
//------------------------------------------- check for float or integer-------------------//
  List<String> columns;
 // ignore: non_constant_identifier_names
  List<List<String>> column_data;
  int row,col; bool show=false;

//   bool isNumeric(String s) {
//     if (s == null) {
//       return false;
//     }
//     return double.tryParse(s) != null;
//   }

//   bool isFloat(String s) {
//     if (s == null) {
//       return false;
//     }
//     return RegExp(r"[+-]?([0-9]*[.])?[0-9]+").hasMatch(s);
  // }

  Future<void> _openFile(BuildContext context) async {
    String path = await FilesystemPicker.open(
      title: 'Open file',
      context: context,
      rootDirectory: rootPath,
      fsType: FilesystemType.all,
      folderIconColor: Colors.teal,
      allowedExtensions: ['.csv'],
      fileTileSelectMode: FileTileSelectMode.wholeTile,
      requestPermission: () async =>
          await Permission.storage.request().isGranted,
    );

    if (path != null) {
      File file = File('$path');
      final input = file.openRead();
      final contents = await input
          .transform(utf8.decoder)
          .transform(LineSplitter())
          .toList();

      String fileName = path.split('/').last;

      // ignore: non_constant_identifier_names
      List<List<String>> main_content = [];
      columns = contents[0].split(',');
      // copy = List<String>.from(columns);
      // select1 = columns[1];
      // select2 = copy[2];
      contents.forEach((element) => main_content.add(element.split(',')));

      column_data = List.generate(
          columns.length, (i) => List(contents.length),
          growable: false);

      for (int i = 0; i < columns.length; i++) {
        for (int j = 0; j < contents.length; j++) {
          column_data[i][j] = main_content[j][i];
      //     if (isNumeric(main_content[j][i])) {
      //       if (isFloat(main_content[j][i])) {
      //         column_data[i][j - 1] = double.parse(main_content[j][i]);
      //       } else {
      //         column_data[i][j - 1] = int.parse(main_content[j][i]);
      //       }
      //     } else if (isFloat(main_content[j][i])) {
      //       column_data[i][j - 1] = double.parse(main_content[j][i]);
      //     } else {
      //       column_data[i][j - 1] = main_content[j][i];
      //     }
        }
      }
      row = contents.length; col = columns.length;
      // print(columns);
      // print(columns.length);

      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
        'You selected ' + fileName,
        style: TextStyle(fontWeight: FontWeight.bold),
      )));

      setState(() {
              show=true;
            });
    }
  }

  // List category = ["All", "Coustom"];
  // String select;
//---------------------------------------------------------------for radio buttons ------------//
  // Row addRadioButton(int btnValue, String title) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: <Widget>[
  //       Radio(
  //         activeColor: Theme.of(context).accentColor,
  //         value: category[btnValue],
  //         groupValue: select,
  //         onChanged: (value) {
  //           setState(() {
  //             select = value;
  //           });
  //         },
  //       ),
  //       Text(title)
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                      child: Text('Select a CSV File', style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontFamily: 'Oraqle-Script'),),
                    ),
                    onPressed:
                        (rootPath != null) ? () => _openFile(context) : null,
                  ),
                ),
                // addRadioButton(0, 'All the Columns in the table '),
                // addRadioButton(1, 'Want to select 2 columns'),
                // if (select == "Coustom")
                //   Wrap(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: Container(
                //           width: MediaQuery.of(context).size.width - 220,
                //           padding: EdgeInsets.only(left: 7.0, right: 2.0),
                //           decoration: BoxDecoration(
                //               color: Colors.grey,
                //               borderRadius: BorderRadius.circular(15)),
                //           child: DropdownButton(
                //             iconEnabledColor: Colors.white,
                //             dropdownColor: Theme.of(context).primaryColor,
                //             elevation: 10,
                //             style: TextStyle(
                //                 fontSize: 22.0,
                //                 decoration: TextDecoration.none,
                //                 textBaseline: TextBaseline.alphabetic),
                //             items: columns.map((con) {
                //               return DropdownMenuItem(
                //                 value: con,
                //                 child: Center(
                //                   child: Text(
                //                     con,
                //                     style: TextStyle(
                //                       color: Colors.white,
                //                       fontFamily: 'Oraqle-Script',
                //                     ),
                //                   ),
                //                 ),
                //               );
                //             }).toList(),
                //             onChanged: (String newCon) {
                //               if (newCon == select2) {
                //                 Scaffold.of(context).showSnackBar(SnackBar(
                //                     content: Text(
                //                   'Please select different Columns',
                //                   style: TextStyle(fontWeight: FontWeight.bold),
                //                 )));
                //               } else {
                //                 setState(() {
                //                   select1 = newCon;
                //                 });
                //               }
                //             },
                //             value: select1,
                //           ),
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: Container(
                //           width: MediaQuery.of(context).size.width - 220,
                //           padding: EdgeInsets.only(left: 7.0, right: 2.0),
                //           decoration: BoxDecoration(
                //               color: Colors.grey,
                //               borderRadius: BorderRadius.circular(15)),
                //           child: DropdownButton(
                //             iconEnabledColor: Colors.white,
                //             dropdownColor: Theme.of(context).primaryColor,
                //             elevation: 10,
                //             style: TextStyle(
                //                 fontSize: 22.0,
                //                 decoration: TextDecoration.none,
                //                 textBaseline: TextBaseline.alphabetic),
                //             items: copy.map((con) {
                //               return DropdownMenuItem(
                //                 value: con,
                //                 child: Center(
                //                   child: Text(
                //                     con,
                //                     style: TextStyle(
                //                       color: Colors.white,
                //                       fontFamily: 'Oraqle-Script',
                //                     ),
                //                   ),
                //                 ),
                //               );
                //             }).toList(),
                //             onChanged: (String newCon) {
                //               if (select1 == newCon) {
                //                 Scaffold.of(context).showSnackBar(SnackBar(
                //                     content: Text(
                //                   'Please select different Columns',
                //                   style: TextStyle(fontWeight: FontWeight.bold),
                //                 )));
                //               } else {
                //                 setState(() {
                //                   select2 = newCon;
                //                 });
                //               }
                //             },
                //             value: select2,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       top: 30.0, left: 20.0, right: 20.0, bottom: 20.0),
                //   child: Text('Visualization',
                //       style: TextStyle(
                //           fontSize: 30.0,
                //           fontFamily: 'Salmela',
                //           fontWeight: FontWeight.bold)),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(bottom: 10.0, left: 70, right: 70),
                //   child: Container(
                //     padding: EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //         color: Colors.blue,
                //         borderRadius: BorderRadius.circular(15)),
                //     child: DropdownButton(
                //       iconEnabledColor: Colors.white,
                //       dropdownColor: Theme.of(context).primaryColor,
                //       elevation: 10,
                //       style: TextStyle(
                //           fontSize: 32.0,
                //           decoration: TextDecoration.none,
                //           textBaseline: TextBaseline.alphabetic),
                //       items: plots.map((con) {
                //         return DropdownMenuItem(
                //           value: con,
                //           child: Center(
                //             child: Text(
                //               con,
                //               style: TextStyle(
                //                 color: Colors.white,
                //                 fontFamily: 'Oraqle-Script',
                //               ),
                //             ),
                //           ),
                //         );
                //       }).toList(),
                //       onChanged: (String newCon) {
                //         setState(() {
                //           select3 = newCon;
                //         });
                //       },
                //       value: select3,
                //     ),
                //   ),
                // ),
                if(show == true)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Number of Rows: $row'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Number of Columns: $col'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context, column_data);
                          },
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Theme.of(context).accentColor, width: 3.0),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Return',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontFamily: 'Salmela'),
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
