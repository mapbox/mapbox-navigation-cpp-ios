// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.25.0-rc.2-SNAPSHOT-06-09--08-24.git-300f62e"
let commonVersion = Version("24.25.0-rc.2-SNAPSHOT-06-09--08-24.git-300f62e")
let navigationNativeVersion = Version("324.25.0-rc.2-SNAPSHOT-06-09--08-24.git-300f62e")
let coreMapsVersion = Version("11.25.0-rc.2-SNAPSHOT-06-09--08-24.git-300f62e")

let checksumNavSdkBase = "a56544cf9122b2c84f406ec3c487a68f31b93611d942025db9fe21ab5c4c2879"
let checksumNavSdk = "159f3e5010b098ff27d22892a0808ea4adaab1c3b6d39bc7107c86edbc433239"
let checksumNavSdkMapComponents = "fd446a1e0e558f49e7ae96215db48c7b7e7047ac3318f969f5e80f14ad5deedf"
let checksumNavSdkNavigation = "711f339775ef9553114cd3b314e7d29cd5a52427252e1bdb4130531811315af8"
let checksumMapsComponents = "bb731c25b447d09f31934209f436644794839b6a4c1e7e2409543cda5eae387d"

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
