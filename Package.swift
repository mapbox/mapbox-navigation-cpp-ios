// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.27.0-SNAPSHOT-07-08--02-03.git-1aeadc3"
let commonVersion = Version("24.27.0-SNAPSHOT-07-08--02-03.git-1aeadc3")
let navigationNativeVersion = Version("324.27.0-SNAPSHOT-07-08--02-03.git-1aeadc3")
let coreMapsVersion = Version("11.27.0-SNAPSHOT-07-08--02-03.git-1aeadc3")

let checksumNavSdkBase = "a987711330f24dbc0c61e4bd7fcb8797a912bf08455481275660ee0f6628552a"
let checksumNavSdk = "9911ed2cb701fd8e7a49e97fdfa266121f08bc407cc8826079cf0fbc226a2c5f"
let checksumNavSdkMapComponents = "c86b11d4bc294ce8bc9367352d48a211ea0b7154b815250e8d5e13dd8e251c91"
let checksumNavSdkNavigation = "dabef0b1346070c87e4dee93403280c15c8130fe38170a244c7f871bccac6f6a"
let checksumMapsComponents = "754d76d488ea654c4770331f446ccf82eb5740c05ac4c61ffbc5d9f5bbe281ed"

let releaseType = "snapshots"

let package = Package(
    name: "MapboxNavigationCpp",
    platforms: [.iOS(.v14)],
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
