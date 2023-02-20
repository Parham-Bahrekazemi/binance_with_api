import 'package:binance/ui/home_page.dart';
import 'package:binance/ui/market_view_page.dart';
import 'package:binance/ui/profile_page.dart';
import 'package:binance/ui/ui_helper/bottom_nav.dart';
import 'package:binance/ui/watch_list_page.dart';
import 'package:flutter/material.dart';

class MainRapper extends StatefulWidget {
  const MainRapper({super.key});

  @override
  State<MainRapper> createState() => _MainRapperState();
}

class _MainRapperState extends State<MainRapper> {
  final PageController myPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Color primaryColorLight = Theme.of(context).primaryColorLight;
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(
        controller: myPage,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {},
        child: Icon(
          Icons.compare_arrows_outlined,
          color:
              primaryColorLight == Colors.white ? Colors.white : Colors.black,
        ),
      ),
      body: PageView(
        controller: myPage,
        children: const <Widget>[
          HomePage(),
          MarketViewPage(),
          ProfilePage(),
          WatchListPage(),
        ],
      ),
    );
  }
}
