// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "swift-toolchain-sqlite",
  products: [
    .executable(
      name: "sqlite",
      targets: ["sqlite"]),
    .library(
      name: "SwiftToolchainCSQLite",
      targets: ["SwiftToolchainCSQLite"]),
  ],
  targets: [
    .executableTarget(
      name: "sqlite",
      dependencies: ["SwiftToolchainCSQLite"],
      cSettings: [
        .define("SQLITE_OMIT_LOAD_EXTENSION"),
        .define(
          "SQLITE_NOHAVE_SYSTEM",
          .when(platforms: [.macCatalyst, .iOS, .tvOS, .watchOS, .visionOS, .wasi])),
        .define("HAVE_READLINE", .when(platforms: [.macOS, .macCatalyst])),
        .define("_WASI_EMULATED_SIGNAL", .when(platforms: [.wasi])),
        .define("_WASI_EMULATED_PROCESS_CLOCKS", .when(platforms: [.wasi])),
        .define("_WASI_EMULATED_GETPID", .when(platforms: [.wasi])),
      ],
      linkerSettings: [
        .linkedLibrary("wasi-emulated-signal", .when(platforms: [.wasi])),
        .linkedLibrary("wasi-emulated-process-clocks", .when(platforms: [.wasi])),
        .linkedLibrary("wasi-emulated-getpid", .when(platforms: [.wasi])),
        .linkedLibrary("m", .when(platforms: [.linux, .android])),
        .linkedLibrary("pthread", .when(platforms: [.custom("freebsd")])),
      ]
    ),
    .target(
      name: "SwiftToolchainCSQLite",
      path: "Sources/CSQLite",
      publicHeadersPath: "include",
      linkerSettings: [
        // Needed for swift_addNewDSOImage
        .linkedLibrary("swiftCore", .when(platforms: [.windows, .wasi]))
      ]
    ),
  ]
)
