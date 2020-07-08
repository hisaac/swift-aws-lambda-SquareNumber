// swift-tools-version:5.2

import PackageDescription

let package = Package(
	name: "SquareNumber",
	platforms: [
		.macOS(.v10_13),
	],
	products: [
		.executable(name: "SquareNumber", targets: ["SquareNumber"]),
	],
	dependencies: [
		.package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", from: "0.1.0"),
	],
	targets: [
		.target(
			name: "SquareNumber",
			dependencies: [
				.product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
			]
		)
	]
)
