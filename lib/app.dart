import 'package:card/sugar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardApp extends StatefulWidget {
  const CardApp({super.key});

  @override
  State<CardApp> createState() => _CardAppState();
}

class _CardAppState extends State<CardApp> {
  @override
  void initState() {
    tempContext = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: "Generic App",
      );
}
