// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../resources/strings_manger.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.notifications),
    );
  }
}
