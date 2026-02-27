# New TypeSpec projects

Refer to [new-typespec-project.instructions.md](./instructions/typespec-project.instructions.md) for detailed steps on:
 - how to create a new TypeSpec project.
 - converting a specification from swagger to typespec
 - troubleshooting tsp compile errors

# Adding Language Emitters to Existing TypeSpec Projects

Refer to [language-emitter.instructions.md](./instructions/language-emitter.instructions.md) for detailed steps on how to add language emitters to an existing `tspconfig.yaml` file in a TypeSpec project.

# SDK generation from TypeSpec

You must use Azure SDK MCP server to generate SDK from TypeSpec.

Refer to [sdk-generation.instructions.md](./instructions/sdk-generation.instructions.md) for additional instructions to generate SDK from TypeSpec.

# Instructions for GitHub coding agent to generate SDKs using GitHub.com

Follow [github-codingagent.instructions.md](./instructions/github-codingagent.instructions.md) for instructions to run SDK generation using pipeline in GitHub coding agent.

# Release readiness of SDK and information about the release pipeline

Run [check package readiness](../eng/common/instructions/azsdk-tools/check-package-readiness.instructions.md) to check the release readiness of an SDK package. This prompt will collect the required information from the user, execute the readiness check, and present the results.

# Up-to-date TypeSpec documentation

Follow [typespec docs](../eng/common/instructions/azsdk-tools/typespec-docs.instructions.md) to get the most up-to-date documentation for TypeSpec, including best practices for writing TypeSpec for Azure.

<!-- LINKS -->

[contoso-widget-manager]: ../specification/contosowidgetmanager/Contoso.WidgetManager/
[tspconfig]: ../specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml
[security-definitions]: https://azure.github.io/typespec-azure/docs/reference/azure-style-guide#security-definitions
[versioning]: https://typespec.io/docs/libraries/versioning/guide#implementing-versioned-apis
[docs]: https://typespec.io/docs/language-basics/documentation
[ci-fix]: ../documentation/ci-fix.md
[url-type]: https://typespec.io/docs/language-basics/built-in-types#string-types
[no-enum]: https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-enum
[typespec-structure-guidelines]: ../documentation/typespec-structure-guidelines.md
