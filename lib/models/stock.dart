import 'package:flutter/material.dart';

class Stock {
  ///product variables
  int id;
  String name;
  double unitValue;
  int productId;
  int unitId;
  int quantity;
  int supplierId;
  bool status;
  bool selected;

  Stock({
    @required this.name,
    @required this.id,
    @required this.productId,
    @required this.supplierId,
    @required this.unitValue,
    @required this.status,
    @required this.unitId,
    @required this.quantity,
    this.selected = false,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'unitId': unitId,
      'name': name,
      'supplierId': supplierId,
      'unitValue': unitValue,
      'status': status,
      'productId': productId,
      'quantity': quantity,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Stock.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        productId = map['productId'],
        unitValue = double.parse(map['unitValue'].toString()),
        name = map['name'],
        supplierId = map['supplierId'],
        status = map['status'] == 1 ? true : false,
        selected = false,
        quantity = map['quantity'],
        unitId = map['unitId'];
}
