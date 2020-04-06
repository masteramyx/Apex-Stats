class PlayerResponse {
  PlayerData data;

  PlayerResponse({this.data});

  factory PlayerResponse.fromJson(Map<String, dynamic> parsedJson) {
    return PlayerResponse(data: PlayerData.fromJson(parsedJson['data']));
  }
}

class PlayerData {
  Player player;
  List<CharacterObject> characters;

  PlayerData({this.player, this.characters});

  factory PlayerData.fromJson(Map<String, dynamic> parsedJson) {
    //List<dynamic>
    var list = parsedJson['children'] as List;
    List<CharacterObject> characterList =
        list.map((i) => CharacterObject.fromJson(i)).toList();
    return PlayerData(
        player: Player.fromJson(parsedJson['metadata']),
        characters: characterList);
  }
}

class Player {
  String name;
  int level;
  String rankImage;

  Player({this.name, this.level, this.rankImage});

  factory Player.fromJson(Map<String, dynamic> parsedJson) {
    return Player(
        name: parsedJson['platformUserHandle'],
        level: parsedJson['level'],
        rankImage: parsedJson['rankImage']);
  }
}

class CharacterObject {
  String id;
  String type;
  Character characterInfo;

  CharacterObject({this.id, this.type, this.characterInfo});

  factory CharacterObject.fromJson(Map<String, dynamic> parsedJson) {
    return CharacterObject(
        id: parsedJson['id'],
        type: parsedJson['type'],
        characterInfo: Character.fromJson(parsedJson['metadata']));
  }
}

class Character {
  String name;
  String icon;
  String bgImage;
  bool isActive;

  Character({this.name, this.icon, this.bgImage, this.isActive});

  factory Character.fromJson(Map<String, dynamic> parsedJson) {
    return Character(
        name: parsedJson['legend_name'],
        icon: parsedJson['icon'],
        bgImage: parsedJson['bgimage'],
        isActive: parsedJson['is_active']);
  }
}
