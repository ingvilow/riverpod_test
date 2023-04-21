import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_test/main.dart';
import 'package:riverpod_test/models/posts_model.dart';
import 'package:riverpod_test/pages/widget/date_and_emoji_picker.dart';
import 'package:riverpod_test/pages/widget/list_post_widget.dart';
import 'package:riverpod_test/repository/provider_database.dart';
import 'package:riverpod_test/repository/repository.dart';
import 'package:riverpod_test/theme/theme_color.dart';

final listsPosts = Provider((_) => Repository().posts);
final databaseProvider = StateNotifierProvider((ref) => DBProvider());

class HomePage extends HookConsumerWidget {
  HomePage({super.key});
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<PostsModel> value = ref.watch(listsPosts);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primaryColor,
        elevation: 0,
      ),
      backgroundColor: ThemeColors.primaryColor,
      body: ListPost(postsModel: value,)

      /*ListView.builder(
        itemCount: value.length,
        itemBuilder: (context, index) {
          return Card(
            color: ThemeColors.secondColor,
            child: InkWell(
              onTap: () {},
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
                  style:
                      TextStyle(fontFamily: "CormorantGaramond", fontSize: 16),
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
      )*/,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 3 / 4),
            backgroundColor: ThemeColors.secondColor,
            builder: (context) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        height: 100,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: ThemeColors.textFieldColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: _titleController,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Enter header',
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: ThemeColors.textFieldColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        controller: _textController,
                        maxLines: null,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Enter body',
                        ),
                      ),
                    ),
                  ),
                  DateAndEmojiPicker(),
                  ElevatedButton(
                      onPressed: () {
                        ref
                            .read(databaseProvider.notifier)
                            .addPosts(_titleController.text, _textController.text);
                        ref
                            .read(databaseProvider.notifier).getAllPosts();

                      },
                      child: Text("add"))
                ],
              );
            },
          );
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
