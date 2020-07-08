import AWSLambdaRuntime

/// MARK: - Request, Response, and Handler

struct Request: Codable {
	let number: Double
}

struct Response: Codable {
	let result: Double
}

Lambda.run { (context, request: Request, callback: @escaping (Result<Response, Error>) -> Void) in
	context.logger.info("Request received!")
	callback(.success(Response(result: request.number * request.number)))
}
