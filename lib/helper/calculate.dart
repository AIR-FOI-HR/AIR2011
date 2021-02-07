import 'package:air_2011/providers/order.dart';
import 'package:flutter/material.dart';

class Calculator {
  double calculateSum(Order _model) {
    var surface = (_model.width / 100) * (_model.height / 100);
    var volume = 2 * (_model.width / 100) + 2 * (_model.height / 100);
    _model.total = (volume * _model.priceFrameOne);
    if (_model.passpartoutGlass != null && _model.passpartoutGlass != 0) {
      _model.total += (surface * _model.passpartoutGlass * 90);
    }

    if (_model.spaceFrameTwo != null && _model.priceFrameTwo != null) {
      var tmpVol2 = ((_model.width - _model.spaceFrameTwo) / 100) * 2 +
          ((_model.height - _model.spaceFrameTwo) / 100)*2;
      _model.total += tmpVol2 * _model.priceFrameTwo;
    }
    if (_model.spaceFrameThree != null && _model.priceFrameThree != null) {
      var tmpVol3 = ((_model.width - _model.spaceFrameThree) / 100) * 2 + 
          ((_model.height - _model.spaceFrameThree) / 100)*2;
      _model.total += tmpVol3 * _model.priceFrameThree;
    }
    return double.parse(_model.total.toStringAsFixed(2));
  }
}
