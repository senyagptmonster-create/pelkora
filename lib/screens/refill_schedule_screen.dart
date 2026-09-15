import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/reservoir_monitor_service.dart';
import '../theme/pelkora_botanical_theme.dart';

class RefillScheduleScreen extends StatelessWidget {
  const RefillScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<ReservoirMonitorService>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: PelkoraTheme.borderCard),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Active Plant Reservoirs', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      const SizedBox(height: 6),
                      Text('${service.plants.length} Monitored Pots',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: PelkoraTheme.botanicalGreen,
                          )),
                      Text(
                        service.urgentAlertsCount > 0
                            ? '${service.urgentAlertsCount} pots need water soon'
                            : 'All reservoirs sufficiently filled',
                        style: TextStyle(
                          color: service.urgentAlertsCount > 0 ? PelkoraTheme.terracotta : PelkoraTheme.reservoirAqua,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.alarm_on, color: PelkoraTheme.botanicalGreen, size: 36),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Predicted Refill Forecast', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          ...service.plants.map((p) {
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: PelkoraTheme.borderCard),
              ),
              child: ListTile(
                title: Text(p.plantName, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('Capacity: ${p.reservoirCapacityMl}ml reservoir'),
                trailing: Text('In ${p.daysUntilEmpty} days',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: p.needsRefill ? PelkoraTheme.terracotta : PelkoraTheme.botanicalGreen,
                    )),
              ),
            );
          }),
        ],
      ),
    );
  }
}
