// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'layers/app/app.dart';
import 'layers/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
