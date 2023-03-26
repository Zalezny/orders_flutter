
import 'package:flutter/cupertino.dart';

class TerminatedMessageProvider extends ChangeNotifier{
  String _orderId = "";

  String get orderId {
    return _orderId;
  }

  void setOrderId(String orderId) {
    _orderId = orderId;
    notifyListeners();
  }
}