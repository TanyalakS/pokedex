class PokeListResultsModel {
  int? height;
  String? name;
  int? order;
  List<Types>? types;
  int? weight;
  Sprites? sprites;

  PokeListResultsModel({
    this.height,
    this.name,
    this.order,
    this.types,
    this.weight,
    this.sprites,
  });

  PokeListResultsModel.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    name = json['name'];
    order = json['order'];
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(Types.fromJson(v));
      });
    }
    weight = json['weight'];
    sprites =
        json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['name'] = name;
    data['order'] = order;
    if (types != null) {
      data['types'] = types!.map((v) => v.toJson()).toList();
    }
    data['weight'] = weight;
    if (sprites != null) {
      data['sprites'] = sprites!.toJson();
    }
    
    return data;
  }
}

class Ability {
  String? name;
  String? url;

  Ability({this.name, this.url});

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class Types {
  int? slot;
  Ability? type;

  Types({this.slot, this.type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? Ability.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slot'] = slot;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    return data;
  }
}

class Sprites {
  String? frontDefault;

  Sprites(
      {this.frontDefault,});

  Sprites.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['front_default'] = frontDefault;
    return data;
  }
}
