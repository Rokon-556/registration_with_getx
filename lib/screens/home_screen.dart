import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:registration_getx/screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                final SharedPreferences? preferences = await _prefs;
                preferences?.clear();
                Get.offAll(const AuthScreen());
              },
              child: const Text(
                'logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Center(child: Column(children: [
        Text("Welcome to home",style: TextStyle(fontSize: 20),),
        TextButton(onPressed: ()async{
          final SharedPreferences? preferences = await _prefs;
          log('${preferences?.get('token')}');
        }, child: Text('Print Token'))
      ],)),
    );
  }
}
