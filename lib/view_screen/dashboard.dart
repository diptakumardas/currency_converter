import 'package:currency_converter/view_screen/home_page.dart';
import 'package:flutter/material.dart';

import 'exchange_page.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedindex = 0;
  Widget getView() {
    if (_selectedindex == 0) {
      return HomePage();
    }
    return ExchangePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _selectedindex = index;
            });
          },
          currentIndex: _selectedindex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.currency_exchange), label: 'exchange')
          ]),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(

          'assets/images/appbar.png',
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
        ),
      ),
      body: getView(),
    );
  }
}
