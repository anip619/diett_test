
import 'package:flutter/material.dart';
import 'package:diet/screens/category.dart';
import 'package:diet/screens/profile.dart';
import 'package:diet/theme/color.dart';
import 'package:diet/utils/constant.dart';
import 'package:diet/widgets/bottombar_item.dart';
import 'mainhome.dart';

class RootApp extends StatefulWidget {
  const RootApp({ Key? key }) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp>  with TickerProviderStateMixin{
  int activeTab = 0;
  List barItems = [
    {
      "icon" : "assets/icons/home.svg",
      "active_icon" : "assets/icons/home.svg",
      "page" : MainHomePage(),
    },
    {
      "icon" : "assets/icons/bookmark.svg",
      "active_icon" : "assets/icons/bookmark.svg",
      "page" : CategoryPage(),//Container(),
    },
    {
      "icon" : "assets/icons/profile.svg",
      "active_icon" : "assets/icons/profile.svg",
      "page" : ProfilePage(),
    },
    /*{
      "icon" : "assets/icons/profile.svg",
      "active_icon" : "assets/icons/profile.svg",
      "page" : Signin(),
    },*/
  ];

//====== set animation=====
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: ANIMATED_BODY_MS),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
     _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  animatedPage(page){
    return FadeTransition(
      child: page,
      opacity: _animation
    );
  }

  void onPageChanged(int index) {
    _controller.reset();
    setState(() {
      activeTab = index;
    });
    _controller.forward();
  }

//====== end set animation=====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      bottomNavigationBar: getBottomBar(),
      body: getBarPage()
    );
  }

  Widget getBarPage(){
    return 
      IndexedStack(
        index: activeTab,
        children: 
          List.generate(barItems.length, 
            (index) => animatedPage(barItems[index]["page"])
          )
      );
  }

  Widget getBottomBar() {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bottomBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), 
          topRight: Radius.circular(25)
        ), 
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(1, 1)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15,),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(barItems.length, 
            (index) => BottomBarItem(barItems[index]["icon"], isActive: activeTab == index, activeColor: primary,
              onTap: (){
                onPageChanged(index);
              },
            )
          )
        )
      ),
    );
  }

}