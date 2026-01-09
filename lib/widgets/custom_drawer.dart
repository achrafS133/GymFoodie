import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../providers/theme_provider.dart';
import '../providers/favorites_provider.dart';
import '../utils/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColors.darkGradient
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    Colors.white,
                  ],
                ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              // En-tête du drawer
              Container(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 20),
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [AppColors.cardShadow],
                          ),
                          child: const Icon(
                            Icons.restaurant_rounded,
                            size: 30,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gym Maroc Nutrition',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Nutrition & Bien-être',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Liste des éléments de navigation
              Expanded(
                child: AnimationLimiter(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 300),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: -50,
                        child: FadeInAnimation(child: widget),
                      ),
                      children: [
                        _buildDrawerItem(
                          context,
                          icon: Icons.home_rounded,
                          title: 'Accueil',
                          index: 0,
                        ),
                        _buildDrawerItem(
                          context,
                          icon: Icons.restaurant_menu_rounded,
                          title: 'Nutrition',
                          index: 1,
                        ),
                        _buildDrawerItem(
                          context,
                          icon: Icons.favorite_rounded,
                          title: 'Favoris',
                          index: 2,
                          badge: favoritesProvider.favoritesCount > 0
                              ? favoritesProvider.favoritesCount.toString()
                              : null,
                        ),
                        _buildDrawerItem(
                          context,
                          icon: Icons.contact_mail_rounded,
                          title: 'Contact',
                          index: 3,
                        ),

                        const Divider(height: 32),

                        // Section paramètres
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Paramètres',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        _buildThemeToggle(context, themeProvider),

                        _buildDrawerAction(
                          context,
                          icon: Icons.info_outline_rounded,
                          title: 'À propos',
                          onTap: () => _showAboutDialog(context),
                        ),

                        _buildDrawerAction(
                          context,
                          icon: Icons.star_outline_rounded,
                          title: 'Évaluer l\'app',
                          onTap: () => _showRatingDialog(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Version 1.0.0',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required int index,
    String? badge,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        leading: Stack(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
            if (badge != null)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () {
          Navigator.pop(context);
          // Navigation vers la page correspondante
          // Cette logique devrait être gérée par le MainScreen
        },
      ),
    );
  }

  Widget _buildDrawerAction(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.grey[600],
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context, ThemeProvider themeProvider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        leading: Icon(
          themeProvider.isDarkMode
              ? Icons.dark_mode_rounded
              : Icons.light_mode_rounded,
          color: AppColors.primary,
          size: 24,
        ),
        title: Text(
          themeProvider.isDarkMode ? 'Mode sombre' : 'Mode clair',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Switch.adaptive(
          value: themeProvider.isDarkMode,
          onChanged: (_) => themeProvider.toggleTheme(),
          activeColor: AppColors.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () => themeProvider.toggleTheme(),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('À propos'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gym Maroc Nutrition'),
            SizedBox(height: 8),
            Text('Une application moderne pour une nutrition sportive marocaine.'),
            SizedBox(height: 16),
            Text('Fonctionnalités:'),
            Text('• Nutrition par catégories (Protéines, Glucides, Lipides)'),
            Text('• Système de favoris'),
            Text('• Commentaires et évaluations'),
            Text('• Mode sombre/clair'),
            Text('• Informations nutritionnelles détaillées'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Évaluer l\'application'),
        content: const Text(
          'Aimez-vous notre application ? Laissez-nous une évaluation !',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Plus tard'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Ouvrir le store pour évaluation
            },
            child: const Text('Évaluer'),
          ),
        ],
      ),
    );
  }
}
