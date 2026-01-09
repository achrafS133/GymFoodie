import '../models/dish.dart';

class SampleDishes {
  static List<Dish> getAllDishes() {
    return [
      // PROTÉINES
      Dish(
        id: 'protein_001',
        name: 'Tagine de Poulet aux Légumes',
        description: 'Poulet fermier marocain mijoté avec légumes de saison, riche en protéines',
        price: 45.00,
        imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=500&h=300&fit=crop',
        category: DishCategory.protein,
        ingredients: ['Poulet fermier', 'Courgettes', 'Carottes', 'Épices marocaines'],
        nutritionalInfo: {
          'calories': 320,
          'proteins': 35,
          'carbs': 12,
          'fats': 15,
        },
      ),

      Dish(
        id: 'protein_002',
        name: 'Kefta Grillée aux Herbes',
        description: 'Boulettes de viande hachée aux herbes fraîches, parfait post-entraînement',
        price: 38.00,
        imageUrl: 'https://images.unsplash.com/photo-1558030006-450675393462?w=500&h=300&fit=crop',
        category: DishCategory.protein,
        ingredients: ['Viande de bœuf', 'Persil', 'Coriandre', 'Menthe'],
        nutritionalInfo: {
          'calories': 280,
          'proteins': 32,
          'carbs': 5,
          'fats': 18,
        },
      ),

      Dish(
        id: 'protein_003',
        name: 'Poisson Grillé à la Chermoula',
        description: 'Poisson frais mariné dans la chermoula traditionnelle marocaine',
        price: 52.00,
        imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=500&h=300&fit=crop',
        category: DishCategory.protein,
        ingredients: ['Poisson blanc', 'Chermoula', 'Citron', 'Huile d\'olive'],
        nutritionalInfo: {
          'calories': 250,
          'proteins': 40,
          'carbs': 3,
          'fats': 12,
        },
      ),

      Dish(
        id: 'protein_004',
        name: 'Œufs Brouillés aux Épices',
        description: 'Œufs fermiers aux épices marocaines, idéal pour le petit-déjeuner sportif',
        price: 25.00,
        imageUrl: 'https://images.unsplash.com/photo-1506084868230-bb9d95c24759?w=500&h=300&fit=crop',
        category: DishCategory.protein,
        ingredients: ['Œufs fermiers', 'Curcuma', 'Gingembre', 'Coriandre'],
        nutritionalInfo: {
          'calories': 220,
          'proteins': 18,
          'carbs': 4,
          'fats': 16,
        },
      ),

      // GLUCIDES
      Dish(
        id: 'carbs_001',
        name: 'Couscous Complet aux Légumes',
        description: 'Couscous de blé complet avec légumes de saison, énergie durable',
        price: 35.00,
        imageUrl: 'https://images.unsplash.com/photo-1476124369491-e7addf5db371?w=500&h=300&fit=crop',
        category: DishCategory.carbs,
        ingredients: ['Couscous complet', 'Légumes variés', 'Bouillon de légumes'],
        nutritionalInfo: {
          'calories': 380,
          'proteins': 12,
          'carbs': 65,
          'fats': 8,
        },
      ),

      Dish(
        id: 'carbs_002',
        name: 'Riz Basmati aux Épices',
        description: 'Riz basmati parfumé aux épices marocaines, accompagnement parfait',
        price: 28.00,
        imageUrl: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500&h=300&fit=crop',
        category: DishCategory.carbs,
        ingredients: ['Riz basmati', 'Safran', 'Cannelle', 'Cardamome'],
        nutritionalInfo: {
          'calories': 320,
          'proteins': 8,
          'carbs': 68,
          'fats': 4,
        },
      ),

      Dish(
        id: 'carbs_003',
        name: 'Patates Douces Rôties',
        description: 'Patates douces rôties aux épices berbères, source d\'énergie naturelle',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=500&h=300&fit=crop',
        category: DishCategory.carbs,
        ingredients: ['Patates douces', 'Épices berbères', 'Huile d\'olive'],
        nutritionalInfo: {
          'calories': 280,
          'proteins': 4,
          'carbs': 58,
          'fats': 6,
        },
      ),

      Dish(
        id: 'carbs_004',
        name: 'Quinoa aux Légumes Grillés',
        description: 'Quinoa bio avec légumes grillés, super-aliment pour sportifs',
        price: 42.00,
        imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500&h=300&fit=crop',
        category: DishCategory.carbs,
        ingredients: ['Quinoa bio', 'Légumes grillés', 'Herbes fraîches'],
        nutritionalInfo: {
          'calories': 350,
          'proteins': 14,
          'carbs': 55,
          'fats': 10,
        },
      ),

      // LIPIDES SAINS
      Dish(
        id: 'fats_001',
        name: 'Avocat aux Noix et Graines',
        description: 'Avocat frais avec mélange de noix et graines, lipides essentiels',
        price: 32.00,
        imageUrl: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=500&h=300&fit=crop',
        category: DishCategory.healthy_fats,
        ingredients: ['Avocat', 'Noix', 'Graines de tournesol', 'Graines de lin'],
        nutritionalInfo: {
          'calories': 420,
          'proteins': 8,
          'carbs': 15,
          'fats': 38,
        },
      ),

      Dish(
        id: 'fats_002',
        name: 'Salade d\'Olives Marocaines',
        description: 'Mélange d\'olives marocaines à l\'huile d\'argan, antioxydants naturels',
        price: 28.00,
        imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500&h=300&fit=crop',
        category: DishCategory.healthy_fats,
        ingredients: ['Olives vertes', 'Olives noires', 'Huile d\'argan', 'Herbes'],
        nutritionalInfo: {
          'calories': 180,
          'proteins': 2,
          'carbs': 8,
          'fats': 18,
        },
      ),

      Dish(
        id: 'fats_003',
        name: 'Amandes Grillées aux Épices',
        description: 'Amandes du Maroc grillées aux épices traditionnelles',
        price: 35.00,
        imageUrl: 'https://images.unsplash.com/photo-1508736793122-f516e3ba5569?w=500&h=300&fit=crop',
        category: DishCategory.healthy_fats,
        ingredients: ['Amandes', 'Épices marocaines', 'Sel de mer'],
        nutritionalInfo: {
          'calories': 320,
          'proteins': 12,
          'carbs': 12,
          'fats': 28,
        },
      ),

      // COMPLÉMENTS
      Dish(
        id: 'supplements_001',
        name: 'Smoothie Protéiné aux Dattes',
        description: 'Smoothie énergétique aux dattes Medjool et protéines végétales',
        price: 25.00,
        imageUrl: 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=500&h=300&fit=crop',
        category: DishCategory.supplements,
        ingredients: ['Dattes Medjool', 'Protéines végétales', 'Lait d\'amande'],
        nutritionalInfo: {
          'calories': 280,
          'proteins': 25,
          'carbs': 35,
          'fats': 8,
        },
      ),

      Dish(
        id: 'supplements_002',
        name: 'Thé Vert à la Menthe',
        description: 'Thé vert traditionnel marocain à la menthe fraîche, antioxydant',
        price: 15.00,
        imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=500&h=300&fit=crop',
        category: DishCategory.supplements,
        ingredients: ['Thé vert', 'Menthe fraîche', 'Miel'],
        nutritionalInfo: {
          'calories': 25,
          'proteins': 0,
          'carbs': 6,
          'fats': 0,
        },
      ),

      Dish(
        id: 'supplements_003',
        name: 'Jus d\'Orange Frais',
        description: 'Jus d\'orange fraîchement pressé, vitamine C naturelle',
        price: 18.00,
        imageUrl: 'https://images.unsplash.com/photo-1571068316344-75bc76f77890?w=500&h=300&fit=crop',
        category: DishCategory.supplements,
        ingredients: ['Oranges fraîches'],
        nutritionalInfo: {
          'calories': 110,
          'proteins': 2,
          'carbs': 26,
          'fats': 0,
        },
      ),

      Dish(
        id: 'supplements_004',
        name: 'Eau de Coco Naturelle',
        description: 'Eau de coco pure, hydratation naturelle post-entraînement',
        price: 22.00,
        imageUrl: 'https://images.unsplash.com/photo-1571068316344-75bc76f77890?w=500&h=300&fit=crop',
        category: DishCategory.supplements,
        ingredients: ['Eau de coco pure'],
        nutritionalInfo: {
          'calories': 45,
          'proteins': 2,
          'carbs': 9,
          'fats': 0,
        },
      ),

      Dish(
        id: 'supplements_005',
        name: 'Infusion de Gingembre',
        description: 'Infusion de gingembre frais, anti-inflammatoire naturel',
        price: 16.00,
        imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=500&h=300&fit=crop',
        category: DishCategory.supplements,
        ingredients: ['Gingembre frais', 'Citron', 'Miel'],
        nutritionalInfo: {
          'calories': 20,
          'proteins': 0,
          'carbs': 5,
          'fats': 0,
        },
      ),
    ];
  }

  static List<Dish> getDishesByCategory(DishCategory category) {
    return getAllDishes().where((dish) => dish.category == category).toList();
  }

  static List<Dish> getPopularDishes() {
    return getAllDishes().take(6).toList();
  }

  static List<Dish> searchDishes(String query) {
    final lowercaseQuery = query.toLowerCase();
    return getAllDishes()
        .where((dish) =>
            dish.name.toLowerCase().contains(lowercaseQuery) ||
            dish.description.toLowerCase().contains(lowercaseQuery) ||
            dish.ingredients.any((ingredient) =>
                ingredient.toLowerCase().contains(lowercaseQuery)))
        .toList();
  }
}