import SwiftUI

struct DetailView: View {
    let item: Item
    @State private var verificationResult: String? = nil
    @State private var isVerifying: Bool = false

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

                Divider()

                // Verify Button
                Button(action: verifyMetadata) {
                    Text(isVerifying ? "Verifying..." : "Verify")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(isVerifying)

                // Result Output
                if let result = verificationResult {
                    Text("Verification Result: \(result)")
                        .font(.caption)
                        .foregroundColor(result.contains("Success") ? .green : .red)
                }
            }
            .padding()
        }
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Mock verification logic
    func verifyMetadata() {
        isVerifying = true
        verificationResult = nil

        // Simulate async task (replace with real logic)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let metadata = item.metadata, metadata.keys.contains("TIFF") {
                verificationResult = "Success: Verified TIFF metadata"
            } else {
                verificationResult = "Failure: No valid TIFF data"
            }
            isVerifying = false
        }
    }
}
