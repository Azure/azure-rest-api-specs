# Getting started with Typespec ARM specifications

Swagger APIs and examples are generated from TypeSpec definitions in folder `resource-manager/Microsoft.DocumentDB/MongoCluster`.

The generated specs and examples are located under `resource-manager/Microsoft.DocumentDB/MongoCluster/preview` and `resource-manager/Microsoft.DocumentDB/MongoCluster/stable` directories and should not be edited directly.

# Setup local environment

See instructions [here](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/typespec-rest-api-dev-process.md#21-with-local-machine-development)

# Folder layout

```
mongocluster
└── resource-manager
    └── Microsoft.DocumentDB
        └── MongoCluster                 
            ├──tspconfig.yaml             ┐
            ├──main.tsp                   │ 
            ├──MongoCluster.tsp           | [ARM API TypeSpec Definition]
            ├──common.tsp                 │
            ├──...                        ┘ 
            ├──examples                  [API Examples]
            |   ├── 2023-11-15-preview
            |   |   ├── MongoClusterCreate.json
            |   |   ├── MongoClusterGet.json
            |   |   ├── ...
            |   └── 2024-03-01-preview
            |       ├── ...
            |
            └── preview
                ├── 2023-11-15-preview
                |   ├── mongoCluster.json     [Swagger specs generated from TypeSpec]
                |   └── examples
                |   |   └── ...               [examples generated from TypeSpec]
                |   └── scenarios             [API Test Scenarios - non-generated]
                |       └── basic.yaml
                ├── 2024-03-01-preview
                ├── ...
```

# Authoring Typespec definition

TypeSpec ARM definitions inline the api version changes without needing to clone/copy specs each time.

Use VS Code to edit TypeSpec definition files.

- If adding a new API version - update `main.tsp` with the API version definition.
  - Copy the `examples\` from the previous `stable` or `preview` API version into a new version folder.
  - For any additions to the API specification, decorate the properties/models/resource etc. with `@added(Versions.v<api-version>)`.
  - Similarly for removing items, use `@removed(Versions.v<api-version>)` - note that this could trigger a API breaking change error during PR review.
- If adding a new resource (proxy or tracked ARM resource), create a new `.tsp` file with the filename matching the resource name, eg. `User.tsp`.
- Any shared models should be added to `common.tsp`.
- Make sure to add or update the examples based on the changes that have been made for the new API version.

# Compiling TypeSpec

From folder `resource-manager/Microsoft.DocumentDB/MongoCluster`, run:

```bash
npx tsp compile .
```

This will re-generate the Swagger API specifications under `resource-manager/Microsoft.DocumentDB/MongoCluster`. Assuming you have made no updates, this should make no changes to the files.

# Management API scenario tests

API Scenario tests validate the API specification against a production ARM endpoint or can be used to record traffic against a proxy endpoint.
The scenarios can be defined using the API version examples and should be run whenever API spec changes are being made.

See complete [documentation](https://github.com/Azure/azure-rest-api-specs/tree/main/documentation/api-scenario)

API scenario file are located alongside examples for each API version

```
mongocluster
└── resource-manager
    └── Microsoft.DocumentDB
        └── MongoCluster
            └── preview
                ├── 2023-11-15-preview
                |   ├──   ...
                |   └── scenarios
                |       └── basic.yaml
                └── 2024-03-01-preview
                    └── scenarios
                        ├── basic.yaml
                        └── new-scenario.yaml
```

## Adding or editing scenario definitions

[Quickstart guide](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/api-scenario/how-to/QuickStart.md#authoring-steps) is a good a starting point for authoring.

See [API scenario definition reference](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/api-scenario/references/ApiScenarioDefinition.md).

Rule of thumb is to author or generate practical API spec examples that can be turned be compiled into a scenario test.

Example Scenarios:

- Basic [DONE] - covers common operations such as create, add firewall, data disk scaling, delete operations.

## Running API scenarios for Mongo Clusters API

**Full instructions on [wiki page here](https://msdata.visualstudio.com/CosmosDB/_git/pgmongo?path=/docs/pgmongo/mongo_arm/api_specification/typespec-authoring.md&version=GBolivert/arm_spec_docs&_a=preview)**