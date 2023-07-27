## What is an TypeSpec Specification?

TypeSpec is a language for describing cloud service APIs and generating other API description languages, client and service code, documentation, and other assets. TypeSpec provides highly extensible core language primitives that can describe API shapes common among REST, GraphQL, gRPC, and other protocols.

In `azure-rest-api-specs` repo, TypeSpec specification is used as source to generate corresponding OpenAPI 2.0 (swagger) API docs
 

Please note TypeSpec specification is REQUIRED for all new ARM services.

### TLDR: Key checklist for TypeSpec PR in azure-rest-api-spec repos

#### General:
- :white_check_mark: Do include `tspconfig.yaml`.
- :white_check_mark: Do include examples folder
- :x: Do NOT include package.json
- :x: Do NOT modify any generated files under `resource-manager` or `data-plane`.

#### ARM:
- :white_check_mark: TypeSpec folder name should end with `.Management`
- :white_check_mark: This `tspconfig.yaml` is [standard for ARM](https://github.com/microsoft/typespec/blob/main/eng/feeds/arm/tspconfig.yaml). The one thing you may customize is the output json file name for `typespec-autorest` emitter.

#### Data-Plane:
- :white_check_mark: `tspconfig.yaml` starting template for [Data-plane is here.](https://github.com/microsoft/typespec/blob/main/eng/feeds/arm/tspconfig.yaml). For `typespec-autorest` emitter, you may only customize the output json file name. For other language SDK emitters' settings, you may override values for TypeSpec direct SDK generation.

### Detailed information

- [Setting up local environment for TypeSpec](./typespec-rest-api-dev-process.md#2-repo-setup--prerequisites)
- Read up on [Folder Structure for TypeSpec](./typespec-structure-guidelines.md)
- [Setting up a new TypeSpec project](./typespec-rest-api-dev-process.md#3-creating-a-new-typespec-project)
- [Setting up and regenerate SDK projects](./typespec-rest-api-dev-process.md#4-generate-or-refresh-sdk-code-from-a-typespec-project)