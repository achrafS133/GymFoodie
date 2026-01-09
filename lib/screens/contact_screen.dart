import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  late AnimationController _headerController;
  late Animation<double> _headerAnimation;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _headerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutBack,
    ));

    _headerController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: ListView(
          padding: EdgeInsets.zero,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 400),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildContactInfo(),
              const SizedBox(height: 20),
              _buildLocationSection(),
              const SizedBox(height: 20),
              _buildContactForm(),
              const SizedBox(height: 20),
              _buildSocialMedia(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _headerAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _headerAnimation.value,
          child: Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      gradient: AppColors.primaryGradient.scale(0.8),
                    ),
                  ),
                ),

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [AppColors.cardShadow],
                        ),
                        child: const Icon(
                          Icons.contact_mail_rounded,
                          size: 35,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Contactez-nous',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Votre coach nutrition vous écoute',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  icon: Icons.phone_rounded,
                  title: 'Téléphone',
                  subtitle: '+212 5 22 XX XX XX',
                  color: AppColors.primary,
                  onTap: () => _launchPhone('+212522XXXXXX'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoCard(
                  icon: Icons.email_rounded,
                  title: 'Email',
                  subtitle: 'contact@gymmaroc.ma',
                  color: AppColors.accent,
                  onTap: () => _launchEmail('contact@gymmaroc.ma'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            icon: Icons.location_on_rounded,
            title: 'Adresse',
            subtitle: 'Avenue Mohammed V, Casablanca, Maroc',
            color: AppColors.secondary,
            onTap: () => _launchMaps(),
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            icon: Icons.chat_rounded,
            title: 'WhatsApp Nutrition',
            subtitle: 'Conseils personnalisés & Commandes: +212 6 XX XX XX XX',
            color: Colors.green,
            onTap: () {
              // TODO: WhatsApp Launcher
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [AppColors.cardShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                height: 1.3,
              ),
            ),
            if (onTap != null) ...[
              const SizedBox(height: 8),
              Icon(
                Icons.arrow_forward_rounded,
                color: color,
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppColors.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.access_time_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Horaires d\'ouverture',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildScheduleItem('Lundi - Vendredi', '12h00 - 14h30 | 19h00 - 23h00'),
          _buildScheduleItem('Samedi', '12h00 - 15h00 | 19h00 - 23h30'),
          _buildScheduleItem('Dimanche', '12h00 - 15h00 | 19h00 - 22h30'),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.info.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.info,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Consultation nutritionnelle sur rendez-vous',
                    style: TextStyle(
                      color: AppColors.info,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              day,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 3,
            child: Text(
              hours,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppColors.cardShadow],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.message_rounded,
                    color: AppColors.accent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Envoyez-nous un message',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Nom
            TextFormField(
              controller: _nameController,
              decoration: _buildInputDecoration(
                label: 'Nom complet',
                icon: Icons.person_rounded,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Veuillez entrer votre nom';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Email
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: _buildInputDecoration(
                label: 'Email',
                icon: Icons.email_rounded,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Veuillez entrer votre email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                  return 'Email invalide';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Téléphone
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: _buildInputDecoration(
                label: 'Téléphone (optionnel)',
                icon: Icons.phone_rounded,
              ),
            ),

            const SizedBox(height: 16),

            // Message
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: _buildInputDecoration(
                label: 'Message',
                icon: Icons.chat_rounded,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Veuillez entrer votre message';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            // Bouton d'envoi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 4,
                  shadowColor: AppColors.primary.withOpacity(0.3),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Envoyer le message',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildSocialMedia() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppColors.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suivez-nous',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSocialButton(
                icon: Icons.facebook_rounded,
                label: 'Facebook',
                color: const Color(0xFF1877F2),
                onTap: () => _launchSocial('facebook'),
              ),
              _buildSocialButton(
                icon: Icons.camera_alt_rounded,
                label: 'Instagram',
                color: const Color(0xFFE4405F),
                onTap: () => _launchSocial('instagram'),
              ),
              _buildSocialButton(
                icon: Icons.alternate_email_rounded,
                label: 'Twitter',
                color: const Color(0xFF1DA1F2),
                onTap: () => _launchSocial('twitter'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    // Simulation d'envoi
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSubmitting = false;
    });

    // Reset form
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();

    // Show success message
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: AppColors.success),
            SizedBox(width: 8),
            Text('Message envoyé'),
          ],
        ),
        content: const Text(
          'Merci pour votre message ! Nous vous répondrons dans les plus brefs délais.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _launchPhone(String phone) {
    // TODO: Implémenter l'ouverture du téléphone
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ouverture du téléphone...'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _launchEmail(String email) {
    // TODO: Implémenter l'ouverture de l'email
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ouverture de l\'email...'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _launchMaps() {
    // TODO: Implémenter l'ouverture de Maps
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ouverture de Maps...'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _launchSocial(String platform) {
    // TODO: Implémenter l'ouverture des réseaux sociaux
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ouverture de $platform...'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}