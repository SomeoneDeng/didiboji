/**
 * 新闻
 */
class News{
  String id;
  String message;
  String link;
  String imageLink;
  bool priority;
  String date;
  String eta;
  bool update;
  bool primeAccess;
  bool stream;
  String asString;

  News({
    this.id,
    this.asString,
    this.date,
    this.eta,
    this.imageLink,
    this.link,
    this.message,
    this.primeAccess,
    this.priority,
    this.stream,
    this.update
  });
}
/**
 * 突击状态
 */
class Sortie{
  String id;
  String activation;
  String expiry;
  String rewardPool;
  String eta;
  List<Variant> variants;
  String boss;
  String faction;

  Sortie({
    this.boss,
    this.faction,
    this.activation,
    this.expiry,
    this.id,
    this.rewardPool,
    this.variants,
    this.eta
  }); 
}
/**
 * 突击任务
 */
class Variant{
  String missionType;
  String modifier;
  String modifierDescription;
  String node;

  Variant({
    this.missionType,
    this.modifier,
    this.modifierDescription,
    this.node,
  }); 
}

/**
 * 地球循环
 */

class EarthCycle{
  String id;
  String expiry;
  bool isDay;
  String timeLeft;

  EarthCycle({
    this.expiry,
    this.id,
    this.isDay,
    this.timeLeft
  });
}
/**
 * 希图斯的循环
 */
class CetusCycle{
  String id;
  String expiry;
  String timeLeft;
  String shortString;
  bool isDay;

  CetusCycle({
    this.isDay,
    this.timeLeft,
    this.expiry,
    this.id,
    this.shortString
  });
}
