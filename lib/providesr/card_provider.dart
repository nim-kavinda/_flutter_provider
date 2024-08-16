import 'package:flutter/material.dart';
import 'package:project_name/models/card_models.dart';

class CardProvider extends ChangeNotifier {
  //cart items state
  Map<String, CartItem> _items = {};

  //getter
  Map<String, CartItem> get items {
    return {..._items};
  }

  //add item
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
      print("Add existing data");
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
      print("Add new data");
    }
    print(_items);
    notifyListeners();
  }

  //remove from cart
  void removeItem(String productId) {
    _items.remove(productId);

    notifyListeners();
  }

  //remove sngle item from card
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (exsitingCartItem) => CartItem(
          id: exsitingCartItem.id,
          title: exsitingCartItem.title,
          price: exsitingCartItem.price,
          quantity: exsitingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  // clear
  void clearAll() {
    _items = {};
    notifyListeners();
  }

  //caculate Toatal
  double get totleAmount {
    var total = 0.0;
    _items.forEach(
      (key, cartItem) {
        total = total + cartItem.price * cartItem.quantity;
      },
    );
    notifyListeners();
    return total;
  }
}
