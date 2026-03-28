import SwiftUI

struct HomeView: View {
    @ObservedObject var player: PlayerEngine

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                AmethystCard {
                    Text("Amethyst")
                        .font(.largeTitle.bold())
                    Text("Native Swift iOS Minecraft player. Dark + purple. Smooth and clean.")
                        .foregroundStyle(.secondary)
                    Text("Copyright: Minecraft is owned by Mojang Studios. Fan project only.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                AmethystCard {
                    Text("Quick Actions")
                        .font(.headline)
                    HStack {
                        Button("Play") { player.play(song: player.currentSong) }
                        Button("Shuffle Forever") { player.loopMode = .shuffleForever; player.next() }
                        Button("Repeat Forever") { player.loopMode = .singleForever; player.play(song: player.currentSong) }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Palette.accent)
                }

                AmethystCard {
                    Text("Now")
                        .font(.headline)
                    Text(player.currentSong.title)
                        .font(.title2.weight(.semibold))
                    HStack {
                        Button(player.isPlaying ? "Pause" : "Play") { player.togglePlayback() }
                        Button("Next") { player.next() }
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(.horizontal)
        }
    }
}
