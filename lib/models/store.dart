class Store {
  String approved = '';
  String placed = '';
  String delivered = '';

  Store(String approved, String placed, String delivered) {
    this.approved = approved;
    this.placed = placed;
    this.delivered = delivered;
  }

  Store.fromJson(Map json)
      : approved = json['approved'],
        placed = json['placed'],
        delivered = json['delivered'];

  Map toJson() {
    return {'approved': approved, 'placed': placed, 'delivered': delivered};
  }
}
