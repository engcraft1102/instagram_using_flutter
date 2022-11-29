import 'dart:io';

class Post {
  int id;
  File image;
  int likes;
  String date;
  String content;
  bool liked;
  String user;

  Post(this.id, this.image, this.likes, this.date, this.content, this.liked,
      this.user);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'likes': likes,
      'date': date,
      'content': content,
      'liked': liked,
      'user': user
    };
  }
}
