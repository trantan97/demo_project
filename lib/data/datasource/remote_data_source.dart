import 'package:demo_project/core/error/failures.dart';
import 'package:demo_project/core/network/api.dart';
import 'package:demo_project/core/network/network.dart';
import 'package:demo_project/data/model/comment_model.dart';

abstract class RemoteDataSource {
  Future<List<CommentModel>> getListComments({int start = 0, int limit = 50});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Network network;

  RemoteDataSourceImpl(this.network);

  @override
  Future<List<CommentModel>> getListComments({int start = 0, int limit = 50}) async {
    final response = await network.get(
      url: Api.comment,
      params: {
        "_start": start,
        "_limit": limit,
      },
    );
    final data = response.data;
    try {
      if (data is List) {
        return data.map((e) => CommentModel.fromJson(e)).toList();
      }
    } catch (_) {}
    throw const ResponseFailure(
      path: Api.comment,
      statusCode: ResponseFailure.invalidDataErrorCode,
      statusMessage: "Invalid Data",
    );
  }
}
