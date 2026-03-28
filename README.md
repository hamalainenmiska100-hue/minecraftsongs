# Amethyst (Native iOS Swift App)

Amethyst is a **native SwiftUI iOS app** for playing Minecraft songs with a modern dark-purple design.

## Highlights
- Native Swift (SwiftUI) app architecture.
- Multi-screen UX with tabs: Home, Library, Settings.
- Smooth dark/purple visual theme designed for iOS.
- Built-in playback features:
  - Normal playback
  - Auto-play forever (random)
  - Forever play (same song)
- iOS Shortcuts URL scheme support:
  - `amethyst://play`
  - `amethyst://shuffle`
  - `amethyst://repeat`
- Developer overlay and playback controls.
- Copyright disclaimer in app content.

## Project structure
- `Amethyst/project.yml` (XcodeGen spec)
- `Amethyst/Sources/Amethyst/*` (SwiftUI app source)

## Build locally (native)
1. Install Xcode + Xcode command line tools.
2. Install XcodeGen (`brew install xcodegen`).
3. Generate project:
   ```bash
   cd Amethyst
   xcodegen generate
   ```
4. Open `Amethyst.xcodeproj` in Xcode and run on iOS simulator/device.

## Unsigned IPA CI workflow
Use `.github/workflows/build-unsigned-ipa.yml` (manual `workflow_dispatch`).
The workflow generates the Xcode project via XcodeGen, archives without code signing, and exports an unsigned IPA artifact.
