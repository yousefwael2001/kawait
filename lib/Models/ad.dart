class Ad {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Ad(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl});

  factory Ad.fromMap(Map<String, dynamic> map, String id) {
    return Ad(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['image_url'] as String,
    );
  }
}
