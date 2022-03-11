class UserModel {
  String? userId;
  String? name;
  String? phone;
  String? email;
  String? image;
  bool? isEmailVerified;

  UserModel({this.userId, this.name, this.phone, this.email, this.isEmailVerified});

  UserModel.empty();

  UserModel.fromJson(Map<String, dynamic> jsonData) {
    userId = jsonData['userId'];
    name = jsonData['name'];
    phone = jsonData['phone'];
    email = jsonData['email'];
    isEmailVerified = jsonData['isEmailVerified'];
    // image = jsondata['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'name': this.name,
      'phone': this.phone,
      'email': this.email,
      'isEmailVerified': this.isEmailVerified,
    };
  }
}
