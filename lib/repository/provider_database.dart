import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_test/models/posts_model.dart';
import 'package:riverpod_test/repository/repository.dart';
import 'package:riverpod_test/sqlService/sql_service.dart';
import 'package:riverpod_test/state/PostsState.dart';

final databaseProvider = Provider((ref) => SQLService());
final reposPosts = Provider((ref) => Repository());

class DBProvider extends StateNotifier<PostsState> {


  SQLService sqlService = SQLService();

  DBProvider(): super(PostsInitial());


  Future<PostsState> getAllPosts() async {
    await sqlService.initializeDB();
    state = PostsLoading();
    try {
      final posts = await sqlService.allPosts();
      if (posts!.isEmpty) {
        state = PostsEmpty();
      } else {
        state = PostsLoaded(posts: posts);
      }
    } catch (e) {
      state = PostsFailure();
      throw Exception("Error while retrieving posts: $e");
    }
    return state;
  }


  Future<PostsState>? addPosts(String text, String title) async {
    await sqlService.initializeDB();
    state = PostsLoading();
    PostsModel postsModel = PostsModel(title: title, text: text, id: 0);
    try {
      var posts = await sqlService.insertPosts(postsModel);
      if (text.isEmpty && title.isEmpty) {
        state = PostsFailure();
      } else {
        state = PostsSuccess();
        state = OnePostAdded(postsModel: posts);
      }
    } catch (e) {
      state = PostsFailure();
    }
    return state;
  }


  Future<void> deletePosts(int id) async {
    try {
      await sqlService.deletePosts(id);
      state = PostsSuccess();;
      getAllPosts();
    } catch (e) {
      state = PostsFailure();
      throw Exception();
    }
    throw Exception("unhandeled");
  }
}

