import 'package:flutter/widgets.dart';

import 'share_channel.dart';
import 'share_icon.dart';
import 'share_utils.dart';

/// A ready-made row of [ShareIcon]s wired straight to [ShareUtils.share] -
/// the inline version. Drop it under a "Share this" heading, in a bottom
/// sheet, wherever a row fits. For a long-press context menu instead, see
/// `showShareMenu`.
///
/// ```dart
/// ShareButtonsRow(
///   message: 'Check out this listing!\n\nhttps://example.com/item/42',
///   url: 'https://example.com/item/42', // used for Facebook specifically
///   subject: 'A listing you might like',
/// )
/// ```
class ShareButtonsRow extends StatelessWidget {
  /// The full text sent to WhatsApp, SMS, Email, and the system share
  /// sheet - typically your message plus the link, already concatenated.
  final String message;

  /// The bare link, used only for the Facebook channel (its share dialog
  /// has no field for free text - see `ShareUtils.toFacebook`). Falls
  /// back to [message] if omitted, which is rarely what you want if
  /// [message] has more than just a URL in it.
  final String? url;

  /// Used as the subject line for Email, and passed through to the
  /// system share sheet's own subject field where the target app supports
  /// one.
  final String? subject;

  /// Which channels to show, and in what order. Defaults to
  /// [ShareChannel.defaults] (WhatsApp, SMS, Facebook, Email, system).
  final List<ShareChannel> channels;

  final EdgeInsetsGeometry padding;
  final double iconSize;
  final MainAxisAlignment mainAxisAlignment;

  /// Called when a specific channel fails to launch (app not installed,
  /// URL rejected, etc). Left unset, failures are silent.
  final void Function(Object error)? onError;

  const ShareButtonsRow({
    super.key,
    required this.message,
    this.url,
    this.subject,
    this.channels = ShareChannel.defaults,
    this.padding = EdgeInsets.zero,
    this.iconSize = 40,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          for (final channel in channels)
            ShareIcon(
              channel: channel,
              size: iconSize,
              onTap: () => ShareUtils.share(
                channel: channel.type,
                message: message,
                url: url,
                subject: subject,
                onError: onError,
              ),
            ),
        ],
      ),
    );
  }
}
