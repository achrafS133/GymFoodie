import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Inputs
  double? _weight;
  double? _height;
  int? _age;
  String _gender = 'Homme';
  String _activityLevel = 'Modéré';
  String _goal = 'Maintien';

  // Results
  double? _bmi;
  double? _calories;
  Map<String, double>? _macros;

  final Map<String, double> _activityMultipliers = {
    'Sédentaire': 1.2,
    'Léger': 1.375,
    'Modéré': 1.55,
    'Actif': 1.725,
    'Très Actif': 1.9,
  };

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        // BMI Calculation
        _bmi = _weight! / ((_height! / 100) * (_height! / 100));

        // BMR (Mifflin-St Jeor Equation)
        double bmr;
        if (_gender == 'Homme') {
          bmr = (10 * _weight!) + (6.25 * _height!) - (5 * _age!) + 5;
        } else {
          bmr = (10 * _weight!) + (6.25 * _height!) - (5 * _age!) - 161;
        }

        // TDEE
        double tdee = bmr * _activityMultipliers[_activityLevel]!;

        // Goal Adjustment
        if (_goal == 'Perte de poids') {
          _calories = tdee - 500;
        } else if (_goal == 'Prise de masse') {
          _calories = tdee + 500;
        } else {
          _calories = tdee;
        }

        // Macros Breakdown (Example: 30% Protein, 40% Carbs, 30% Fats)
        _macros = {
          'Protéines': (_calories! * 0.30) / 4,
          'Glucides': (_calories! * 0.40) / 4,
          'Lipides': (_calories! * 0.30) / 9,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculateur Macros', style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Informations Personnelles'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Poids (kg)',
                      icon: Icons.monitor_weight_outlined,
                      onSaved: (v) => _weight = double.tryParse(v!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: 'Taille (cm)',
                      icon: Icons.height_outlined,
                      onSaved: (v) => _height = double.tryParse(v!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Âge',
                      icon: Icons.calendar_today_outlined,
                      onSaved: (v) => _age = int.tryParse(v!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown(
                      label: 'Genre',
                      value: _gender,
                      items: ['Homme', 'Femme'],
                      onChanged: (v) => setState(() => _gender = v!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Style de vie & Objectif'),
              const SizedBox(height: 16),
              _buildDropdown(
                label: 'Niveau d\'activité',
                value: _activityLevel,
                items: _activityMultipliers.keys.toList(),
                onChanged: (v) => setState(() => _activityLevel = v!),
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: 'Objectif',
                value: _goal,
                items: ['Perte de poids', 'Maintien', 'Prise de masse'],
                onChanged: (v) => setState(() => _goal = v!),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Calculer mes besoins',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              if (_calories != null) ...[
                const SizedBox(height: 40),
                _buildResults(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildTextField({required String label, required IconData icon, required Function(String?) onSaved}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      keyboardType: TextInputType.number,
      validator: (v) => (v == null || v.isEmpty) ? 'Requis' : null,
      onSaved: onSaved,
    );
  }

  Widget _buildDropdown({required String label, required String value, required List<String> items, required Function(String?) onChanged}) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildResults() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Text(
                'Besoins Journaliers Estimés',
                style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              Text(
                '${_calories!.toStringAsFixed(0)} kcal',
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMacroResult('Protéines', '${_macros!['Protéines']!.toStringAsFixed(0)}g', AppColors.primary),
                  _buildMacroResult('Glucides', '${_macros!['Glucides']!.toStringAsFixed(0)}g', AppColors.accent),
                  _buildMacroResult('Lipides', '${_macros!['Lipides']!.toStringAsFixed(0)}g', AppColors.secondary),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildBmiIndicator(),
      ],
    );
  }

  Widget _buildMacroResult(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _buildBmiIndicator() {
    String status;
    Color color;
    if (_bmi! < 18.5) {
      status = 'Poids insuffisant';
      color = Colors.blue;
    } else if (_bmi! < 25) {
      status = 'Poids normal';
      color = Colors.green;
    } else if (_bmi! < 30) {
      status = 'Surpoids';
      color = Colors.orange;
    } else {
      status = 'Obésité';
      color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Votre IMC est de ${_bmi!.toStringAsFixed(1)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(status, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
