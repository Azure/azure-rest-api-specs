# Azure CLI AutoRest configuration (archived)

This page is archived. The legacy `readme.az.md`, `readme.cli.md`, and `readme.python.md` AutoRest configuration flow is no longer the recommended path for SDK generation from this repository.

For current SDK generation, author the service in TypeSpec and configure SDK language emitters in the service project's `tspconfig.yaml`. The `spec-gen-sdk` pipeline reads those TypeSpec emitter options and generates SDK pull requests for the configured languages.

Use these current references instead:

- [Getting started with TypeSpec specifications](../Getting-started-with-TypeSpec-specifications.md)
- [Azure REST API, SDK development process with TypeSpec](../typespec-rest-api-dev-process.md#5-generate-sdk-code-from-a-typespec-project)
- [SDK automation and `spec-gen-sdk` pipeline details](../sdkautomation/README.md)

Do not add new per-language AutoRest readme files only to enable SDK generation. If a service still has existing Swagger/AutoRest configuration, treat it as legacy maintenance and prefer migrating future API work to TypeSpec.
