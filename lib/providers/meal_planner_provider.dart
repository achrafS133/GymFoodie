import 'package:flutter/material.dart';
import '../models/dish.dart';

enum MealSlot {
  breakfast('Petit-déjeuner'),
  lunch('Déjeuner'),
  dinner('Dîner'),
  snack('Collation');

  const MealSlot(this.label);
  final String label;
}

class MealPlannerProvider extends ChangeNotifier {
  final Map<MealSlot, List<Dish>> _mealPlan = {
    MealSlot.breakfast: [],
    MealSlot.lunch: [],
    MealSlot.dinner: [],
    MealSlot.snack: [],
  };

  Map<MealSlot, List<Dish>> get mealPlan => Map.unmodifiable(_mealPlan);

  void addDishToSlot(Dish dish, MealSlot slot) {
    _mealPlan[slot]?.add(dish);
    notifyListeners();
  }

  void removeDishFromSlot(Dish dish, MealSlot slot) {
    _mealPlan[slot]?.removeWhere((d) => d.id == dish.id);
    notifyListeners();
  }

  void clearSlot(MealSlot slot) {
    _mealPlan[slot]?.clear();
    notifyListeners();
  }

  void clearAllMeals() {
    _mealPlan.forEach((key, value) => value.clear());
    notifyListeners();
  }

  List<Dish> getSlotDishes(MealSlot slot) {
    return List.unmodifiable(_mealPlan[slot] ?? []);
  }

  // Calculate total macros for the day
  Map<String, double> get totalMacros {
    double calories = 0;
    double proteins = 0;
    double carbs = 0;
    double fats = 0;

    _mealPlan.values.forEach((dishes) {
      for (var dish in dishes) {
        calories += (dish.nutritionalInfo['calories'] as num?)?.toDouble() ?? 0;
        proteins += (dish.nutritionalInfo['proteins'] as num?)?.toDouble() ?? 0;
        carbs += (dish.nutritionalInfo['carbs'] as num?)?.toDouble() ?? 0;
        fats += (dish.nutritionalInfo['fats'] as num?)?.toDouble() ?? 0;
      }
    });

    return {
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
    };
  }

  // Get total price for the day
  double get totalPrice {
    double total = 0;
    _mealPlan.values.forEach((dishes) {
      for (var dish in dishes) {
        total += dish.price;
      }
    });
    return total;
  }

  // Get total number of dishes
  int get totalDishes {
    int count = 0;
    _mealPlan.values.forEach((dishes) => count += dishes.length);
    return count;
  }
}
