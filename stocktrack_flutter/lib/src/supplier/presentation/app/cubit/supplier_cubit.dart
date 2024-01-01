import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';
import 'package:stocktrack_flutter/src/supplier/domain/usecases/add_supplier.dart';
import 'package:stocktrack_flutter/src/supplier/domain/usecases/delete_supplier.dart';
import 'package:stocktrack_flutter/src/supplier/domain/usecases/get_detail_supplier.dart';
import 'package:stocktrack_flutter/src/supplier/domain/usecases/get_suppliers.dart';
import 'package:stocktrack_flutter/src/supplier/domain/usecases/update_supplier.dart';

part 'supplier_state.dart';

/// A Cubit for managing the state related to supplier operations.
class SupplierCubit extends Cubit<SupplierState> {
  SupplierCubit({
    required AddSupplier addSupplier,
    required DeleteSupplier deleteSupplier,
    required GetDetailSupplier getDetailSupplier,
    required GetSuppliers getSuppliers,
    required UpdateSupplier updateSupplier,
  })  : _addSupplier = addSupplier,
        _deleteSupplier = deleteSupplier,
        _getDetailSupplier = getDetailSupplier,
        _getSuppliers = getSuppliers,
        _updateSupplier = updateSupplier,
        super(const SupplierInitial());

  final AddSupplier _addSupplier;
  final DeleteSupplier _deleteSupplier;
  final GetDetailSupplier _getDetailSupplier;
  final GetSuppliers _getSuppliers;
  final UpdateSupplier _updateSupplier;

  /// Adds a new supplier with the provided request.
  Future<void> addSupplier(SupplierCreateRequest request) async {
    emit(const AddingSupplier());
    final result = await _addSupplier(request);
    result.fold(
      (failure) => emit(SupplierError(failure.errorMessage)),
      (response) => emit(SupplierAdded(response)),
    );
  }

  /// Deletes a supplier with the provided request.
  Future<void> deleteSupplier(SupplierDeleteRequest request) async {
    emit(const DeletingSupplier());
    final result = await _deleteSupplier(request);
    result.fold(
      (failure) => emit(SupplierError(failure.errorMessage)),
      (response) => emit(SupplierDeleted(response)),
    );
  }

  /// Fetches details of a specific supplier with the provided request.
  Future<void> getDetailSupplier(SupplierDetailRequest request) async {
    emit(const GettingDetailSupplier());
    final result = await _getDetailSupplier(request);
    result.fold(
      (failure) => emit(SupplierError(failure.errorMessage)),
      (response) => emit(SupplierDetailLoaded(response)),
    );
  }

  /// Fetches a list of suppliers with the provided request.
  Future<void> getSuppliers(SupplierListRequest request) async {
    emit(const GettingSuppliers());
    final result = await _getSuppliers(request);
    result.fold(
      (failure) => emit(SupplierError(failure.errorMessage)),
      (response) => emit(SuppliersLoaded(response)),
    );
  }

  /// Updates an existing supplier with the provided request.
  Future<void> updateSupplier(SupplierUpdateRequest request) async {
    emit(const UpdatingSupplier());
    final result = await _updateSupplier(request);
    result.fold(
      (failure) => emit(SupplierError(failure.errorMessage)),
      (response) => emit(SupplierUpdated(response)),
    );
  }
}
