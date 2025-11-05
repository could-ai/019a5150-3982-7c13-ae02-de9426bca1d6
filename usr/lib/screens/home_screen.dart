import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/bordereau_item.dart';
import 'package:couldai_user_app/screens/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _projectNameController = TextEditingController();
  final _surfaceController = TextEditingController();
  final _dimensionsController = TextEditingController();

  @override
  void dispose() {
    _projectNameController.dispose();
    _surfaceController.dispose();
    _dimensionsController.dispose();
    super.dispose();
  }

  void _generateBordereau() {
    if (_formKey.currentState!.validate()) {
      // For demonstration, we'll use mock data for the generated items.
      // In a real app, this would come from an analysis of the images and data.
      final List<BordereauItem> items = [
        BordereauItem(description: 'Réparation de fissure murale - Enduit', quantity: 5, unitPrice: 15.0),
        BordereauItem(description: 'Peinture acrylique blanche (m²)', quantity: 20, unitPrice: 10.5),
        BordereauItem(description: 'Remplacement de tuile cassée', quantity: 3, unitPrice: 25.0),
        BordereauItem(description: 'Main d\'œuvre spécialisée (heure)', quantity: 8, unitPrice: 45.0),
      ];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            projectName: _projectNameController.text,
            items: items,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau Projet de Maintenance'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Informations sur le projet',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _projectNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom du projet ou référence',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business_center),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom de projet';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _surfaceController,
                  decoration: const InputDecoration(
                    labelText: 'Surface (ex: 50 m²)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.square_foot),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dimensionsController,
                  decoration: const InputDecoration(
                    labelText: 'Dimensions (ex: 10x5x3 m)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.straighten),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement image picking logic using image_picker package
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fonctionnalité de téléchargement d\'images à venir!')),
                    );
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Télécharger des Images'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _generateBordereau,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Analyser et Générer le Bordereau'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
