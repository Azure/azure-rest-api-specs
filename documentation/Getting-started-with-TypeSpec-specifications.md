## What is a TypeSpec Specification?

TypeSpec is a versatile language used for describing cloud service APIs and generating various API description languages, client and service code, documentation, and other related assets. It provides highly extensible core language primitives that can describe API structures common among REST, GraphQL, gRPC, and other protocols.

Within the azure-rest-api-specs repository, the TypeSpec specification serves as the source to generate corresponding OpenAPI 2.0 (swagger) API documentation. By utilizing the model and operation patterns found in the standard Azure typespec-core and typespec-resource-manager libraries, TypeSpec offers a much simpler way to express service APIs and ensures compliance with the Azure REST API guidelines for swagger specifications.

**Please note** TypeSpec specification is REQUIRED for all new ARM services.

### TLDR: Key checklist for TypeSpec PR in azure-rest-api-spec repos

#### General:
- :white_check_mark: Do include `tspconfig.yaml`.
- :white_check_mark: Do include examples folder.
- :x: Do NOT include package.json.
- :x: Do NOT modify any generated files under `resource-manager` or `data-plane`.

#### ARM:
- :white_check_mark: TypeSpec folder name should end with `.Management`.
- :white_check_mark: This `tspconfig.yaml` is [standard for ARM](https://github.com/Azure/typespec-azure/blob/main/eng/feeds/arm/tspconfig.yaml). The one thing you may customize is the output json file name for `typespec-autorest` emitter.

#### Data-Plane:
- :white_check_mark: `tspconfig.yaml` starting template for [Data-plane is here.](https://github.com/Azure/typespec-azure/blob/main/eng/feeds/data-plane/tspconfig.yaml). For `typespec-autorest` emitter, you may only customize the output json file name. For other language SDK emitters' settings, you may override values for TypeSpec direct SDK generation.

### Detailed information

- [Setting up local environment for TypeSpec](./typespec-rest-api-dev-process.md#2-repo-setup--prerequisites)
- Read up on [Folder Structure for TypeSpec](./typespec-structure-guidelines.md)
- [Setting up a new TypeSpec project](./typespec-rest-api-dev-process.md#3-creating-a-new-typespec-project)
- [Setting up and regenerate SDK projects](./typespec-rest-api-dev-process.md#4-generate-or-refresh-sdk-code-from-a-typespec-project)
