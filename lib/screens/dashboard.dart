import 'package:flutter/material.dart';
import 'package:tentwenty_techinical_assessment/screens/medialibrary.dart';
import 'package:tentwenty_techinical_assessment/screens/upcoming.dart';

import 'more.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int selectedIndex = 0;


  List<Widget> widgets = [
    Dashboard(),
    UpcomingMovies(),
    MediaLibrary(),
    More(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:(selectedIndex==0)?const Center(
        child: Text("Dashboard"),
      ):widgets[selectedIndex],
      bottomNavigationBar: bottomNavigation(),
    );
  }
  Widget bottomNavigation(){
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
        topRight: Radius.circular(25)),
      ),
      child: ClipRRect(
        child: BottomNavigationBar(
          elevation: 5,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/dashboard.png"),
                  // color: Color(0xFF3A5A98),
                ),
                label:'Dashboard'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/watch.png"),
                  // color: Color(0xFF3A5A98),
                ),
                label:'Watch'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/media.png"),
                  // color: Color(0xFF3A5A98),
                ),
                label:'Media Library'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/more.png"),
                  // color: Color(0xFF3A5A98),
                ), label: 'More'),
          ],
          currentIndex: selectedIndex,
          fixedColor: Colors.white,
          selectedFontSize: 14,
          unselectedFontSize: 10,
          unselectedItemColor: Colors.grey,
          onTap: (int indext) {
            setState(() {
              selectedIndex = indext;
            });
          },
        ),
      ),
    );
  }

}
