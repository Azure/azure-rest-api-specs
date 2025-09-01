# Generate a basic API Scenario file

In this section, we will show you how to generate a basic API scenario file from Swagger. This is useful for quickly generating a basic API scenario file as baseline, and you can improve the API Scenario (adjusting step orders and providing meaningful values) and make it runnable.

## Prerequisites

1. Install [oav](https://www.npmjs.com/package/oav)

```bash
npm i -g oav
```
2. Install [docker](https://docs.docker.com/get-docker/)

## Steps

1. Compile Swagger into dependencies.json with Restler.

```bash
docker run --rm -v $(pwd)/specification:/swagger -w /swagger/.restler_output mcr.microsoft.com/restlerfuzzer/restler dotnet /RESTler/restler/Restler.dll compile --api_spec /swagger/appconfiguration/resource-manager/Microsoft.AppConfiguration/stable/2022-05-01/appconfiguration.json
```

2. Generate a basic API Scenario file.

The generated API Scenario file will contain all the operations in the Swagger file, ordered by the dependencies. At each step, the minimum required parameters will be filled in. 

```bash
oav generate-api-scenario static --specs specification/appconfiguration/resource-manager/Microsoft.AppConfiguration/stable/2022-05-01/appconfiguration.json --dependency specification/.restler_output/Compile/dependencies.json -o specification/appconfiguration/resource-manager/Microsoft.AppConfiguration/stable/2022-05-01/scenarios
```

As an alternative, if Swagger examples are ready, you can add `--useExample` parameter to generate the API scenario file based on Swagger examples:

```bash
oav generate-api-scenario static --specs specification/appconfiguration/resource-manager/Microsoft.AppConfiguration/stable/2022-05-01/appconfiguration.json --dependency specification/.restler_output/Compile/dependencies.json -o specification/appconfiguration/resource-manager/Microsoft.AppConfiguration/stable/2022-05-01/scenarios --useExample
```

Next you can run the API scenario file with `oav run`. See how in [QuickStart](./QuickStart.md).
