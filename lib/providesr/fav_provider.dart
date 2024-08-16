import 'package:flutter/material.dart';

class FavProvider extends ChangeNotifier {
  //state
  final Map<String, bool> _fav = {};

  //getter
  Map<String, bool> get fav => _fav;

  //toogle fav
  void toogleFavourites(String productId) {
    if (_fav.containsKey(productId)) {
      _fav[productId] = !_fav[productId]!;
    } else {
      _fav[productId] = true;
    }
    notifyListeners();
  }

  //method to check wether a favorite or not
  bool isFavourite(String productId) {
    return _fav[productId] ?? false;
  }
}
