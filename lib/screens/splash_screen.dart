import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_management/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/user_cubit.dart';
import '../models/user.dart';
import 'login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // isLogin();
  }

  Future<bool> isLogin()async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.getString('token')  != null){
        return true;
    }else{
      return false;

    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:
      BlocConsumer<UserCubit,User>(builder: (BuildContext context, state) {
        print(state);
        if(!state.success){
          return Login();
        }else{
          return HomePage();
        }
      }, listener: (BuildContext context, Object? state) {
          print(state);
      },

      )

      // Image(
      //     height: double.infinity,
      //     fit: BoxFit.fitHeight,
      //     image: NetworkImage(
      //         "https://images.unsplash.com/photo-1557682268-e3955ed5d83f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=282&q=80")),
    );
  }
}