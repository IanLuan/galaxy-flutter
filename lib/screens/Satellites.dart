import 'package:flutter/material.dart';
import 'package:galaxy_flutter/Api.dart';
import 'package:galaxy_flutter/RouteGenerator.dart';
import 'package:galaxy_flutter/models/Satellite.dart';
import 'package:galaxy_flutter/widgets/Lists.dart';

class Satellites extends StatefulWidget {
  @override
  _SatellitesState createState() => _SatellitesState();
}

class _SatellitesState extends State<Satellites> {

  Api db = Api();

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
       onWillPop: () async {
         Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.ROUTE_HOME, (_) => false);
         return false;
       },
       child: Scaffold(
         appBar: AppBar(
          title: Text("Satélites", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              //TODO busca por nome
              child: Icon(Icons.search),
            )
          ],
         ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: Colors.pink[700],),
          backgroundColor: Colors.white,
          onPressed: (){
             Navigator.pushNamed(context, RouteGenerator.ROUTE_REGISTER_SATELLITE);
        },),
        body: NameList(type: 'Satelite', future: db.getAll("satellite", Satellite), route: RouteGenerator.ROUTE_SATELLITE_PROFILE)
      ),
    );
  }
}