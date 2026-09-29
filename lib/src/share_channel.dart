import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Which sharing mechanism a [ShareChannel] triggers. Kept separate from
/// [ShareChannel] itself so [ShareUtils.share] can switch on it without
/// depending on any particular icon/color/label choice.
enum ShareChannelType {
  whatsapp,
  sms,
  facebook,
  email,

  /// The platform's own share sheet (`share_plus`'s `Share.share`) -
  /// "More" in the default set, since it's the catch-all for every other
  /// app installed on the device.
  system,
}

/// One button's worth of presentation for a share channel: what it's
/// called, what it looks like, and which [ShareChannelType] it triggers.
/// [ShareButtonsRow] and [showShareMenu] both render a `List<ShareChannel>`
/// - override [ShareChannel.defaults] entirely, or copyWith() one of the
/// built-in constants to tweak just its color/label/icon.
@immutable
class ShareChannel {
  final ShareChannelType type;
  final String label;
  final IconData icon;
  final Color color;

  /// Replaces the default `Icon(icon, ...)` entirely when set - use this
  /// to drop in a brand SVG/asset instead of the Material glyph, without
  /// this package needing an `flutter_svg` (or any image-loading)
  /// dependency of its own.
  final Widget? customChild;

  const ShareChannel({
    required this.type,
    required this.label,
    required this.icon,
    required this.color,
    this.customChild,
  });

  ShareChannel copyWith({
    String? label,
    IconData? icon,
    Color? color,
    Widget? customChild,
  }) {
    return ShareChannel(
      type: type,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      customChild: customChild ?? this.customChild,
    );
  }

  static const whatsapp = ShareChannel(
    type: ShareChannelType.whatsapp,
    label: 'WhatsApp',
    icon: Icons.chat_bubble,
    color: Color(0xFF25D366),
  );

  static const sms = ShareChannel(
    type: ShareChannelType.sms,
    label: 'SMS',
    icon: Icons.sms,
    color: Color(0xFF34C759),
  );

  static const facebook = ShareChannel(
    type: ShareChannelType.facebook,
    label: 'Facebook',
    icon: Icons.facebook,
    color: Color(0xFF1877F2),
  );

  static const email = ShareChannel(
    type: ShareChannelType.email,
    label: 'Email',
    icon: Icons.mail,
    color: Color(0xFF4285F4),
  );

  /// Rendered with `Icons.ios_share` on iOS instead of [icon] - handled
  /// by [ShareIcon] at build time (platform, not app state, decides it),
  /// not baked in here so this whole class can stay a plain `const`.
  static const system = ShareChannel(
    type: ShareChannelType.system,
    label: 'More',
    icon: Icons.share,
    color: Color(0xFF6B7280),
  );

  /// The row this package ships as its default - WhatsApp, SMS, Facebook,
  /// Email, then the system share sheet last as the catch-all.
  static const List<ShareChannel> defaults = [
    whatsapp,
    sms,
    facebook,
    email,
    system,
  ];
}
