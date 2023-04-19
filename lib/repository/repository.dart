import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_test/models/posts_model.dart';
import 'package:riverpod_test/pages/widget/date_and_emoji_picker.dart';
import 'package:riverpod_test/theme/theme_color.dart';

final repos = Provider((ref) => Repository());
final reactRepo = ChangeNotifierProvider((ref) => Repository());

class Repository extends ChangeNotifier {
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  DateTime selectedDate = DateTime.now();


  List<PostsModel> posts = [
    PostsModel(
        title: 'Lorem ipsum dolor sit amet',
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
        id: 0,
        creator: 'Creator One'),
    PostsModel(
        title: 'Lorem ipsum',
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ',
        id: 1,
        creator: 'creator1'),
    PostsModel(
        title: 'de Finibus Bonorum et Malorum',
        text:
            'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium ',
        id: 2,
        creator: 'creator1'),
    PostsModel(
        title: '1.10.33 "de Finibus Bonorum et Malorum',
        text:
            'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis ',
        id: 3,
        creator: 'creator1'),
    PostsModel(
        title: '1914 года, H. Rackham',
        text:
            'On the other hand, we denounce with righteous indignation and dislike men ',
        id: 4,
        creator: 'creator1'),
  ];

  Future<void> showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 3 / 4),
      backgroundColor: ThemeColors.secondColor,
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                  height: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            DateAndEmojiPicker()
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> selecteDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1920),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      notifyListeners();
    }
  }

  String getFormattedDate() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(selectedDate);
    return formatted;
  }
}
