import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/bordereau_item.dart';

class ResultScreen extends StatelessWidget {
  final String projectName;
  final List<BordereauItem> items;

  const ResultScreen({
    super.key,
    required this.projectName,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    double total = items.fold(0, (sum, item) => sum + item.total);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bordereau: $projectName'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analyse et Solution',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Anomalie détectée: Fissures murales et dégradation de la peinture dues à l\'humidité.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Solution proposée: Assainissement du mur, réparation des fissures avec un enduit spécialisé, et application de deux couches de peinture anti-humidité.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Détail des Prix',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 20,
                columns: const [
                  DataColumn(label: Text('Article')),
                  DataColumn(label: Text('Qté'), numeric: true),
                  DataColumn(label: Text('P.U.'), numeric: true),
                  DataColumn(label: Text('Total'), numeric: true),
                ],
                rows: [
                  ...items.map((item) => DataRow(
                    cells: [
                      DataCell(Text(item.description)),
                      DataCell(Text(item.quantity.toString())),
                      DataCell(Text('${item.unitPrice.toStringAsFixed(2)} €')),
                      DataCell(Text('${item.total.toStringAsFixed(2)} €')),
                    ],
                  )),
                  DataRow(
                    cells: [
                      DataCell(Text('Total HT', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('${total.toStringAsFixed(2)} €', style: TextStyle(fontWeight: FontWeight.bold))),
                    ]
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
