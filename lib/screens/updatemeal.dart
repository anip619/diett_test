import 'package:flutter/material.dart';
import 'package:diet/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diet/screens/login.dart';
import 'package:diet/utils/colors.dart';
import 'package:diet/utils/function.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:diet/utils/url_source.dart';


class UpdateMealPage extends StatefulWidget {
  var mealID;

   UpdateMealPage({super.key, this.mealID});

  @override
  _UpdateMealPageState createState() => _UpdateMealPageState();
}

class _UpdateMealPageState extends State<UpdateMealPage> {

  var titleTextController =  TextEditingController();
  var categoryTextController =  TextEditingController();
  var descriptionTextController =  TextEditingController();
  var foodcaloriesTextController =  TextEditingController();
  var UserID;
  var imgold="https://www.shutterstock.com/image-vector/no-data-vector-outline-icon-260nw-2082722071.jpg";
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker imgpicker = ImagePicker();
  late List<XFile> imagefiles;
  //XFile imagecamera;
  XFile? imageupload;//= null;//XFile('');
  late String? selectedOption='Breakfast';
  List<String> options = ['Breakfast', 'Lunch', 'Hi-tea','Dinner'];

  _getData(mealID) async {
    var data = {
      "action": "datauser",
      "mealID":mealID
    };
    var returnData = await dioHttpPostRequest(context,data,"listmeal2.php",1,"Please wait..","brewing data..");
    print("here we go");
    print(returnData);
    print("xxxdsdsdsdxxx");
    Navigator.pop(context);

    if(returnData!="errorException"){

      if(returnData['status']==true){
        print("oooppoppp");
        setState(() {
           titleTextController.text =  returnData['data'][0]['mealTitle'].toString();
           selectedOption=returnData['data'][0]['CategoryID'];
           imgold="${mainUrl}upload/."+returnData['data'][0]['pictureCode'];
           descriptionTextController.text  =  returnData['data'][0]['Description'].toString();
           foodcaloriesTextController.text  = returnData['data'][0]['foodCalorie'].toString();
           print("00000090000000");
           print(imgold);
        });



      }else{
        screenLoadingx(context,"",returnData['msgtxt'].toString(),true,true,false);


      }


    }



  }


  Widget multipleSelectImage(){
    return  SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            //open button ----------------
            /*  ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                onPressed: (){
                  openImages();
                },
                child: Text("Select Images")
            ),

            Divider(),
            Text("Picked Files:"),
            Divider(),*/

            imagefiles != null?Wrap(
              children: imagefiles.map((imageone){
                return Container(
                    child:Card(
                      child: Container(
                        height: 100, width:100,
                        child: Image.file(File(imageone.path)),
                      ),
                    )
                );
              }).toList(),
            ):Container()
          ],
        ),
      ),
    );

  }

  openImages1(type) async {
    var pickedfiles1;
    try {
      print("0000000000");
      print(type);
      if(type=="camera"){
        pickedfiles1 = await imgpicker.pickImage(source:ImageSource.camera);
        print(pickedfiles1);
      }else if(type=="gallery"){
        pickedfiles1 = await imgpicker.pickImage(source:ImageSource.gallery);
      }
      //you can use ImageCourse.camera for Camera capture
      if(pickedfiles1 != null){

        setState(() {
          imageupload = pickedfiles1;
        });
      }else{
        print("No image is selected.");
      }
    }catch (e) {
      print("error while picking file.");
    }
  }

  Widget cameraSelectImage(){
    return  SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            imageupload != null?Wrap(
                children:[
                  Container(
                    child: Card(
                      child: Container(
                        height: 100, width: 100,
                        child: Image.file(File(imageupload!.path)),
                      ),
                    ),
                  ),
                ]
            ):Container()
          ],
        ),
      ),
    );

  }

  Future bottomAttachment(){
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //SizedBox(height: 30,),
              ListTile(
                leading: new Icon(Icons.photo),
                title: new Text('Album'),
                onTap: () {
                  Navigator.pop(context);
                  openImages1("gallery");
                  //openImages();
                  // multipleSelectImage();
                },
              ),
              ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  openImages1("camera");
                  //cameraSelectImage();
                },
              ),
              SizedBox(height: 30,),
              /*ListTile(
                leading: new Icon(Icons.videocam),
                title: new Text('Video'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.share),
                title: new Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),*/
            ],
          );
        });
  }

  getlocalMemoryData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserID =  prefs.getString("UserID");
    });

    //_getData(UserID);
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getlocalMemoryData();
    _getData(widget.mealID);

  }

/*
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

*/


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

                Text("New Meal", style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 18,)),

              ],
            )
            ),

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
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: titleTextController ,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    hintText: 'Title'),
              ),
            ),
            SizedBox(height: 10,),
            Padding(

              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),

                child: DropdownButton<String?>(
                  isExpanded: true,
                  value: selectedOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue!;
                    });
                  },
                  items: options.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: foodcaloriesTextController ,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Food Calories',
                    hintText: 'Food Calories'),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: descriptionTextController,
                minLines: 3,
                maxLines: 4,
                //obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    hintText: 'Description'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(

              margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
              padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
              // height: double.infinity,
              //width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),

              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Container(
                      margin:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(3, 4))
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          imageupload !=null? Wrap(
                              children:[
                                Container(
                                  child: Card(
                                    child: Container(
                                      height: 100, width: 100,
                                      child: Image.file(File(imageupload!.path)),
                                    ),
                                  ),
                                ),
                              ]
                          ):

                          Wrap(
                              children:[
                                Container(
                                  child: Card(
                                    child: Container(
                                      height: 100, width: 100,
                                      child:Image.network(
                                        imgold,
                                        fit: BoxFit.fill,
                                        loadingBuilder: (BuildContext context, Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          ),
                          InkWell(
                            onTap: (){

                              bottomAttachment();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(6.0),
                                        boxShadow: [BoxShadow(color: Colors.blueAccent)]),
                                    padding: EdgeInsets.all(24.0),
                                    child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      iconSize: 40.0,
                                      onPressed: () {  },
                                      /* onPressed: () {


                                                    },*/
                                    )
                                )


                              ],
                            ),
                          ),

                        ],
                      )
                  ),


                ],
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
                  if(imageupload==null){
                     uploadImageUpdate(context,"null",widget.mealID,titleTextController.text,selectedOption,foodcaloriesTextController.text,descriptionTextController.text,imageupload,UserID);

                  }else{
                     uploadImageUpdate(context,"value",widget.mealID,titleTextController.text,selectedOption,foodcaloriesTextController.text,descriptionTextController.text,imageupload,UserID);

                  }
                  //print(imageupload);

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