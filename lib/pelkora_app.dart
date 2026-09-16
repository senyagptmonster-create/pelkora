import 'package:flutter/material.dart';
import 'theme/pelkora_theme.dart';
import 'painters/reservoir_level_painter.dart';

class PelkoraApp extends StatelessWidget {
  const PelkoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pelkora Plant Reservoirs',
      debugShowCheckedModeBanner: false,
      theme: PelkoraTheme.themeData,
      home: const PelkoraShell(),
    );
  }
}

class PelkoraShell extends StatefulWidget {
  const PelkoraShell({super.key});

  @override
  State<PelkoraShell> createState() => _PelkoraShellState();
}

class _PelkoraShellState extends State<PelkoraShell> {
  int _navIndex = 0;
  double _waterLevel = 0.68; // 68% full
  final double _capacityL = 2.5;

  final List<Map<String, dynamic>> _plants = [
    {
      'name': 'Monstera Deliciosa',
      'location': 'Living Room Window',
      'level': 0.68,
      'capacity': '2.5 L',
      'daysLeft': '6 days',
      'status': 'Optimal',
    },
    {
      'name': 'Fiddle Leaf Fig',
      'location': 'Studio Corner',
      'level': 0.22,
      'capacity': '3.0 L',
      'daysLeft': '2 days',
      'status': 'Refill Soon',
    },
    {
      'name': 'Peace Lily (Spathiphyllum)',
      'location': 'Office Desk',
      'level': 0.85,
      'capacity': '1.2 L',
      'daysLeft': '9 days',
      'status': 'Full',
    },
    {
      'name': 'Calathea Orbifolia',
      'location': 'Bedroom Shelf',
      'level': 0.12,
      'capacity': '1.5 L',
      'daysLeft': '1 day',
      'status': 'Critical',
    },
  ];

  int _selectedPlantIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getTitle(_navIndex),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: PelkoraTheme.ink,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                color: PelkoraTheme.bg,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.eco_rounded, size: 36, color: PelkoraTheme.accent),
                    SizedBox(height: 12),
                    Text(
                      'PELKORA BOTANICS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: PelkoraTheme.ink,
                      ),
                    ),
                    Text(
                      'Self-Watering Reservoir Monitor',
                      style: TextStyle(fontSize: 12, color: PelkoraTheme.muted),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: PelkoraTheme.edge),
              _buildDrawerItem(0, 'Reservoir Status Gauge', Icons.water_drop_rounded),
              _buildDrawerItem(1, 'Sub-Irrigated Plants', Icons.yard_rounded),
              _buildDrawerItem(2, 'Refill Schedule', Icons.calendar_month_rounded),
              _buildDrawerItem(3, 'Care & Wick Guide', Icons.menu_book_rounded),
            ],
          ),
        ),
      ),
      body: _buildCurrentBody(),
    );
  }

  String _getTitle(int idx) {
    switch (idx) {
      case 0: return 'Reservoir Status Gauge';
      case 1: return 'Sub-Irrigated Plants';
      case 2: return 'Refill Schedule';
      case 3: return 'Care & Wick Guide';
      default: return 'Pelkora Botanics';
    }
  }

  Widget _buildDrawerItem(int index, String title, IconData icon) {
    final isSel = _navIndex == index;
    return ListTile(
      leading: Icon(icon, color: isSel ? PelkoraTheme.accent : PelkoraTheme.muted),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
          color: isSel ? PelkoraTheme.accent : PelkoraTheme.ink,
        ),
      ),
      selected: isSel,
      selectedTileColor: PelkoraTheme.edge.withValues(alpha: 0.3),
      onTap: () {
        setState(() => _navIndex = index);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildCurrentBody() {
    switch (_navIndex) {
      case 0: return _buildGaugeScreen();
      case 1: return _buildPlantsScreen();
      case 2: return _buildScheduleScreen();
      case 3: return _buildGuideScreen();
      default: return _buildGaugeScreen();
    }
  }

  Widget _buildGaugeScreen() {
    final currentPlant = _plants[_selectedPlantIdx];
    final currentLiters = _capacityL * _waterLevel;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(currentPlant['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('${(_waterLevel * 100).toStringAsFixed(0)}% FULL', style: const TextStyle(fontWeight: FontWeight.bold, color: PelkoraTheme.accent)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: CustomPaint(
                      painter: ReservoirLevelPainter(
                        fillPercentage: _waterLevel,
                        currentLiters: currentLiters,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${currentLiters.toStringAsFixed(2)} L',
                              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: PelkoraTheme.ink),
                            ),
                            Text(
                              'Remaining in Basin',
                              style: const TextStyle(fontSize: 12, color: PelkoraTheme.muted),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Float Level Indicator: Low Risk Zone',
                    style: const TextStyle(fontSize: 12, color: PelkoraTheme.muted),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Water top-up slider
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Simulate Water Consumption:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${(_waterLevel * 100).toStringAsFixed(0)} %', style: const TextStyle(fontWeight: FontWeight.bold, color: PelkoraTheme.accent)),
                    ],
                  ),
                  Slider(
                    value: _waterLevel,
                    min: 0.0,
                    max: 1.0,
                    activeColor: PelkoraTheme.accent,
                    inactiveColor: PelkoraTheme.edge,
                    onChanged: (v) => setState(() => _waterLevel = v),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => setState(() => _waterLevel = 1.0),
                    icon: const Icon(Icons.water_rounded),
                    label: const Text('REFILL TO MAXIMUM (100%)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PelkoraTheme.accent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(44),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantsScreen() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _plants.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final p = _plants[i];
        final isSel = i == _selectedPlantIdx;
        return Card(
          color: isSel ? PelkoraTheme.edge.withValues(alpha: 0.3) : PelkoraTheme.surface,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: PelkoraTheme.edge,
              child: Icon(Icons.local_florist_rounded, color: PelkoraTheme.accent),
            ),
            title: Text(p['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${p['location']} • Basin: ${p['capacity']}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(p['daysLeft'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: PelkoraTheme.accent)),
                Text(p['status'] as String, style: const TextStyle(fontSize: 11, color: PelkoraTheme.muted)),
              ],
            ),
            onTap: () => setState(() {
              _selectedPlantIdx = i;
              _waterLevel = p['level'] as double;
              _navIndex = 0;
            }),
          ),
        );
      },
    );
  }

  Widget _buildScheduleScreen() {
    final schedule = [
      {'plant': 'Calathea Orbifolia', 'due': 'Tomorrow (Oct 17)', 'amount': '1.5 L', 'urgent': true},
      {'plant': 'Fiddle Leaf Fig', 'due': 'In 2 days (Oct 18)', 'amount': '3.0 L', 'urgent': false},
      {'plant': 'Monstera Deliciosa', 'due': 'In 6 days (Oct 22)', 'amount': '2.5 L', 'urgent': false},
      {'plant': 'Peace Lily', 'due': 'In 9 days (Oct 25)', 'amount': '1.2 L', 'urgent': false},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: schedule.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final s = schedule[i];
        final isUrgent = s['urgent'] as bool;
        return Card(
          child: ListTile(
            leading: Icon(
              isUrgent ? Icons.notification_important_rounded : Icons.schedule_rounded,
              color: isUrgent ? Colors.orange : PelkoraTheme.accent,
            ),
            title: Text(s['plant'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Due: ${s['due']}'),
            trailing: Text(s['amount'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: PelkoraTheme.accent)),
          ),
        );
      },
    );
  }

  Widget _buildGuideScreen() {
    final tips = [
      {'title': 'Wick Capillary Action', 'desc': 'Ensure fiberglass wicks reach 2/3 depth into the potting mix for even moisture.'},
      {'title': 'Dry-Out Buffer Periods', 'desc': 'Allow the reservoir to remain empty for 1-2 days before refilling to oxygenate roots.'},
      {'title': 'Mineral Salt Flushing', 'desc': 'Top-water thoroughly every 3 months to flush accumulated fertilizer salts from the medium.'},
      {'title': 'LECA Drainage Base', 'desc': 'A 2-inch layer of expanded clay pebbles prevents potting soil from contacting stagnant water.'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: tips.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final t = tips[i];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: PelkoraTheme.edge,
              child: Text('${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold, color: PelkoraTheme.ink)),
            ),
            title: Text(t['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle: Text(t['desc']!, style: const TextStyle(fontSize: 12, color: PelkoraTheme.muted)),
          ),
        );
      },
    );
  }
}
