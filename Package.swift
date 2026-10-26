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

let version = "0.35.0-SNAPSHOT-10-26--14-36.git-15d97db"
let commonVersion = Version("24.35.0-SNAPSHOT-10-26--14-36.git-15d97db")
let navigationNativeVersion = Version("324.35.0-SNAPSHOT-10-26--14-36.git-15d97db")
let coreMapsVersion = Version("11.35.0-SNAPSHOT-10-26--14-36.git-15d97db")

let checksumNavSdkBase = "4159dee4c2209f076effaae33302cdc1b6c3ca80d09d67e664a4cb8c54e0f4a9"
let checksumNavSdk = "6b463d699eaf9d8f147072f42bd86c1ec46df532493e04b8b8ba642a95e9bac7"
let checksumNavSdkMapComponents = "b61dafa418ed6cc1253d65b63468be471c4c74c76c6f5f8cf47b27a31bf76dbd"
let checksumNavSdkNavigation = "6df3406d8ff7690ca3cd939ddac078466cce77fdfd41dd3a9a67a85f956296d4"
let checksumNavSdkRoadCameras = "4446ce49d0b4f16a91e45dbf9cd68a3bd8039605595ec423dd231e102506f8e9"
let checksumMapsComponents = "0c38ee8280caa71ce6b021a5c02104548debc5f13b1808a9bd1db9d167ba787b"

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
