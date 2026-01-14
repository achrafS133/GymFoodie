# GymFoodie - Sports Nutrition & Fitness Companion

![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-E8E8E8?style=for-the-badge&logo=android&logoColor=black)
![License](https://img.shields.io/badge/License-MIT-4CAF50?style=for-the-badge)

GymFoodie is a high-performance, aesthetically pleasing Flutter application designed for athletes and fitness enthusiasts. It bridges the gap between nutrition and performance, offering a curated menu of healthy dishes, personalized meal planning, and advanced nutritional tracking.

---

## Key Features

### Smart Nutrition Menu
- **Categorized Discovery**: Browse through Starters, Mains, Desserts, and Drinks.
- **Detailed Insights**: View macro-nutrients, descriptions, and popularity for every dish.
- **Interactive Feedback**: Like, dislike, and comment on dishes to engage with the community.

### Advanced Macro Calculator
- **TDEE Estimation**: Calculate your Total Daily Energy Expenditure using the Mifflin-St Jeor equation.
- **Goal-Oriented Planning**: Receive personalized calorie and macro targets (Protein, Carbs, Fats) based on your fitness goals (Weight Loss, Maintenance, or Bulking).
- **BMI Tracking**: Integrated Body Mass Index indicator with health status feedback.

### Personalized Meal Planner
- **Custom Schedules**: Organize your nutrition for the week.
- **Automated Suggestions**: Get recommendations tailored to your macro requirements.

### Intelligent AI Assistance
- **Support Chat**: Real-time assistance for nutritional questions or application support.
- **Micro-interactions**: Enhanced user experience with smooth animations and responsive feedback.

### Robust Persistence & UX
- **Hive Database**: Blazing fast local storage for favorites, comments, and settings.
- **Dark/Light Mode**: Premium adaptive UI with custom color palettes.
- **Hero Animations**: Seamless transitions between screens for a fluid feel.

---

## Professional Design System

- **Primary Paradigm**: Inspired by modern fitness aesthetics with a premium red and orange palette.
- **Material 3**: Customized components with high border radii and soft depth effects.
- **Typography**: Optimized for readability using Google Fonts (Inter & Playfair Display).
- **Staggered Animations**: List items and cards enter the view with elegant, timed transitions.

---

## Technical Stack

- **Frontend**: Flutter & Dart
- **State Management**: Provider Provider
- **Local Storage**: Hive & SharedPreferences
- **Animations**: Flutter Animate & Staggered Animations
- **Assets Support**: SVG Integration & Network Image Caching

---

## Project Structure

```text
lib/
├── data/          # Data sources and sample models
├── models/        # Hive-compatible data entities
├── providers/     # Business logic & state management
├── screens/       # UI Pages (Home, Menu, Calculator, Chat, etc.)
├── widgets/       # Reusable UI components
└── utils/         # Constants, Themes, and App Colors
```

---

## Setup & Installation

### Prerequisites
- Flutter SDK (v3.10.0 or higher)
- Android Studio / VS Code / IntelliJ
- Git

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/achrafS133/GymFoodie.git
   cd GymFoodie
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Data Adapters**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Launch Application**
   ```bash
   flutter run
   ```

---

## Author

**Achraf ER-RAHOUTI**
- GitHub: [@achrafS133](https://github.com/achrafS133)
- Email: [achraferrahouti48@gmail.com](mailto:achraferrahouti48@gmail.com)

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

<p align="center">
  Developed for the Fitness Community
</p>
