import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registration_getx/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_endpoints.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
 TextEditingController passwordController = TextEditingController();

 final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


 Future<void> loginUser() async{
   try{
    final dio = Dio();
    const url = ApiEndPoints.baseUrl+ApiEndPoints.loginUrl;
    var headers = {'Content-Type': 'application/json'};
    Map<String,dynamic> body = {
      'email' : emailController.text.trim(),
      'password' : passwordController.text
    };
    final response = await dio.post(url,data:body,options: Options(headers: headers));
    if(response.statusCode == 200){
      var token = response.data['authorization']['token'];
      log('Token:$token');
      final SharedPreferences preferences = await _prefs;
      await preferences.setString('token', token);
      emailController.clear();
      passwordController.clear();
      Get.offAll(const HomeScreen());

    }else{
      log('Unknown Occurred');
    }
  }catch(e){
    log(e.toString());
  }
 }
}