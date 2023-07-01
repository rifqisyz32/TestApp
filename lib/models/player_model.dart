class PlayerModel {
  String id, imageUrl, name, position;
  DateTime createdAt;

  PlayerModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.position,
    required this.imageUrl,
  });
}
