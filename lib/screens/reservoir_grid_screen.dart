import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/reservoir_monitor_service.dart';
import '../components/reservoir_gauge_card.dart';

class ReservoirGridScreen extends StatelessWidget {
  const ReservoirGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<ReservoirMonitorService>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: service.plants.length,
      itemBuilder: (context, idx) {
        final plant = service.plants[idx];
        return ReservoirGaugeCard(
          plant: plant,
          onRefill: () {
            service.refillReservoir(plant.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Refilled reservoir for ${plant.plantName}!')),
            );
          },
        );
      },
    );
  }
}
