import 'package:flutter/material.dart';
import 'package:demo_flutter/map.dart';
import 'package:demo_flutter/firebase.dart';
import 'package:demo_flutter/rabbit.dart';

void main() => runApp(Aplication());


class Aplication extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
//      home: MapsSample(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  final String title = 'Demo app Flutter';
  int _selectDrawerItem = 0;
  _getDrawerItemWidget (int pos){
    switch(pos){
      case 0: return MapsSample();
      case 1: return firebaseState();
      case 2: return rabbitState();
    }
  }
  _onSelectItem(int pos) {
    setState(() {
      _selectDrawerItem = pos;
    });
  }

//  HomeState({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _getDrawerItemWidget(_selectDrawerItem),
      drawer: Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("xyz"),
              accountEmail: Text("xyz@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("xyz"),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text("abc"),
                )
              ],
            ),
            ListTile(
              title: new Text("Places"),
              leading: new Icon(Icons.flight),
            ),
            Divider(),
            ListTile(
              onTap: (){
                Navigator.of(context).pop();
              _onSelectItem(0);
              },
              title: new Text("Mapa"),
              trailing: new Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pop();
                _onSelectItem(1);
              },
              title: new Text("Firebase"),
              trailing: new Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pop();
                _onSelectItem(2);
              },
              title: new Text("Rabbit"),
              trailing: new Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}



