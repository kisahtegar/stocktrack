import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';
import 'package:stocktrack_flutter/core/res/fonts.dart';

class ItemHeader extends StatelessWidget {
  const ItemHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'List of Item',
      style: OpenSans.bold.copyWith(
        fontSize: 32,
        color: Colours.textColour,
      ),
    );
  }
}
