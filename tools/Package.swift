// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "catalog",
    platforms: [.macOS(.v14)],
    targets: [
        // Checks the records in data/, re-fetches every source to verify every quote, and renders catalog/.
        .executableTarget(name: "catalog"),
    ]
)
