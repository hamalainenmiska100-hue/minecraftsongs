# Ore Beats (iOS)

A React + TypeScript Minecraft song player with an Ore-inspired UI theme, targeted for iOS packaging via Capacitor.

## Features
- Start menu + animated transitions.
- Player with all provided Minecraft songs.
- Settings:
  - Normal playback.
  - **Auto-play forever** (random endless songs).
  - **Forever play** (single track repeat forever).
  - Crossfade duration.
- Developer options overlay.
- iOS Shortcuts compatibility through URL scheme actions:
  - `orebeats://play`
  - `orebeats://shuffle`
  - `orebeats://repeat`
- Copyright disclaimer included in-app.

## Run locally
```bash
npm install
npm run dev
```

## iOS
```bash
npm run ios:sync
npm run ios:open
```

## Build unsigned IPA
Use GitHub Actions workflow: `.github/workflows/build-unsigned-ipa.yml`.
It archives without code signing and packages `OreBeats-unsigned.ipa` as an artifact.

## Notes
- Mojang ore-ui repository: <https://github.com/Mojang/ore-ui>
- This app uses an Ore-inspired visual style for fan project UI.
