// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../resources/strings_manger.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.settings),
    );
  }
}
