class UserModel {
  String? uId, email, firstName, lastName ,
  image ,imageCover;

  UserModel(
      {this.uId,
      this.email,
      this.firstName,
      this.lastName,
      this.image,
      this.imageCover});



  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uId = json['uId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    image = json['image'];
    imageCover = json['imageCover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uId'] = uId;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['image'] = image;
    data['imageCover'] = imageCover;
    return data;
  }
}
