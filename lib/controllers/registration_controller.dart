import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registration_getx/api_endpoints.dart';

import '../screens/home_screen.dart';

class RegistrationController extends GetxController{
 TextEditingController nameController = TextEditingController();
 TextEditingController emailController = TextEditingController();
 TextEditingController passwordController = TextEditingController();



 Future<void> registerUser()async {
  try{
    final dio = Dio();
    const url = ApiEndPoints.baseUrl+ApiEndPoints.registrationUrl;
    var headers = {'Content-Type': 'application/json'};
    Map<String,dynamic> body = {
      'name' : nameController.text,
      'email' : emailController.text.trim(),
      'password' : passwordController.text
    };
    final response = await dio.post(url,data:body,options: Options(headers: headers));
    if(response.statusCode == 200){
      // final jsonData = jsonDecode(response.data);
      log('${response.data['message']}');
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          Get.offAll(const HomeScreen());

    }else{
      log('Already Registered');
    }
  }catch(e){
    log(e.toString());
  }
 }


}