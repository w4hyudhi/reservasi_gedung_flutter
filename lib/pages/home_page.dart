import 'package:diet_penyakit/pages/map_page.dart';
import 'package:diet_penyakit/pages/setting_page.dart';
import 'package:diet_penyakit/pages/transaksi_page.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'menu_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    // setState(() {
    //   _page = index;
    // });
    _pageController.animateToPage(index,
        curve: Curves.easeIn, duration: Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,

        // brightness: Brightness.light,
      ),
      bottomNavigationBar: BottomBarBubble(
        items: [
          BottomBarItem(
            iconData: Icons.business,
            label: 'GEDUNG',
          ),
          BottomBarItem(
            iconData: Icons.map,
            label: 'PETA',
          ),
          // BottomBarItem(
          //   iconData: Icons.chat,
          //   label: 'Chat',
          // ),
          // BottomBarItem(
          //   iconData: Icons.notifications,
          //   // label: 'Notification',
          // ),
          BottomBarItem(
            iconData: Icons.receipt,
            label: 'History',
          ),
          BottomBarItem(
            iconData: Icons.settings,
            label: 'Setting',
          ),
        ],
        onSelect: (index) {
          // setState(() {
          onTabTapped(index);
          // });
        },
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          MenuPage(),
          MapPage(),
          TransaksiPage(),
          SettingPage(),
        ],
      ),
    );
  }
}
