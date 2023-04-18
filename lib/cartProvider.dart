import 'package:cart/dbHelper.dart';
import 'package:cart/model/cartModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardProvider with ChangeNotifier {
  DBHelper db = DBHelper();
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;
  Future<List<Cart>> getData() async {
    _cart = db.getCartList();
    return _cart;
  }

  void _setPrefItems() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('cart_item', _counter);
    sp.setDouble('cart_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _counter = sp.getInt('cart_item') ?? 0;
    _totalPrice = sp.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }
}
