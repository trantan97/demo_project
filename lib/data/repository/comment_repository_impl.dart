import 'package:demo_project/core/error/failures.dart';
import 'package:demo_project/data/datasource/remote_data_source.dart';
import 'package:demo_project/domain/entity/comment.dart';
import 'package:demo_project/domain/repository/comment_repository.dart';
import 'package:either_dart/src/either.dart';

class CommentRepositoryImpl implements CommentRepository {
  final RemoteDataSource remoteDataSource;

  CommentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CommentEntity>>> getListComments({
    int start = 0,
    int limit = 50,
  }) async {
    try {
      final result = await remoteDataSource.getListComments(start: start, limit: limit);
      return Right(result.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
