import 'package:flutter/material.dart';

class confirmExitRemove extends StatelessWidget {
  const confirmExitRemove({this.title, this.action, this.content: ''});

  final title;
  final action;
  final content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0))),
    title: Text(title),
    content: Text(content),
    contentPadding: content == '' ? EdgeInsets.all(0.0) : EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    actions: <Widget>[
      FlatButton(child: Text("Sim"),onPressed: action,),
      FlatButton(child: Text("Cancelar"),onPressed: (){
        Navigator.pop(context);
      },)
    ],);
  }
}

class addHorizontalList extends StatefulWidget {
  addHorizontalList({this.title, this.list, this.create, this.save});

  final title;
  final list;
  final create;
  final save;

  @override
  _addHorizontalListState createState() => _addHorizontalListState();
}

class SelectDialog extends StatefulWidget {
  SelectDialog(this.future, this.title, this.listId);

  final future;
  final title;
  final listId;

  @override
  _SelectDialogState createState() => _SelectDialogState();
}

class _SelectDialogState extends State<SelectDialog> {

  Map map;
  var items;
  var _selectedItem;
  var controllerName = TextEditingController();
  var controllerId = TextEditingController();

  loadList() async{
    var listBD = await widget.future;
    List<DropdownMenuItem> items = [];

    for (var item in listBD){
      if(!widget.listId.contains(item.id)){
        items.add(new DropdownMenuItem(
            child: Text(item.name,  style: TextStyle(
                                color: Colors.purple[700],
                                fontFamily: "Poppins",
                                fontSize: 18.0,)),
            value: item,  
        )
        );
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {

    items = loadList();
    final _formKey = GlobalKey<FormState>();

    return AlertDialog(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0))),
      title: Text(widget.title),
      contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      content: Container(
        height: 120.0,
        child: FutureBuilder(
          future: items,
          builder: (context, snapshot){
            switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                      case ConnectionState.done:
                        return Form(
                          key: _formKey,
                          child: Column(
                            children:[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                  child: DropdownButtonFormField(
                                     items: snapshot.data,
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Selecione um planeta';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:BorderRadius.circular(25.0),
                                            borderSide: BorderSide(
                                              color: Colors.purple[700],
                                              width: 1.5
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: new BorderRadius.circular(25.0),
                                            borderSide: BorderSide(
                                              color: Colors.pink[700],
                                              width: 1.5
                                            ),
                                          )
                                        ),
                                        hint: Text("Selecione o planeta",  style: TextStyle(
                                                                            color: Colors.purple[700],
                                                                            fontFamily: "Poppins",
                                                                            fontSize: 18.0,)),
                                        style: TextStyle(
                                          color: Colors.purple[700],
                                          fontFamily: "Poppins",
                                          fontSize: 18.0,),
                                        isDense: true,
                                        isExpanded: true,
                                        value: _selectedItem,
                                        onChanged: (newValue) {      
                                          setState(() {
                                              _selectedItem = newValue;   
                                              controllerId.text = newValue.id;
                                              controllerName.text = newValue.name;  
                                          });          
                                      },

                                  ),
                                ),
                            ]
                          ),
                        );
            }
          }
        ),
      ),
      actions: <Widget>[
        FlatButton(child: Text("Sim"),onPressed: (){

          if (_formKey.currentState.validate()) {
          
          Navigator.pop(context, 
                  {'name': controllerName.text, 
                    'id': controllerId.text,
                  });   
          }
        }),
        FlatButton(child: Text("Cancelar"),onPressed: (){
          Navigator.pop(context, null);
        },)
      ],
    );
  }
}

class _addHorizontalListState extends State<addHorizontalList> {

  var _isSelected = [];

  @override
  Widget build(BuildContext context) {
    
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    MediaQueryData queryData = MediaQuery.of(context);
    double padding = queryData.size.height/7;

    return Padding(
      padding: isPortrait ? EdgeInsets.only(top: padding, bottom: padding) : EdgeInsets.all(0) ,
      child: AlertDialog(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0))),
      title: Text(widget.title),
      content: SingleChildScrollView(
          child: Column(
          children: List.generate(
            widget.list.length+1,
            (int index) {
              for (int i=0; i<=widget.list.length; i++){
                _isSelected.add(false);
              }
              if (index != widget.list.length){
                 return new CheckboxListTile(
                        title: Text(widget.list[index]),
                        value: _isSelected[index],
                        onChanged: (bool newValue){
                          setState(() {
                            _isSelected[index] = newValue;
                          });
                        },
                );
              }else{
                 return Padding(
                  padding: const EdgeInsets.only(top: 5),
                    child: FlatButton(child: Text("Novo Satélite", style: TextStyle(color: Colors.purple),),onPressed: widget.create,)
                );
                /*
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 5),
                    child: Row(children: [Text("Outro:"), Padding(
                      padding: const EdgeInsets.only(left: 108.0),
                      child: IconButton(icon: Icon(Icons.add_box), onPressed: (){}, iconSize: 30,),
                    ),]
                    //child:FlatButton(color: Colors.pink,child: Text("Novo Satélite"),onPressed: () =>  Navigator.pop(context))
                    ),
                );*/
              }
            }
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(child: Text("Cancelar"),onPressed: () =>  Navigator.pop(context)
        ,),
        FlatButton(child: Text("Adicionar"),onPressed: widget.save,)
      ],),
    );
  }
}

/*
Widget _Options() => PopupMenuButton<int>(
          itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text("Remover"),
                ),
              ],
          icon: Icon(Icons.more_vert),
          offset: Offset(0, -100),
          shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
);*/