import 'dart:math';
// import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_scanner/database/shared/shared_preference.dart';
import 'package:pos_scanner/models/product.dart';
// import 'package:pos_scanner/provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

double _salesTaxRate = 0.18;
double _shippingCostPerItem = 0.0;
// bool _vat = false;

mixin ConnectedPOSModel on Model {
  // HttpRequestProvier _httpRequestProvier = HttpRequestProvier();

  /// Shared preference DB
  SharedPref sharedPref = SharedPref();

  /** Products */
  ///Product list
  List<Product> _availableProducts;

  ///editing message
  Map<String, dynamic> _editingMessage;
  //getter
  Map<String, dynamic> get editingMessage => _editingMessage;

  /** Shopping cart */
  /// The IDs and quantities of products currently in the cart.
  final Map<int, int> _productsInCart = <int, int>{};

  // Removes everything from the cart.
  void _clearCart() {
    _productsInCart.clear();

    notifyListeners();
  }
}

mixin ProductModel on ConnectedPOSModel {
  ///Random String Generator
  Random random = new Random();

  ///editing a product
  Product _productToEdit;

  ///seleted product
  Product _selectedProduct;

  ///getter of Product List
  List<Product> get productList {
    return _availableProducts.isEmpty
        ? []
        : List<Product>.from(_availableProducts);
  }

  List<Product> productListByCategoryId(categoryId) {
    return _availableProducts.isEmpty
        ? []
        : List<Product>.from(_availableProducts
            .where((product) => product.categoryId == categoryId));
  }

  ///getter of Product List
  List<Product> get inactiveProductList {
    return _availableProducts.isEmpty
        ? []
        : List<Product>.from(
            _availableProducts.where((product) => !product.status));
  }

//get products of the same category
  List<Product> getProductsByCategoryId({@required int id}) {
    return _availableProducts.isEmpty
        ? []
        : List<Product>.from(
            _availableProducts.where((product) => product.categoryId == id));
  }

  ///getter
  Product get productToEdit => _productToEdit;

  ///getter for a selected category
  Product get selectedProduct => _selectedProduct;

  ///setter for a selected category
  set selectProduct(Product newValue) {
    _selectedProduct = newValue;
    notifyListeners();
  }

  // Returns the Product instance matching the provided id.
  Product getProductById(int id) {
    return _availableProducts.firstWhere((Product p) => p.id == id);
  }
}

mixin CartModel on ConnectedPOSModel {
  ///getter for cart products
  Map<int, int> get productsInCart => Map<int, int>.from(_productsInCart);

  /// Total number of items in the cart.
  int get totalCartQuantity =>
      _productsInCart.values.fold(0, (int v, int e) => v + e);

  /// Totaled prices of the items in the cart.
  double get subtotalCost {
    return _productsInCart.keys.map((int id) {
      print(id);
      int index = _availableProducts.indexWhere((product) => product.id == id);
      return _availableProducts[index].sellingPrice * _productsInCart[id];
    }).fold(0.0, (double sum, double e) => sum + e);
  }

  /// Total shipping cost for the items in the cart.
  double get shippingCost {
    return _shippingCostPerItem *
        _productsInCart.values.fold(0.0, (num sum, int e) => sum + e);
  }

  /// Sales tax for the items in the cart
  double get tax => subtotalCost * _salesTaxRate;

  /// Total cost to order everything in the cart.
  double get totalCost => subtotalCost + shippingCost + tax;

  /// Adds a product to the cart.
  void addProductToCart({@required Product currentProduct}) {
    if (!_productsInCart.containsKey(currentProduct.id)) {
      _productsInCart[currentProduct.id] = 1;
    } else {
      _productsInCart[currentProduct.id]++;
    }

    int index = _availableProducts
        .indexWhere((product) => product.id == currentProduct.id);

    _availableProducts[index].stock--;

    notifyListeners();
  }

  /// Removes an item from the cart.
  void removeItemFromCart({@required Product currentProduct}) {
    if (_productsInCart.containsKey(currentProduct.id)) {
      if (_productsInCart[currentProduct.id] == 1) {
        _productsInCart.remove(currentProduct.id);
      } else {
        _productsInCart[currentProduct.id]--;
      }
    }
    int index = _availableProducts
        .indexWhere((product) => product.id == currentProduct.id);
    print(index);
    _availableProducts[index].stock++;
    notifyListeners();
  }

  void revertCart() {
    _productsInCart.forEach((id, num) {
      int index = _availableProducts.indexWhere((product) => product.id == id);
      _availableProducts[index].stock += num;
    });
    _clearCart();
  }
}
