import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/src/supplier/presentation/refactors/supplier_body.dart';
import 'package:stocktrack_flutter/src/supplier/presentation/refactors/supplier_header.dart';

class SupplierView extends StatelessWidget {
  const SupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: const [
            SupplierHeader(),
            SupplierBody(),
          ],
        ),
      ),
    );
  }
}
