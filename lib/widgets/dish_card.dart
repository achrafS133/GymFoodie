import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/dish.dart';
import '../providers/favorites_provider.dart';
import '../providers/comments_provider.dart';
import '../providers/meal_planner_provider.dart';
import '../utils/app_colors.dart';

class DishCard extends StatelessWidget {
  final Dish dish;
  final VoidCallback? onTap;

  const DishCard({
    super.key,
    required this.dish,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image du plat
              _buildDishImage(context),

              // Contenu de la carte
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nom et prix
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            dish.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            dish.formattedPrice,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Sommaire Macros
                    Row(
                      children: [
                        _buildMacroBadge(
                          icon: Icons.local_fire_department_rounded,
                          value: '${dish.nutritionalInfo['calories']} cal',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        _buildMacroBadge(
                          icon: Icons.fitness_center_rounded,
                          value: '${dish.nutritionalInfo['proteins']}g P',
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        _buildMacroBadge(
                          icon: Icons.grain_rounded,
                          value: '${dish.nutritionalInfo['carbs']}g G',
                          color: Colors.blue,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Description
                    Text(
                      dish.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    // Actions et statistiques
                    Row(
                      children: [
                        // Bouton favori
                        Consumer<FavoritesProvider>(
                          builder: (context, favoritesProvider, child) {
                            final isFavorite = favoritesProvider.isFavorite(dish.id);
                            return GestureDetector(
                              onTap: () {
                                favoritesProvider.toggleFavorite(dish);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isFavorite
                                      ? AppColors.favoriteColor.withOpacity(0.1)
                                      : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite
                                      ? AppColors.favoriteColor
                                      : Colors.grey[500],
                                  size: 20,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(width: 8),

                        // Bouton Ajouter au plan
                        GestureDetector(
                          onTap: () => _showMealSlotDialog(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.add_circle_outline_rounded,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Statistiques likes/dislikes
                        Flexible(
                          child: Consumer<CommentsProvider>(
                            builder: (context, commentsProvider, child) {
                              final likes = commentsProvider.getLikes(dish.id);
                              final dislikes = commentsProvider.getDislikes(dish.id);
                              final comments = commentsProvider.getComments(dish.id);

                              return Row(
                                children: [
                                  _buildStatChip(
                                    icon: Icons.thumb_up_rounded,
                                    count: likes,
                                    color: AppColors.likeColor,
                                  ),
                                  const SizedBox(width: 6),
                                  _buildStatChip(
                                    icon: Icons.thumb_down_rounded,
                                    count: dislikes,
                                    color: AppColors.dislikeColor,
                                  ),
                                  const SizedBox(width: 6),
                                  _buildStatChip(
                                    icon: Icons.chat_bubble_outline_rounded,
                                    count: comments.length,
                                    color: AppColors.info,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        // Indicateur de popularité
                        Consumer<CommentsProvider>(
                          builder: (context, commentsProvider, child) {
                            final isPopular = commentsProvider.isPopular(dish.id);
                            if (!isPopular) return const SizedBox.shrink();

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.favoriteColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    'Populaire',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDishImage(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: CachedNetworkImage(
              imageUrl: dish.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported_rounded,
                      size: 40,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Image non disponible',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Badge de catégorie
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getCategoryIcon(dish.category),
                  size: 14,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  dish.category.label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Badge disponibilité
        if (!dish.isAvailable)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text(
                    'Non disponible',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMacroBadge({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(DishCategory category) {
    switch (category) {
      case DishCategory.protein:
        return Icons.fitness_center_rounded;
      case DishCategory.carbs:
        return Icons.grain_rounded;
      case DishCategory.healthy_fats:
        return Icons.eco_rounded;
      case DishCategory.supplements:
        return Icons.local_drink_rounded;
    }
  }

  void _showMealSlotDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter au plan de repas'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: MealSlot.values.map((slot) {
            return ListTile(
              leading: Icon(
                _getSlotIcon(slot),
                color:_getSlotColor(slot),
              ),
              title: Text(slot.label),
              onTap: () {
                Provider.of<MealPlannerProvider>(context, listen: false)
                    .addDishToSlot(dish, slot);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${dish.name} ajouté à ${slot.label}'),
                    duration: const Duration(seconds: 2),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
            );
          }).toList(),
        ),
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
}
