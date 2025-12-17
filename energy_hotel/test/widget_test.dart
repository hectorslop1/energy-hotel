import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_hotel/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: EnergyHotelApp()));
    await tester.pumpAndSettle();
    expect(find.text('Energy Hotel'), findsWidgets);
  });
}
