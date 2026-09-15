import 'package:flutter/material.dart';
import '../theme/pelkora_botanical_theme.dart';

class MoistureHistoryScreen extends StatelessWidget {
  const MoistureHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      {'date': 'Today', 'event': 'Refilled Fiddle Leaf Fig reservoir (2000ml)', 'status': 'Optimal'},
      {'date': '2 days ago', 'event': 'Monstera reached 80% reservoir milestone', 'status': 'Healthy'},
      {'date': '5 days ago', 'event': 'ZZ Plant capillary wick checked and rinsed', 'status': 'Maintained'},
      {'date': '1 week ago', 'event': 'Peace Lily water reservoir drained and flushed', 'status': 'Optimal'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: history.length,
      itemBuilder: (context, idx) {
        final item = history[idx];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: PelkoraTheme.borderCard),
          ),
          child: ListTile(
            leading: const Icon(Icons.history, color: PelkoraTheme.reservoirAqua),
            title: Text(item['event']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            subtitle: Text(item['date']!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: PelkoraTheme.creamBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(item['status']!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: PelkoraTheme.botanicalGreen)),
            ),
          ),
        );
      },
    );
  }
}
