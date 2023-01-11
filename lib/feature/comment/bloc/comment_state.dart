part of 'comment_cubit.dart';

class CommentState extends BaseState {
  final BaseState actionState;
  final List<CommentEntity> comments;
  final bool canLoadMore;

  const CommentState({
    this.actionState = const InitState(),
    this.comments = const [],
    this.canLoadMore = true,
  });

  @override
  List<Object?> get props => [actionState, comments, canLoadMore];

  CommentState copyWith({
    BaseState? actionState,
    List<CommentEntity>? comments,
    bool? canLoadMore,
  }) {
    return CommentState(
      actionState: actionState ?? this.actionState,
      comments: comments ?? this.comments,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}
