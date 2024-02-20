import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';

class DatePicker {
  final BuildContext context;
  final String dateFormat;
  final ValueChanged<String>? date;

  DatePicker(this.context, {this.dateFormat = 'yyyy-MM-dd', this.date});

  void show() async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime
          .now()
          .year - 100),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: TtnflixColors.frozenListYellow
                      .platformBrightnessColor(context) ?? Colors.amber, // <-- SEE HERE
                ),
             textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
            foregroundColor: TtnflixColors.textBlackColor.platformBrightnessColor(context), // button text color
            ),
        ),
            ),
        child: child!,);
        
      }
    );
    if (pickedDate != null) {
      String formattedDate =
      DateFormat(dateFormat).format(pickedDate);
      if (date != null) {
        date!(formattedDate);
      }
    }
  }
}
