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

let version = "0.37.0-SNAPSHOT-11-20--01-22.git-e5992b5"
let commonVersion = Version("24.37.0-SNAPSHOT-11-20--01-22.git-e5992b5")
let navigationNativeVersion = Version("324.37.0-SNAPSHOT-11-20--01-22.git-e5992b5")
let coreMapsVersion = Version("11.37.0-SNAPSHOT-11-20--01-22.git-e5992b5")

let checksumNavSdkBase = "098e66715302535352ba049607be98053cbabe6abd55ecc9cd45e71453f733c5"
let checksumNavSdk = "0c6b548d830f5a53e3e96aa13ba9dfa58f8248eeba1cce08b903dc53110369a4"
let checksumNavSdkMapComponents = "945110a938a20c6721c06ea2184da22a8ab879f62b3f34283801dd26972ae06f"
let checksumNavSdkNavigation = "9669d1ce4ca7767961dd59eb02c08d6b0bb598f7397bc3e92ef423cfa69f8e67"
let checksumNavSdkRoadCameras = "e572e81b21debc86430ca690b8f467090513647694e33e4004ab51d489e5c185"
let checksumMapsComponents = "87a89a341a9eb09917ee8db3d080615d204aebac08627a0803020676ce425b18"

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
