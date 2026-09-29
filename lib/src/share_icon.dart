import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';

import 'share_channel.dart';

/// One circular, colored, tooltip-labeled tap target for a [ShareChannel].
/// [ShareButtonsRow] builds a row of these; use it directly if you want a
/// single channel's button somewhere else in your own layout.
class ShareIcon extends StatelessWidget {
  final ShareChannel channel;
  final VoidCallback onTap;
  final double size;
  final EdgeInsetsGeometry padding;

  const ShareIcon({
    super.key,
    required this.channel,
    required this.onTap,
    this.size = 40,
    this.padding = const EdgeInsets.only(right: 15),
  });

  @override
  Widget build(BuildContext context) {
    // "More" reads as the system share icon that actually matches the
    // running platform - Icons.share elsewhere, Icons.ios_share on iOS -
    // without ShareChannel.system itself needing to know about platforms.
    final isSystemOnIOS = channel.type == ShareChannelType.system &&
        defaultTargetPlatform == TargetPlatform.iOS;
    final icon = isSystemOnIOS ? Icons.ios_share : channel.icon;

    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Tooltip(
          message: channel.label,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: channel.color,
              shape: BoxShape.circle,
            ),
            child: channel.customChild ??
                Icon(
                  icon,
                  color: Colors.white,
                  size: size * 0.5,
                ),
          ),
        ),
      ),
    );
  }
}
