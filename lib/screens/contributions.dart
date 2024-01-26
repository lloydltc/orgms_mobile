import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_management/models/contribution.dart';
import 'package:organisation_management/screens/login.dart';
import 'package:organisation_management/screens/make_contribution.dart';
import 'package:organisation_management/screens/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/user_cubit.dart';
import '../core/contribution_api.dart';
import '../models/user.dart';

class ContributionsPage extends StatefulWidget {
  ContributionsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ContributionsPageState createState() => _ContributionsPageState();
}

class _ContributionsPageState extends State<ContributionsPage> {

  int currentPage=0;
  Future<List<Contribution>> contributions = getList();


  static Future<List<Contribution>> getList() async {
    ContributionAPI _contributionAPI = ContributionAPI();
    SharedPreferences _prefs = await  SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var id = _prefs.getInt('id');
    Future<List<Contribution>> contributions = _contributionAPI.getContributions(id! ,token!) ;
    return contributions;
  }
  @override
  void initState() {
    super.initState();
  }


  ListTile makeListTile(Contribution contribution) => ListTile(
    contentPadding:
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Text( contribution.amount!.toString()),
    ),
    title: Text(
      contribution.description!,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

    subtitle: Row(
      children: <Widget>[
        // Expanded(
        //     flex: 1,
        //     child: Container(
        //       // tag: 'hero',
        //       child: LinearProgressIndicator(
        //           backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
        //           value: 0.5,
        //           valueColor: AlwaysStoppedAnimation(Colors.green)),
        //     )),
        Expanded(
          flex: 4,
          child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(contribution.status!,
                  style: TextStyle(color: Colors.white))),
        )
      ],
    ),
    trailing:
    Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
    onTap: () {
      /// TODO: go to contribution and show status and edit
      // showModalBottomSheet(context: context, builder: builder)
    },
  );

  makeBody(List<Contribution> constList) => Container(
    // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),

    child:
    ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: constList.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(constList[index]);
      },
    ),
  );

  Card makeCard(Contribution contribution) => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: makeListTile(contribution),
    ),
  );

   makeBottom ()=> Container(
    height: 55.0,
    child: BottomAppBar(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              setState(() {
                currentPage=0;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.account_box, color: Colors.white),
            onPressed: () {
              setState(() {
                currentPage=1;
              });
            },
          )
        ],
      ),
    ),
  );

 makeHome(int currentPage){
   return [
     FutureBuilder<List<Contribution>>(
       future: contributions,
       builder: (context, snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
           // until data is fetched, show loader
           return const CircularProgressIndicator();
         } else if (snapshot.hasData) {
           // once data is fetched, display it on screen (call buildPosts())
           final constList = snapshot.data!;
           return makeBody(constList);
         } else {
           // if no data, show simple Text
           return const Text("No data available");
         }
       },
     ),
     ProfilePage()
   ][currentPage];
 }

  void handleClick(int item) {
    switch (item) {
      case 0:
        logout();
            break;
      case 1:
        break;
    }
  }
void logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('id');
    _prefs.remove('token');
    context.read<UserCubit>().login(User(email: '',firstName: "",lastName: "",id: 0, success: false,phone: "",token: ""));
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Login()));

}
    @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(widget.title),
      actions: <Widget>[
        PopupMenuButton<int>(
          onSelected: (item) => handleClick(item),
          itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0, child: Text('Logout')),
            PopupMenuItem<int>(value: 1, child: Text('Settings')),
          ],
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeHome(currentPage),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context){
            return Padding(
              padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: MakeContributionPage(),
            );
          });
        },
      ),
      bottomNavigationBar: makeBottom(),
    );
  }
}

