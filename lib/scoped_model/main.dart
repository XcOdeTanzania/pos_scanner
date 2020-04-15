import 'package:pos_scanner/scoped_model/connected_scanner_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with ConnectedPOSModel, ProductModel, CartModel {}
