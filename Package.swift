// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.23.0-SNAPSHOT-04-10--14-21.git-9165870"
let commonVersion = Version("24.23.0-SNAPSHOT-04-10--14-21.git-9165870")
let navigationNativeVersion = Version("324.23.0-SNAPSHOT-04-10--14-21.git-9165870")
let coreMapsVersion = Version("11.23.0-SNAPSHOT-04-10--14-21.git-9165870")

let checksumNavSdkBase = "53a230e0e12e41dbe28c6a39c87cc9fad48f7519a232e15893c6e7436fd129a0"
let checksumNavSdk = "727f64f68fb7f67e40c24f3f557d5847682784ea221f7960693f1690c0f4ad11"
let checksumNavSdkMapComponents = "2c791abc8b29c0ce54c9b5d4516b390757eae3d8076a96a93651be5cb2d1a167"
let checksumNavSdkNavigation = "88f741f1c36b93c3fe27c74185a8bcd6482cbc9e1a4a0352400440aaba25eed1"
let checksumMapsComponents = "9712cb879a0fbc23fdff3af381f8ddb66cde2f26fe1adb527f1ca5493e291802"

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
