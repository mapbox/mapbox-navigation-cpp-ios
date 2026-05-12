// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.23.1"
let commonVersion = Version("24.23.1")
let navigationNativeVersion = Version("324.23.1")
let coreMapsVersion = Version("11.23.1")

let checksumNavSdkBase = "23cbaeb6dcbb4d19c63b0f49c2f7065a0b2dc0f9d5cba35562921264b99902d5"
let checksumNavSdk = "e8a71c36bb3c1802aabae687747cd089693f6d0be47bf859991ce83f2d831db3"
let checksumNavSdkMapComponents = "fcf2794bb88ce3d8d09049cda6e8ec3fccc60e97af4fe219810b975c78b1f569"
let checksumNavSdkNavigation = "608a28bf3da597022bf247c9129e92b0ba03bfb02f0c514541958c39d12e5e6e"
let checksumMapsComponents = "d2fe67a3790aaefd86613b8e0f2927f374efa19cd984ae52a48d33aaf3fbc8f3"

let releaseType = "releases"

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
