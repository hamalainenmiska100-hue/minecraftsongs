import SwiftUI

struct SettingsView: View {
    @ObservedObject var player: PlayerEngine

    var body: some View {
        Form {
            Section("Playback") {
                Picker("Mode", selection: $player.loopMode) {
                    Text("Normal").tag(LoopMode.normal)
                    Text("Auto-play Forever (Random)").tag(LoopMode.shuffleForever)
                    Text("Forever Play (Same Song)").tag(LoopMode.singleForever)
                }

                HStack {
                    Text("Crossfade")
                    Slider(value: $player.crossfadeSeconds, in: 0...4, step: 0.2)
                }
                Text("\(player.crossfadeSeconds, specifier: "%.1f")s")
                    .font(.caption)
            }

            Section("Developer") {
                Toggle("Show Developer Overlay", isOn: $player.showDeveloperOverlay)
                Text("Shortcuts URLs")
                Text("amethyst://play")
                Text("amethyst://shuffle")
                Text("amethyst://repeat")
            }
        }
        .scrollContentBackground(.hidden)
    }
}
