import 'package:flutter_test/flutter_test.dart';
import 'package:pelkora/pelkora_app.dart';

void main() {
  testWidgets('PelkoraApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PelkoraApp());
    await tester.pump();
    expect(find.text('Reservoirs'), findsWidgets);
  });
}
