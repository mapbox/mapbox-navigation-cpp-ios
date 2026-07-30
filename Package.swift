// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.29.0-SNAPSHOT-07-30--02-03.git-a8e4aae"
let commonVersion = Version("24.29.0-SNAPSHOT-07-30--02-03.git-a8e4aae")
let navigationNativeVersion = Version("324.29.0-SNAPSHOT-07-30--02-03.git-a8e4aae")
let coreMapsVersion = Version("11.29.0-SNAPSHOT-07-30--02-03.git-a8e4aae")

let checksumNavSdkBase = "e1edf742e400ce2ae8d691a04625f59f946081fdc00cc9676dfe7d4f8b5ab789"
let checksumNavSdk = "cc647440180321a4150136b62ff0a8e52ebd08bbf6af5c7c0618a7bf26c33cb3"
let checksumNavSdkMapComponents = "3c8b8bbd88d3581bc1faeb6dd7b68999b93f3a96fabe6b5a8eaa596efa3f44ea"
let checksumNavSdkNavigation = "3366acc41876f06590b672d989e0fd944869ca5244fd1f068eb1f434c8b433ee"
let checksumMapsComponents = "b2217250f6bcae46ef1a57d6487a10824e39b7221b20689246d6c6259b08aee9"

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
