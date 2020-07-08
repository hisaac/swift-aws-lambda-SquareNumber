# SquareNumber

## To Package for Deployment

Run the following docker script in your console from the root directory of the project:

```shell
docker run --rm --volume "$(pwd)/:/src" --workdir "/src/" swift-lambda-builder scripts/package.sh SquareNumber
```

Note: If using fish, replace `$(pwd)` with `$PWD`
