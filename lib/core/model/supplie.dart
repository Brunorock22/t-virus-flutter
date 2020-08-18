class Supplie {
  int id;
  String name;
  int points;
  int quantity;
  int survivorId;

  Supplie({this.id, this.name, this.points, this.quantity, this.survivorId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'points': points,
      'quantity': quantity,
    };
  }
}
