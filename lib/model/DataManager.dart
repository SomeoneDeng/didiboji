import 'package:didiboji/bean/Beans.dart';
import 'package:didiboji/bean/Settings.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
class DataManager{
  // 获取News Data
  Future<List<News>> getNews(){
  print("getting news data..");
    return get(Settings.NEWS_URL)
    .then((response){ 
      return response.body;
    })
    .then((body){
      return json.decode(body);
    })
    .then((list){
      List<News> listNews = new List();
      list.forEach((l){
        listNews.add(new News(
          id: l['id'],
          asString: l['asString'],
          date: l['date'],
          eta: l['eta'],
          imageLink: l['imageLink'],
          message: l['message'],
          primeAccess: l['primeAccess'],
          priority: l['priority'],
          stream: l['stream'],
          update: l['update'],
          link: l['link']
        ));
      }); 
      return listNews;
    });
  }

  // 获取突击信息
  Future<Sortie> getSortie(){
    print("getting sortie data..");
    return get(Settings.SORTIE_URL)
      .then((resp){
        return resp.body;
      })
      .then((body){
        return json.decode(body);
      })
      .then((sjson){
        var temp = sjson['variants'];
        List<Variant> vl = new List();
        temp.forEach((v){
          vl.add(new Variant(
            missionType: v['missionType'],
            modifier: v['modifier'],
            modifierDescription: v['modifierDescription'],
            node: v['node']
          ));
        });
        return new Sortie(
          id: sjson['id'],
          eta: sjson['eta'],
          boss: sjson['boss'],
          faction: sjson['faction'],
          activation: sjson['activation'],
          expiry: sjson['expiry'],
          rewardPool: sjson['rewardPool'],
          variants: vl
        );
      }
    );
  }

  // 地球循环
  Future<EarthCycle> getEarthCycle(){
    return get(Settings.EARTH_CYCLE_URL)
    .then((resp)=>resp.body)
    .then((body)=>json.decode(body))
    .then((data)=>new EarthCycle(
      id: data['id'],
      expiry: data['expiry'],
      isDay: data['isDay'],
      timeLeft: data['timeLeft']
    )); 
  }

  // 希图斯循环
  Future<CetusCycle> getCetusCycle(){
    return get(Settings.CETUS_CYCLE_URL)
    .then((resp) => resp.body)
    .then((body) => json.decode(body))
    .then((data) => new CetusCycle(
      id: data['id'],
      timeLeft: data['timeLeft'],
      expiry: data['expiry'],
      isDay: data['isDay'],
      shortString: data['shortString']
    ));
  }

}