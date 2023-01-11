import 'package:demo_project/core/base_bloc/base.dart';
import 'package:demo_project/domain/entity/comment.dart';
import 'package:demo_project/domain/usecase/get_list_comment.dart';

part 'comment_state.dart';

class CommentCubit extends BaseCubit<CommentState> {
  final pageSize = 50;
  final GetListComment _getListComment;

  CommentCubit(this._getListComment) : super(const CommentState());

  Future<void> initData() {
    return _getComments();
  }

  Future<void> loadMore() async {
    if (state.actionState is LoadingState) return;
    if (!state.canLoadMore) return;
    _getComments(isLoadMore: true);
  }

  Future<void> _getComments({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      emit(
        state.copyWith(
          actionState: const LoadingState(),
        ),
      );
    }
    final start = state.comments.length;
    final result = await _getListComment.execute(
      start: start,
      limit: pageSize,
    );
    result.fold((left) {
      emit(
        state.copyWith(
          actionState: ErrorState(
            code: left.code,
            data: left,
          ),
        ),
      );
    }, (right) {
      emit(
        state.copyWith(
          actionState: const LoadedState(),
          comments: isLoadMore ? [...state.comments, ...right] : right,
          canLoadMore: right.length >= pageSize,
        ),
      );
    });
  }
}
