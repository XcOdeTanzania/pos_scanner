import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_scanner/constants/enum.dart';
import 'package:pos_scanner/scoped_model/main.dart';
import 'package:pos_scanner/util/currency_convetor.dart';
import 'package:pos_scanner/views/components/text_fields/currency_text_field.dart';
import 'package:pos_scanner/views/components/text_fields/two_texts_text_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CheckOutPage extends StatefulWidget {
  final String customer;
  final int itemNo;
  final double totalTax;
  final double totalAmount;
  final PaymentMethod paymentMethod;
  final CurrencyCovertor currencyCovertor;

  CheckOutPage(
      {Key key,
      @required this.customer,
      @required this.itemNo,
      @required this.totalTax,
      @required this.totalAmount,
      @required this.paymentMethod,
      @required this.currencyCovertor})
      : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();

  bool _submit = true;

  @override
  void initState() {
    _textEditingController.text = widget.totalAmount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Check Out'),
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'BILL',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TwoTextsTextTile(
                        title: 'Customer:',
                        subtile: widget.customer,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TwoTextsTextTile(
                        title: 'Order No:',
                        subtile: '12222232',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TwoTextsTextTile(
                        title: 'Items No:',
                        subtile: widget.itemNo.toString(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TwoTextsTextTile(
                        title: 'Total Tax:',
                        subtile: widget.currencyCovertor
                            .currencyCovertor(amount: widget.totalTax),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TwoTextsTextTile(
                        title: 'Total Amount:',
                        subtile: widget.currencyCovertor
                            .currencyCovertor(amount: widget.totalAmount),
                        textColor: Colors.red,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TwoTextsTextTile(
                        title: 'Payment Method:',
                        subtile: 'Cash',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CurrencyTextfield(
                          focusNode: _focusNode,
                          hitText: null,
                          labelText: 'PAY:',
                          maxLines: 1,
                          message: null,
                          prefix: 'TZS\t\t\t',
                          surfix: '/-',
                          textEditingController: _textEditingController,
                          onChange: (value) {
                            print(value);
                            if (double.parse(value.replaceAll(',', '')) <=
                                    widget.totalAmount &&
                                value.isNotEmpty) {
                              setState(() {
                                _submit = true;
                              });
                            } else {
                              setState(() {
                                _submit = false;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Platform.isAndroid
                      ? FlatButton(
                          color: Theme.of(context).buttonColor,
                          child: Text('Decline',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : CupertinoButton(
                          color: Theme.of(context).buttonColor,
                          child: Text('Decline',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Platform.isAndroid
                      ? FlatButton(
                          disabledColor: Colors.red,
                          color: Colors.green,
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _submit
                              ? () {
                                  // model.createInvoice(
                                  //   amount: widget.totalAmount,
                                  //   creatorId: 1,
                                  //   customerId: 2,
                                  //   paid: _textEditingController.text.isNotEmpty
                                  //       ? _textEditingController.text
                                  //       : '0',
                                  // );

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              : null,
                        )
                      : CupertinoButton(
                          disabledColor: Colors.red,
                          color: Colors.green,
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _submit
                              ? () {
                                  // model
                                  //     .createInvoice(
                                  //       amount: widget.totalAmount,
                                  //       creatorId: 1,
                                  //       customerId: 2,
                                  //       paid: _textEditingController
                                  //               .text.isNotEmpty
                                  //           ? _textEditingController.text
                                  //           : '0',
                                  //     )
                                  //     .then((onValue) {});

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              : null,
                        ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
