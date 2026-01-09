# 🍔 Gym Maroc Nutrition

![Flutter](https://img.shields.io/badge/Flutter-3.10+-blue?logo=flutter) ![Dart](https://img.shields.io/badge/Dart-3.0+-blue?logo=dart) ![License](https://img.shields.io/badge/License-MIT-green)

A modern and intuitive Flutter mobile application for exploring a sports nutrition menu in Morocco, featuring a vibrant and sleek UI designed for athletes and fitness enthusiasts.

## 📋 Table of Contents

- [✨ Overview](#-overview)
- [🚀 Features](#-features)
- [🎨 Design & Style](#-design--style)
- [🛠️ Tech Stack](#-tech-stack)
- [📁 Project Structure](#-project-structure)
- [⚙️ Installation & Setup](#-installation--setup)
- [📸 Screenshots](#-screenshots)
- [🎯 Technical Highlights](#-technical-highlights)
- [🔧 Customization](#-customization)
- [🐛 Troubleshooting](#-troubleshooting)
- [🔮 Future Features](#-future-features)
- [📜 License](#-license)
- [🤝 Contribution](#-contribution)
- [📧 Contact](#-contact)

## ✨ Overview

**Gym Maroc Nutrition** is a Flutter-based mobile app designed for athletes and fitness enthusiasts in Morocco, offering a seamless and visually appealing way to explore high-performance nutrition. With a responsive design, smooth animations, and a user-friendly interface, it provides an engaging experience for customers to browse healthy dishes, calculate macros, and optimize their fitness journey.

## 🚀 Features

### 📱 Navigation & Interface
- **Side Drawer**: Easy navigation to all pages.
- **Bottom Navigation Bar**: Quick access to key sections.
- **Responsive Design**: Adapts to small and large screens.
- **Dark/Light Mode**: Automatic theme switching.
- **Smooth Animations**: Elegant transitions for a polished feel.

### 🏠 Home Page
- Restaurant overview with essential details.
- Displays address, phone number, and opening hours.
- Animated statistics (e.g., number of dishes, average rating, total customers).
- Special offers showcased in a carousel.
- Modern design with gradients and animations.

### 🍽️ Interactive Menu
- **TabBar** for filtering by categories:
  - Starters
  - Main Courses
  - Desserts
  - Drinks
- **Dish Cards** with:
  - High-quality images
  - Name, description, and price
  - Like/Dislike buttons with counters
  - Comment system
  - Popularity badge
- **Search Bar**: Quick dish lookup.
- **Detailed Modal**: Full interaction for each dish.

### ❤️ Favorites System
- Add/remove favorite dishes.
- Dedicated page with statistics (total price, categories, average price).
- **Swipe-to-Delete**: Intuitive management.
- Local data persistence.

### 📞 Contact & About
- Complete restaurant information.
- **Contact Form**: Input validation included.
- Detailed opening hours.
- Social media links.
- Integration with phone, email, and maps.

### 💾 Data Persistence
- **Hive**: Fast local storage.
- **SharedPreferences**: User settings storage.
- Automatic saving of:
  - Favorites
  - Comments and ratings
  - Theme preferences
  - Interaction history

## 🎨 Design & Style

### Color Palette (Inspired by Burger King)
- **Primary Red**: `#D62300`
- **Yellow/Orange**: `#FFC72C`
- **Bright Orange**: `#FF6B35`
- **Dark Mode**: Dark grays with colorful accents

### Design Elements
- **Material 3**: Customized for a unique look.
- **Rounded Corners**: High BorderRadius for a modern aesthetic.
- **Soft Shadows**: Depth effect for visual hierarchy.
- **Gradients**: Highlight key elements.
- **Typography**: Google Fonts (Inter + Playfair Display).
- **Expressive Icons**: Consistent and visually appealing.

### Animations
- **Staggered Animations**: For lists and cards.
- **Hero Animations**: Smooth page transitions.
- **Fade/Slide Transitions**: Between pages.
- **Micro-Interactions**: On buttons and interactive elements.
- **Loading States**: With progress indicators.

## 🛠️ Tech Stack

### Framework & Tools
- **Flutter 3.10+**: Cross-platform UI framework.
- **Dart 3.0+**: Programming language.

### Main Packages
```yaml
dependencies:
  flutter:
    sdk: flutter
  # State & Persistence
  provider: ^6.0.5              # State management
  hive: ^2.2.3                  # Local database
  hive_flutter: ^1.1.0          # Hive extension for Flutter
  shared_preferences: ^2.2.2     # User preferences
  # UI
  google_fonts: ^6.1.0          # Google Fonts
  animations: ^2.0.8            # Advanced animations
  flutter_staggered_animations: ^1.1.1  # Staggered animations
  cached_network_image: ^3.3.0   # Network image caching
  # Utilities
  flutter_svg: ^2.0.9           # SVG support
  cupertino_icons: ^1.0.2       # iOS-style icons

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0         # Dart/Flutter linting
  hive_generator: ^2.0.1        # Hive adapters generation
  build_runner: ^2.4.7          # Code generation
```

## 📁 Project Structure

```
lib/
├── main.dart                  # App entry point
├── data/
│   └── sample_dishes.dart     # Sample dish data
├── models/
│   ├── dish.dart             # Dish data model
│   └── dish.g.dart           # Generated Hive adapter
├── providers/
│   ├── theme_provider.dart    # Theme management
│   ├── favorites_provider.dart # Favorites management
│   └── comments_provider.dart  # Comments/likes management
├── screens/
│   ├── splash_screen.dart     # Splash screen
│   ├── main_screen.dart       # Main screen with navigation
│   ├── home_screen.dart       # Home page
│   ├── menu_screen.dart       # Menu with TabBar
│   ├── favorites_screen.dart  # Favorites page
│   └── contact_screen.dart    # Contact page
├── widgets/
│   ├── custom_drawer.dart     # Navigation drawer
│   ├── dish_card.dart         # Dish card widget
│   └── animated_counter.dart  # Animated counter widget
└── utils/
    └── app_colors.dart        # Color constants
```

## ⚙️ Installation & Setup

### Prerequisites
- **Flutter SDK 3.10+**
- **Dart SDK 3.0+**
- **IDE**: VS Code, Android Studio, or IntelliJ
- **Simulator/Emulator** or physical device

### Installation Steps

1. **Clone the Project**
```bash
git clone [project-url]
cd gym_maroc_nutrition
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Generate Hive Adapters**
```bash
flutter packages pub run build_runner build
```

4. **Verify Flutter Setup**
```bash
flutter doctor
```

### Running the App

1. **Start the Application**
```bash
flutter run
```

2. **Build for Production**
```bash
# Android
flutter build apk --release
# iOS
flutter build ios --release
```

## 📸 Screenshots

### Home Screen
- Animated logo with scaling effect.
- Restaurant info with elegant cards.
- Animated statistics counters.
- Special offers in a horizontal carousel.

### Interactive Menu
- TabBar with icons for each category.
- Dish cards with images and details.
- Functional search bar.
- Detailed modal with comments and ratings.

### Favorites
- Personalized list of favorite dishes.
- Statistics (total price, average price).
- Swipe-to-delete functionality.
- Empty state with illustration.

### Contact
- Validated contact form.
- Complete restaurant information.
- Opening hours display.
- Social media buttons.

## 🎯 Technical Highlights

### Architecture
- **Provider Pattern**: For state management.
- **Separation of Concerns**: Models, Views, and Providers.
- **Modular Code**: Reusable components.

### Performance
- **Lazy Loading**: Images with caching.
- **Optimized Animations**: 60 FPS performance.
- **Fast Local Storage**: Using Hive.

### User Experience
- **Responsive Design**: Supports all screen sizes.
- **Intuitive Interactions**: Clear user feedback.
- **Smooth Navigation**: Seamless page transitions.

### Accessibility
- **Semantic Labels**: For screen readers.
- **High Contrast**: For readability.
- **Optimal Touch Targets**: For usability.

## 🔧 Customization

### Change Colors
Edit `lib/utils/app_colors.dart`:
```dart
static const Color primary = Color(0xFFYOUR_COLOR);
```

### Add Dishes
Update `lib/data/sample_dishes.dart`:
```dart
Dish(
  id: 'new_dish',
  name: 'Dish Name',
  description: 'Description...',
  price: 25.50,
  imageUrl: 'https://your-image.jpg',
  category: DishCategory.mains,
),
```

### Modify Animations
Adjust durations in screen files:
```dart
duration: const Duration(milliseconds: 400),
```

## 🐛 Troubleshooting

### Common Issues

1. **Hive Build Error**
```bash
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
```

2. **Image Cache Issue**
```bash
flutter clean
flutter pub get
```

3. **Dependency Errors**
```bash
flutter pub deps
flutter pub upgrade
```

## 🔮 Future Features

- [ ] **Reservation System**: Integrated booking.
- [ ] **Mobile Payments**: Stripe integration.
- [ ] **Push Notifications**: For special offers.
- [ ] **Offline Mode**: Full functionality without internet.
- [ ] **Social Sharing**: Share dishes on social media.
- [ ] **Loyalty System**: Points-based rewards.
- [ ] **Live Chat**: Real-time customer support.
- [ ] **Voice Search**: Voice-activated dish search.
- [ ] **Augmented Reality**: Visualize dishes in AR.
- [ ] **Multilingual Support**: EN, ES, IT.

## 📜 License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## 🤝 Contribution

Contributions are welcome! To contribute:
1. **Fork** the project.
2. Create a **feature branch**.
3. **Commit** your changes.
4. **Push** to the branch.
5. Open a **Pull Request**.

## 📧 Contact

For any questions about the project:
- **Email**: achraferrahouti48@gmail.com
- **GitHub**: [achrafrahouti](https://github.com/achrafrahouti)

---

**Developed with ❤️ and Flutter**
