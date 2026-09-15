import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/pelkora_botanical_theme.dart';
import 'services/reservoir_monitor_service.dart';
import 'screens/reservoir_grid_screen.dart';
import 'screens/refill_schedule_screen.dart';
import 'screens/moisture_history_screen.dart';
import 'screens/species_tips_screen.dart';

class PelkoraApp extends StatelessWidget {
  const PelkoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReservoirMonitorService(),
      child: MaterialApp(
        title: 'Pelkora Plant Water',
        theme: PelkoraTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const PelkoraHomeScaffold(),
      ),
    );
  }
}

class PelkoraHomeScaffold extends StatefulWidget {
  const PelkoraHomeScaffold({super.key});

  @override
  State<PelkoraHomeScaffold> createState() => _PelkoraHomeScaffoldState();
}

class _PelkoraHomeScaffoldState extends State<PelkoraHomeScaffold> {
  int _currentIndex = 0;

  final _titles = ['Reservoirs', 'Refill Schedule', 'Moisture Logs', 'Sub-Irrigation Tips'];
  final _screens = const [
    ReservoirGridScreen(),
    RefillScheduleScreen(),
    MoistureHistoryScreen(),
    SpeciesTipsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.opacity_outlined), selectedIcon: Icon(Icons.opacity), label: 'Reservoirs'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Schedule'),
          NavigationDestination(icon: Icon(Icons.show_chart_outlined), selectedIcon: Icon(Icons.show_chart), label: 'Logs'),
          NavigationDestination(icon: Icon(Icons.tips_and_updates_outlined), selectedIcon: Icon(Icons.tips_and_updates), label: 'Tips'),
        ],
      ),
    );
  }
}
