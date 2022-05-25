import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  Timestamp? dateTime;
  String? idPost;
  String? imagePost;
  String? imageUser;
  String? name;
  String? text;
  String? uId;
  Likes? likes;

  PostModel(
      {this.dateTime,
      this.idPost,
      this.imagePost,
      this.imageUser,
      this.name,
      this.text,
      this.uId,
      this.likes});

  PostModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    idPost = json['idPost'];
    imagePost = json['imagePost'];
    imageUser = json['imageUser'];
    name = json['name'];
    text = json['text'];
    uId = json['uId'];
    likes = json['likes'] != null ? Likes.fromJson(json['likes']) : null;
  }

  factory PostModel.fromHive(Map<dynamic, dynamic> json) => PostModel(
      // dateTime: json['dateTime'].toString(),
      idPost: json['idPost'],
      imagePost: json['imagePost'],
      imageUser: json['imageUser'],
      name: json['name'],
      text: json['text'],
      uId: json['uId'],
      likes: json['likes'] != null ? Likes.fromHive(json['likes']) : null);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dateTime'] = this.dateTime;
    data['idPost'] = this.idPost;
    data['imagePost'] = this.imagePost;
    data['imageUser'] = this.imageUser;
    data['name'] = this.name;
    data['text'] = this.text;
    data['uId'] = this.uId;
    if (this.likes != null) {
      data['likes'] = this.likes!.toJson();
    }
    return data;
  }
  Map<String, dynamic> toJsonHive() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dateTime'] = this.dateTime.toString();
    data['idPost'] = this.idPost;
    data['imagePost'] = this.imagePost;
    data['imageUser'] = this.imageUser;
    data['name'] = this.name;
    data['text'] = this.text;
    data['uId'] = this.uId;
    if (this.likes != null) {
      data['likes'] = this.likes!.toJson();
    }
    return data;
  }
}

class Likes {
  bool? isLike;
  List<String>? likesUserId;

  Likes({this.isLike, this.likesUserId});

  Likes.fromJson(Map<String, dynamic> json) {
    isLike = json['isLike'];
    likesUserId = json['likesUserId'].cast<String>();
  }

  factory Likes.fromHive(Map<dynamic, dynamic> json) => Likes(
        isLike: json['isLike'],
        likesUserId: json['likesUserId'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isLike'] = this.isLike;
    data['likesUserId'] = this.likesUserId;
    return data;
  }
}
