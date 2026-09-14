import 'package:flutter/material.dart';
import '../app/brand.dart';
import '../app/theme.dart';
import 'pelkora_store.dart';

class PelkoraMainScreen extends StatefulWidget {
  const PelkoraMainScreen({super.key});
  @override
  _PelkoraMainScreenState createState() => _PelkoraMainScreenState();
}

class _PelkoraMainScreenState extends State<PelkoraMainScreen> {
  final PelkoraStore _store = PelkoraStore();
  Widget? _currentScreen;
  String _title = 'Reservoir Status';

  @override
  void initState() {
    super.initState();
    _currentScreen = _buildStatusGrid();
    _store.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  void _nav(Widget screen, String title) {
    setState(() {
      _currentScreen = screen;
      _title = title;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBg,
      appBar: AppBar(
        title: Text(_title, style: AppTheme.display(cSurface)),
        backgroundColor: cAccent,
      ),
      drawer: Drawer(
        backgroundColor: cSurface,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: cAccent),
              child: Text('Pelkora Nav', style: AppTheme.display(cSurface)),
            ),
            ListTile(title: Text('Status Grid', style: AppTheme.text(cInk)), onTap: () => _nav(_buildStatusGrid(), 'Reservoir Status')),
            ListTile(title: Text('Refill Schedule', style: AppTheme.text(cInk)), onTap: () => _nav(_buildSchedule(), 'Refill Schedule')),
            ListTile(title: Text('Moisture Logs', style: AppTheme.text(cInk)), onTap: () => _nav(_buildLogs(), 'Moisture Logs')),
            ListTile(title: Text('Species Tips', style: AppTheme.text(cInk)), onTap: () => _nav(_buildTips(), 'Species Tips')),
          ],
        ),
      ),
      body: _currentScreen,
    );
  }

  Widget _buildStatusGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
      itemCount: _store.reservoirs.length,
      itemBuilder: (context, index) {
        final r = _store.reservoirs[index];
        bool low = r['level'] < 30;
        return Container(
          decoration: BoxDecoration(color: cSurface, borderRadius: BorderRadius.circular(12), border: Border.all(color: low ? Colors.red : cEdge)),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(r['name'], style: AppTheme.display(cInk)),
              const SizedBox(height: 8),
              Icon(Icons.water_drop, color: low ? Colors.red : cAccent, size: 40),
              const SizedBox(height: 8),
              Text('${r['level']}% Full', style: AppTheme.text(low ? Colors.red : cAccent2)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSchedule() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _store.reservoirs.length,
      itemBuilder: (context, index) {
        final r = _store.reservoirs[index];
        return Card(
          color: cSurface,
          child: ListTile(
            title: Text(r['name'], style: AppTheme.display(cInk)),
            subtitle: Text('Next refill: ${r['nextRefill']}', style: AppTheme.text(cAccent2)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: cAccent),
              onPressed: () => _store.refill(index),
              child: Text('Refill', style: AppTheme.text(cSurface)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogs() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _store.logs.length,
      itemBuilder: (context, index) {
        final l = _store.logs[index];
        return ListTile(
          title: Text(l['plant'], style: AppTheme.text(cInk)),
          subtitle: Text(l['date'], style: AppTheme.text(cEdge)),
          trailing: Text('${l['moisture']}%', style: AppTheme.display(cAccent)),
        );
      },
    );
  }

  Widget _buildTips() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _store.tips.length,
      itemBuilder: (context, index) {
        final t = _store.tips[index];
        return ExpansionTile(
          title: Text(t['species'], style: AppTheme.display(cInk)),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(t['tip'], style: AppTheme.text(cAccent2)),
            )
          ],
        );
      },
    );
  }
}
