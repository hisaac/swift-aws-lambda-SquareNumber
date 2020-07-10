import AWSLambdaEvents
import AWSLambdaRuntime
import Foundation
import Logging

// In order to use URLSession on Linux, you have to import this specific library, separate from Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// Entry point to the lambda
Lambda.run { (context: Lambda.Context, request: APIGateway.V2.Request, callback: @escaping (Result<APIGateway.V2.Response, Error>) -> Void) in
	context.logger.info("hello, api gateway!")
	if let name = request.queryStringParameters?["nspredicatename"] {
		PredicateTest.doPredicatesWork(nameToSearchFor: name, logger: context.logger, callback: callback)
	} else {
		SWAPIInteractor.getStarship(logger: context.logger, requestBody: request.body, callback: callback)
	}
}

struct Person: Codable {
	let name: String
}

// Example of using a query string paramater to filter an array using an NSPredicate
struct PredicateTest {
	static func doPredicatesWork(nameToSearchFor: String, logger: Logger, callback: @escaping (Result<APIGateway.V2.Response, Error>) -> Void) {
		let isaac = Person(name: "Isaac")
		let cyrus = Person(name: "Cyrus")
		let jon = Person(name: "Jon")
		let people = [isaac, cyrus, jon]

		let predicate = NSPredicate { (evaluatedObject, _) -> Bool in
			guard let person = evaluatedObject as? Person else { return false }
			return person.name == nameToSearchFor
		}
		let filteredPeople = people.filter { predicate.evaluate(with: $0) }
		guard let responseData = try? JSONEncoder().encode(filteredPeople) else {
			logger.info("unable to encode response JSON")
			return
		}

		callback(.success(APIGateway.V2.Response(statusCode: .ok, body: String(data: responseData, encoding: .utf8))))
	}
}

struct StarshipNumber: Decodable {
	let number: Int
}

// Example of hitting another API from within a lambda, decoding the number value off of the request body
// Must be a Post request with body formatted like so:
// {
//   "number": 9
// }
// If no body is provided, it will select a random starship and return that
struct SWAPIInteractor {
	static func getStarship(logger: Logger, requestBody: String?, callback: @escaping (Result<APIGateway.V2.Response, Error>) -> Void) {
		var starshipNumber = Int.random(in: 1...36)

		if let requestBody = requestBody,
		   let requestBodyData = requestBody.data(using: .utf8),
		   let number = try? JSONDecoder().decode(StarshipNumber.self, from: requestBodyData) {
			starshipNumber = number.number
		} else {
			logger.info("no starship value provided, grabbing random starship")
		}

		URLSession.shared.dataTask(with: URL(string: "https://swapi.dev/api/starships/\(starshipNumber)/")!) { (data, response, error) in
			guard let data = data else {
				logger.info("no data present")
				return
			}
			logger.info("Data present")
			guard let dataString = String(data: data, encoding: .utf8) else {
				logger.info("cannot convert data to string")
				return
			}
			logger.info("\(dataString)")
			guard let starship = try? JSONDecoder().decode(Starship.self, from: data) else {
				logger.info("unable to decode starship data")
				return
			}
			logger.info("Starship parsed")
			guard let responseData = try? JSONEncoder().encode(starship) else {
				logger.info("unable to re-encode data")
				return
			}
			logger.info("response data generated")
			callback(.success(APIGateway.V2.Response(statusCode: .ok, body: String(data: responseData, encoding: .utf8))))
		}.resume()
	}
}
