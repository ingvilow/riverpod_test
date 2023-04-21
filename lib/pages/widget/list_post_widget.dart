import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_test/models/posts_model.dart';
import 'package:riverpod_test/repository/repository.dart' as r;

import 'package:riverpod_test/state/PostsState.dart';
import 'package:riverpod_test/theme/theme_color.dart';

import '../../repository/provider_database.dart';

final databaseState = FutureProvider.autoDispose<List<PostsModel>>((ref) {
  final sqlService = ref.watch(databaseProvider);
  return sqlService.allPosts();
});

class ListPost extends ConsumerWidget {
  List<PostsModel> postsModel;
  ListPost({Key? key, required this.postsModel}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<PostsModel>> postsState = ref.watch(databaseState);
    var refreshFunc = ref.watch(r.repos);
    return postsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) {
        return Text(err.toString());
      },
      data: (posts) => RefreshIndicator(
        onRefresh: () { return refreshFunc.refreshPosts(); },
        child: ListView.builder(
          itemCount: postsModel.length,
          itemBuilder: (context, index) {
            return Card(
              color: ThemeColors.secondColor,
              child: InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text(
                    postsModel[index].title ?? '',
                    style: const TextStyle(
                        fontFamily: "CormorantGaramond",
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    postsModel[index].text ?? '',
                    style: const TextStyle(
                        fontFamily: "CormorantGaramond", fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.favorite_outlined,
                      color: ThemeColors.iconsColor,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
