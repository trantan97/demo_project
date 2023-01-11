import 'package:demo_project/core/error/failures.dart';
import 'package:demo_project/domain/entity/comment.dart';
import 'package:demo_project/domain/repository/comment_repository.dart';
import 'package:either_dart/either.dart';

class GetListComment {
  final CommentRepository repository;

  GetListComment(this.repository);

  Future<Either<Failure, List<CommentEntity>>> execute({int start = 0, int limit = 50}) {
    return repository.getListComments(start: start, limit: limit);
  }
}
