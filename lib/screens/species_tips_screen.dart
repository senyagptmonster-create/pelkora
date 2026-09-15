import 'package:flutter/material.dart';
import '../theme/pelkora_botanical_theme.dart';

class SpeciesTipsScreen extends StatelessWidget {
  const SpeciesTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      {
        'title': 'Sub-Irrigation Basics',
        'desc': 'Capillary wicking pulls water from reservoir to root zone without saturating upper soil stem collar.',
      },
      {
        'title': 'Preventing Root Hypoxia',
        'desc': 'Allow reservoir to run completely empty for 2-3 days every month to aerate porous leca/perlite substrate.',
      },
      {
        'title': 'Mineral Salt Build-up Flush',
        'desc': 'Every 3 months, top-water generously until water flushes completely out drain port to eliminate fertilizer salts.',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tips.length,
      itemBuilder: (context, idx) {
        final t = tips[idx];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: PelkoraTheme.borderCard),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.spa, color: PelkoraTheme.botanicalGreen, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(t['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(t['desc']!, style: TextStyle(color: Colors.grey.shade700, fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        );
      },
    );
  }
}
