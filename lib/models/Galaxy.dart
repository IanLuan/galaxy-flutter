class Galaxy{

  String id;
  String name;
  String earthDistance;
  int numSystems;
  int colorId;

  Galaxy({this.id, this.name, this.earthDistance, this.numSystems, this.colorId});

  Galaxy.fromMap(var document){
    id = document.documentID;

    this.name = document.data["name"];
    this.earthDistance = document.data["earthDistance"];
    this.numSystems = document.data["numSystems"];
    this.colorId = document.data["colorId"];

  }

   toMap(){
    return {
      "name":this.name,
      "earthDistance":this.earthDistance,
      "numSystems": this.numSystems,
      "colorId": this.colorId};
  }
}