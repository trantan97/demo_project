import 'package:demo_project/core/base_bloc/base.dart';
import 'package:demo_project/feature/comment/bloc/comment_cubit.dart';
import 'package:demo_project/feature/comment/widgets/index.dart';
import 'package:demo_project/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ListCommentPage extends StatelessWidget {
  const ListCommentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<CommentCubit>(),
      child: const _ListCommentPage(),
    );
  }
}

class _ListCommentPage extends StatefulWidget {
  const _ListCommentPage({Key? key}) : super(key: key);

  @override
  State<_ListCommentPage> createState() => _ListCommentPageState();
}

class _ListCommentPageState extends State<_ListCommentPage> {
  final _scrollController = ScrollController();
  final _loadMoreStream = PublishSubject();
  late CommentCubit commentCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    //
    commentCubit = context.read<CommentCubit>();
    commentCubit.initData();
    //
    _loadMoreStream.debounceTime(const Duration(milliseconds: 300)).listen((event) {
      commentCubit.loadMore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List Comments")),
      body: BlocConsumer<CommentCubit, CommentState>(
        listener: (context, state) {
          final actionState = state.actionState;
          if (actionState is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Some thing wrong"),
              ),
            );
            ;
          }
        },
        builder: (context, state) {
          final actionState = state.actionState;
          if (actionState is LoadedState) {
            if (state.comments.isEmpty) {
              return const Center(child: Text('no data'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.comments.length
                    ? const BottomLoader()
                    : CommentItem(
                        commentEntity: state.comments[index],
                      );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: state.canLoadMore ? state.comments.length + 1 : state.comments.length,
              controller: _scrollController,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _loadMoreStream.close();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _loadMoreStream.add("loadMore");
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
