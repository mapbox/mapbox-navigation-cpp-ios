// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let privateBetaEnabled = FileManager.default
    .fileExists(atPath: FileManager.default
        .homeDirectoryForCurrentUser
        .appendingPathComponent(".mapbox-navigation-ios.navigation_sdks_private_beta")
        .path
    )

let version = "0.36.0-SNAPSHOT-11-16--16-10.git-049f6e4"
let commonVersion = Version("24.36.0-SNAPSHOT-11-16--16-10.git-049f6e4")
let navigationNativeVersion = Version("324.36.0-SNAPSHOT-11-16--16-10.git-049f6e4")
let coreMapsVersion = Version("11.36.0-SNAPSHOT-11-16--16-10.git-049f6e4")

let checksumNavSdkBase = "bfd3ae53feee9346780e4d5b4d62219c17fa12d094305cbf34812f898846517d"
let checksumNavSdk = "c4ac38c1345b1b0d257b9348b8414122c55fd3a87eae2cadb5c2b9b984785cc9"
let checksumNavSdkMapComponents = "93ee5ab929616e4be2c3cbd2ae3c6a0584bce379021fec6d0deddc944cf4c21c"
let checksumNavSdkNavigation = "9462ec512723a04d092a97882a40b2b1b2948ffe95cc87011fb7422b5d6585c9"
let checksumNavSdkRoadCameras = "d3dc5d2d6adedd85b24152b4ab5f202d00cef33ae56d2a519b0c1dcf0e50b1f2"
let checksumMapsComponents = "86d9741992766b465b43c6948706cc9b652b877346657d3346c25a17f17f721a"

let releaseType = "snapshots"

let package = Package(
    name: "MapboxNavigationCpp",
    // The Nav SDK Cpp doesn't support macOS but declared the minimum macOS requirement with downstream deps to enable `swift run` cli tools
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(
            name: "MapboxNavigationCpp",
            targets: ["MapboxNavigationCppWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/mapbox/mapbox-common-ios.git", exact: commonVersion),
        .package(url: "https://github.com/mapbox/mapbox-core-maps-ios.git", exact: coreMapsVersion),
        .package(url: "https://github.com/mapbox/mapbox-navigation-native-ios.git", exact: navigationNativeVersion)
    ],
    targets: [
        .target(
            name: "MapboxNavigationCppWrapper",
            dependencies: [
                .product(name: "MapboxCommon", package: "mapbox-common-ios"),
                .product(name: "MapboxCoreMaps", package: "mapbox-core-maps-ios"),
                .product(name: "MapboxNavigationNative", package: "mapbox-navigation-native-ios"),
                "MapboxNavSdkBase",
                "MapboxNavSdkMapComponents",
                "MapboxNavSdkNavigation",
                "MapboxNavSdkRoadCameras",
                "MapboxMapsComponents"
            ].updatedWithBetaFeatures(),
        ),
        .binaryTarget(
            name: "MapboxNavSdkBase",
            url: "https://api.mapbox.com/downloads/v2/navsdk-cpp-base/\(releaseType)/ios/\(version)/MapboxNavSdkBase.xcframework.zip",
            checksum: checksumNavSdkBase
        ),
        .binaryTarget(
            name: "MapboxNavSdkMapComponents",
            url: "https://api.mapbox.com/downloads/v2/navsdk-cpp-map-components/\(releaseType)/ios/\(version)/MapboxNavSdkMapComponents.xcframework.zip",
            checksum: checksumNavSdkMapComponents
        ),
        .binaryTarget(
            name: "MapboxNavSdkNavigation",
            url: "https://api.mapbox.com/downloads/v2/navsdk-cpp-navigation/\(releaseType)/ios/\(version)/MapboxNavSdkNavigation.xcframework.zip",
            checksum: checksumNavSdkNavigation
        ),
        .binaryTarget(
            name: "MapboxNavSdkRoadCameras",
            url: "https://api.mapbox.com/downloads/v2/navsdk-cpp-roadcam/\(releaseType)/ios/\(version)/MapboxNavSdkRoadCameras.xcframework.zip",
            checksum: checksumNavSdkRoadCameras
        ),
        .binaryTarget(
            name: "MapboxMapsComponents",
            url: "https://api.mapbox.com/downloads/v2/mobile-maps-components/\(releaseType)/ios/\(version)/MapboxMapsComponents.xcframework.zip",
            checksum: checksumMapsComponents
        ),
    ].updatedWithBetaFeatures(),
)

// MARK: - Private beta (MapboxNavSdk)

extension [Target.Dependency] {
    func updatedWithBetaFeatures() -> Self {
        var dependencies = self
        if privateBetaEnabled {
            dependencies.append("MapboxNavSdk")
        }
        return dependencies
    }
}

extension [PackageDescription.Target] {
    func updatedWithBetaFeatures() -> Self {
        var targets = self
        if privateBetaEnabled {
            targets.append(
                .binaryTarget(
                    name: "MapboxNavSdk",
                    url: "https://api.mapbox.com/downloads/v2/navsdk-cpp-sdk/\(releaseType)/ios/\(version)/MapboxNavSdk.xcframework.zip",
                    checksum: checksumNavSdk
                )
            )
        }
        return targets
    }
}
