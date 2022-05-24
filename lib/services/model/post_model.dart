// class PostModel {
//   String? name, uId, idPost, imageUser, text, imagePost, dateTime;
//
//   LikesModel? likes;
//
//   PostModel(
//       {this.name,
//       this.uId,
//       this.idPost,
//       this.imageUser,
//       this.dateTime,
//       this.text,
//       this.likes,
//       this.imagePost});
//
//   PostModel.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     uId = json['uId'];
//     idPost = json['idPost'];
//     imageUser = json['imageUser'];
//     dateTime = json['dateTime'];
//     text = json['text'];
//     imagePost = json['imagePost'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['uId'] = uId;
//     data['idPost'] = idPost;
//     data['name'] = name;
//     data['imageUser'] = imageUser;
//     data['dateTime'] = dateTime;
//     data['imagePost'] = imagePost;
//     data['text'] = text;
//     return data;
//   }
// }
//
// class LikesModel {
//   bool? isLike;
//
//   List<String>? likesUserId;
//
//   LikesModel.fromJson(Map<String, dynamic> json) {
//     isLike = json['isLike'];
//
//     if (json['likesUserId'] != null) {
//       likesUserId = [];
//       json['likesUserId'].forEach((v) {
//         likesUserId!.add(v);
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['isLike'] = isLike;
//     if (likesUserId != null) {
//       data['likesUserId'] = likesUserId?.map((v) => v).toList();
//     }
//
//     return data;
//   }
// }

class PostModel {
  String? dateTime;
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
      dateTime: json['dateTime'],
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
