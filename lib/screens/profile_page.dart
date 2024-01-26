import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_management/bloc/user_cubit.dart';

import '../models/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _key =  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BlocConsumer<UserCubit,User>(builder: (BuildContext context, state) {
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 70),
                        Text("User Profile", style: TextStyle(
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
                                enabled: false,
                              controller: TextEditingController(text: state.firstName),
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  labelText: 'First Name',
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: "First Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),)
                              ),
                              // onChanged: (val) => setState(() => firstName = val),
                            )
                        ),
                        SizedBox(height: 30),
                        Container(
                            width: 400,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(64, 75, 96, .9),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              enabled: false,
                              controller: TextEditingController(text: state.lastName),
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: "Last Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),)
                              ),
                              // onChanged: (val) => setState(() => lastName = val),
                            )
                        ),
                        SizedBox(height: 30),
                        Container(
                            width: 400,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(64, 75, 96, .9),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              enabled: false,
                              controller: TextEditingController(text: state.phone),
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  labelText: 'Phone',
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: "Phone",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),)
                              ),
                              // onChanged: (val) => setState(() => phone = val),
                            )
                        ),
                        SizedBox(height: 30),
                        Container(
                            width: 400,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(64, 75, 96, .9),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              enabled: false,
                              controller: TextEditingController(text: state.email),
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),)
                              ),
                              // onChanged: (val) => setState(() => email = val),
                            )
                        ),

                      ],
                    )
                )
            ),
          );
        }, listener: (BuildContext context, Object? state) {  },

          )
      ),
    );
  }
}
