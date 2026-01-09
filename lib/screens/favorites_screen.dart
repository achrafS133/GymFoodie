import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../providers/favorites_provider.dart';
import '../data/sample_dishes.dart';
import '../models/dish.dart';
import '../utils/app_colors.dart';
import '../widgets/dish_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with TickerProviderStateMixin {
  late AnimationController _emptyStateController;
  late Animation<double> _emptyStateAnimation;

  @override
  void initState() {
    super.initState();
    _emptyStateController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _emptyStateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _emptyStateController,
      curve: Curves.easeOutBack,
    ));
  }

  @override
  void dispose() {
    _emptyStateController.dispose();
    super.dispose();
  }

  List<Dish> _getFavoriteDishes(Set<String> favoriteIds) {
    final allDishes = SampleDishes.getAllDishes();
    return allDishes.where((dish) => favoriteIds.contains(dish.id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favoriteDishes = _getFavoriteDishes(favoritesProvider.favoriteIds);

          if (favoriteDishes.isEmpty) {
            _emptyStateController.forward();
            return _buildEmptyState();
          } else {
            _emptyStateController.reset();
            return _buildFavoritesList(favoriteDishes, favoritesProvider);
          }
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return AnimatedBuilder(
      animation: _emptyStateAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _emptyStateAnimation.value,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      shape: BoxShape.circle,
                      boxShadow: [AppColors.primaryShadow],
                    ),
                    child: const Icon(
                      Icons.favorite_outline_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 32),

                  Text(
                    'Aucun favori pour le moment',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Parcourez notre menu et ajoutez vos plats préférés en tapant sur l\'icône cœur',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigation vers le menu
                      DefaultTabController.of(context)?.animateTo(1);
                    },
                    icon: const Icon(Icons.restaurant_menu_rounded),
                    label: const Text('Découvrir le menu'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 4,
                      shadowColor: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavoritesList(List<Dish> favoriteDishes, FavoritesProvider favoritesProvider) {
    return Column(
      children: [
        // En-tête avec statistiques
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mes Favoris',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${favoriteDishes.length} plat${favoriteDishes.length > 1 ? 's' : ''} favori${favoriteDishes.length > 1 ? 's' : ''}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (favoriteDishes.isNotEmpty)
                      IconButton(
                        onPressed: () => _showClearAllDialog(favoritesProvider),
                        icon: const Icon(
                          Icons.clear_all_rounded,
                          color: Colors.white,
                        ),
                        tooltip: 'Tout supprimer',
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // Statistiques rapides
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Prix total',
                        '${_calculateTotalPrice(favoriteDishes).toStringAsFixed(2)} €',
                        Icons.euro_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Catégories',
                        '${_getUniqueCategories(favoriteDishes).length}',
                        Icons.category_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Prix moyen',
                        '${_calculateAveragePrice(favoriteDishes).toStringAsFixed(2)} €',
                        Icons.analytics_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Liste des plats favoris
        Expanded(
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteDishes.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 400),
                  child: SlideAnimation(
                    horizontalOffset: -50,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Dismissible(
                          key: Key(favoriteDishes[index].id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete_rounded,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Supprimer',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            return await _showRemoveDialog(favoriteDishes[index]);
                          },
                          onDismissed: (direction) {
                            favoritesProvider.toggleFavorite(favoriteDishes[index]);
                            _showRemovedSnackBar(favoriteDishes[index]);
                          },
                          child: DishCard(
                            dish: favoriteDishes[index],
                            onTap: () => _showDishDetails(favoriteDishes[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  double _calculateTotalPrice(List<Dish> dishes) {
    return dishes.fold(0.0, (sum, dish) => sum + dish.price);
  }

  double _calculateAveragePrice(List<Dish> dishes) {
    if (dishes.isEmpty) return 0.0;
    return _calculateTotalPrice(dishes) / dishes.length;
  }

  Set<String> _getUniqueCategories(List<Dish> dishes) {
    return dishes.map((dish) => dish.category.label).toSet();
  }

  Future<bool?> _showRemoveDialog(Dish dish) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Retirer des favoris'),
        content: Text('Voulez-vous retirer "${dish.name}" de vos favoris ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retirer'),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog(FavoritesProvider favoritesProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Vider les favoris'),
        content: const Text('Voulez-vous supprimer tous vos plats favoris ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              favoritesProvider.clearAllFavorites();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Tout supprimer'),
          ),
        ],
      ),
    );
  }

  void _showRemovedSnackBar(Dish dish) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${dish.name} retiré des favoris'),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showDishDetails(Dish dish) {
    // Réutiliser le même modal que dans MenuScreen
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey[600] 
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(dish.imageUrl),
                          fit: BoxFit.cover,
                          onError: (e, s) {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      dish.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      dish.formattedPrice,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      dish.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    // Statistiques rapides
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatChip(context, Icons.local_fire_department_rounded, '${dish.nutritionalInfo['calories'] ?? 0} kcal'),
                        _buildStatChip(context, Icons.fitness_center_rounded, '${dish.nutritionalInfo['proteins'] ?? 0}g Prot'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Fermer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
