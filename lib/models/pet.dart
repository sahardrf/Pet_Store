class Pet {
  int id = 0;
  String name = '';
  String category = '';
  List<dynamic>? photoUrls;
  List<dynamic> tags = [];
  String status = '';

  Pet(int id, String name, String category, List<dynamic> photoUrls,
      List<dynamic> tags, String status) {
    this.id = id;
    this.name = name;
    this.category = category;
    this.photoUrls = photoUrls;
    this.tags = tags;
    this.status = status;
  }

  Pet.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        category = json['category']['name'],
        photoUrls = json['photoUrls'],
        tags = json['tags'],
        status = json['status'];

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'photoUrls': photoUrls,
      'tags': tags,
      'status': status
    };
  }
}
