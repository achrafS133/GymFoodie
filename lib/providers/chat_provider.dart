import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;

  // Quick action suggestions
  final List<String> quickActions = [
    '💪 Recommandations protéines',
    '🔥 Plats pour perte de poids',
    '📞 Contact & Horaires',
    '🥗 Menu du jour',
    '💊 Conseils suppléments',
    '🏋️ Calculer mes macros',
  ];

  ChatProvider() {
    // Welcome message
    _messages.add(ChatMessage(
      text: 'Bienvenue chez Gym Maroc Nutrition! 💪\n\nJe suis votre assistant nutrition. Comment puis-je vous aider aujourd\'hui?',
      isUser: false,
    ));
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    // Add user message
    _messages.add(ChatMessage(text: text, isUser: true));
    notifyListeners();

    // Simulate typing
    _isTyping = true;
    notifyListeners();

    // Generate response after delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      _isTyping = false;
      _messages.add(ChatMessage(
        text: _generateResponse(text),
        isUser: false,
      ));
      notifyListeners();
    });
  }

  String _generateResponse(String query) {
    final lowerQuery = query.toLowerCase();

    // Protein recommendations
    if (lowerQuery.contains('protéine') || lowerQuery.contains('protein') || lowerQuery.contains('muscle') || lowerQuery.contains('masse')) {
      return '💪 **Nos meilleures sources de protéines:**\n\n'
          '• **Bowl Poulet Grillé** - 35g de protéines\n'
          '• **Steak de Thon** - 32g de protéines\n'
          '• **Omelette Sportive** - 28g de protéines\n\n'
          'Pour une prise de masse, visez 1.6-2.2g de protéines par kg de poids corporel! 🎯';
    }

    // Weight loss
    if (lowerQuery.contains('perte') || lowerQuery.contains('maigrir') || lowerQuery.contains('régime') || lowerQuery.contains('calories')) {
      return '🔥 **Pour la perte de poids, je recommande:**\n\n'
          '• **Salade Power** - 180 kcal seulement\n'
          '• **Bowl Quinoa Légumes** - 220 kcal\n'
          '• **Wrap Poulet Light** - 250 kcal\n\n'
          'Conseil: Créez un déficit de 300-500 kcal/jour pour une perte saine! 📉';
    }

    // Contact & Hours
    if (lowerQuery.contains('contact') || lowerQuery.contains('horaire') || lowerQuery.contains('téléphone') || lowerQuery.contains('adresse')) {
      return '📞 **Nos coordonnées:**\n\n'
          '📍 123 Avenue Mohammed V, Casablanca\n'
          '📱 +212 6 12 34 56 78\n'
          '💬 WhatsApp: +212 6 12 34 56 78\n\n'
          '🕐 **Horaires:**\n'
          'Lun-Sam: 8h00 - 22h00\n'
          'Dimanche: 10h00 - 18h00';
    }

    // Menu
    if (lowerQuery.contains('menu') || lowerQuery.contains('plat') || lowerQuery.contains('manger')) {
      return '🥗 **Notre menu du jour:**\n\n'
          '**Protéines:**\n'
          '• Bowl Poulet Grillé - 45 DH\n'
          '• Steak de Thon - 55 DH\n\n'
          '**Glucides sains:**\n'
          '• Bowl Quinoa Power - 40 DH\n'
          '• Patate Douce Farcie - 35 DH\n\n'
          'Consultez l\'onglet Nutrition pour voir tous nos plats! 📱';
    }

    // Supplements
    if (lowerQuery.contains('supplément') || lowerQuery.contains('whey') || lowerQuery.contains('créatine') || lowerQuery.contains('vitamine')) {
      return '💊 **Nos compléments disponibles:**\n\n'
          '• **Whey Protein** - Après entraînement\n'
          '• **BCAA** - Pendant l\'entraînement\n'
          '• **Créatine** - Force et récupération\n'
          '• **Multivitamines** - Bien-être général\n\n'
          'Demandez conseil à nos experts en boutique! 👨‍⚕️';
    }

    // Macros calculator
    if (lowerQuery.contains('macro') || lowerQuery.contains('calcul') || lowerQuery.contains('calorie') || lowerQuery.contains('besoin')) {
      return '🧮 **Calculateur de Macros**\n\n'
          'Utilisez notre calculateur intégré pour déterminer:\n'
          '• Vos besoins caloriques journaliers\n'
          '• Votre répartition en macronutriments\n'
          '• Votre IMC\n\n'
          'Accédez-y depuis l\'accueil en cliquant sur "Calculateur de Macros"! 📊';
    }

    // Greeting
    if (lowerQuery.contains('bonjour') || lowerQuery.contains('salut') || lowerQuery.contains('hello') || lowerQuery.contains('salam')) {
      return 'Bonjour et bienvenue! 👋\n\n'
          'Je suis là pour vous aider avec:\n'
          '• Recommandations nutritionnelles\n'
          '• Informations sur nos plats\n'
          '• Conseils pour vos objectifs fitness\n\n'
          'Que puis-je faire pour vous? 😊';
    }

    // Thanks
    if (lowerQuery.contains('merci') || lowerQuery.contains('thank')) {
      return 'Avec plaisir! 🙏\n\n'
          'N\'hésitez pas si vous avez d\'autres questions.\n'
          'Bonne journée et bon entraînement! 💪🔥';
    }

    // Default response
    return '🤔 Je comprends votre question!\n\n'
        'Pour une assistance plus personnalisée, vous pouvez:\n'
        '• Nous appeler au +212 6 12 34 56 78\n'
        '• Nous contacter via WhatsApp\n'
        '• Visiter notre boutique\n\n'
        'Ou essayez une de ces options:\n'
        '💪 Protéines | 🔥 Perte de poids | 📞 Contact';
  }

  void clearChat() {
    _messages.clear();
    _messages.add(ChatMessage(
      text: 'Conversation réinitialisée. Comment puis-je vous aider? 😊',
      isUser: false,
    ));
    notifyListeners();
  }
}
