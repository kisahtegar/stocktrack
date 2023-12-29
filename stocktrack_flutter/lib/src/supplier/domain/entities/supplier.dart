// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SupplierItem extends Equatable {
  const SupplierItem({
    this.supplierId,
    this.supplierCode,
    this.supplierName,
    this.address,
    this.contact,
    this.isActive,
  });

  const SupplierItem.empty()
      : this(
          supplierId: 0,
          supplierCode: '_empty.supplierCode',
          supplierName: '_empty.supplierName',
          address: '_empty.name',
          contact: '_empty.contact',
        );

  final int? supplierId;
  final String? supplierCode;
  final String? supplierName;
  final String? address;
  final String? contact;
  final int? isActive;

  @override
  List<Object?> get props => [supplierId];

  @override
  String toString() {
    return 'SupplierItem{supplierId:, $supplierId, supplierCode: $supplierCode,'
        ' supplierName: $supplierName, address: $address, contact: $contact}';
  }
}

class SupplierRequest extends Equatable {
  const SupplierRequest({
    this.token,
  });

  final String? token;
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
