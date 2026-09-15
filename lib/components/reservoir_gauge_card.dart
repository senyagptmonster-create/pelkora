import 'package:flutter/material.dart';
import '../services/reservoir_monitor_service.dart';
import '../theme/pelkora_botanical_theme.dart';

class ReservoirGaugeCard extends StatelessWidget {
  final PlantReservoir plant;
  final VoidCallback onRefill;

  const ReservoirGaugeCard({
    super.key,
    required this.plant,
    required this.onRefill,
  });

  @override
  Widget build(BuildContext context) {
    final isLow = plant.needsRefill;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isLow ? PelkoraTheme.terracotta : PelkoraTheme.borderCard,
          width: isLow ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: (isLow ? PelkoraTheme.terracotta : PelkoraTheme.botanicalGreen).withValues(alpha: 0.15),
                  child: Icon(Icons.local_florist, color: isLow ? PelkoraTheme.terracotta : PelkoraTheme.botanicalGreen),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(plant.plantName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(plant.location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                Text(
                  '${plant.waterLevelPercent.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: isLow ? PelkoraTheme.terracotta : PelkoraTheme.reservoirAqua,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: (plant.waterLevelPercent / 100.0).clamp(0.0, 1.0),
                minHeight: 10,
                backgroundColor: PelkoraTheme.creamBg,
                valueColor: AlwaysStoppedAnimation(isLow ? PelkoraTheme.terracotta : PelkoraTheme.reservoirAqua),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    isLow ? '🚨 LOW RESERVOIR: ~2 days left' : 'Good: ~ ${plant.daysUntilEmpty} days remaining',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isLow ? PelkoraTheme.terracotta : Colors.grey.shade700,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: onRefill,
                  icon: const Icon(Icons.water_drop, size: 16),
                  label: const Text('Top Up (100%)'),
                  style: TextButton.styleFrom(foregroundColor: PelkoraTheme.reservoirAqua),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
