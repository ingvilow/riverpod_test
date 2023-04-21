import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_test/models/posts_model.dart';
import 'package:riverpod_test/pages/widget/date_and_emoji_picker.dart';
import 'package:riverpod_test/repository/provider_database.dart';
import 'package:riverpod_test/theme/theme_color.dart';

import '../sqlService/sql_service.dart';

final repos = Provider((ref) => Repository());
final reactRepo = ChangeNotifierProvider((ref) => Repository());
final databaseProvider = StateNotifierProvider((ref) => DBProvider());
class Repository extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
   SQLService sqlService = SQLService();
  List<PostsModel> posts = [
    PostsModel(
        title: 'Lorem ipsum dolor sit amet',
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
        id: 0,
       ),
    PostsModel(
        title: 'Lorem ipsum',
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ',
        id: 1,
        ),
    PostsModel(
        title: 'de Finibus Bonorum et Malorum',
        text:
            'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium ',
        id: 2,
        ),
    PostsModel(
        title: '1.10.33 "de Finibus Bonorum et Malorum',
        text:
            'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis ',
        id: 3,
        ),
    PostsModel(
        title: '1914 years, H. Rackham',
        text:
            'On the other hand, we denounce with righteous indignation and dislike men ',
        id: 4,
       ),
  ];


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
  Future<void> refreshPosts() async{
    var posts = await sqlService.allPosts();
      posts = posts;
      notifyListeners();
  }
}
