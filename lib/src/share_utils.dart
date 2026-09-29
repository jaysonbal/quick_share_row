import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'share_channel.dart';

/// Per-channel share mechanics: builds the right deep-link URL for each
/// app and launches it, or falls through to the OS share sheet. Stateless
/// static methods - no `BuildContext` required anywhere, so these are
/// safe to call from a provider/controller/notifier as well as a widget.
///
/// None of this reports errors itself (no toast, no snackbar, no
/// dependency on a particular UI-feedback package) - pass [onError] if
/// you want to react to a launch failure (app not installed, URL
/// rejected, etc); otherwise failures are silently swallowed, same as a
/// user just closing the target app without sending anything.
class ShareUtils {
  const ShareUtils._();

  static Future<void> toWhatsApp(
    String message, {
    void Function(Object error)? onError,
  }) {
    return _launch(
      'https://wa.me/?text=${Uri.encodeComponent(message)}',
      onError,
    );
  }

  static Future<void> toSms(
    String message, {
    void Function(Object error)? onError,
  }) {
    return _launch('sms:?body=${Uri.encodeComponent(message)}', onError);
  }

  /// Facebook's web share dialog only ever accepts a bare URL (the `u`
  /// query param) - it has no field for custom text, unlike every other
  /// channel here. Pass the link itself, not a composed message.
  static Future<void> toFacebook(
    String url, {
    void Function(Object error)? onError,
  }) {
    return _launch(
      'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(url)}',
      onError,
    );
  }

  static Future<void> toEmail(
    String message, {
    String subject = '',
    void Function(Object error)? onError,
  }) {
    return _launch(
      'mailto:?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(message)}',
      onError,
    );
  }

  /// The platform's own share sheet, via `share_plus`.
  /// [sharePositionOrigin] is passed straight through - required by
  /// `share_plus` on iPad so the popover has somewhere to anchor from.
  ///
  /// Uses the `SharePlus.instance.share(ShareParams(...))` API (share_plus
  /// 10+) rather than the older static `Share.share(...)`, which that
  /// package has since deprecated.
  static Future<void> toSystem(
    String message, {
    String? subject,
    Rect? sharePositionOrigin,
    void Function(Object error)? onError,
  }) async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: message,
          subject: subject,
          sharePositionOrigin: sharePositionOrigin,
        ),
      );
    } catch (e) {
      onError?.call(e);
    }
  }

  /// Dispatches to the right method above by [channel] - what
  /// [ShareButtonsRow] and [showShareMenu] call internally, exposed
  /// directly in case you want to trigger one specific channel from your
  /// own custom UI without building a whole row or popup for it.
  ///
  /// [url] is used only for [ShareChannelType.facebook] (see [toFacebook]
  /// above); every other channel uses [message]. [subject] is used only
  /// for [ShareChannelType.email] and [ShareChannelType.system] (where
  /// share_plus/the OS may show it as a subject line, depending on the
  /// target app).
  static Future<void> share({
    required ShareChannelType channel,
    required String message,
    String? url,
    String? subject,
    Rect? sharePositionOrigin,
    void Function(Object error)? onError,
  }) {
    switch (channel) {
      case ShareChannelType.whatsapp:
        return toWhatsApp(message, onError: onError);
      case ShareChannelType.sms:
        return toSms(message, onError: onError);
      case ShareChannelType.facebook:
        return toFacebook(url ?? message, onError: onError);
      case ShareChannelType.email:
        return toEmail(message, subject: subject ?? '', onError: onError);
      case ShareChannelType.system:
        return toSystem(
          message,
          subject: subject,
          sharePositionOrigin: sharePositionOrigin,
          onError: onError,
        );
    }
  }

  static Future<void> _launch(
    String url,
    void Function(Object error)? onError,
  ) async {
    try {
      final uri = Uri.parse(url);
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        onError?.call('Could not launch $url');
      }
    } catch (e) {
      onError?.call(e);
    }
  }
}
