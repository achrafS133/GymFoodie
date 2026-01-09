import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales inspirées du Maroc et du fitness
  static const Color primary = Color(0xFFE74C3C); // Rouge marocain
  static const Color secondary = Color(0xFFF39C12); // Orange/Or
  static const Color accent = Color(0xFF27AE60); // Vert fitness

  // Couleurs de fond
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Colors.white;

  // Mode sombre
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2D2D2D);

  // Couleurs d'état
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Couleurs de texte
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textWhite = Colors.white;

  // Couleurs pour les interactions
  static const Color likeColor = Color(0xFFE91E63);
  static const Color dislikeColor = Color(0xFF9E9E9E);
  static const Color favoriteColor = Color(0xFFFFD700);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, accent],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, Color(0xFFFFB74D)],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [darkBackground, darkCard],
  );

  // Ombres
  static BoxShadow get primaryShadow => BoxShadow(
    color: primary.withOpacity(0.3),
    blurRadius: 12,
    offset: const Offset(0, 6),
  );

  static BoxShadow get cardShadow => BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );

  static BoxShadow get darkCardShadow => BoxShadow(
    color: Colors.black.withOpacity(0.3),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );
}
