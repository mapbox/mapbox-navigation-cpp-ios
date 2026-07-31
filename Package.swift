// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let version = "0.29.0-SNAPSHOT-07-31--02-03.git-0c5e1d5"
let commonVersion = Version("24.29.0-SNAPSHOT-07-31--02-03.git-0c5e1d5")
let navigationNativeVersion = Version("324.29.0-SNAPSHOT-07-31--02-03.git-0c5e1d5")
let coreMapsVersion = Version("11.29.0-SNAPSHOT-07-31--02-03.git-0c5e1d5")

let checksumNavSdkBase = "a79de6d6d80f839b75146efb21fb647d3861aefd6451ff9dcd6743c872d2cd1e"
let checksumNavSdk = "7e8fc46dc5607f807af8855be0208d15ee4bcc63047dc08d812ec6a6015f245b"
let checksumNavSdkMapComponents = "af788a0c47c5a5f88b1683aa02daf1f8ae1cc811cc332dbca74759de5d78aaa1"
let checksumNavSdkNavigation = "6219a3305e7e9852740aec10925b398f2c22dff40ab4d6d71de978265b7a77db"
let checksumMapsComponents = "19622ae1558d8b8261176bdc1d2a3a6cd04f79cfedbb5883f6a775554185b338"

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
