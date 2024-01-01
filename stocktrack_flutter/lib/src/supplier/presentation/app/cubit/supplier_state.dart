part of 'supplier_cubit.dart';

/// Represents different states related to supplier.
///
/// Extends [Equatable] for equality comparison.
sealed class SupplierState extends Equatable {
  const SupplierState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of supplier-related operations.
final class SupplierInitial extends SupplierState {
  const SupplierInitial();
}

/// Represents the state when suppliers are being fetched.
final class GettingSuppliers extends SupplierState {
  const GettingSuppliers();
}

/// Represents the state when detail supplier are being fetched.
final class GettingDetailSupplier extends SupplierState {
  const GettingDetailSupplier();
}

/// Represents the state when supplier are being added.
final class AddingSupplier extends SupplierState {
  const AddingSupplier();
}

/// Represents the state when an supplier is being updated.
final class UpdatingSupplier extends SupplierState {
  const UpdatingSupplier();
}

/// Represents the state when an supplier is being deleted.
final class DeletingSupplier extends SupplierState {
  const DeletingSupplier();
}

/// Represents the state when suppliers have been successfully loaded.
final class SuppliersLoaded extends SupplierState {
  const SuppliersLoaded(this.supplierListResponse);

  final SupplierListResponse supplierListResponse;

  @override
  List<Object> get props => [supplierListResponse];
}

/// Represents the state when detail supplier have been successfully loaded.
final class SupplierDetailLoaded extends SupplierState {
  const SupplierDetailLoaded(this.supplierDetailResponse);

  final SupplierDetailResponse supplierDetailResponse;

  @override
  List<Object> get props => [supplierDetailResponse];
}

/// Represents the state when an supplier has been successfully added.
final class SupplierAdded extends SupplierState {
  const SupplierAdded(this.supplierCreateResponse);

  final SupplierCreateResponse supplierCreateResponse;

  @override
  List<Object> get props => [supplierCreateResponse];
}

/// Represents the state when an supplier has been successfully updated.
final class SupplierUpdated extends SupplierState {
  const SupplierUpdated(this.supplierUpdateResponse);

  final SupplierUpdateResponse supplierUpdateResponse;

  @override
  List<Object> get props => [supplierUpdateResponse];
}

/// Represents the state when an supplier has been successfully deleted.
final class SupplierDeleted extends SupplierState {
  const SupplierDeleted(this.supplierDeleteResponse);

  final SupplierDeleteResponse supplierDeleteResponse;

  @override
  List<Object> get props => [supplierDeleteResponse];
}

/// Represents the error state with an associated error message.
final class SupplierError extends SupplierState {
  const SupplierError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
