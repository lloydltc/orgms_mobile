import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_management/bloc/user_cubit.dart';
import 'package:organisation_management/core/auth_api.dart';
import 'package:organisation_management/models/user.dart';
import 'package:organisation_management/main.dart';
import 'package:organisation_management/screens/home.dart';
import 'package:organisation_management/screens/registration.dart';

import '../core/prefs.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthAPI _authAPI = AuthAPI();
  final _key =  GlobalKey<FormState>();
  String title= 'ORGMS';
   String email='';
   String password='';

  get user => null;

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      centerTitle: true,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(title),
    );

    return Scaffold(
      appBar: topAppBar,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),

        body: SingleChildScrollView(
         child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 70),
                      Text("Login", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                      ),),
                      SizedBox(height: 30),
                      Container(
                          width: 400,

                          decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.white),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),)

                            ),
                            onChanged: (val) => setState(() => email = val),
                          )
                      ),
                      SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9),
                            borderRadius: BorderRadius.circular(10)),
                        width: 400,
                        child: TextFormField(
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              labelText: 'Password',
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "Password",

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),)
                          ),
                          onChanged: (val) => setState(() => password = val),
                        ),
                      ),
                      SizedBox(height: 25),

                      Container(
                          width: 400,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20), // button's shape
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),

                              onPrimary: Colors.white, // text color
                              elevation: 1, // button's elevation when it's pressed
                            ),
                            onPressed: () async {
                              if(_key.currentState!.validate()){
                                try{
                                  var req = await
                                  _authAPI.login(email,  password);
                                  if(req.statusCode == 200){
                                    // print(req.body);
                                    var user =
                                    User.fromReqBody(req.body);
                                    context.read<UserCubit>().login(user);
                                    print(user.firstName);
                                    // customer.printAttributes();
                                    upDateSharedPreferences(user.token, user.id);
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => HomePage()));
                                  } else {
                                    print(req.statusCode);
                                  }
                                } on Exception catch (e){
                                  print(e.toString());

                                }
                              }
                            }, child:  const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          )
                      ),
                      SizedBox(height: 25),
                      GestureDetector(
                        child: Text("Don't have Account", style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            decoration: TextDecoration.underline
                        ),),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Registration()));
                        },
                      ),
                      SizedBox(height: 25),
                    ],
                  )
              )
          ),
        )

      );
  }

}