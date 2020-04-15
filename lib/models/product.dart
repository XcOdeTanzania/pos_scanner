import 'package:flutter/material.dart';

class Product {
  ///product variables
  int id;
  String image;
  String title;
  double buyingPrice;
  double sellingPrice;
  int categoryId;
  String expiryDate;
  String productDetail;
  int alertQuantity;
  int taxId;
  int unitId;
  int supplierId;
  String taxMethod;
  bool status;
  int position;

  bool selected;
  int stock;

  Product({
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.buyingPrice,
    @required this.sellingPrice,
    @required this.stock,
    @required this.categoryId,
    @required this.expiryDate,
    @required this.productDetail,
    @required this.alertQuantity,
    @required this.taxId,
    @required this.supplierId,
    @required this.taxMethod,
    @required this.status,
    @required this.position,
    @required this.unitId,
    this.selected = false,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'image': image,
      'buyingPrice': buyingPrice,
      'sellingPrice': sellingPrice,
      'categoryId': categoryId,
      'expiryDate': expiryDate,
      'productDetail': productDetail,
      'alertQuantity': alertQuantity,
      'taxId': taxId,
      'unitId': unitId,
      'supplierId': supplierId,
      'taxMethod': taxMethod,
      'status': status,
      'position': position,
      'stock': stock
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Product.fromMap(Map<String, dynamic> map)
      : assert(map['_id'] != null),
        assert(map['title'] != null),
        id = map['_id'],
        image = map['image'],
        title = map['title'],
        buyingPrice = map['buyingPrice'],
        sellingPrice = map['sellingPrice'],
        stock = map['stock'],
        categoryId = map['categoryId'],
        expiryDate = map['expiryDate'],
        productDetail = map['productDetail'],
        alertQuantity = map['alertQuantity'],
        taxId = map['taxId'],
        supplierId = map['supplierId'],
        taxMethod = map['taxMethod'],
        status = map['status'],
        position = map['position'],
        selected = false,
        unitId = map['unitId'];
}
