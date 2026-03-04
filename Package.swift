// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.21.0-rc.1-SNAPSHOT-03-04--04-51.git-e6485c3"
let commonVersion = Version("24.21.0-rc.1-SNAPSHOT-03-04--04-51.git-e6485c3")
let navigationNativeVersion = Version("324.21.0-rc.1-SNAPSHOT-03-04--04-51.git-e6485c3")
let coreMapsVersion = Version("11.21.0-rc.1-SNAPSHOT-03-04--04-51.git-e6485c3")

let checksumNavSdkBase = "d5f19d63d88223d405c18d3437d856b1b195aa2eb9c4315e938b4076d71a0459"
let checksumNavSdk = "0f31e6e0c6c3eb8986534bdbe7a249a6fca8c52524f599026634f479642a7ec7"
let checksumNavSdkMapComponents = "e563fcec421c10a846b1a0e6e21299dc8292f910a02fb38feaff6a3474a8d9da"
let checksumNavSdkNavigation = "660a13cc46bb7a6fc99937917bfe65d278d9f7d6beb208bf756270a8403bd417"
let checksumMapsComponents = "44a3ae8f508f5e2f5f615b1c77969e2b6456eb68506a1da276aa4b6500184c9b"

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
