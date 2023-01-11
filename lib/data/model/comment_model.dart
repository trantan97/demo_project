import 'package:demo_project/domain/entity/comment.dart';

class CommentModel {
  CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentModel.fromJson(dynamic json) {
    return CommentModel(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['postId'] = postId;
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['body'] = body;
    return map;
  }

  CommentEntity toEntity() => CommentEntity(
        postId: postId,
        id: id,
        name: name,
        email: email,
        body: body,
      );
}
