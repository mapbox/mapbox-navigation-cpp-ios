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

let version = "0.33.0-SNAPSHOT-09-28--01-48.git-d288ecd"
let commonVersion = Version("24.33.0-SNAPSHOT-09-28--01-48.git-d288ecd")
let navigationNativeVersion = Version("324.33.0-SNAPSHOT-09-28--01-48.git-d288ecd")
let coreMapsVersion = Version("11.33.0-SNAPSHOT-09-28--01-48.git-d288ecd")

let checksumNavSdkBase = "f5f3da4a202981044cc75d63f0d1c40fb9fd77e6887280daf313c78f3ae7e85b"
let checksumNavSdk = "7f7914e4297909023d55e5622f0a0aeac4673eda75201a3775e71596a9e7d17e"
let checksumNavSdkMapComponents = "3d62976f8c0099b41dd0b0acde4b6ba5eb20043b58256c707f1299fb0224a8c3"
let checksumNavSdkNavigation = "c988a8cc4970a98b71902cd20cbf7d561ff434e161cc52d8d4ded9d124360eec"
let checksumNavSdkRoadCameras = "4b8615081824008daf63c3c08bf0d1c5702f0995d9ce765929536f0bab65e942"
let checksumMapsComponents = "4c8c3c7101dd9bbe13cabf8af2592c4ef0c39072595bd4e6ea37f1e546ef7749"

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
