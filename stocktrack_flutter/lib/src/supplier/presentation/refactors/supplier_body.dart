// ignore_for_file: lines_longer_than_80_chars

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
  SupplierItem? _detailedSupplier;

  void _getSuppliers({SupplierListRequest? request}) {
    context
        .read<SupplierCubit>()
        .getSuppliers(request ?? const SupplierListRequest());
  }

  // This could navigate to a detailed view or show a dialog with details
  void _getDetailSupplier({SupplierDetailRequest? request}) {
    context
        .read<SupplierCubit>()
        .getDetailSupplier(request ?? const SupplierDetailRequest());
  }

  // This could navigate to a detailed view or show a dialog with details
  void _deleteSupplier({SupplierDeleteRequest? request}) {
    context
        .read<SupplierCubit>()
        .deleteSupplier(request ?? const SupplierDeleteRequest());
  }

  /// Widget that display dialog article.
  Future<void> _showAddOrUpdateSupplier({
    SupplierUpdateRequest? supplierUpdateRequest,
  }) async {
    final supplierCodeController = TextEditingController();
    final supplierNameController = TextEditingController();
    final addressController = TextEditingController();
    final contactController = TextEditingController();
    final isActiveController = TextEditingController();

    // Checking supplier.
    if (supplierUpdateRequest != null) {
      supplierCodeController.text = supplierUpdateRequest.supplierCode!;
      supplierNameController.text = supplierUpdateRequest.supplierName!;
      addressController.text = supplierUpdateRequest.address!;
      contactController.text = supplierUpdateRequest.contact!;
      isActiveController.text = supplierUpdateRequest.isActive.toString();
    }

    // Show dialog.
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  supplierUpdateRequest != null
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
                          int? isActive;

                          // Try parsing the text to an integer
                          final parsedValue = int.tryParse(
                            isActiveController.text,
                          );
                          // Check if parsing was successful
                          if (parsedValue != null) {
                            // Assign the parsed value to isActive
                            isActive = parsedValue;
                          } else {
                            debugPrint('Invalid integer value for isActive');
                          }

                          if (supplierUpdateRequest != null) {
                            context.read<SupplierCubit>().updateSupplier(
                                  SupplierUpdateRequest(
                                    supplierId:
                                        supplierUpdateRequest.supplierId,
                                    supplierCode: supplierCodeController.text,
                                    supplierName: supplierNameController.text,
                                    address: addressController.text,
                                    contact: contactController.text,
                                    isActive: isActive,
                                  ),
                                );

                            Navigator.of(context).pop();
                          } else {
                            // Call the cubit to addSupplier
                            context.read<SupplierCubit>().addSupplier(
                                  SupplierCreateRequest(
                                    supplierCode: supplierCodeController.text,
                                    supplierName: supplierNameController.text,
                                    address: addressController.text,
                                    contact: contactController.text,
                                    isActive: isActive,
                                  ),
                                );

                            // Pop widget form.
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

  void _showDetailSupplier({SupplierItem? response}) {
    setState(() {
      _detailedSupplier = response;
    });

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supplier Details'),
        content: Text(
          'Supplier ID: ${_detailedSupplier?.supplierId}\n'
          'Supplier Code: ${_detailedSupplier?.supplierCode}\n'
          'Supplier Name: ${_detailedSupplier?.supplierName}\n'
          'Address: ${_detailedSupplier?.address}\n'
          'Contact: ${_detailedSupplier?.contact}\n'
          'IsActive: ${_detailedSupplier?.isActive}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
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
          _getSuppliers();
        } else if (state is SupplierAdded) {
          debugPrint(
            'SupplierBody: SupplierAdded{${state.supplierCreateResponse.message}}',
          );
          CoreUtils.showSnackBar(
            context,
            state.supplierCreateResponse.message ?? 'Added',
          );
          // Fetch suppliers again after adding a new one.
          _getSuppliers();
        } else if (state is SupplierDetailLoaded) {
          debugPrint(
            'SupplierBody: SupplierDetailLoaded{${state.supplierDetailResponse.message}}',
          );

          final response = state.supplierDetailResponse.data;
          _showDetailSupplier(response: response);
          _getSuppliers();
        } else if (state is SupplierDeleted) {
          debugPrint(
            'SupplierBody: SupplierAdded{${state.supplierDeleteResponse.message}}',
          );
          CoreUtils.showSnackBar(
            context,
            state.supplierDeleteResponse.message ?? 'Deleted',
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
                    onPressed: _showAddOrUpdateSupplier,
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
                    DataColumn(label: Text('Action')),
                  ],
                  source: _SupplierDataSorce(
                    data: suppliers ?? [],
                    onView: (request) => _getDetailSupplier(request: request),
                    onEdit: (request) => _showAddOrUpdateSupplier(
                      supplierUpdateRequest: request,
                    ),
                    onDelete: (request) => _deleteSupplier(request: request),
                  ),
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
  _SupplierDataSorce({
    required this.data,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  final List<SupplierItem> data;
  final void Function(SupplierDetailRequest) onView;
  final void Function(SupplierUpdateRequest) onEdit;
  final void Function(SupplierDeleteRequest) onDelete;

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
                item.isActive == 1 ? 'Active' : 'InActive',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        DataCell(
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'view',
                child: ListTile(
                  leading: Icon(Icons.visibility),
                  title: Text('View'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                ),
              ),
            ],
            onSelected: (String value) {
              // Handle the selected action
              switch (value) {
                case 'view':
                  onView(
                    SupplierDetailRequest(supplierCode: item.supplierCode),
                  );
                case 'edit':
                  onEdit(
                    SupplierUpdateRequest(
                      supplierId: item.supplierId,
                      supplierCode: item.supplierCode,
                      supplierName: item.supplierName,
                      address: item.address,
                      contact: item.contact,
                      isActive: item.isActive,
                    ),
                  );
                case 'delete':
                  onDelete(
                    SupplierDeleteRequest(supplierCode: item.supplierCode),
                  );
              }
            },
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
