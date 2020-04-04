class PlayerResponse {
  Map<String, dynamic> data;

  PlayerResponse({this.data});

  factory PlayerResponse.fromJson(Map<String, dynamic> parsedJson) {
    return PlayerResponse(data: parsedJson['data']);
  }
}

class PlayerMetadata {
  Map<String, dynamic> player;
  List<dynamic> characters;

  PlayerMetadata({this.player, this.characters});

  factory PlayerMetadata.fromJson(Map<String, dynamic> parsedJson) {
    return PlayerMetadata(
        player: parsedJson['metadata'], characters: parsedJson['children']);
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

class CharacterList {
  List<dynamic> characters;

  CharacterList({this.characters});

  factory CharacterList.fromJson(List<dynamic> parsedJson) {
    return CharacterList(characters: parsedJson);
  }
}


class CharacterMeta {
  Map<String, dynamic> characterInfo;

  CharacterMeta({this.characterInfo});

  factory CharacterMeta.fromJson(Map<String, dynamic> parsedJson) {
    return CharacterMeta(characterInfo: parsedJson['metadata']);
  }
}

class Character {
  String name;
  String icon;

  Character({this.name, this.icon});

  factory Character.fromJson(Map<String, dynamic> parsedJson) {
    return Character(name: parsedJson['legend_name'], icon: parsedJson['icon']);
  }
}
