import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_test/repository/repository.dart';
import 'package:riverpod_test/theme/theme_color.dart';

class DateAndEmojiPicker extends HookConsumerWidget {
  const DateAndEmojiPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datePicker = ref.watch(reactRepo);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          splashRadius: 30.0,
          splashColor: ThemeColors.primaryColor,
          onPressed: () {
            datePicker.selecteDatePicker(context);
          },
          icon: Icon(
            Icons.calendar_month_rounded,
            color: ThemeColors.iconsColor,
            size: 28,
          ),
        ),
        IconButton(
          splashRadius: 30.0,
          splashColor: ThemeColors.primaryColor,
          onPressed: () {},
          icon: Icon(
            Icons.access_alarm_rounded,
            color: ThemeColors.iconsColor,
            size: 28,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ThemeColors.primaryColor,
          ),
          height: 30,
          width: 100,
          child:  Center(child: Text(datePicker.getFormattedDate(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
        )
      ],
    );
  }
}
