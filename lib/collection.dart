class Collection {
  final int id;
  final String name;
  final String description;
  final String tag;
  final String keyPhoto;
  final String layout;

  Collection({this.id, this.name, this.description, this.tag, this.keyPhoto, this.layout});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "tag": tag,
      "keyPhoto": keyPhoto,
      "layout": layout
    };
  }

  factory Collection.fromMap(Map<String, dynamic> data) {
    return Collection(
      id: data["id"],
      name: data["name"],
      description: data["description"],
      tag: data["tag"],
      keyPhoto: data["keyPhoto"],
      layout: data["layout"]
    );
  }

  @override
  String toString(){
    return 'Collection{id: $id, name: $name}';
  }
}
