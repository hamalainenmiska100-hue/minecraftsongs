import SwiftUI

struct RootView: View {
    @StateObject private var player = PlayerEngine()

    var body: some View {
        ZStack {
            LinearGradient(colors: [Palette.bgTop, Palette.bgBottom], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            TabView {
                NavigationStack { HomeView(player: player).navigationTitle("Home") }
                    .tabItem { Label("Home", systemImage: "house.fill") }

                NavigationStack { LibraryView(player: player).navigationTitle("Library") }
                    .tabItem { Label("Library", systemImage: "music.note.list") }

                NavigationStack { SettingsView(player: player).navigationTitle("Settings") }
                    .tabItem { Label("Settings", systemImage: "gearshape.fill") }
            }
            .tint(Palette.accent)

            if player.showDeveloperOverlay {
                VStack {
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("DEV")
                            Text("Song: \(player.currentSong.title)")
                            Text("Playing: \(player.isPlaying ? "Yes" : "No")")
                            Text("Mode: \(player.loopMode.rawValue)")
                        }
                        .font(.caption2.monospaced())
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    }
                    Spacer()
                }
            }
        }
        .onOpenURL { url in
            player.handle(url: url)
        }
    }
}
