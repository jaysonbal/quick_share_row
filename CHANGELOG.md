## 0.1.7

- Hero banner image redesigned

## 0.1.6

- Added an optional `iconColor` parameter to `ShareButtonsRow` and
  `showShareMenu()` (and the underlying `ShareIcon.color`, default white)
  to tint every channel's glyph at once - separate from
  `ShareChannel.color`, which is each icon's circular background, and
  ignored on a channel using `ShareChannel.customChild` (an SVG/asset
  brings its own coloring).

## 0.1.5

- Widened the `share_plus` upper bound further, to `>=11.0.0 <14.0.0`
  (0.1.4 had widened it to `<13.0.0`). Checked share_plus's own changelog
  again: neither 12.0.0 nor 13.0.0 changed the `Share`/`SharePlus`/
  `ShareParams` API - both were breaking-change releases for build tooling
  only (Android Gradle/Kotlin minimums, win32, Flutter/Dart SDK floors) -
  so there's no reason to block a consuming app on share_plus 12.x or
  13.x either.

## 0.1.4

- Widened the `share_plus` upper bound to `>=11.0.0 <13.0.0` (was
  `<12.0.0`). share_plus 12.0.0's breaking changes were Android/Gradle
  build-tooling minimums (AGP, Gradle, Kotlin versions), not an API change,
  so there was no reason to block apps that already depend on
  `share_plus: ^12.0.1` or similar from adding this package.

## 0.1.3

- Fixed pub.dev score issues:
  - Shortened `pubspec.yaml`'s `description` to 137 characters (was several
    hundred) - pub.dev only indexes/displays the first 60-180.
  - Corrected the `share_plus` lower bound to `>=11.0.0 <12.0.0`. The
    previous `>=10.0.0` floor was wrong: `SharePlus.instance`/`ShareParams`
    (used in `toSystem()`) were actually introduced in share_plus 11.0.0,
    not 10.0.0 - pub.dev's "compatible with dependency constraint lower
    bounds" check resolves the floor version exactly and caught that those
    identifiers don't exist there (`flutter pub downgrade` + `analyze`
    reproduces it).
- Added the hero banner image to the top of `README.md`.

## 0.1.2

- Fixed the pub.dev screenshots (`assets/screenshot-row.png`,
  `assets/screenshot-popup.png`): the previous versions were hard-clipped
  partway down the phone mockup (a render-viewport bug during image
  generation, not a code issue) and had a faint grey halo around the
  rounded corners instead of true transparency. Both now render the full
  phone with a shadow that fades cleanly to transparent on any background.
- No code changes in this release - assets/metadata only.

## 0.1.1

- Fixed `deprecated_member_use`: `ShareUtils.toSystem()` now calls
  `SharePlus.instance.share(ShareParams(...))` instead of the deprecated
  static `Share.share(...)`.
- Bumped the `share_plus` constraint to `>=10.0.0 <12.0.0` - required for
  the `SharePlus.instance`/`ShareParams` API used above.
- Added `homepage` and `repository` links to `pubspec.yaml`.
- Added `screenshots:` (ShareButtonsRow inline row, showShareMenu() popup)
  so they render in the carousel on the pub.dev listing page, and embedded
  the same two images in the README.

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
