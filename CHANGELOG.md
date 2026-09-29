## 0.1.0

- Initial release.
- `ShareChannel` / `ShareChannelType` - WhatsApp, SMS, Facebook, Email, and
  the system share sheet, each with a default icon/color/label,
  overridable via `copyWith`.
- `ShareUtils` - static, context-free per-channel share methods
  (`toWhatsApp`, `toSms`, `toFacebook`, `toEmail`, `toSystem`) plus a
  `share(channel: ...)` dispatcher.
- `ShareIcon` - a single circular, tooltip-labeled channel button.
- `ShareButtonsRow` - a ready-made row of `ShareIcon`s for any channel
  list.
- `showShareMenu` - the same row shown in a floating popup anchored at a
  tap/long-press position, for a context-menu-style share UI.
