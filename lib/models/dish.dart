import 'package:hive/hive.dart';

part 'dish.g.dart';

@HiveType(typeId: 0)
class Dish extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  double price;

  @HiveField(4)
  String imageUrl;

  @HiveField(5)
  DishCategory category;

  @HiveField(6)
  int likes;

  @HiveField(7)
  int dislikes;

  @HiveField(8)
  List<String> comments;

  @HiveField(9)
  bool isFavorite;

  @HiveField(10)
  bool isAvailable;

  @HiveField(11)
  List<String> ingredients;

  @HiveField(12)
  Map<String, dynamic> nutritionalInfo;

  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.likes = 0,
    this.dislikes = 0,
    this.comments = const [],
    this.isFavorite = false,
    this.isAvailable = true,
    this.ingredients = const [],
    this.nutritionalInfo = const {},
  });

  // Méthodes utiles
  String get formattedPrice => '${price.toStringAsFixed(2)} €';

  int get totalReactions => likes + dislikes;

  double get likeRatio => totalReactions > 0 ? likes / totalReactions : 0.0;

  bool get isPopular => totalReactions > 50 && likeRatio > 0.7;

  // Copie avec modifications
  Dish copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    DishCategory? category,
    int? likes,
    int? dislikes,
    List<String>? comments,
    bool? isFavorite,
    bool? isAvailable,
    List<String>? ingredients,
    Map<String, dynamic>? nutritionalInfo,
  }) {
    return Dish(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      comments: comments ?? this.comments,
      isFavorite: isFavorite ?? this.isFavorite,
      isAvailable: isAvailable ?? this.isAvailable,
      ingredients: ingredients ?? this.ingredients,
      nutritionalInfo: nutritionalInfo ?? this.nutritionalInfo,
    );
  }

  @override
  String toString() {
    return 'Dish(id: $id, name: $name, price: $price, category: $category)';
  }
}

@HiveType(typeId: 1)
enum DishCategory {
  @HiveField(0)
  protein('Protéines'),

  @HiveField(1)
  carbs('Glucides'),

  @HiveField(2)
  healthy_fats('Lipides Sains'),

  @HiveField(3)
  supplements('Compléments');

  const DishCategory(this.label);
  final String label;
}
