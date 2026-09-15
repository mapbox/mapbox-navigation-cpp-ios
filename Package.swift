// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.26.0-SNAPSHOT-09-15--08-57.git-ff8522a"
let commonVersion = Version("24.26.0-SNAPSHOT-09-15--08-57.git-ff8522a")
let navigationNativeVersion = Version("324.26.0-SNAPSHOT-09-15--08-57.git-ff8522a")
let coreMapsVersion = Version("11.26.0-SNAPSHOT-09-15--08-57.git-ff8522a")

let checksumNavSdkBase = "51d9be937e0ae5e31ff540ada716bff6d92bb8341eb5123d0a9f12f929f0c096"
let checksumNavSdk = "37546f3f7a71c0df57d81b9e1734eea13b6c29856123cc4b9af08f5200c491bf"
let checksumNavSdkMapComponents = "d898d5f8d18944e877234cedc15ade3f6de1712f9c8ac4504f51219b7caa36dd"
let checksumNavSdkNavigation = "a49b1a36d3dbfb5c54cdabd6e0e8aedfbd0559b026266cecd7328647c1deb2bc"
let checksumMapsComponents = "4a57cf085606a1b08a738a59a61cbb40b1a8928897701e0605d30306e0c5bbff"

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
