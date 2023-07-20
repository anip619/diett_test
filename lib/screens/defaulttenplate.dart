import 'package:flutter/material.dart';
import 'package:diet/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diet/screens/root_app.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  var username;
  var user_type;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  getlocalMemoryData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username =  prefs.getString("username");
      user_type =  prefs.getString("user_type");
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getlocalMemoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
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

                Text('$username', style: TextStyle(color: labelColor, fontSize: 14,),),
                SizedBox(height: 5,),
                Text("Profile", style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 18,)),

              ],
            )
            ),

            /* NotificationBox(
              notifiedNumber: 0,
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ) ,*/
            SizedBox(width: 15,),
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

  buildBody(){
    return
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text("Profile widget here")
              ]
          ),
        ),
      );
  }



}