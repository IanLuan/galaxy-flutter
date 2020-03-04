import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:galaxy_flutter/RouteGenerator.dart';

class Planetas extends StatefulWidget {
  @override
  _PlanetasState createState() => _PlanetasState();
}

class _PlanetasState extends State<Planetas> {

  // TODO Vai ser uma lista de objetos
 
  var planets = ["Marte","Vênus","Urano","Saturno","Netuno","Mercúrio"];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: () async {
         Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.ROUTE_HOME, (_) => false);
         return false;
       },
       child: Scaffold(
         appBar: AppBar(
          title: Text("Planetas", style: TextStyle(color: Colors.white)),
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
             Navigator.pushNamed(context, RouteGenerator.ROUTE_CADASTRAR_PLANETA);
        },),
        body: Container(
          color: Color(0xff380b4c),
          padding: EdgeInsets.only(top: 20),
          child: ListView.builder(
            itemBuilder: (context, index) => 
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: PlanetRow(planets[index]),
            ),
            itemCount: planets.length,
          ),
        ),
      ),
    );
  }
}

class PlanetRow extends StatelessWidget {
  const PlanetRow(this.title);

  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 120.0,
       margin: const EdgeInsets.symmetric(
         vertical: 10.0,
       ),
      child: Stack(
        children: <Widget>[
          PlanetCard(title),
          Positioned (left: 10, child: Padding(
            padding: const EdgeInsets.only(top:5.0),
            child: PlanetAnimation(),
          )),
        ],
      )
    );
    
  }
}

class PlanetAnimation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
     child: SizedBox(
          width: 110,
          height: 110,
          child: FlareActor('assets/animations/planetList.flr',
          animation: 'rotation',
          ),
     ),
    );
  }
}

class PlanetCard extends StatelessWidget {
  const PlanetCard(this.title);

  final title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //TODO Identificar qual planeta e entrar no perfil
        Navigator.pushNamed(context, RouteGenerator.ROUTE_PLANET);
      },
      child: Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title, 
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff380b4c), fontSize: 20, ),),
            Text("Tamanho: 49.244 km", 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54, fontSize: 15, ),),
            Text("Massa: 1,024 × 10^26 kg", 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54, fontSize: 15, ),),   
          ],
        )),
        height: 120.0,
        margin: EdgeInsets.only(left: 60.0, right: 20 ),
        decoration:
        BoxDecoration(
          color: Colors.purple[800],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [BoxShadow(
            color: Color(0xff280538),
            blurRadius: 20.0,)],
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops:[0,4],
            colors: [Colors.pink[700], Colors.purple[800]],
          ),
      ),

      ),
    );
  }
}