import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_management/screens/login.dart';
import 'package:organisation_management/screens/registration.dart';
import 'package:organisation_management/bloc/user_cubit.dart';
import 'package:organisation_management/models/user.dart';
import 'package:organisation_management/screens/home.dart';
import 'package:organisation_management/screens/splash_screen.dart';

void main() {
  runApp( App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers:  [
        BlocProvider<UserCubit>(
            create: (BuildContext context) => UserCubit(User(email: '',firstName: "",lastName: "",id: 0, success: false,phone: "",token: ""))
        ),
      ],
      child: MaterialApp(
        title: 'ORGMS',
        theme: ThemeData(
        primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBarTheme: AppBarTheme(elevation: 0.1),
      ),
      home: SplashScreen(),
        debugShowCheckedModeBanner: false,
    ),
    );
  }
}
