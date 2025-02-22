## Setup
Follow instructions from [link](https://github.com/Azure/azure-rest-api-specs/blob/feature/azure-ai-projects/documentation/typespec-rest-api-dev-process.md)

## To compile
```
npx tsp compile .
```

## To generate JSON output
```
npx tsp compile . --emit=@typespec/openapi3 --options @typespec/openapi3.output-file=openapi.json
```

## To generate .yaml file
```
npx tsp compile . --emit @typespec/openapi3
```
