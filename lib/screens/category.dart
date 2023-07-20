import 'package:flutter/material.dart';
import 'package:diet/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diet/screens/root_app.dart';
import 'package:diet/utils/function.dart';
import 'package:diet/utils/url_source.dart';
import 'package:intl/intl.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List seleclistmeal = [];
  var dataX = [];
  var username;
  var user_type;
  var UserID;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late List listmeal = [];
  var totalcalories = 0.0;
  var bmrrecord = "null";
  double bmrResult = 0.0;
  List<String> options = ['Breakfast', 'Lunch', 'Hi-tea', 'Dinner'];
  getlocalMemoryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      user_type = prefs.getString("user_type");
      UserID = prefs.getString("UserID");
    });
    _callBMR(UserID);
    _callselectListMeal(UserID);
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

  _callselectListMeal(UserIDx) async {
    var data = {
      "UserID": UserIDx,
    };
    print("sssssss");
    print(data);
    var returnData = await dioHttpPostRequest(context, data,
        "listselectmeal.php", 1, "Please wait..", "brewing data..");
    print("_callselectListMeal");
    print(returnData);
    print("_callselectListMeal");
    Navigator.pop(context);

    if (returnData != "errorException") {
      if (returnData['status'] == true) {
        print("Diatery Guidance");
        print(returnData);
        setState(() {
          seleclistmeal = returnData['data'];
        });
        print("bbbbbbbbbbb");
        print(seleclistmeal.length);
        totalcalariesFunction();
      } else {
        screenLoadingx(
            context, "", returnData['msgtxt'].toString(), true, true, false);
      }
    }
  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users

      results = dataX;
    } else {
      results = dataX
          .where((Key) => Key["mealTitle"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      listmeal = results;
    });
  }

  totalcalariesFunction() {
    setState(() {
      totalcalories = 0.0;
    });
    print("jxk");
    print(seleclistmeal.length);
    print(listmeal.length);
    for (int i = 0; i < seleclistmeal.length; i++) {
      for (int x = 0; x < listmeal.length; x++) {
        if (listmeal[x]['mealID'] == seleclistmeal[i]['mealID']) {
          print("jk");
          setState(() {
            totalcalories =
                double.parse(listmeal[x]['foodCalorie']) + totalcalories;
          });
        }
      }
    }
  }

  _callListMeal() async {
    print("click here");
    var data = {
      "action": "listmeal",
    };
    var returnData = await dioHttpPostRequest(
        context, data, "listmeal.php", 1, "Please wait..", "brewing data..");
    print("xxxyyyyxxx");
    print(returnData);
    print("xxxyyyyxxx");
    Navigator.pop(context);

    if (returnData != "errorException") {
      if (returnData['status'] == true) {
        print("Diatery Guidance");
        print(returnData);
        setState(() {
          dataX = returnData['data'];
          listmeal = dataX;
        });
      } else {
        screenLoadingx(
            context, "", returnData['msgtxt'].toString(), true, true, false);
      }
    }
  }

  SelectMeal(mealID) async {
    var data = {"action": "selectmeal", "UserID": UserID, "mealID": mealID};
    var returnData = await dioHttpPostRequest(context, data,
        "newselectmeal.php", 1, "Please wait..", "brewing data..");
    print(returnData);
    Navigator.pop(context);

    if (returnData != "errorException") {
      if (returnData['status'] == true) {
        _callselectListMeal(UserID);
        // _callselectListMeal(UserID);
        //Navigator.pop(context);
        screenLoadingx(
            context, "", returnData['message'].toString(), true, true, false);
      } else {
        screenLoadingx(
            context, "", returnData['message'].toString(), true, true, false);
      }
    }
  }

  DelSelectMeal(dailyID) async {
    var data = {
      "action": "DelSelectMeal",
      "UserID": UserID,
      "daily_id": dailyID
    };
    var returnData = await dioHttpPostRequest(
        context, data, "deletemeal.php", 1, "Please wait..", "brewing data..");
    print(returnData);
    Navigator.pop(context);

    if (returnData != "errorException") {
      if (returnData['status'] == true) {
        _callselectListMeal(UserID);
        totalcalariesFunction();
        // _callselectListMeal(UserID);
        //Navigator.pop(context);
        screenLoadingx(
            context, "", returnData['message'].toString(), true, true, false);
      } else {
        screenLoadingx(
            context, "", returnData['message'].toString(), true, true, false);
      }
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getlocalMemoryData();
    _callListMeal();
  }

  DisplayCategory() {
    return SingleChildScrollView(
      child: Expanded(
          // height: MediaQuery.of(context).size.height,
          child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          TextField(
            onChanged: (value) => _runFilter(value),
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              labelStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView(
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(options.length, (index) {
                return Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Text(
                        options[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    for (int i = 0; i < listmeal.length; i++)
                      listmeal[i]['CategoryID'] == options[index]
                          ? Container(
                              margin: EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 2),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(
                                          mainUrl +
                                              "upload/" +
                                              "." +
                                              listmeal[i][
                                                  'pictureCode'], // Replace with your network image URL
                                          fit: BoxFit
                                              .cover, // Adjust the fit based on your requirements
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                          child: Container(
                                              child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                  child: Container(
                                                      child: Text(
                                                          listmeal[i][
                                                                  'mealTitle'] +
                                                              "-" +
                                                              listmeal[i][
                                                                  'foodCalorie'] +
                                                              " calori",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700)))),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              OutlinedButton(
                                                onPressed: () {
                                                  SelectMeal(
                                                      listmeal[i]['mealID']);
                                                  // Button action
                                                },
                                                child: Text(
                                                  'Select Meal',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                  side: BorderSide(
                                                      color: Colors
                                                          .white), // Set the border color
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ))),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    Container(
                      height: 40,
                    ),
                  ],
                );
              }))
        ],
      )),
    );
  }

  DisplaySelectedMeal() {
    return SingleChildScrollView(
      child: ListView(
          padding: EdgeInsets.only(top: 10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(seleclistmeal.length, (index) {
            return Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),

                  //child: Text(options[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                for (int i = 0; i < listmeal.length; i++)
                  seleclistmeal[index]['mealID'] == listmeal[i]['mealID']
                      ? Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 2),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                      mainUrl +
                                          "upload/" +
                                          "." +
                                          listmeal[i][
                                              'pictureCode'], // Replace with your network image URL
                                      fit: BoxFit
                                          .cover, // Adjust the fit based on your requirements
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Container(
                                          child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                              child: Container(
                                                  child: Text(
                                                      listmeal[i]['mealTitle'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .w700)))),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                              child: Container(
                                                  child: Text(
                                                      listmeal[i]
                                                              ['foodCalorie'] +
                                                          " calori",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .w700)))),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                              child: Container(
                                                  child: Text(
                                                      listmeal[i]['CategoryID'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .w700)))),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              print(seleclistmeal[index]
                                                  ['daily_id']);
                                              DelSelectMeal(seleclistmeal[index]
                                                  ['daily_id']);
                                              //SelectMeal(listmeal[i]['mealID']);
                                              // Button action
                                            },
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: OutlinedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              side: BorderSide(
                                                  color: Colors
                                                      .white), // Set the border color
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ))),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(),
                Container(
                  height: 10,
                ),
              ],
            );
          })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
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
              SizedBox(
                height: 5,
              ),
              Text("Category",
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
              color: Colors.black,
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
        ],
      ),
    );
  }

  buildBody() {
    return DefaultTabController(
        initialIndex: 0, //optional, starts from 0, select the tab by default
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              title: Text("Category"),
              backgroundColor: Colors.white,
              bottom: TabBar(labelColor: Colors.black, tabs: [
                Tab(
                  text: "List Category",
                ),
                Tab(
                  text: "Selected Category",
                )
              ]),
            ),
            body: TabBarView(children: [
              DisplayCategory(),
              Container(
                //for second tab
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text("Total Selected Calorie :${totalcalories}"),
                      Text("Ideal BMR Calorie/day :${bmrResult}"),
                      (bmrResult - totalcalories) >= 0
                          ? Text(
                              "Balance BMR Calorie :${bmrResult - totalcalories}",
                              style: (TextStyle(color: Colors.green)),
                            )
                          : Text(
                              "Balance BMR Calorie :${bmrResult - totalcalories}",
                              style: (TextStyle(color: Colors.red)),
                            ),
                      Text(
                          "Date :${DateFormat('dd-MM-yyyy').format(DateTime.now())}"),
                      seleclistmeal.length > 0
                          ? DisplaySelectedMeal()
                          : Container(),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
