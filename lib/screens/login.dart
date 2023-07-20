import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:diet/utils/function.dart';
import 'package:diet/utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:diet/screens/root_app.dart';
import 'package:diet/screens/signup.dart';
import 'package:diet/theme/color.dart';

class Signin extends StatefulWidget {
  Signin({Key? key}) : super(key: key);
  //MenuOption(this.title,this.imageUrl,this.discount);

  @override
  _SigninState createState() => _SigninState();
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class _SigninState extends State<Signin> {
  bool _visible = true;
  var phonenoTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phonenoTextController.text = "";
    passwordTextController.text = "";
  }

  /*Start function biometric*/

  _submitlogin(paramemail, parampass) async {
    var data = {
      "action": "login",
      "UserEmail": paramemail,
      "UserPassword": parampass
    };
    var returnData = await dioHttpPostRequest(
        context, data, "login.php", 1, "Please wait..", "brewing data..");
    print("xxxdsdsdsxxx");
    print(returnData);
    print("xxxdsdsdsdxxx");
    Navigator.pop(context);

    if (returnData != "errorException") {
      if (returnData['status'] == true) {
        String UserName = returnData['UserName'].toString();
        String UserDatatype = returnData['UserDatatype'].toString();
        String UserID = returnData['UserID'].toString();
        print("oooooottttooooooo");
        print(UserName);

        await setlocalMemoryData("string", "UserDatatype", UserDatatype);
        await setlocalMemoryData("string", "UserName", UserName);
        await setlocalMemoryData("string", "UserID", UserID);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RootApp()));

        // screenLoadingx(context,"",returnData['mesejayat'].toString(),true,true,false);
        //Navigator.of(context).pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);

        // _myorder();

/*
        Map<String, dynamic> map = returnData;
        List<dynamic> data = map["data"];
        List<Jadual> Jaduals = [];
        for (int i = 0; i < returnData['count_result']; i++) {
          Jadual user = Jadual(data[i]['codecategori'],data[i]['categoryname']);

          Jaduals.add(user);
        }

        return Jaduals;*/
      } else {
        screenLoadingx(
            context, "", returnData['msgtxt'].toString(), true, true, false);
        /*if(returnData['count_result']=="0"){
          setState(() {
            statusrekod="false";
          });

        }else{

          Navigator.of(context).pushNamedAndRemoveUntil('/Menu', (Route<dynamic> route) => false);
          screenLoadingx(context,"",returnData['mesejayat'].toString(),true,true,false);

        }*/
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, //appBgColor,//const Color(0xffeeeee4),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white, // appBgColor,//Color(0xffeeeee4),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0), topRight: Radius.circular(0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.09),
                  child: Image.asset("assets/newlogo.png"),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffeeeee4), //Colors.white,
                      border: Border.all(width: 1, color: Colors.white),

                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                        controller: phonenoTextController,
                        cursorColor: cofeehight,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          icon: Icon(
                            Icons.mail,
                            color: cofeehight,
                          ),
                          hintText: "Username",
                          labelText: "Username",
                          focusColor: cofeehight,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          filled: false,
                          border: InputBorder.none,
                          //border: OutlineInputBorder(),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Color(0xffeeeee4), //Colors.white,
                    border: Border.all(width: 1, color: Colors.white),

                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      controller: passwordTextController,
                      cursorColor: cofeehight,
                      style: const TextStyle(color: Colors.black),
                      obscureText: _visible,
                      decoration: InputDecoration(
                          labelStyle: const TextStyle(color: Colors.black),
                          isCollapsed: false,
                          hintText: "At least 8 Charecter",
                          labelText: "Password",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          filled: false,
                          border: InputBorder.none,
                          icon: const Icon(Icons.lock, color: cofeehight),
                          suffixIcon: IconButton(
                              color: cofeehight,
                              padding: const EdgeInsets.all(0),
                              icon: Icon(_visible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _visible = !_visible;
                                });
                              })),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    child: Row(children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              _submitlogin(phonenoTextController.text,
                                  passwordTextController.text);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              //height: 200,//MediaQuery.of(context).size.height * 0.07,
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              decoration: const BoxDecoration(
                                color: mainC,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              /*decoration: BoxDecoration(
                                            color: Color(0xFFFFCB3F),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),*/
                              child: const Center(
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: cofeehight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /*  Container(
                            //width: MediaQuery.of(context).size.width * 0.2,
                            //height: double.infinity,
                            //width: double.infinity,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: cofeelow,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
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
                            */ /*child: InkWell(
                                onTap: () {

                                },*/ /*
                            child: IconButton(
                                icon: const Icon(Icons.fingerprint),
                                color: Colors.white,
                                iconSize: 35.0,
                                onPressed: () {
                                  print("zzzzz");
                                  _authenticateWithBiometrics("0123232333");
                                }
                            ),
                            // ),
                          ),*/
                    ])),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                          text: "Don't Have an account? ",
                          style: TextStyle(
                              color: cofeehight.withOpacity(0.8), fontSize: 16),
                          children: [
                            TextSpan(
                                text: "Sign Up",
                                style: const TextStyle(
                                    color: cofeehight,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()));
                                    /* Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp())

                                    );*/
                                    print("Sign Up click");
                                  }),
                          ]),
                    ),
                  ],
                ),

                /* Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 30),
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (_supportState == _SupportState.unknown)
                            const CircularProgressIndicator()
                          else if (_supportState == _SupportState.supported)
                            const Text('This device is supported')
                          else
                            const Text('This device is not supported'),
                          const Divider(height: 100),
                          Text('Can check biometrics: $_canCheckBiometrics\n'),
                          ElevatedButton(
                            child: const Text('Check biometrics'),
                            onPressed: _checkBiometrics,
                          ),
                          const Divider(height: 100),
                          Text('Available biometrics: $_availableBiometrics\n'),
                          ElevatedButton(
                            child: const Text('Get available biometrics'),
                            onPressed: _getAvailableBiometrics,
                          ),
                          const Divider(height: 100),
                          Text('Current State: $_authorized\n'),
                          if (_isAuthenticating)
                            ElevatedButton(
                              onPressed: _cancelAuthentication,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  Text('Cancel Authentication'),
                                  Icon(Icons.cancel),
                                ],
                              ),
                            )
                          else
                            Column(
                              children: <Widget>[
                                ElevatedButton(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Text('Authenticate'),
                                      Icon(Icons.perm_device_information),
                                    ],
                                  ),
                                  onPressed: _authenticate,
                                ),
                                ElevatedButton(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(_isAuthenticating
                                            ? 'Cancel'
                                            : 'Authenticate: biometrics only'),
                                        const Icon(Icons.fingerprint),
                                      ],
                                    ),
                                    onPressed:(){
                                      _authenticateWithBiometrics("232332122");
                                    }
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckerBox extends StatefulWidget {
  const CheckerBox({
    required Key key,
  }) : super(key: key);

  @override
  State<CheckerBox> createState() => _CheckerBoxState();
}

class _CheckerBoxState extends State<CheckerBox> {
  late bool isCheck;
  @override
  void initState() {
    // TODO: implement initState
    isCheck = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              value: isCheck,
              checkColor: whiteshade, // color of tick Mark
              activeColor: cofeehight,
              onChanged: (val) {
                setState(() {
                  isCheck = val!;
                  print(isCheck);
                });
              }),
          Text.rich(
            TextSpan(
              text: "Remember me",
              style:
                  TextStyle(color: cofeehight.withOpacity(0.8), fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
