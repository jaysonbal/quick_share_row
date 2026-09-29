import 'package:flutter/material.dart';
import 'package:quick_share_row/quick_share_row.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'quick_share_row example',
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatelessWidget {
  const ExampleHome({super.key});

  static const _url = 'https://example.com/listing/42';
  static const _message =
      'Check out this listing!\n\n$_url\n\nShared via the example app';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('quick_share_row')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Inline row:'),
            const SizedBox(height: 12),
            const ShareButtonsRow(
              message: _message,
              url: _url,
              subject: 'A listing you might like',
            ),
            const SizedBox(height: 40),

            // Long-press this card to see the popup variant, same
            // channels, anchored at the touch point.
            GestureDetector(
              onLongPressStart: (details) => showShareMenu(
                context,
                details.globalPosition,
                message: _message,
                url: _url,
                subject: 'A listing you might like',
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('Long-press me to share'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
