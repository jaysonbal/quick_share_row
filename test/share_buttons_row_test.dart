import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_share_row/quick_share_row.dart';

void main() {
  test('ShareChannel.defaults has the five built-in channels in order', () {
    expect(ShareChannel.defaults.map((c) => c.type), [
      ShareChannelType.whatsapp,
      ShareChannelType.sms,
      ShareChannelType.facebook,
      ShareChannelType.email,
      ShareChannelType.system,
    ]);
  });

  testWidgets('ShareButtonsRow renders one ShareIcon per channel',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ShareButtonsRow(message: 'hello', url: 'https://example.com'),
        ),
      ),
    );

    expect(find.byType(ShareIcon), findsNWidgets(ShareChannel.defaults.length));
  });

  testWidgets('ShareButtonsRow respects a custom channel list',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ShareButtonsRow(
            message: 'hello',
            channels: [ShareChannel.whatsapp, ShareChannel.sms],
          ),
        ),
      ),
    );

    expect(find.byType(ShareIcon), findsNWidgets(2));
  });

  testWidgets('ShareIcon shows a tooltip with the channel label',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShareIcon(channel: ShareChannel.whatsapp, onTap: () {}),
        ),
      ),
    );

    expect(find.byTooltip('WhatsApp'), findsOneWidget);
  });
}
