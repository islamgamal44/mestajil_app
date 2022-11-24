// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../presentation/resources/routes_manger.dart';
import '../presentation/resources/theme_manger.dart';

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key); //default constructor

  MyApp._internal(); //named constructor

  int appState = 0;

  static final MyApp _instance =
      MyApp._internal(); //singleton or single instance

  factory MyApp() => _instance; // factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splachRoute,
      theme: getAppTheme(),
    );
  }
}

// class Test extends StatelessWidget {
//   const Test({Key? key}) : super(key: key);
//
//   void updateAppState()
//   {
//     MyApp().appState = 11 ;
//   }
//   void getAppState()
//   {
//     print( MyApp().appState);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class Person
// {
//   late final String name;
//   late final int age;
//
//   Person(this.name ,this.age); //default constructor
//
//  Person.fromJson(Map< String ,dynamic> json) //named constructor
//  {
//    this.name = json['name'];
//    this.age = json['age'];
//  }
//
// }
