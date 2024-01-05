import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocktrack_flutter/core/common/views/loading_view.dart';
import 'package:stocktrack_flutter/core/common/widgets/not_found_text.dart';
import 'package:stocktrack_flutter/core/common/widgets/rounded_button.dart';
import 'package:stocktrack_flutter/core/extensions/context_extension.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';
import 'package:stocktrack_flutter/core/utils/core_utils.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';
import 'package:stocktrack_flutter/src/supplier/presentation/app/cubit/supplier_cubit.dart';

class SupplierBody extends StatefulWidget {
  const SupplierBody({super.key});

  @override
  State<SupplierBody> createState() => _SupplierBodyState();
}

class _SupplierBodyState extends State<SupplierBody> {
  final int _pageSize = 10;

  void getSuppliers({SupplierListRequest? request}) {
    context
        .read<SupplierCubit>()
        .getSuppliers(request ?? const SupplierListRequest());
  }

  @override
  void initState() {
    super.initState();
    getSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('===> SupplierBody: Running...');
    return BlocConsumer<SupplierCubit, SupplierState>(
      listener: (_, state) {
        if (state is SupplierError) {
          debugPrint('SupplierBody: SupplierError{${state.message}}');
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is GettingSuppliers) {
          return const LoadingView();
        } else if (state is SuppliersLoaded &&
                state.supplierListResponse.data!.isEmpty ||
            state is SupplierError) {
          return const NotFoundText(
            'No suppliers found\nTry to add a new supplier.',
          );
        } else if (state is SuppliersLoaded) {
          final suppliers = state.supplierListResponse.data;

          return Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('List of Supplier'),
                  RoundedButton(
                    label: 'Create',
                    minimumSize: const Size(10, 10),
                    buttonColour: Colours.greenColour,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: PaginatedDataTable(
                  headingRowHeight: 25,
                  dataRowMinHeight: 35,
                  dataRowMaxHeight: 40,
                  rowsPerPage: _pageSize,
                  horizontalMargin: 20,
                  // headingRowColor: MaterialStateColor.resolveWith(
                  //   (states) => Colors.black,
                  // ),
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Supplier Code')),
                    DataColumn(label: Text('Supplier Name')),
                    DataColumn(label: Text('address')),
                    DataColumn(label: Text('Contact')),
                    DataColumn(label: Text('IsActive')),
                  ],
                  source: _SupplierDataSorce(data: suppliers ?? []),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _SupplierDataSorce extends DataTableSource {
  _SupplierDataSorce({required this.data});

  final List<SupplierItem> data;

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
      cells: [
        DataCell(Text(item.supplierId.toString())),
        DataCell(Text(item.supplierCode ?? '')),
        DataCell(Text(item.supplierName ?? '')),
        DataCell(Text(item.address ?? '')),
        DataCell(Text(item.contact ?? '')),
        DataCell(Text(item.isActive.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
