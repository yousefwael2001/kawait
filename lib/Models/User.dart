class UserData {
  String? id;
  String? phone;
  String? imageURL;
  String? address;
  String? name;
  String? email;
  String? companyName;

  UserData({
    required this.id,
    required this.phone,
    required this.imageURL,
    required this.address,
    required this.name,
    required this.email,
    required this.companyName,
  });

  // A factory method to convert a Map to UserData object
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? '',
      phone: map['phone'] ?? '',
      imageURL: map['imageURL'] ?? '',
      address: map['address'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      companyName: map['companyName'] ?? '',
    );
  }

  // A method to convert UserData object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'imageURL': imageURL,
      'address': address,
      'name': name,
      'email': email,
      'companyName': companyName,
    };
  }
}
