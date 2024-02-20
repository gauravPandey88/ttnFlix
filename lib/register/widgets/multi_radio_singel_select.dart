

import 'package:flutter/material.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';

class MultiRadioSingleSelectWidget extends StatefulWidget {
  const MultiRadioSingleSelectWidget(
      {required this.radioTitleList,
        this.axisDirection = Axis.horizontal,
        Key? key,
        this.textStyle,
        this.contentPadding,
        required this.onSelectedIndex,
        this.initialSelectedItem = -1})
      : super(key: key);

  final List<String> radioTitleList;
  final Axis axisDirection;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final void Function(int) onSelectedIndex;
  final int initialSelectedItem;

  @override
  State<MultiRadioSingleSelectWidget> createState() =>
      _MultiRadioSingleSelectWidgetState();
}

class _MultiRadioSingleSelectWidgetState
    extends State<MultiRadioSingleSelectWidget> {
  late int _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.initialSelectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.radioTitleList.map((radioItem) {
        return _RadioView(
          title: radioItem,
          padding: widget.contentPadding,
          context: context,
          value: widget.radioTitleList.indexOf(radioItem),
          onChanged: (selectedItem) {
            setState(() {
              _groupValue = selectedItem!;
              widget.onSelectedIndex(getOptionSelectedIndex(radioItem));
            });
          },
          groupValue: _groupValue,
        );
      }).toList(),
    );
  }

  int evaluateGroupValue({required int currentIndex}) {
    _groupValue == currentIndex;
    return -1;
  }

  int getOptionSelectedIndex(String title) {
    return widget.radioTitleList.indexOf(title);
  }
}

class _RadioView extends StatelessWidget {
  const _RadioView({
    required this.title,
    required this.context,
    required int groupValue,
    required this.padding,
    required this.onChanged,
    required this.value,
  }) : _groupValue = groupValue;

  final EdgeInsets? padding;
  final String title;
  final int value;
  final BuildContext context;
  final int _groupValue;
  final void Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
          //  activeColor: TtnflixColors.whiteGlow,
            fillColor: MaterialStateColor.resolveWith((states) => TtnflixColors.titleColor.platformBrightnessColor(context)!),
            value: value,
            groupValue: _groupValue,
            onChanged: onChanged,
          ),
          Padding(
            padding: const EdgeInsets.only(left: TtnflixSpacing.spacing16),
            child: Text(title,
                style: TtnFlixTextStyle.defaultTextTheme.bodyLarge?.copyWith(
                    color: TtnflixColors.titleColor.platformBrightnessColor(context)),
          ),
          ),
        ],
      ),
    );
  }
}