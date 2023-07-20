import 'package:flutter/material.dart';
import 'package:diet/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diet/utils/url_source.dart';
import 'package:diet/utils/function.dart';
import 'package:diet/screens/updatemeal.dart';

class ListMealPage extends StatefulWidget {
  const ListMealPage({ Key? key }) : super(key: key);

  @override
  _ListMealPageState createState() => _ListMealPageState();
}

class _ListMealPageState extends State<ListMealPage> {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  late List listmeal=[];
  var dataX=[];
  List<String> options = ['Breakfast', 'Lunch', 'Hi-tea','Dinner'];
  getlocalMemoryData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users

        results = dataX;


    } else {
      results = dataX
          .where((Key) =>
          Key["mealTitle"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      listmeal = results;
    });
  }


  _callListMeal() async {
    print("Click here");
    var data = {
      "action": "listmeal",
    };
    var returnData = await dioHttpPostRequest(context,data,"listmeal.php",1,"Please wait..","brewing data..");
    print("xxxyyyyxxx");
    print(returnData);
    print("xxxyyyyxxx");
    Navigator.pop(context);

    if(returnData!="errorException"){

      if(returnData['status']==true){
        print("Diatery Guidance");
        print(returnData);
        /*setState(() {

          listmeal=returnData['data'];
        });*/
        setState(() {
          dataX = returnData['data'];
          listmeal= dataX;
        });

      }else{
        screenLoadingx(context,"",returnData['msgtxt'].toString(),true,true,false);


      }


    }



  }


  _deleteListMeal(mealID) async {
    print("Click here");
    var data = {
      "mealID": mealID,
    };
    var returnData = await dioHttpPostRequest(context,data,"deletemeal.php",1,"Please wait..","brewing data..");
    print("xxxyyyyxxx");
    print(returnData);
    print("xxxyyyyxxx");
    Navigator.pop(context);

    if(returnData!="errorException"){

      if(returnData['status']==true){
        screenLoadingx(context,"",returnData['mesejayat'].toString(),true,true,false);


      }else{
        screenLoadingx(context,"",returnData['msgtxt'].toString(),true,true,false);


      }


    }



  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _callListMeal();
    //getlocalMemoryData();
  }

  DisplayList(){
    return
      SingleChildScrollView(
        child: ListView(
            padding: EdgeInsets.only(top: 10),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(listmeal.length,
                    (index){


                  return Container(
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
                          offset: Offset(1, 1), // changes position of shadow
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
                                mainUrl+"upload/"+"."+listmeal[index]['pictureCode'], // Replace with your network image URL
                                fit: BoxFit.cover, // Adjust the fit based on your requirements
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                child:
                                Container(
                                    child:
                                    Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                                child: Container(
                                                    child: Text(listmeal[index]['mealTitle'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                                                )
                                            ),
                                            SizedBox(width: 5),

                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.edit), // Replace with the desired icon
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => UpdateMealPage(mealID:listmeal[index]['mealID']),
                                                      ),
                                                    );
                                                    // Add your onPressed logic here
                                                    // This function will be called when the button is pressed
                                                    // You can perform actions or navigate to a different screen, for example
                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 15),
                                            IconButton(
                                              icon: Icon(Icons.delete), // Replace with the desired icon
                                              onPressed: () {
                                                print(listmeal[index]['mealID']);
                                                _deleteListMeal(listmeal[index]['mealID']);
                                                // Add your onPressed logic here
                                                // This function will be called when the button is pressed
                                                // You can perform actions or navigate to a different screen, for example
                                              },
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5,),

                                      ],
                                    )
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
            )
        ),
      );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: BackButton(
                  color: Colors.black
              ),
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,//appBarColor,
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
        )
    );
  }

  Widget getAppBar(){
    return
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 5,),
                Text("List Meal", style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 18,)),

              ],
            )
            ),

            /* NotificationBox(
              notifiedNumber: 0,
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ) ,*/
            Container(
              //padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appBarColor,
                border: Border.all(color: Colors.grey.withOpacity(.3)),
              ),
              child:  IconButton(
                color: Colors.green,
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListMealPage(),
                    ),
                  );

                  // handle the press
                },
              ),
            ),
            SizedBox(width: 15,),
          /*  Container(
              //padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appBarColor,
                border: Border.all(color: Colors.grey.withOpacity(.3)),
              ),
              child:  IconButton(
                color: Colors.green,
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListMealPage(),
                    ),
                  );

                  // handle the press
                },
              ),
            ),*/

          ],
        ),
      );
  }

  buildBody(){
    return Container(
      height: MediaQuery.of(context).size.height,
      child:  Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration:  InputDecoration(
                labelText: 'Search', suffixIcon: Icon(Icons.search,color: Colors.white,),
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder:OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.grey, width: 2.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child:DisplayList(),
            ),

          ],
        ),
      ),
    );

  }



}