import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_management/screens/login.dart';

import '../bloc/user_cubit.dart';
import '../core/auth_api.dart';
import '../core/prefs.dart';
import '../models/user.dart';
import 'home.dart';

class Registration extends StatefulWidget {

  @override
  _RegistrationState createState() => _RegistrationState();
}
class _RegistrationState extends State<Registration> {
  AuthAPI _authAPI = AuthAPI();
  final _key =  GlobalKey<FormState>();
  late String email;
  late String password;
  late String firstName;
  late String lastName;
  late String phone;
  get user => null;
  String title = "ORGSM";
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
                      Text("Register", style: TextStyle(
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
                                labelText: 'First Name',
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: "First Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),)
                            ),
                            onChanged: (val) => setState(() => firstName = val),
                          )
                      ),
                      SizedBox(height: 30),
                      Container(
                          width: 400,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Last Name',
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: "Last Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),)
                            ),
                            onChanged: (val) => setState(() => lastName = val),
                          )
                      ),
                      SizedBox(height: 30),
                      Container(
                          width: 400,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Phone',
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: "Phone",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),)
                            ),
                            onChanged: (val) => setState(() => phone = val),
                          )
                      ),
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
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),)
                            ),
                            onChanged: (val) => setState(() => email = val),
                          )
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9),
                            borderRadius: BorderRadius.circular(10)),
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
                                  _authAPI.register(firstName,lastName,email,phone,  password);
                                  if(req.statusCode == 200){
                                    // print(req.body);
                                    var user =
                                    User.fromReqBody(req.body);
                                    context.read<UserCubit>().register(user);
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
                            "Register",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          )

                      ),
                      SizedBox(height: 25),
                      GestureDetector(
                        child: Text("Already have Account", style: TextStyle(
                          color: Colors.white,
                            fontSize: 18.0,
                            decoration: TextDecoration.underline
                        ),),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Login()));
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