import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pos_scanner/constants/enum.dart';
import 'package:pos_scanner/scoped_model/main.dart';
import 'package:pos_scanner/util/currency_convetor.dart';
import 'package:pos_scanner/views/components/cards/cart_product_item.dart';
import 'package:scoped_model/scoped_model.dart';

import 'check_out_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    List<Widget> _createShoppingCartRows(MainModel model) {
      return model.productsInCart.keys
          .map(
            (int id) => CartProductItem(
              model: model,
              product: model.getProductById(id),
              quantity: model.productsInCart[id],
            ),
          )
          .toList();
    }

    Widget _buildTotals(MainModel model) {
      return ClipOval(
        clipper: OvalTopBorderClipper(),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey.shade700,
                  spreadRadius: 80.0),
            ],
            color: Colors.white,
          ),
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Subtotal"),
                  Text(currencyCovertor.currencyCovertor(
                      amount: model.subtotalCost)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Tax fee"),
                  Text(currencyCovertor.currencyCovertor(amount: model.tax)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0)),
                  Text(
                      currencyCovertor.currencyCovertor(
                          amount: model.totalCost),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Platform.isAndroid
                  ? MaterialButton(
                      height: 50,
                      color: Theme.of(context).buttonColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CheckOutPage(
                                      customer: 'Jimmy Eliau',
                                      itemNo: model.totalCartQuantity,
                                      paymentMethod: PaymentMethod.CASH,
                                      totalAmount: model.totalCost,
                                      totalTax: model.tax,
                                      currencyCovertor: currencyCovertor,
                                    )));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("CHECK OUT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          Text(
                              currencyCovertor.currencyCovertor(
                                  amount: model.totalCost),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ],
                      ),
                    )
                  : CupertinoButton(
                      color: Theme.of(context).buttonColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("CHECK OUT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          Text(
                              currencyCovertor.currencyCovertor(
                                  amount: model.totalCost),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CheckOutPage(
                                      customer: 'Jimmy Eliau',
                                      itemNo: model.totalCartQuantity,
                                      paymentMethod: PaymentMethod.CASH,
                                      totalAmount: model.totalCost,
                                      totalTax: model.tax,
                                      currencyCovertor: currencyCovertor,
                                    )));
                      },
                    ),
            ],
          ),
        ),
      );
    }

    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Check Out'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.clear_all),
                onPressed: () {
                  _showDialog(
                      context: context,
                      content: 'Do you want to clear the cart?',
                      title: 'Clear Cart',
                      model: model);
                },
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: _createShoppingCartRows(model),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                _buildTotals(model)
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDialog(
      {@required BuildContext context,
      @required String title,
      @required content,
      @required MainModel model}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Platform.isAndroid
            ? AlertDialog(
                title: Text(title),
                content: new Text(content),
                actions: <Widget>[
                  FlatButton(
                    textColor: Theme.of(context).buttonColor,
                    child: new Text("CLOSE"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    textColor: Colors.red,
                    child: new Text("CLEAR"),
                    onPressed: () {
                      model.revertCart();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            : CupertinoAlertDialog(
                title: Text(title),
                content: new Text(content),
                actions: <Widget>[
                  CupertinoDialogAction(
                    textStyle: TextStyle(color: Theme.of(context).buttonColor),
                    child: const Text('Close'),
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    child: const Text('Clear'),
                    isDestructiveAction: true,
                    onPressed: () {
                      model.revertCart();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
      },
    );
  }
}
