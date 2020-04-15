import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pos_scanner/models/product.dart';
import 'package:pos_scanner/scoped_model/main.dart';
import 'package:pos_scanner/util/currency_convetor.dart';

class CartProductItem extends StatelessWidget {
  final int quantity;
  final MainModel model;
  final Product product;

  const CartProductItem(
      {Key key,
      @required this.quantity,
      @required this.model,
      @required this.product})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      'model.getProductById(model.getStockById(product.stockId).productId).name[0]',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            text:
                                'model.getProductById(model.getStockById(product.stockId).productId).name',
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\n(' +
                                      'model.getStockById(product.stockId).name' +
                                      ')',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)),
                              TextSpan(
                                  text: '',
                                  style: TextStyle(
                                      color: Colors.redAccent, fontSize: 38))
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(text: 'Quantity: '),
                                TextSpan(
                                    text: quantity.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey))
                              ]),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16.0),
                              children: [
                                TextSpan(
                                    text: 'Each @ \t',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey)),
                                TextSpan(
                                  text: currencyCovertor.currencyCovertor(
                                      amount: product.sellingPrice),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 15,
          child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.all(0.0),
              color: product.id == 0 ? Colors.grey : Colors.green,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                if (product.id > 0) model.addProductToCart(currentProduct: product);
              },
            ),
          ),
        ),
        Positioned(
          top: 60,
          right: 15,
          child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.all(0.0),
              color: Colors.pinkAccent,
              child: Icon(
                FontAwesomeIcons.minus,
                size: 15,
                color: Colors.white,
              ),
              onPressed: () {
                model.removeItemFromCart(currentProduct: product);
              },
            ),
          ),
        ),
      ],
    );
  }
}
