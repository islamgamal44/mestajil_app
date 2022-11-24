// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mmuussttaaeejjiill/layers/presentation/main/pages/home/view/home_page.dart';
import 'package:mmuussttaaeejjiill/layers/presentation/main/pages/notifications/notifications_page.dart';
import 'package:mmuussttaaeejjiill/layers/presentation/main/pages/search/search_page.dart';
import 'package:mmuussttaaeejjiill/layers/presentation/main/pages/settings/settings_page.dart';

import '../resources/color_manger.dart';
import '../resources/strings_manger.dart';
import '../resources/values_manger.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingsPage(),
  ];

  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];
  var _title = AppStrings.home;
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManger.white,
        title: Text(
          _title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManger.lightGray, spreadRadius: AppSize.s0_5)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManger.primary,
          unselectedItemColor: ColorManger.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: AppStrings.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined), label: AppStrings.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active_outlined),
                label: AppStrings.notifications),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: AppStrings.settings),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
