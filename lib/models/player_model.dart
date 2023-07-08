class PlayerModel {
  String id, imageUrl, name, position;
  DateTime createdAt, updatedAt;

  PlayerModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.position,
    required this.imageUrl,
  });
}
