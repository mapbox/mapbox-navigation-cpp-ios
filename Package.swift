// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.26.0-SNAPSHOT-09-16--12-21.git-1d8984b"
let commonVersion = Version("24.26.0-SNAPSHOT-09-16--12-21.git-1d8984b")
let navigationNativeVersion = Version("324.26.0-SNAPSHOT-09-16--12-21.git-1d8984b")
let coreMapsVersion = Version("11.26.0-SNAPSHOT-09-16--12-21.git-1d8984b")

let checksumNavSdkBase = "a97d378eec64c5e2fb90ed0ee628e67108d73a622be4b55ce80a5b48f6e87fac"
let checksumNavSdk = "b6d446f63c636770b134aa3fb63f4536632ca1edad01c49b1c95870d3ea18207"
let checksumNavSdkMapComponents = "d2fe55bbe7ecfaaecad66a21e0b3c822085cbb42bc9c344b6879b3ca8b160667"
let checksumNavSdkNavigation = "70c70077044c0c92f408cfd934242fad5b410b531d8fa93844f6e5f371f42b13"
let checksumMapsComponents = "179b1e5b1c649a837b66a46e8c9e93a016b7b6ee073f38e9a1917d4830f64e1a"

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
