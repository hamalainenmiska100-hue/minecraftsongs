import SwiftUI

struct LibraryView: View {
    @ObservedObject var player: PlayerEngine
    @State private var query = ""

    var filteredSongs: [Song] {
        if query.isEmpty { return player.songs }
        return player.songs.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        List(filteredSongs) { song in
            Button {
                player.play(song: song)
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(song.title)
                        Text("Track \(song.id)").font(.caption).foregroundStyle(.secondary)
                    }
                    Spacer()
                    if song == player.currentSong {
                        Image(systemName: "speaker.wave.2.fill").foregroundStyle(Palette.accent)
                    }
                }
            }
            .listRowBackground(Palette.panel.opacity(0.55))
        }
        .scrollContentBackground(.hidden)
        .searchable(text: $query, prompt: "Find a Minecraft song")
    }
}
