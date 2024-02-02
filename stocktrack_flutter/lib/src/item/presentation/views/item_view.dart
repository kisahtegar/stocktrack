import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/src/item/presentation/refactors/item_body.dart';
import 'package:stocktrack_flutter/src/item/presentation/refactors/item_header.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: const [
            ItemHeader(),
            ItemBody(),
          ],
        ),
      ),
    );
  }
}
