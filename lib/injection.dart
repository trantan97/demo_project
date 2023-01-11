import 'package:demo_project/core/network/network.dart';
import 'package:demo_project/data/datasource/remote_data_source.dart';
import 'package:demo_project/data/repository/comment_repository_impl.dart';
import 'package:demo_project/domain/repository/comment_repository.dart';
import 'package:demo_project/domain/usecase/get_list_comment.dart';
import 'package:demo_project/feature/comment/bloc/comment_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  //network
  locator.registerLazySingleton(() => Network());

  //resource
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(locator()));

  //repository
  locator.registerLazySingleton<CommentRepository>(() => CommentRepositoryImpl(locator()));

  //user case
  locator.registerLazySingleton(() => GetListComment(locator()));

  //bloc
  locator.registerFactory(() => CommentCubit(locator()));
}
