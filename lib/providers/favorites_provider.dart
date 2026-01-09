import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/dish.dart';

class FavoritesProvider extends ChangeNotifier {
  late Box<String> _favoritesBox;
  Set<String> _favoriteIds = {};

  Set<String> get favoriteIds => _favoriteIds;

  FavoritesProvider() {
    _initFavorites();
  }

  Future<void> _initFavorites() async {
    _favoritesBox = Hive.box('favorites');
    _favoriteIds = _favoritesBox.values.toSet();
    notifyListeners();
  }

  bool isFavorite(String dishId) {
    return _favoriteIds.contains(dishId);
  }

  Future<void> toggleFavorite(Dish dish) async {
    if (_favoriteIds.contains(dish.id)) {
      await _removeFavorite(dish.id);
    } else {
      await _addFavorite(dish.id);
    }
  }

  Future<void> _addFavorite(String dishId) async {
    _favoriteIds.add(dishId);
    await _favoritesBox.add(dishId);
    notifyListeners();
  }

  Future<void> _removeFavorite(String dishId) async {
    _favoriteIds.remove(dishId);

    // Trouver la clé correspondant à cette valeur
    final keys = _favoritesBox.keys.where((key) =>
        _favoritesBox.get(key) == dishId).toList();

    for (final key in keys) {
      await _favoritesBox.delete(key);
    }

    notifyListeners();
  }

  Future<void> clearAllFavorites() async {
    _favoriteIds.clear();
    await _favoritesBox.clear();
    notifyListeners();
  }

  List<String> getFavoritesList() {
    return _favoriteIds.toList();
  }

  int get favoritesCount => _favoriteIds.length;
}
