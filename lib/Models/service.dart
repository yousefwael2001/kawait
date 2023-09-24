class Service {
  final String id;
  final String? imageUrl;

  Service({required this.id, required this.imageUrl});

  factory Service.fromMap(Map<String, dynamic>? map, String id) {
    return Service(
      id: id,
      imageUrl: map?['image_url'] as String?,
    );
  }
}
