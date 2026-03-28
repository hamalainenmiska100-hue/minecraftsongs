import SwiftUI

struct AmethystCard<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            content
        }
        .padding(16)
        .background(Palette.panel.opacity(0.9))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(Palette.panelBorder.opacity(0.45), lineWidth: 1))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
