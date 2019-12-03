import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsSample extends StatefulWidget {
  @override
  _MapsSampleState createState() => _MapsSampleState();
}

class _MapsSampleState extends State<MapsSample> {
//  final String title;

//  MyHomePage({Key key, this.title}) : super(key: key);

  final Set<Marker> _markers = Set();
  final double _zoom = 23;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(4.6097102, -74.081749),zoom: 11);
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text(title)),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: _markers,
            mapType: _defaultMapType,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    child: Icon(Icons.layers),
                    elevation: 5,
                    backgroundColor: Colors.teal[200],
                    onPressed: () {
                      _changeMapType();
                      print('Changing the Map Type');
                    }),
              ],
            ),
          ),

        ],
      ),
    );
  }
}