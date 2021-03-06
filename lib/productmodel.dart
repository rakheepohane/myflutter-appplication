class ItemModel{
  static List<Item> items=[];
}




class Item {
  num id;
  String name;
  String desc;
  num price;
  String color;
  String image;

  Item({required this.id, required this.name, required this.desc, required this.price, required this.color, required this.image});


  factory Item.fromMap(Map<String, dynamic>map){
    return Item(
      id: map["id"],
      name: map["name"],
      desc: map["desc"],
      price: map["price"],
      color: map["color"],
      image: map["image"],
    );
  }


  tomap() =>
      {
        "id": id,
        "name": name,
        "desc": desc,
        "price": price,
        "color": color,
        "image": image,

      };

}