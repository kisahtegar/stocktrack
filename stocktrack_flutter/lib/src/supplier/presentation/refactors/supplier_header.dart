import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';
import 'package:stocktrack_flutter/core/res/fonts.dart';

class SupplierHeader extends StatelessWidget {
  const SupplierHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'List of Supplier',
      style: OpenSans.bold.copyWith(
        fontSize: 32,
        color: Colours.textColour,
      ),
    );
  }
}
