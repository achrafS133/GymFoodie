import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';

import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_drawer.dart';
import 'home_screen.dart';
import 'menu_screen.dart';
import 'contact_screen.dart';
import 'favorites_screen.dart';
import 'chat_screen.dart';
import 'meal_planner_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;
  late AnimationController _fabController;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MenuScreen(),
    const MealPlannerScreen(),
    const FavoritesScreen(),
    const ContactScreen(),
  ];

  final List<String> _titles = [
    'Accueil',
    'Nutrition',
    'Plan Repas',
    'Favoris',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        actions: [
          // Bouton de basculement du thème
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
            tooltip: themeProvider.isDarkMode
              ? 'Mode clair'
              : 'Mode sombre',
          ),

          // Bouton de recherche (pour le menu)
          if (_currentIndex == 1)
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {
                // TODO: Implémenter la recherche
                _showSearchDialog(context);
              },
              tooltip: 'Rechercher un plat',
            ),

          // Bouton de chat assistant
          IconButton(
            icon: const Icon(Icons.chat_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatScreen()),
              );
            },
            tooltip: 'Assistant Nutrition',
          ),

          const SizedBox(width: 8),
        ],
      ),

      drawer: const CustomDrawer(),

      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _screens[_currentIndex],
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onPageChanged,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 9,
            ),
            showUnselectedLabels: false,
            iconSize: 22,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu_outlined),
                activeIcon: Icon(Icons.restaurant_menu_rounded),
                label: 'Nutrition',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                activeIcon: Icon(Icons.calendar_today_rounded),
                label: 'Plan Repas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                activeIcon: Icon(Icons.favorite_rounded),
                label: 'Favoris',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contact_mail_outlined),
                activeIcon: Icon(Icons.contact_mail_rounded),
                label: 'Contact',
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: _currentIndex == 1
        ? ScaleTransition(
            scale: _fabController,
            child: FloatingActionButton(
              onPressed: () {
                // Scroll vers le haut du menu
                // TODO: Implémenter le scroll to top
              },
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              child: const Icon(Icons.keyboard_arrow_up_rounded),
            ),
          )
        : null,
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recherche'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Rechercher un plat...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implémenter la recherche
              Navigator.pop(context);
            },
            child: const Text('Rechercher'),
          ),
        ],
      ),
    );
  }
}
