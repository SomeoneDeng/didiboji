import 'package:didiboji/model/DataManager.dart';
void main(){ testEarthCycle(); }

// test
void testGetNews(){
  new DataManager()
    .getNews()
    .then((listNews)=>listNews.forEach((news)=>print(news.imageLink))) ; 
}
// test 
void testGetSortie(){
  new DataManager().getSortie().then((s){
    s.variants.forEach((v){
      print(v.modifierDescription);
    });
  }); 
}

void testEarthCycle(){
  new DataManager().getEarthCycle().then((ea){
    print(ea.timeLeft);
    print(ea.isDay);
  });
}