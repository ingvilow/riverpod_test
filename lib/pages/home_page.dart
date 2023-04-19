import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_test/main.dart';
import 'package:riverpod_test/models/posts_model.dart';
import 'package:riverpod_test/repository/repository.dart';
import 'package:riverpod_test/theme/theme_color.dart';

final listsPosts = Provider((_) => Repository().posts);

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<PostsModel> value = ref.watch(listsPosts);
    final func = ref.watch(repos);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primaryColor,
        elevation: 0,
      ),
      backgroundColor: ThemeColors.primaryColor,
      body: ListView.builder(
        itemCount: value.length,
        itemBuilder: (context, index) {
          return Card(
            color: ThemeColors.secondColor,
            child: InkWell(
              onTap: (){

              },
              child: ListTile(
                title: Text(
                  value[index].title ?? '',
                  style: TextStyle(
                      fontFamily: "CormorantGaramond",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  value[index].text ?? '',
                  style: TextStyle(fontFamily: "CormorantGaramond", fontSize: 16),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          func.showBottomSheet(context);
        },
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.edit,
                color: ThemeColors.iconsColor,
              ),
            ),
            Text(
              'Tap to write',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: "CormorantGaramond",
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        backgroundColor: ThemeColors.secondColor,
      ),
    );
  }
}
