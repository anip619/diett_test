import 'package:flutter/material.dart';
import 'package:diet/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diet/screens/login.dart';
import 'package:diet/utils/colors.dart';
import 'package:diet/utils/function.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  var namaTextController =  TextEditingController();
  var emailTextController =  TextEditingController();
  var usernameTextController =  TextEditingController();
  var passwordTextController =  TextEditingController();
  var UserID;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  getlocalMemoryData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserID =  prefs.getString("UserID");
    });

    _getData(UserID);
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getlocalMemoryData();

  }


  _submitkemaskini(nama,email,username,password) async {
    var data = {
      "action": "updateuser",
      "UserID":UserID,
      "Name":nama,
      "UserEmail":email,
      "UserName":username,
      "UserPassword":password
    };
    var returnData = await dioHttpPostRequest(context,data,"updateprofile.php",1,"Please wait..","brewing data..");
    print(returnData);
    Navigator.pop(context);

    if(returnData!="errorException"){

      if(returnData['status']==true){

        //Navigator.pop(context);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Signin())

        );
        screenLoadingx(context,"",returnData['mesejayat'].toString(),true,true,false);

      }else{
        screenLoadingx(context,"",returnData['mesejayat'].toString(),true,true,false);



      }


    }



  }




  _getData(paramuserID) async {
    var data = {
      "action": "datauser",
      "UserID":paramuserID
    };
    var returnData = await dioHttpPostRequest(context,data,"userdetail.php",1,"Please wait..","brewing data..");
    print("xxxdsdsdsxxx");
    print(returnData);
    print("xxxdsdsdsdxxx");
    Navigator.pop(context);

    if(returnData!="errorException"){

      if(returnData['status']==true){
        setState(() {
           namaTextController.text =  returnData['Name'].toString();
           emailTextController.text  =  returnData['UserEmail'].toString();
           usernameTextController.text  =  returnData['UserName'].toString();
           passwordTextController.text  =  returnData['UserPassword'].toString();
        });



      }else{
        screenLoadingx(context,"",returnData['msgtxt'].toString(),true,true,false);


      }


    }



  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
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

                Text("Profile Detail", style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 18,)),

              ],
            )
            ),

            /* NotificationBox(
              notifiedNumber: 0,
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ) ,*/
           /* SizedBox(width: 15,),
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
            ),*/

          ],
        ),
      );
  }

  buildBody(){
    return
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0,bottom: 10),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/profile.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: namaTextController ,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama',
                    hintText: 'Nama'),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailTextController ,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter'),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: usernameTextController ,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Username'),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordTextController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: mainC, borderRadius: BorderRadius.circular(20)),
              child: MaterialButton(
                onPressed: () {

                  _submitkemaskini(namaTextController.text,emailTextController.text,usernameTextController.text,passwordTextController.text);
                  /* Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyHomePage()));*/
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
           /* InkWell(
              onTap: (){

              },
              child: Text('Sudah mempunyai akaun? log masuk'),
            ),*/


          ],
        ),
      );
  }



}