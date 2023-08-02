class Product {
  String name;
  String shortDescription;
  String longDescription;
  double price;
  DateTime dateOfEnd;
  String email;
  String phone;
  List<String> imagePaths; // List to store image paths from assets
  String videoPath; // String to store video path from assets

  Product({
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.price,
    required this.dateOfEnd,
    required this.email,
    required this.phone,
    required this.imagePaths,
    required this.videoPath,
  });
}
