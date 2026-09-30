import 'package:flutter/material.dart';

import 'share_buttons_row.dart';
import 'share_channel.dart';

/// Shows [ShareButtonsRow] inside a floating popup anchored at [position]
/// - the long-press-to-share pattern (`onLongPressStart: (d) =>
/// showShareMenu(context, d.globalPosition, message: ...)`), as an
/// alternative to embedding the row directly in your layout.
///
/// The popup carries no `PopupMenuItem` value of its own, so tapping a
/// channel icon both shares AND closes the menu in one tap, without a
/// second, separate "confirm" step.
///
/// [iconColor] tints each channel's glyph (white by default) - it has no
/// effect on a channel using [ShareChannel.customChild], and is separate
/// from [ShareChannel.color], which is the icon's circular background.
Future<void> showShareMenu(
  BuildContext context,
  Offset position, {
  required String message,
  String? url,
  String? subject,
  List<ShareChannel> channels = ShareChannel.defaults,
  double iconSize = 40,
  Color iconColor = const Color(0xFFFFFFFF),
  Color backgroundColor = Colors.white,
  void Function(Object error)? onError,
}) {
  return showMenu<void>(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      position.dx + 1,
      position.dy + 1,
    ),
    color: backgroundColor,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    items: [
      PopupMenuItem<void>(
        enabled: false, // the row's own ShareIcon taps do the real work -
        // disabling the item itself stops it swallowing the first tap or
        // popping with a value the row never sets.
        child: Center(
          child: ShareButtonsRow(
            message: message,
            url: url,
            subject: subject,
            channels: channels,
            iconSize: iconSize,
            iconColor: iconColor,
            mainAxisAlignment: MainAxisAlignment.center,
            onError: onError,
          ),
        ),
      ),
    ],
  );
}
