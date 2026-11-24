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

let version = "0.37.0-SNAPSHOT-11-24--11-53.git-3ff02f8"
let commonVersion = Version("24.37.0-SNAPSHOT-11-24--11-53.git-3ff02f8")
let navigationNativeVersion = Version("324.37.0-SNAPSHOT-11-24--11-53.git-3ff02f8")
let coreMapsVersion = Version("11.37.0-SNAPSHOT-11-24--11-53.git-3ff02f8")

let checksumNavSdkBase = "d1a514d4e0920fb9ddd9c819b1dadccf4f67bdc94dc587934dbdd37d457f288c"
let checksumNavSdk = "ae57fc4948952c7204cfd9d14350398c1a984b81a7bb71cfe09dfbe014d762af"
let checksumNavSdkMapComponents = "a298e6ce34b7e21e0d36fd6cab2a4abe5720aed85a382189e1b8e15776d5f4a7"
let checksumNavSdkNavigation = "b4577c5c80e34754084e5b67551ac1037a241d65cf5590c19348d8fc37d76e14"
let checksumNavSdkRoadCameras = "ae60c15f90bcc23baec25a1b98230acb4844087de85f6e39244ac405cb348537"
let checksumMapsComponents = "7abdcc275b9a12e5e9daa243e5c9038d25eeeaee29cf1fcdd68110e2bf3fc677"

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
