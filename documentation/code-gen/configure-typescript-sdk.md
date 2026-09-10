# TypeScript SDK AutoRest configuration (archived)

This page is archived. The legacy `readme.typescript.md` AutoRest configuration flow is no longer the recommended path for Azure SDK for JavaScript/TypeScript generation.

For current SDK generation, author the service in TypeSpec and configure the JavaScript/TypeScript SDK emitter in the service project's `tspconfig.yaml`. The `spec-gen-sdk` pipeline reads the TypeSpec emitter options and generates the JavaScript/TypeScript SDK pull request.

Use these current references instead:

- [Getting started with TypeSpec specifications](../Getting-started-with-TypeSpec-specifications.md)
- [Azure REST API, SDK development process with TypeSpec](../typespec-rest-api-dev-process.md#5-generate-sdk-code-from-a-typespec-project)
- [SDK automation and `spec-gen-sdk` pipeline details](../sdkautomation/README.md)

Do not add new `readme.typescript.md` files only to enable SDK generation. If a service still has existing Swagger/AutoRest configuration, treat it as legacy maintenance and prefer migrating future API work to TypeSpec.
