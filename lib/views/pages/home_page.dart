import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pos_scanner/scoped_model/main.dart';
import 'package:pos_scanner/views/pages/drawer_page.dart';
import 'package:scoped_model/scoped_model.dart';

import 'cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('POS scan'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    print(model.productsInCart);
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => CartPage()));
                  },
                  child: Badge(
                    showBadge: model.totalCartQuantity > 0 ? true : false,
                    badgeContent: Text(
                      model.totalCartQuantity.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    badgeColor: Colors.red,
                  ),
                ),
              ],
            ),
            body: Builder(
              builder: (BuildContext context) {
                return Container(
                    margin: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    onPressed: () => scanBarcodeNormal(),
                                    child: Text("Start barcode scan")),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    onPressed: () => startBarcodeScanStream(),
                                    child: Text("Start barcode scan stream")),
                              ),
                            ],
                          ),
                          Text('Scan result : $_scanBarcode\n',
                              style: TextStyle(fontSize: 20))
                        ]));
              },
            ),
            drawer: DrawerPage());
      },
    );
  }
}
