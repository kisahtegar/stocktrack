import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/src/item/presentation/refactors/item_body.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ItemBody(),
    );
  }
}
