// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.29.0-SNAPSHOT-07-30--09-28.git-0417397"
let commonVersion = Version("24.29.0-SNAPSHOT-07-30--09-28.git-0417397")
let navigationNativeVersion = Version("324.29.0-SNAPSHOT-07-30--09-28.git-0417397")
let coreMapsVersion = Version("11.29.0-SNAPSHOT-07-30--09-28.git-0417397")

let checksumNavSdkBase = "7895f3aa0656cd48927b7355aebea78226ca2da271cc6216ac63234eddc381ae"
let checksumNavSdk = "32df510f9e54f260015203ab7fe7b3831b771b10327ff17787bac1f07b2747c7"
let checksumNavSdkMapComponents = "60dd0f559c7555e8bb3ae1ee24f57f2d66085801c4270eb851889c8cdbb44491"
let checksumNavSdkNavigation = "6748b337725ca6060e1c1e8502d5e61904a6d90ea04fdecfb6dd8eadc374a54b"
let checksumMapsComponents = "b760abe165e011f55f578611a793a755df05d341784c6444c5e137ddefdab3fe"

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
                "MapboxNavSdk",
                "MapboxNavSdkBase",
                "MapboxNavSdkMapComponents",
                "MapboxNavSdkNavigation",
                "MapboxMapsComponents"
            ],
        ),
        .binaryTarget(
            name: "MapboxNavSdk",
            url: "https://api.mapbox.com/downloads/v2/navsdk-cpp-sdk/\(releaseType)/ios/\(version)/MapboxNavSdk.xcframework.zip",
            checksum: checksumNavSdk
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
            name: "MapboxMapsComponents",
            url: "https://api.mapbox.com/downloads/v2/mobile-maps-components/\(releaseType)/ios/\(version)/MapboxMapsComponents.xcframework.zip",
            checksum: checksumMapsComponents
        ),
    ],
)
