import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_management/bloc/contibution_cubit.dart';
import 'package:organisation_management/models/contribution.dart';
import 'package:organisation_management/screens/login.dart';
import 'package:organisation_management/bloc/user_cubit.dart';
import 'package:organisation_management/core/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/auth.dart';
import '../core/prefs.dart';
import '../models/user.dart';
import 'contributions.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthAPI _authAPI = AuthAPI();
    return BlocBuilder<UserCubit, User>(
        buildWhen: (previous, current) => previous != current,
        builder: (BuildContext context, User state){
          checkPrefsForUser() async {
            SharedPreferences _prefs = await          SharedPreferences.getInstance();
            var _sharedToken = _prefs.getString('token');
            var _sharedId = _prefs.getInt('id');
            if(_sharedToken != null && _sharedId != null){
              try{
                var req = await _authAPI.getUser(_sharedId, _sharedToken);
                if(req.statusCode == 202){
                  var user = User.fromReqBody(req.body);
                  BlocProvider.of<UserCubit>(context).login(user);

                }
              }on Exception catch (e){}
            }
          }
          if(state == null){
            checkPrefsForUser();
          }
          return MultiBlocProvider(
            providers:  [
              BlocProvider<ContributionCubit>(
                  create: (BuildContext context) => ContributionCubit(Contribution())
              ),
            ],
            child: MaterialApp(
              title: 'ORGMS',
              theme: ThemeData(
                primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
                appBarTheme: AppBarTheme(elevation: 0.1),
              ),
              home: ContributionsPage(title: 'Contributions',),
              debugShowCheckedModeBanner: false,
            ),
          );
    });
  }
}
