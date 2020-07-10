# SquareNumber

This is a POC I created to test out Apple's new [Swift AWS Lambda Runtime](https://swift.org/blog/aws-lambda-runtime/).

The code is very messy — this is just something I hacked together to learn. Also, originally the Lambda just squared any number that it was given, hence the name Square Number. It does more now.

## Usage

I've got two different usages set up.

### NSPredicate Testing

I needed to test if NSPredicates worked, so I built a handler for that. You can use this handler by sending a GET request to the following url:

`https://qtp37zmyzc.execute-api.us-east-1.amazonaws.com/default/SquareNumber?nspredicatename=<name>`

The array the predicate filters against contains the values "Isaac", "Cyrus", and "Jon". So substituting any of those values in for `<name>` in the query string will return a result, and anything else will not return a result.

### API Request Testing

I also needed to test if it was possible to send an API request from within the Lambda. I'm using [The Star Wars API](https://swapi.dev) to grab some example data. You can test this handler by sending a POST request to the following url:

`https://qtp37zmyzc.execute-api.us-east-1.amazonaws.com/default/SquareNumber`

Sending an empty POST request should return JSON representing a random starship from the Star Wars universe.

You can also specify a specific starship by number by providing a JSON body in the following format:

```json
{
	"number": <number>
}
```

Substituting an integer for the `<number>` value (a number being 1–36).

## To Package and Deploy

Call the `deploy.sh` script to deploy to AWS Lambda
