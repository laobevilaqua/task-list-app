class Item {
  String title;
  bool done;

  // Constructor for creating new Item
  Item({this.title, this.done});

  // Convert Item in Json to Item
  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }

  // Convert Item in Json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['done'] = this.done;
    return data;
  }
}
