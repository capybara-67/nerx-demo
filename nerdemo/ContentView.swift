import SwiftUI

private struct DemoOffer: Identifiable {
    let id: Int
    let title: String
    let business: String
    let category: String
    let reward: String
    let detail: String
}

struct ContentView: View {
    @State private var query = ""
    @State private var showSaved = false
    @AppStorage("saved-offer-ids") private var savedData = Data()
    private var saved: Set<Int> { BookmarkCodec.decode(savedData) }
    @State private var selected: DemoOffer?
    private let accent = Color(red: 0.65, green: 0.48, blue: 1)
    private let offers = [
        DemoOffer(id: 1, title: "A coffee worth sharing", business: "Matcha House UB", category: "Food", reward: "Coffee for two", detail: "Visit a local café and share a short story about your experience. This sample offer demonstrates the collaboration flow."),
        DemoOffer(id: 2, title: "Find your next workout", business: "FitZone", category: "Fitness", reward: "One-week gym pass", detail: "Try a new training space and create a short reel. This demo uses sample data and does not send applications."),
        DemoOffer(id: 3, title: "Make the city your runway", business: "StyleMN", category: "Fashion", reward: "A piece from the collection", detail: "Choose a look and show how you style it. Example content only; no agreement or purchase is created.")
    ]
    private var visibleOffers: [DemoOffer] {
        offers.filter { offer in
            (!showSaved || saved.contains(offer.id)) &&
            (query.isEmpty || (offer.title + offer.business + offer.category).localizedCaseInsensitiveContains(query))
        }
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HStack(spacing: 14) {
                        Image("logo").resizable().scaledToFit().frame(width: 64, height: 64).clipShape(RoundedRectangle(cornerRadius: 16)).accessibilityLabel("Collab logo")
                        VStack(alignment: .leading, spacing: 4) {
                            Text("collab.mn").font(.largeTitle.bold())
                            Text("Local brands. Creative people.").foregroundStyle(.secondary)
                        }
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Small collaborations,\nbig possibilities.").font(.system(size: 30, weight: .bold))
                        Text("Browse example offers, save a favorite, and see the details.").foregroundStyle(.secondary)
                        Label("Interactive demo · sample offers", systemImage: "info.circle").font(.caption).foregroundStyle(accent)
                    }
                    Toggle("Show saved offers", isOn: $showSaved).tint(accent)
                    if visibleOffers.isEmpty {
                        ContentUnavailableView("No matching offers", systemImage: "magnifyingglass", description: Text("Try a different search or turn off the saved filter."))
                    }
                    ForEach(visibleOffers) { offer in
                        VStack(alignment: .leading, spacing: 14) {
                            HStack {
                                Text(offer.category.uppercased()).font(.caption.bold()).foregroundStyle(accent)
                                Spacer()
                                Button {
                                    savedData = BookmarkCodec.toggling(offer.id, in: savedData)
                                } label: {
                                    Image(systemName: saved.contains(offer.id) ? "bookmark.fill" : "bookmark")
                                        .padding(8)
                                }
                                .accessibilityLabel(saved.contains(offer.id) ? "Unsave \(offer.title)" : "Save \(offer.title)")
                            }
                            Text(offer.title).font(.title3.bold())
                            Text(offer.business).foregroundStyle(.secondary)
                            Label(offer.reward, systemImage: "gift").font(.subheadline)
                            Button("View offer") { selected = offer }
                                .buttonStyle(.borderedProminent).tint(accent)
                        }
                        .padding(20).frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 20))
                    }
                }
                .padding(24)
            }
            .background(Color(red: 0.05, green: 0.05, blue: 0.09))
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $query, prompt: "Search brands or categories")
            .sheet(item: $selected) { offer in
                NavigationStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(offer.title).font(.largeTitle.bold())
                        Text(offer.business).foregroundStyle(.secondary)
                        Label(offer.reward, systemImage: "gift").foregroundStyle(accent)
                        Text(offer.detail)
                        Spacer()
                    }
                    .padding(24)
                    .navigationTitle("Sample offer")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { selected = nil } } }
                }
                .preferredColorScheme(.dark)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View { ContentView() }
}
