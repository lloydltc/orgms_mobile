import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_management/bloc/contibution_cubit.dart';
import 'package:organisation_management/bloc/user_cubit.dart';
import 'package:organisation_management/core/auth_api.dart';
import 'package:organisation_management/core/contribution_api.dart';
import 'package:organisation_management/models/contribution.dart';
import 'package:organisation_management/models/user.dart';
import 'package:organisation_management/main.dart';
import 'package:organisation_management/screens/home.dart';
import 'package:organisation_management/screens/registration.dart';

import '../core/prefs.dart';

class MakeContributionPage extends StatefulWidget {

  @override
  _MakeContributionPageState createState() => _MakeContributionPageState();
}

class _MakeContributionPageState extends State<MakeContributionPage> {
  ContributionAPI _contributionAPI = ContributionAPI();
  final _key =  GlobalKey<FormState>();
   String description="";
   double amount=0;

  get user => null;
  @override
  Widget build(BuildContext context) {

    return Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(58, 66, 86, 1.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 70),
                    Text("Make Contribution", style: TextStyle(),),
                    SizedBox(height: 30),
                    Container(
                        width: 400,
                        child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  labelText: 'First Name',
                                  hintStyle: TextStyle(color: Colors.white),
                              hintText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),)
                          ),
                          onChanged: (val) => setState(() => description = val),
                          onSaved: (val){
                            setState(() {
                              description=val!;
                            });
                          },
                        )
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(64, 75, 96, .9),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              labelText: 'First Name',
                              hintStyle: TextStyle(color: Colors.white),
                            hintText: "Amount",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),)
                        ),
                        onChanged: (val) => setState(() => amount = double.tryParse(val)!),
                        onSaved: (val){
                          setState(() {
                            amount=double.tryParse(val!)!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 25),

                    Container(
                        width: 400,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9),
                            borderRadius: BorderRadius.circular(10)),
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
                                _key.currentState!.save();
                                var req = await
                                _contributionAPI.contribute(description,  amount);
                                if(req.statusCode == 200){
                                  // print(req.body);
                                  // var body = jsonDecode(source)
                                  // var contribution =
                                  // Contribution.fromJson(req.body as Map<dynamic,dynamic>);
                                  // BlocProvider.of<ContributionCubit>(context).contribute(contribution);
                                  // print(contribution.amount);
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
                          "Contribute",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        )
                    ),
                    SizedBox(height: 25),

                  ],
                )
            )

    );

  }

}