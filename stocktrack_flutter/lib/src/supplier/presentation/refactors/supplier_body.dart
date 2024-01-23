import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocktrack_flutter/core/common/views/loading_view.dart';
import 'package:stocktrack_flutter/core/common/widgets/input_data_widget.dart';
import 'package:stocktrack_flutter/core/common/widgets/not_found_text.dart';
import 'package:stocktrack_flutter/core/common/widgets/rounded_button.dart';
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

  void _getSuppliers({SupplierListRequest? request}) {
    context
        .read<SupplierCubit>()
        .getSuppliers(request ?? const SupplierListRequest());
  }

  void _addSupplier({SupplierCreateRequest? request}) {
    context
        .read<SupplierCubit>()
        .addSupplier(request ?? const SupplierCreateRequest());
  }

  void _updateSupplier({SupplierUpdateRequest? request}) {
    context
        .read<SupplierCubit>()
        .updateSupplier(request ?? const SupplierUpdateRequest());
  }

  /// Widget that display dialog article.
  Future<void> _showSupplierItemDialog({SupplierItem? supplierItem}) async {
    final supplierCodeController = TextEditingController();
    final supplierNameController = TextEditingController();
    final addressController = TextEditingController();
    final contactController = TextEditingController();
    final isActiveController = TextEditingController();

    // Checking supplier.
    if (supplierItem != null) {
      supplierCodeController.text = supplierItem.supplierCode!;
      supplierNameController.text = supplierItem.supplierName!;
      addressController.text = supplierItem.address!;
      contactController.text = supplierItem.contact!;
      isActiveController.text = supplierItem.isActive.toString();
    }

    // Show dialog.
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  supplierItem != null
                      ? 'Update Supplier Data'
                      : 'Input Supplier Data',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                InputDataWidget(
                  inputDataController: supplierCodeController,
                  namaData: 'Supplier Code',
                  hintText: 'Input supplier code',
                  maxLength: 10,
                ),
                const Divider(),
                InputDataWidget(
                  inputDataController: supplierNameController,
                  namaData: 'Supplier Name',
                  hintText: 'Input supplier name',
                  maxLength: 50,
                ),
                InputDataWidget(
                  inputDataController: addressController,
                  namaData: 'Address',
                  hintText: 'Input address',
                  maxLength: 50,
                ),
                InputDataWidget(
                  inputDataController: contactController,
                  namaData: 'Contact',
                  hintText: 'Input contact',
                  maxLength: 15,
                ),
                InputDataWidget(
                  inputDataController: isActiveController,
                  namaData: 'Status',
                  hintText: 'Input address',
                  maxLength: 1,
                ),
                const Divider(),
                const SizedBox(height: 50),
                Row(
                  children: [
                    // Button: Save button.
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (supplierItem != null) {
                            _updateSupplier(
                              request: SupplierUpdateRequest(
                                // TODO(kisahtegar): Need to use supplierId
                                supplierCode: supplierCodeController.text,
                                supplierName: supplierNameController.text,
                                address: addressController.text,
                                contact: contactController.text,
                                isActive: isActiveController.text as int,
                              ),
                            );
                            Navigator.of(context).pop();
                          } else {
                            int? isActive;

                            // Try parsing the text to an integer
                            final parsedValue =
                                int.tryParse(isActiveController.text);
                            // Check if parsing was successful
                            if (parsedValue != null) {
                              // Assign the parsed value to isActive
                              isActive = parsedValue;
                            } else {
                              print('Invalid integer value for isActive');
                            }
                            _addSupplier(
                              request: SupplierCreateRequest(
                                supplierCode: supplierCodeController.text,
                                supplierName: supplierNameController.text,
                                address: addressController.text,
                                contact: contactController.text,
                                isActive: isActive,
                              ),
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save_alt_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Save',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Button: Cancel button.
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            Text(
                              'Exit',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('===> SupplierBody: Running...');
    return BlocConsumer<SupplierCubit, SupplierState>(
      listener: (_, state) {
        if (state is SupplierError) {
          debugPrint('SupplierBody: SupplierError{${state.message}}');
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is SupplierAdded) {
          debugPrint(
            // ignore: lines_longer_than_80_chars
            'SupplierBody: SupplierAdded{${state.supplierCreateResponse.message}}',
          );
          CoreUtils.showSnackBar(
            context,
            state.supplierCreateResponse.message ?? 'Added',
          );
          // Fetch suppliers again after adding a new one.
          _getSuppliers();
        }
      },
      builder: (context, state) {
        if (state is GettingSuppliers || state is AddingSupplier) {
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
                    onPressed: _showSupplierItemDialog,
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
        DataCell(
          Container(
            width: 70,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: item.isActive == 1
                  ? const Color.fromARGB(255, 56, 129, 58)
                  : const Color.fromARGB(255, 161, 45, 37),
            ),
            child: Center(
              child: Text(
                item.isActive == 1 ? 'active' : 'InActive',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
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
