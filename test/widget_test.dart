import 'package:flutter_test/flutter_test.dart';
import 'package:pelkora/pelkora_app.dart';

void main() {
  testWidgets('PelkoraApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PelkoraApp());
    expect(find.text('Reservoir Status Gauge'), findsWidgets);
    expect(find.text('REFILL TO MAXIMUM (100%)'), findsOneWidget);
  });
}
