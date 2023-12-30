import 'package:equatable/equatable.dart';

/// Represents a request for fetching a list of suppliers with optional
/// parameters such as page, limit, and search criteria.
class SupplierListRequest extends Equatable {
  /// Constructs a [SupplierListRequest] instance with the provided details.
  const SupplierListRequest({
    this.page,
    this.limit,
    this.search,
  });

  /// The page number for paginated results.
  final int? page;

  /// The maximum number of items to return per page.
  final int? limit;

  /// Search criteria to filter the list of suppliers.
  final String? search;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierListRequest` instances.
  @override
  List<Object?> get props => [page, limit, search];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierListRequest` instance.
  @override
  String toString() {
    return 'SupplierListRequest{page: $page, limit: $limit, search: $search}';
  }
}

/// Represents a request for fetching details of a specific supplier identified
/// by the supplier code.
class SupplierDetailRequest extends Equatable {
  /// Constructs a [SupplierDetailRequest] instance with the provided details.
  const SupplierDetailRequest({
    this.supplierCode,
  });

  /// The unique identifier for the supplier.
  final String? supplierCode;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierDetailRequest` instances.
  @override
  List<Object?> get props => [supplierCode];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierDetailRequest` instance.
  @override
  String toString() {
    return 'SupplierDetailRequest{supplierCode: $supplierCode';
  }
}

/// Represents a request for creating a new supplier with details such as code,
/// name, address, contact information, and active status.
class SupplierCreateRequest extends Equatable {
  /// Constructs a [SupplierCreateRequest] instance with the provided details.
  const SupplierCreateRequest({
    this.supplierCode,
    this.supplierName,
    this.address,
    this.contact,
    this.isActive,
  });

  /// The unique code for the new supplier.
  final String? supplierCode;

  /// The name of the new supplier.
  final String? supplierName;

  /// The address of the new supplier.
  final String? address;

  /// The contact information for the new supplier.
  final String? contact;

  /// The active status of the new supplier.
  final int? isActive;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierCreateRequest` instances.
  @override
  List<Object?> get props => [supplierCode];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierCreateRequest` instance.
  @override
  String toString() {
    return 'SupplierCreateRequest{supplierCode: $supplierCode, supplierName: '
        '$supplierName, address: $address, contact: $contact, isActive: '
        '$isActive}';
  }
}

/// Represents a request for updating an existing supplier identified by the
/// supplier ID, with details such as code, name, address, contact information,
/// and active status.
class SupplierUpdateRequest extends Equatable {
  /// Constructs a [SupplierUpdateRequest] instance with the provided details.
  const SupplierUpdateRequest({
    this.supplierId,
    this.supplierCode,
    this.supplierName,
    this.address,
    this.contact,
    this.isActive,
  });

  /// The unique identifier for the existing supplier.
  final int? supplierId;

  /// The unique code for the supplier.
  final String? supplierCode;

  /// The updated name of the supplier.
  final String? supplierName;

  /// The updated address of the supplier.
  final String? address;

  /// The updated contact information for the supplier.
  final String? contact;

  /// The updated active status of the supplier.
  final int? isActive;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierUpdateRequest` instances.
  @override
  List<Object?> get props => [supplierId];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierUpdateRequest` instance.
  @override
  String toString() {
    return 'SupplierUpdateRequest{supplierId: $supplierId, supplierCode: '
        '$supplierCode,supplierName: $supplierName, address: $address, '
        'contact: $contact, isActive: $isActive}';
  }
}

/// Represents a request for deleting a supplier identified by the supplier
/// code.
class SupplierDeleteRequest extends Equatable {
  /// Constructs a [SupplierDeleteRequest] instance with the provided details.
  const SupplierDeleteRequest({
    this.supplierCode,
  });

  /// The unique identifier for the supplier to be deleted.
  final String? supplierCode;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierDeleteRequest` instances.
  @override
  List<Object?> get props => [supplierCode];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierDeleteRequest` instance.
  @override
  String toString() {
    return 'SupplierDeleteRequest{supplierCode: $supplierCode';
  }
}
