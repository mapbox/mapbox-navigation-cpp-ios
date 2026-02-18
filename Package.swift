// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.20.0-SNAPSHOT-02-18--04-59.git-22c9609"
let commonVersion = Version("24.20.0-SNAPSHOT-02-18--04-59.git-22c9609")
let navigationNativeVersion = Version("324.20.0-SNAPSHOT-02-18--04-59.git-22c9609")
let coreMapsVersion = Version("11.20.0-SNAPSHOT-02-18--04-59.git-22c9609")

let checksumNavSdkBase = "06ab521ee83b0095d7792522931cfdb93b3f80e5550a8724611e10583ddf8df3"
let checksumNavSdk = "48daebae8538538505f434da52aca1500e803fae61490d24a8f3e8caf9d337a2"
let checksumNavSdkMapComponents = "fcabbaec99299fccf86b4ea9d807f9b1150d127d7f16c00d6cfddf3ed72c42a9"
let checksumNavSdkNavigation = "6da1f5d02555607f2f57063a1b2f49983fb7653c6e90198437b797c713f4a624"
let checksumMapsComponents = "209a207f88f5cf7d814e71898e7cf35859c5d7792411a21d72684afe4c52e073"

let releaseType = "snapshots"

let package = Package(
    name: "MapboxNavSDK",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "MapboxNavSDK",
            targets: ["MapboxNavSDKWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/mapbox/mapbox-common-ios.git", exact: commonVersion),
        .package(url: "https://github.com/mapbox/mapbox-core-maps-ios.git", exact: coreMapsVersion),
        .package(url: "https://github.com/mapbox/mapbox-navigation-native-ios.git", exact: navigationNativeVersion)
    ],
    targets: [
        .target(
            name: "MapboxNavSDKWrapper",
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
