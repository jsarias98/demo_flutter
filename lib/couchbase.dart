import 'package:flutter/material.dart';
//import 'package:fluttercouch/document.dart';
//import 'package:fluttercouch/fluttercouch.dart';
//import 'package:fluttercouch/mutable_document.dart';
//import 'package:fluttercouch/query/query.dart';


//class AppModel extends Object with Fluttercouch {
//  String _databaseName;
//  Document docExample;
//  Query query;
//
//  AppModel() {
//    initPlatformState();
//  }
//
//  initPlatformState() async {
//    try {
//      _databaseName = await initDatabaseWithName("couch-prueba-local");
//      setReplicatorEndpoint("ws://192.168.0.103:4984/couch-prueba");
//      setReplicatorType("PUSH_AND_PULL");
//      setReplicatorBasicAuthentication(<String, String>{
//        "username": "gateway",
//        "password": "123456"
//      });
//      setReplicatorContinuous(true);
//      initReplicator();
//      startReplicator();
//      // docExample = await getDocumentWithId("diocesi_tab");
//      // notifyListeners();
//      // MutableDocument mutableDoc = MutableDocument();
//      // mutableDoc.setString("prova", "");
//    } catch (e) {
//
//    }
//  }
//}
class couchBase extends StatefulWidget {
  couchBaseState createState() => couchBaseState();
}
class couchBaseState extends State<couchBase>  {
  Widget build(BuildContext context) {
    return Center(child: new Text('couchbase'));
  }
}
