import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/dish.dart';

class CommentsProvider extends ChangeNotifier {
  late Box _commentsBox;
  late Box _likesBox;
  late Box _dislikesBox;
  late Box _userReactionsBox;

  Map<String, List<String>> _dishComments = {};
  Map<String, int> _dishLikes = {};
  Map<String, int> _dishDislikes = {};
  Map<String, String> _userReactions = {}; // dishId -> 'like'/'dislike'/null

  CommentsProvider() {
    _initStorage();
  }

  Future<void> _initStorage() async {
    _commentsBox = Hive.box('comments');
    _likesBox = await Hive.openBox('likes');
    _dislikesBox = await Hive.openBox('dislikes');
    _userReactionsBox = await Hive.openBox('user_reactions');

    // Charger les données existantes
    _loadData();
    notifyListeners();
  }

  void _loadData() {
    // Charger les commentaires
    for (var key in _commentsBox.keys) {
      final comments = _commentsBox.get(key);
      if (comments is List) {
        _dishComments[key] = List<String>.from(comments);
      }
    }

    // Charger les likes et dislikes
    for (var key in _likesBox.keys) {
      _dishLikes[key] = _likesBox.get(key) ?? 0;
    }

    for (var key in _dislikesBox.keys) {
      _dishDislikes[key] = _dislikesBox.get(key) ?? 0;
    }

    // Charger les réactions utilisateur
    for (var key in _userReactionsBox.keys) {
      _userReactions[key] = _userReactionsBox.get(key);
    }
  }

  // Gestion des commentaires
  List<String> getComments(String dishId) {
    return _dishComments[dishId] ?? [];
  }

  Future<void> addComment(String dishId, String comment) async {
    if (comment.trim().isEmpty) return;

    final comments = _dishComments[dishId] ?? [];
    comments.add(comment.trim());
    _dishComments[dishId] = comments;

    await _commentsBox.put(dishId, comments);
    notifyListeners();
  }

  Future<void> removeComment(String dishId, int index) async {
    final comments = _dishComments[dishId];
    if (comments != null && index >= 0 && index < comments.length) {
      comments.removeAt(index);
      _dishComments[dishId] = comments;
      await _commentsBox.put(dishId, comments);
      notifyListeners();
    }
  }

  // Gestion des likes/dislikes
  int getLikes(String dishId) {
    return _dishLikes[dishId] ?? 0;
  }

  int getDislikes(String dishId) {
    return _dishDislikes[dishId] ?? 0;
  }

  String? getUserReaction(String dishId) {
    return _userReactions[dishId];
  }

  Future<void> toggleLike(String dishId) async {
    final currentReaction = _userReactions[dishId];

    if (currentReaction == 'like') {
      // Retirer le like
      _dishLikes[dishId] = (_dishLikes[dishId] ?? 1) - 1;
      _userReactions.remove(dishId);
      await _userReactionsBox.delete(dishId);
    } else {
      // Ajouter un like
      if (currentReaction == 'dislike') {
        // Retirer le dislike d'abord
        _dishDislikes[dishId] = (_dishDislikes[dishId] ?? 1) - 1;
        await _dislikesBox.put(dishId, _dishDislikes[dishId]!);
      }

      _dishLikes[dishId] = (_dishLikes[dishId] ?? 0) + 1;
      _userReactions[dishId] = 'like';
      await _userReactionsBox.put(dishId, 'like');
    }

    await _likesBox.put(dishId, _dishLikes[dishId]!);
    notifyListeners();
  }

  Future<void> toggleDislike(String dishId) async {
    final currentReaction = _userReactions[dishId];

    if (currentReaction == 'dislike') {
      // Retirer le dislike
      _dishDislikes[dishId] = (_dishDislikes[dishId] ?? 1) - 1;
      _userReactions.remove(dishId);
      await _userReactionsBox.delete(dishId);
    } else {
      // Ajouter un dislike
      if (currentReaction == 'like') {
        // Retirer le like d'abord
        _dishLikes[dishId] = (_dishLikes[dishId] ?? 1) - 1;
        await _likesBox.put(dishId, _dishLikes[dishId]!);
      }

      _dishDislikes[dishId] = (_dishDislikes[dishId] ?? 0) + 1;
      _userReactions[dishId] = 'dislike';
      await _userReactionsBox.put(dishId, 'dislike');
    }

    await _dislikesBox.put(dishId, _dishDislikes[dishId]!);
    notifyListeners();
  }

  // Statistiques
  int getTotalReactions(String dishId) {
    return getLikes(dishId) + getDislikes(dishId);
  }

  double getLikeRatio(String dishId) {
    final total = getTotalReactions(dishId);
    return total > 0 ? getLikes(dishId) / total : 0.0;
  }

  bool isPopular(String dishId) {
    return getTotalReactions(dishId) > 50 && getLikeRatio(dishId) > 0.7;
  }

  // Nettoyage
  Future<void> clearAllData() async {
    _dishComments.clear();
    _dishLikes.clear();
    _dishDislikes.clear();
    _userReactions.clear();

    await _commentsBox.clear();
    await _likesBox.clear();
    await _dislikesBox.clear();
    await _userReactionsBox.clear();

    notifyListeners();
  }
}
