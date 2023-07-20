import 'package:diet/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:diet/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diet/screens/root_app.dart';
import 'package:diet/screens/listmeal.dart';
import 'package:diet/screens/newmeal.dart';
import 'package:diet/utils/function.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  var UserName;
  var UserDatatype;
  var UserID;
  var bmirecord = "null";
  var bmrrecord = "null";
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double bmiResult = 0.0;
  double bmrResult = 0.0;
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController AgeController = TextEditingController();

  int _gender = 1;

  getlocalMemoryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserName = prefs.getString("UserName");
      UserDatatype = prefs.getString("UserDatatype");
      UserID = prefs.getString("UserID");
    });
    print("0000000000");
    print(UserID);
    print("0000000000");
    _callBMI(UserID);
    _callBMR(UserID);
  }

  calculateBMI(paramweight, paramheight) {
    print("enter calculate");
    print(paramweight);
    print(paramheight);
    print("enter calculate");
    double weight = double.parse(paramweight);
    double height = double.parse(paramheight) / 100; // Convert height to meters
    double bmi = weight / (height * height);

    setState(() {
      bmiResult = double.parse(bmi.toStringAsFixed(2));
    });
  }

  calculateBMR(paramweight, paramheight, paramAge, paramSex) {
    if (paramSex == "1") {
      setState(() {
        bmrResult = 10 * double.parse(paramweight) +
            6.25 * double.parse(paramheight) -
            5 * double.parse(paramAge) +
            5;
      });
    } else {
      setState(() {
        bmrResult = 10 * double.parse(paramweight) +
            6.25 * double.parse(paramheight) -
            5 * double.parse(paramAge) -
            161;
      });
    }
  }

  _submitnewBMI(paramweight, paramheight) async {
    var data = {
      "action": "newbmi",
      "bmiWeight": paramweight,
      "bmiHeight": paramheight,
      "UserID": UserID
    };
    var returnData = await dioHttpPostRequest(
        context, data, "newbmi.php", 1, "Please wait..", "brewing data..");
    print("xxxdsdsdsxxx");
    print(returnData);
    //print((returnData["data"][0]["bmiWeight"]).toString());
    print("xxxdsdsdsdxxx");
    Navigator.pop(context);

    if (returnData != "errorException") {
      if (returnData['status'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RootApp(),
          ),
        );
      } else {
        screenLoadingx(
            context, "", returnData['msgtxt'].toString(), true, true, false);
      }
    }
  }

  _submitnewBMR(paramweight, paramheight, paramage, paramgender) async {
    var data = {
      "action": "newbmr",
      "bmrWeight": paramweight,
      "bmrHeight": paramheight,
      "bmrAge": paramage,
      "bmrSex": paramgender,
      "UserID": UserID
    };
    var returnData = await dioHttpPostRequest(
        context, data, "newbmr.php", 1, "Please wait..", "brewing data..");
    print("xxxdsdsdsxxx");
    print(returnData);
    print("xxxdsdsdsdxxx");
    Navigator.pop(context);

    if (returnData != "errorException") {
      if (returnData['status'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RootApp(),
          ),
        );
      } else {
        screenLoadingx(
            context, "", returnData['msgtxt'].toString(), true, true, false);
      }
    }
  }

  _callBMI(paramUserID) async {
    var data = {"action": "bmi", "UserID": paramUserID};
    var returnData = await dioHttpPostRequest(
        context, data, "bmi.php", 1, "Please wait..", "brewing data..");
    print("xxxdsdsdsxxx");
    print(returnData);
    //print((returnData["data"][0]["bmiWeight"]).toString());
    print("xxxdsdsdsdxxx");
    Navigator.pop(context);

    if (returnData != "errorException") {
      if (returnData['status'] == true) {
        if (returnData['record_no'] == "true") {
          setState(() {
            bmirecord = "unnull";
          });
          calculateBMI(returnData["data"][0]["bmiWeight"],
              returnData["data"][0]["bmiHeight"]);
        } else {
          setState(() {
            bmirecord = "null";
          });
        }
        //   String UserName=returnData['UserName'].toString();
      } else {
        screenLoadingx(
            context, "", returnData['msgtxt'].toString(), true, true, false);
      }
    }
  }

  _callBMR(paramUserID) async {
    var data = {"action": "bmi", "UserID": paramUserID};
    var returnData = await dioHttpPostRequest(
        context, data, "bmr.php", 1, "Please wait..", "brewing data..");
    print("xxxdsdsdsxxx");
    print(returnData);
    //print((returnData["data"][0]["bmiWeight"]).toString());
    print("xxxdsdsdsdxxx");
    Navigator.pop(context);

    if (returnData != "errorException") {
      if (returnData['status'] == true) {
        if (returnData['record_no'] == "true") {
          setState(() {
            bmrrecord = "unnull";
          });
          calculateBMR(
              returnData["data"][0]["bmrWeight"],
              returnData["data"][0]["bmrHeight"],
              returnData["data"][0]["bmrAge"],
              returnData["data"][0]["bmrSex"]);
        } else {
          setState(() {
            bmrrecord = "null";
          });
        }
        //   String UserName=returnData['UserName'].toString();
      } else {
        screenLoadingx(
            context, "", returnData['msgtxt'].toString(), true, true, false);
      }
    }
  }

  Widget DrawerWidget() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100,
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('New Meal'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewMealPage()));
            },
          ),
          ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('List Meal'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListMealPage()));
              }),
          ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Signin()),
                        (Route<dynamic> route) => false);
              }),
          /* ListTile(
            leading: Icon(Icons.update),
            title: Text('Update Meal'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),*/
        ],
      ),
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getlocalMemoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        key: scaffoldKey,
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white, //appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: getAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => buildBody(),
                childCount: 1,
              ),
            )
          ],
        ));
  }

  Widget insertNewBMI() {
    return Container(
      height: 300.0,
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _submitnewBMI(weightController.text, heightController.text);
                  // Add your button click logic here
                  print('Button pressed!');
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  insertNewBMR() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter myState) {
              return Container(
                height: 700.0,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              RadioListTile(
                                value: 1,
                                title: const Text("Male"),
                                groupValue: _gender,
                                onChanged: (val) => myState(() {
                                  _gender = val! as int;
                                }),
                              ),
                              RadioListTile(
                                value: 2,
                                title: const Text("Female"),
                                groupValue: _gender,
                                onChanged: (val) => myState(() {
                                  _gender = val! as int;
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          TextField(
                            controller: AgeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Age',
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Weight (kg)',
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextField(
                            controller: heightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Height (cm)',
                            ),
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              _submitnewBMR(
                                  weightController.text,
                                  heightController.text,
                                  AgeController.text,
                                  _gender);
                              // Add your button click logic here
                              print('Button pressed!');
                            },
                            child: Text('Submit'),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  Widget getAppBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$UserName',
                style: TextStyle(
                  color: labelColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Good Morning!",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
            ],
          )),

          /* NotificationBox(
              notifiedNumber: 0,
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ) ,*/

          SizedBox(
            width: 15,
          ),
          Container(
            //padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appBarColor,
              border: Border.all(color: Colors.grey.withOpacity(.3)),
            ),
            child: IconButton(
              color: Colors.green,
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RootApp(),
                  ),
                );

                // handle the press
              },
            ),
          ),
          SizedBox(
            width: 15,
          ),
          UserDatatype == "1"
              ? Container(
                  //padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: appBarColor,
                    border: Border.all(color: Colors.grey.withOpacity(.3)),
                  ),
                  child: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        color: Colors.green,
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 10),
              padding:
                  EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    bmirecord != "null"
                        ? Column(
                            children: [
                              Text(
                                "Your BMI",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                (bmiResult).toString() + " kg/m2",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Text("BMI table for adults"),
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                border: TableBorder.all(),
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Classification'),
                                      ),
                                      TableCell(
                                        child: Text('BMI range - kg/m²'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Severe Thinness'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('< 16'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Moderate Thinness'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('16 - 17'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Mild Thinness'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('17 - 18.5'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Normal'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('18.5 - 25'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Overweight'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('25 - 30'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Obese Class I'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('30 - 35'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Obese Class II'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('35 - 40'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Obese Class III'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('> 40'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return insertNewBMI();
                                    },
                                  );

                                  // Add your button click logic here
                                  print('Button pressed!');
                                },
                                child: Text('New BMI Record'),
                              )
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return insertNewBMI();
                                },
                              );

                              // Add your button click logic here
                              print('Button pressed!');
                            },
                            child: Text('New BMI Record'),
                          )
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 10),
              padding:
                  EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    bmrrecord != "null"
                        ? Column(
                            children: [
                              Text(
                                "Your BMR",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                (bmrResult).toString() + " Calories/day",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "Daily calorie needs based on activity level"),
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                border: TableBorder.all(),
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Activity Level'),
                                      ),
                                      TableCell(
                                        child: Text('Calorie'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text(
                                            'Sedentary: little or no exercise'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('1,926'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Exercise 1-3 times/week'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('2,207'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Exercise 4-5 times/week'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('2,351'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text(
                                            'Daily exercise or intense exercise 3-4 times/week'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('2,488'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text(
                                            'Intense exercise 6-7 times/week'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('2,769'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text(
                                            'Very intense exercise daily, or physical job'),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text('3,050'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  insertNewBMR();

                                  // Add your button click logic here
                                  print('Button pressed!');
                                },
                                child: Text('New BMR Record'),
                              )
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () {
                              insertNewBMR();

                              // Add your button click logic here
                              print('Button pressed!');
                            },
                            child: Text('New BMR Record'),
                          )
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
