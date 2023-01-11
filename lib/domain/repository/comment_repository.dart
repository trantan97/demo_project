import 'package:demo_project/core/error/failures.dart';
import 'package:demo_project/domain/entity/comment.dart';
import 'package:either_dart/either.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<CommentEntity>>> getListComments({int start = 0, int limit = 50});
}
