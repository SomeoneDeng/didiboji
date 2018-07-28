import 'package:didiboji/bean/Beans.dart';
import 'package:didiboji/model/DataManager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:didiboji/page/SortiePage.dart';
import 'package:didiboji/bean/Settings.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '滴滴啵唧',
      theme: new ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: new MyHomePage(title: '滴滴啵唧'),
      // routes: {
      //   '/sortiePage': (BuildContext con)=> new SortiePage()
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DataManager _dataManager = new DataManager();
  // 新闻
  List<News> _newsList = new List(0);
  // 突击
  Sortie _sortie;
  // 地球周期
  EarthCycle earthCycle = new EarthCycle(
    isDay: false,
    timeLeft: "",
  );
  // 希图斯
  CetusCycle cetusCycle = new CetusCycle(
    isDay: false,
    timeLeft: "",
    expiry: ""
  );
  // 突击栏的时间
  Text _sortieSubTitle;

  @override
  void initState(){
    print("state ==> _MyHomePageState initing..");
    _sortieSubTitle = new Text("还剩：");
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    /**
     * 获取新闻
     */
    _dataManager
    .getNews()
    .then((ns){
      setState(() {
        ns= ns.reversed.toList();
        _newsList = ns;        
      });
    });
    /**
     * 突击
     */
    _dataManager
    .getSortie()
    .then((st){
      setState(() {
        _sortie = st; 
        _sortieSubTitle = new Text.rich(
          new TextSpan(
            text: "剩余：",
            style: new TextStyle(
              color: Colors.black87
            ),
            children: <TextSpan>[
              new TextSpan(
                text: _sortie.eta,
                style: TextStyle(
                  color: Colors.red
                )
              )
            ]
          )
        );
      });
    });
    /**
     * 地球周期
     */
    _dataManager
    .getEarthCycle()
    .then((cycle){
      setState((){
        earthCycle = cycle;
      }); 
    });
    /**
     * 希图斯周期
     */
    _dataManager
    .getCetusCycle()
    .then((cycle){
      setState(() {
        cetusCycle = cycle;        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title,style: new TextStyle(color: Colors.white),),
      ),
      body: new ListView(
        padding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
        children: <Widget>[
        new Card(
            elevation: 2.0,
            child: new Container(
              height: 150.0,
              child:new ListView(
                scrollDirection: Axis.horizontal,
                children: _newsList.map((ns){
                  return new GestureDetector(
                    onTap: (){ 
                      Fluttertoast.showToast(
                        msg: '正在跳转到浏览器',
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      canLaunch(ns.link)
                      .then((can){
                        if (true){
                          launch(ns.link);
                        }else{
                          throw 'Could not launch $ns.link';
                        }
                      });
                    },
                    child: new Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new NetworkImage(ns.imageLink),
                        fit: BoxFit.fill,
                        repeat: ImageRepeat.noRepeat
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomLeft,
                    child: new ListTile(
                      title: new Text(
                        ns.message,
                        style: new TextStyle(
                          color: Colors.amber
                        ),
                      ),
                      subtitle: new Text(
                        ns.eta,
                        style: new TextStyle(
                          color: Colors.amberAccent.shade100
                        )
                      ),
                    ),
                  ), 
                  );
                }).toList(),
              )
            ), 
          ),
        new Card(
          elevation: 2.0,
          child: new GestureDetector(
            onTap: (){ 
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context){
                    return new SortiePage(
                      sortie: _sortie,
                    );
                  }
                ) 
              );
            },
              child: new Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                alignment: Alignment.centerLeft,
                height: 100.0,
                child:new ListTile(
                  title: new Text(
                    "突击   >",
                    style: new TextStyle(
                      fontSize: 30.0,
                      color: Colors.black87
                    ),
                  ), 
                  subtitle: _sortieSubTitle,
                  leading: new Image(
                    image: Image.asset('access/image/Sortie_b.png').image,
                    width: 80.0,
                    height: 80.0, 
                  )
                ),
              ),
            ),
          ),
          new Card(
            elevation: 2.0,
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.white
              ),
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
                    alignment: Alignment.centerLeft,
                    child: new Text("地球的状态",style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87
                      ),
                    ),
                  ),
                  new Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
                    child: new Text.rich(
                      new TextSpan(
                        text: "现在是 ",
                        children: <TextSpan>[
                          new TextSpan(
                            text: earthCycle.isDay? '白天' : '夜晚',
                            style: new TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 20.0 
                            )
                          )
                        ]
                      ),
                    ) 
                  ),
                  new Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 10.0),
                    child: new Text.rich(
                      new TextSpan(
                        text: "剩余时间 ",
                        children: <TextSpan>[
                          new TextSpan(
                            text: earthCycle.timeLeft,
                            style: new TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 20.0
                            )
                          )
                        ]
                      ),
                    ) 
                  ),
                ],
              ),
            ), 
          ),
          new Card(
            elevation: 2.0,
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.white
              ),
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
                    alignment: Alignment.centerLeft,
                    child: new Text("希图斯的状态",style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87
                      ),
                    ),
                  ),
                  new Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
                    child: new Text.rich(
                      new TextSpan(
                        text: "现在是 ",
                        children: <TextSpan>[
                          new TextSpan(
                            text: cetusCycle.isDay? '白天' : '夜晚',
                            style: new TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 20.0 
                            )
                          )
                        ]
                      ),
                    ) 
                  ),
                  new Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 10.0),
                    child: new Text.rich(
                      new TextSpan(
                        text: "剩余时间 ",
                        children: <TextSpan>[
                          new TextSpan(
                            text: cetusCycle.timeLeft,
                            style: new TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 20.0
                            )
                          )
                        ]
                      ),
                    ) 
                  ),
                ],
              ),
            ), 
          )
        ]
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          Fluttertoast.showToast(
            msg: '正在刷新数据',
            toastLength: Toast.LENGTH_SHORT,
          );
          _refreshData();
        },
        tooltip: 'Refresh Data',
        foregroundColor: Colors.white,
        child: new Icon(Icons.refresh),
      ),
    );
  }
}
