// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.21.0-SNAPSHOT-03-20--12-10.git-a3a6922"
let commonVersion = Version("24.21.0-SNAPSHOT-03-20--12-10.git-a3a6922")
let navigationNativeVersion = Version("324.21.0-SNAPSHOT-03-20--12-10.git-a3a6922")
let coreMapsVersion = Version("11.21.0-SNAPSHOT-03-20--12-10.git-a3a6922")

let checksumNavSdkBase = "727a19fa6ade1a473eb28b6c63eca7502bcd9bf341e5378933f7c5cc65154c80"
let checksumNavSdk = "33b6efe920fb4c2bc6caf21b99b420703d2345dca49b3ed06b9780cf2075d680"
let checksumNavSdkMapComponents = "c8ff082b6523ea3ffa9edefce9b1a5aa74c48aeeef363dcbefb99ea27bd4b993"
let checksumNavSdkNavigation = "9cfe84cefd27f09b60cfd33a3caa4a432d4e5df9d9a0e0067326301de300fa3a"
let checksumMapsComponents = "9699d0efd7cd93fc6211e976c08987b1d28ef11c1a1200a54d9837a34736baa8"

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
