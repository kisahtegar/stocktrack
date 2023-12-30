import 'package:equatable/equatable.dart';

/// Represents a supplier entity with details such as ID, code, name, address,
/// contact information, and active status.
class SupplierItem extends Equatable {
  /// Constructs a [SupplierItem] with the provided details.
  const SupplierItem({
    this.supplierId,
    this.supplierCode,
    this.supplierName,
    this.address,
    this.contact,
    this.isActive,
  });

  /// The unique identifier for the supplier.
  final int? supplierId;

  /// The unique code assigned to the supplier.
  final String? supplierCode;

  /// The name of the supplier.
  final String? supplierName;

  /// The address of the supplier.
  final String? address;

  /// The contact information for the supplier.
  final String? contact;

  /// The active status of the supplier.
  final int? isActive;

  /// Overrides the `props` method to provide a list of object properties that
  /// should be considered when determining the equality of two `SupplierItem`
  /// instances.
  @override
  List<Object?> get props => [supplierId];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierItem` instance.
  @override
  String toString() {
    return 'SupplierItem{supplierId: $supplierId, supplierCode: $supplierCode,'
        ' supplierName: $supplierName, address: $address, contact: $contact}';
  }
}

/// Represents pagination data with details such as total data, total page,
/// current page, and limit.
class PaginationData extends Equatable {
  /// Constructs a [PaginationData] instance with the provided details.
  const PaginationData({
    this.totalData,
    this.totalPage,
    this.page,
    this.limit,
  });

  /// The total number of data entries available.
  final int? totalData;

  /// The total number of pages based on the available data and page limit.
  final int? totalPage;

  /// The current page being displayed.
  final int? page;

  /// The maximum number of entries per page.
  final int? limit;

  /// Overrides the `props` method to provide a list of object properties that
  /// should be considered when determining the equality of two `PaginationData`
  /// instances.
  @override
  List<Object?> get props => [totalData, totalPage, page, limit];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `PaginationData` instance.
  @override
  String toString() {
    return 'PaginationData{totalData: $totalData, totalPage: $totalPage, '
        'page: $page, limit: $limit}';
  }
}

/// Represents a response containing a list of suppliers and pagination
/// information.
class SupplierListResponse extends Equatable {
  /// Constructs a [SupplierListResponse] with the provided details.
  const SupplierListResponse({
    this.code,
    this.message,
    this.data,
    this.paginationData,
  });

  /// The HTTP status code of the response.
  final String? code;

  /// A message providing information about the response status.
  final String? message;

  /// The list of [SupplierItem]s.
  final List<SupplierItem>? data;

  /// The pagination information for the list of suppliers.
  final PaginationData? paginationData;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierListResponse` instances.
  @override
  List<Object?> get props => [code, message, data, paginationData];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierListResponse` instance.
  @override
  String toString() {
    return 'SupplierListResponse{code: $code, message: $message, data: $data, '
        'paginationData: $paginationData}';
  }
}

/// Represents a response containing details of a specific supplier.
class SupplierDetailResponse extends Equatable {
  /// Constructs a [SupplierDetailResponse] with the provided details.
  const SupplierDetailResponse({
    this.code,
    this.message,
    this.data,
  });

  /// The HTTP status code of the response.
  final String? code;

  /// A message providing information about the response status.
  final String? message;

  /// The details of a specific supplier.
  final SupplierItem? data;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierDetailResponse` instances.
  @override
  List<Object?> get props => [code, message, data];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierDetailResponse` instance.
  @override
  String toString() {
    return 'SupplierDetailResponse{code: $code, message: $message, data: $data'
        '}';
  }
}

/// Represents a response for creating a new supplier.
class SupplierCreateResponse extends Equatable {
  /// Constructs a [SupplierCreateResponse] with the provided details.
  const SupplierCreateResponse({
    this.code,
    this.message,
    this.error,
  });

  /// The HTTP status code of the response.
  final String? code;

  /// A message providing information about the response status.
  final String? message;

  /// An error message in case of an unsuccessful creation attempt.
  final String? error;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierCreateResponse` instances.
  @override
  List<Object?> get props => [code, message, error];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierCreateResponse` instance.
  @override
  String toString() {
    return 'SupplierCreateResponse{code: $code, message: $message, data: $error'
        '}';
  }
}

/// Represents a response for updating an existing supplier.
class SupplierUpdateResponse extends Equatable {
  /// Constructs a [SupplierUpdateResponse] with the provided details.
  const SupplierUpdateResponse({
    this.code,
    this.message,
    this.error,
  });

  /// The HTTP status code of the response.
  final String? code;

  /// A message providing information about the response status.
  final String? message;

  /// An error message in case of an unsuccessful creation attempt.
  final String? error;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierUpdateResponse` instances.
  @override
  List<Object?> get props => [code, message, error];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierUpdateResponse` instance.
  @override
  String toString() {
    return 'SupplierUpdateResponse{code: $code, message: $message, data: $error'
        '}';
  }
}

/// Represents a response for deleting a supplier.
class SupplierDeleteResponse extends Equatable {
  /// Constructs a [SupplierDeleteResponse] with the provided details.
  const SupplierDeleteResponse({
    this.code,
    this.message,
    this.error,
  });

  /// The HTTP status code of the response.
  final String? code;

  /// A message providing information about the response status.
  final String? message;

  /// An error message in case of an unsuccessful creation attempt.
  final String? error;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierDeleteResponse` instances.
  @override
  List<Object?> get props => [code, message, error];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierDeleteResponse` instance.
  @override
  String toString() {
    return 'SupplierDeleteResponse{code: $code, message: $message, data: $error'
        '}';
  }
}
