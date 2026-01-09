import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/meal_planner_provider.dart';
import '../models/dish.dart';
import '../utils/app_colors.dart';

class MealPlannerScreen extends StatelessWidget {
  const MealPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Consumer<MealPlannerProvider>(
        builder: (context, planner, _) {
          if (planner.totalDishes == 0) {
            return _buildEmptyState(context);
          }

          return Column(
            children: [
              _buildMacrosSummary(context, planner, isDarkMode),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ...MealSlot.values.map((slot) => _buildMealSlotCard(
                      context,
                      slot,
                      planner.getSlotDishes(slot),
                      planner,
                      isDarkMode,
                    )),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Consumer<MealPlannerProvider>(
        builder: (context, planner, _) {
          if (planner.totalDishes == 0) return const SizedBox.shrink();
          
          return FloatingActionButton.extended(
            onPressed: () => _showClearDialog(context),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.delete_sweep_rounded),
            label: const Text('Tout effacer'),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.restaurant_menu_rounded,
              size: 80,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Aucun repas planifié',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Ajoutez des plats depuis le menu pour créer votre plan nutritionnel quotidien',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacrosSummary(BuildContext context, MealPlannerProvider planner, bool isDarkMode) {
    final macros = planner.totalMacros;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.analytics_rounded, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Journalier',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${planner.totalDishes} plat(s) • ${planner.totalPrice.toStringAsFixed(0)} DH',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildMacroChip('🔥', '${macros['calories']!.toStringAsFixed(0)} kcal', 'Calories')),
              const SizedBox(width: 8),
              Expanded(child: _buildMacroChip('💪', '${macros['proteins']!.toStringAsFixed(1)}g', 'Protéines')),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildMacroChip('🍚', '${macros['carbs']!.toStringAsFixed(1)}g', 'Glucides')),
              const SizedBox(width: 8),
              Expanded(child: _buildMacroChip('🥑', '${macros['fats']!.toStringAsFixed(1)}g', 'Lipides')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroChip(String emoji, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealSlotCard(
    BuildContext context,
    MealSlot slot,
    List<Dish> dishes,
    MealPlannerProvider planner,
    bool isDarkMode,
  ) {
    final isEmpty = dishes.isEmpty;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getSlotColor(slot).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _getSlotIcon(slot),
                    color: _getSlotColor(slot),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    slot.label,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (!isEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear_all_rounded),
                    onPressed: () => planner.clearSlot(slot),
                    tooltip: 'Vider',
                    iconSize: 20,
                  ),
              ],
            ),
          ),
          if (isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                'Aucun plat ajouté',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          else
            ...dishes.map((dish) => _buildDishTile(context, dish, slot, planner, isDarkMode)),
        ],
      ),
    );
  }

  Widget _buildDishTile(
    BuildContext context,
    Dish dish,
    MealSlot slot,
    MealPlannerProvider planner,
    bool isDarkMode,
  ) {
    final calories = (dish.nutritionalInfo['calories'] as num?)?.toDouble() ?? 0;
    final proteins = (dish.nutritionalInfo['proteins'] as num?)?.toDouble() ?? 0;
    
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              dish.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: const Icon(Icons.restaurant),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${calories.toStringAsFixed(0)} kcal • ${proteins.toStringAsFixed(1)}g protéines',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${dish.price.toStringAsFixed(0)} DH',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 20),
            onPressed: () => planner.removeDishFromSlot(dish, slot),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  IconData _getSlotIcon(MealSlot slot) {
    switch (slot) {
      case MealSlot.breakfast:
        return Icons.wb_sunny_rounded;
      case MealSlot.lunch:
        return Icons.lunch_dining_rounded;
      case MealSlot.dinner:
        return Icons.dinner_dining_rounded;
      case MealSlot.snack:
        return Icons.cookie_rounded;
    }
  }

  Color _getSlotColor(MealSlot slot) {
    switch (slot) {
      case MealSlot.breakfast:
        return Colors.orange;
      case MealSlot.lunch:
        return Colors.green;
      case MealSlot.dinner:
        return Colors.blue;
      case MealSlot.snack:
        return Colors.purple;
    }
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Effacer le plan'),
        content: const Text('Voulez-vous vraiment supprimer tous les repas planifiés?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<MealPlannerProvider>(context, listen: false).clearAllMeals();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Effacer'),
          ),
        ],
      ),
    );
  }
}
