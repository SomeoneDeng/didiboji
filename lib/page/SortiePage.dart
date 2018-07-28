import 'package:flutter/material.dart';
import 'package:didiboji/bean/Beans.dart';
import 'package:didiboji/bean/Settings.dart';
class SortiePage extends StatefulWidget {
  final Sortie sortie;

  SortiePage({
    this.sortie
  });

  @override
  _SortiePageState createState() => _SortiePageState(sortie: sortie);
}

class _SortiePageState extends State<SortiePage> {

  final Sortie sortie;

  _SortiePageState({this.sortie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('突击',style: new TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: new Column(
        children: <Widget>[
          new Card(
            elevation: 2.0,
            child: new Container(
              width:MediaQuery.of(context).size.width,
              height: 80.0,
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              alignment: Alignment.centerLeft,
              child: new Column(
                children: <Widget>[
                  new Text(
                    sortie.boss,
                    style: new TextStyle(
                      color: Colors.orange,
                      fontSize: 20.0
                    ),
                  ),
                  new Text(
                    sortie.faction,
                    style: new TextStyle(
                      color: Colors.orange.shade300
                    ),
                  ),
                  new Text.rich(
                    new TextSpan(
                      text: "剩余",
                      children: <TextSpan>[
                        new TextSpan(
                          text: sortie.eta ,
                          style: TextStyle(
                            color: Colors.red.shade200
                          )
                        ) 
                      ]
                    ) 
                  )
                ],  
              ), 
            ),
          ),
          new Container(
            height: MediaQuery.of(context).size.height - 204.0,
            child: new ListView(
              children: sortie
              .variants
              .map((v)=>new Card(
                child: new Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: new Text.rich(
                    new TextSpan(
                      text: v.node,
                      style: new TextStyle(
                        fontSize: 20.0
                      ),
                      children: <TextSpan>[
                        new TextSpan(text: "\n"),
                        new TextSpan(
                          text: v.missionType,
                          style: new TextStyle(
                            fontSize: 12.0,
                            color: Colors.amber,
                          )
                        ),
                        new TextSpan(text: "\n"),
                        new TextSpan(
                          text: v.modifier,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black45
                          )
                        ),
                        new TextSpan(text: "\n"),
                        new TextSpan(
                          text: v.modifierDescription,
                          style: new TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0
                          ) 
                        ) 
                      ] 
                    ),  
                  )
                ),
              ))
              .toList()
            ), 
          )
        ], 
      )
    );
  }
}
