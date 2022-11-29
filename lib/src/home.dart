import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primera/models/band.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Adele', votes: 5),
    Band(id: '2', name: 'Tini', votes: 3),
    Band(id: '3', name: 'La oreja de Van Gogh', votes: 2),
    Band(id: '4', name: 'Taylor Swift', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombre de bandas', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) => _bandTile( bands[index] )
       ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ){
        //TODO: llamar el borrado al server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          child: Text('Eliminar', style: TextStyle(color: Colors.white),),
          alignment: Alignment.centerLeft,
        ),
      ),
      child: ListTile(
          leading: CircleAvatar(
            child: Text( band.name.substring(0,2)),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(band.name),
          trailing: Text('${band.votes}', style: TextStyle(fontSize: 20),),
          onTap: (){
            print(band.name);
          },
        ),
    );
  }

  addNewBand(){

    final textController = new TextEditingController();

    if (Platform.isAndroid ){
      return showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title: Text('Nuevo nombre de banda:'),
            content: TextField(controller: textController,),
            actions: [
              MaterialButton(
                child: Text('Agregar'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text),
              ),
            ],
          );
        }
      );
    } 
    showCupertinoDialog(
      context: context, 
      builder: (_){
        return CupertinoAlertDialog(
          title: Text('Nuevo nombre de banda:'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Agregar'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Cerrar'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void addBandToList(String name){
    if (name.length > 1){
      this.bands.add( new Band(id: DateTime.now().toString(), name: name, votes: 0,));
      setState(() {});
    }
    Navigator.pop(context);
  }
  
}