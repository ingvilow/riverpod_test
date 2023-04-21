import 'package:riverpod_test/models/posts_model.dart';

abstract class PostsState {
  PostsState();
}

class PostsInitial extends PostsState {
  PostsInitial();
}

class PostsLoading extends PostsState {
  PostsLoading();
}

class PostsLoaded extends PostsState {
  PostsLoaded({
    required this.posts,
  });

  final List<PostsModel> posts;
}

class OnePostAdded extends PostsState{
  OnePostAdded({required this.postsModel});
  final PostsModel postsModel;
}

class PostsEmpty extends PostsState {
  PostsEmpty();
}

class PostsFailure extends PostsState {
  PostsFailure();
}

class PostsSuccess extends PostsState {
  PostsSuccess();
}