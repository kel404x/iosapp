import SwiftUI

struct DetailView: View {
    let item: Item

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: item.url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }

                Divider()

                Text("Image Metadata")
                    .font(.headline)

                if let metadata = item.metadata {
                    ForEach(metadata.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        Text("\(key): \(value)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } else {
                    Text("No metadata found.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
    }
}
