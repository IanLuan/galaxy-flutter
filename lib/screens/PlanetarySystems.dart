import 'package:flutter/material.dart';
import 'package:galaxy_flutter/Api.dart';
import 'package:galaxy_flutter/RouteGenerator.dart';
import 'package:galaxy_flutter/models/PlanetarySystem.dart';
import 'package:galaxy_flutter/widgets/Lists.dart';

class PlanetarySystems extends StatefulWidget {

  @override
  _PlanetarySystemsState createState() => _PlanetarySystemsState();
}

class _PlanetarySystemsState extends State<PlanetarySystems> {

  Api db = Api();
  String query = "";
  bool search = false;
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) 

  {
    return WillPopScope(
       onWillPop: () async {
         Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.ROUTE_HOME, (_) => false);
         return false;
       },
       child: Scaffold(
         appBar: !search ? AppBar(
          title: Text("Sistemas Planetários", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              //TODO busca por nome
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    search = true;
                  });
                }
              ),
            )
          ],
         )
         : AppBar(
          backgroundColor: Colors.pink[700],
          title: TextField(
            textInputAction: TextInputAction.search,
            autofocus: true,
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            cursorColor: Colors.white,
            controller: searchController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 27,), 
                onPressed: () {
                  setState(() {
                    search = false;
                    searchController.text = "";
                    query = "";
                  });
                }
              ),
              hintText: "Search",
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: Colors.pink[700],),
          backgroundColor: Colors.white,
          onPressed: (){
             Navigator.pushNamed(context, RouteGenerator.ROUTE_REGISTER_PLANETARY_SYSTEM);
        },),
        body: NameList(type: 'System', future: db.getAll("system", PlanetarySystem), route:  RouteGenerator.ROUTE_PLANETARY_SYSTEM_PROFILE, query: query)
      ),
    );

}
}