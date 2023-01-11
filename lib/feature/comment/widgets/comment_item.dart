import 'package:demo_project/domain/entity/comment.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity commentEntity;

  const CommentItem({
    Key? key,
    required this.commentEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "${commentEntity.id}. ${commentEntity.name}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(commentEntity.body),
      ],
    );
  }
}
