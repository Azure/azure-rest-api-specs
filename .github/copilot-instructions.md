# Copilot instructions

## Converting a specification from swagger to typespec

Users can convert a specification from swagger to typespec by using `tsp-client` a CLI designed to help developers throughout various stages of typespec development.

### Instructions for converting a specification from swagger to typespec

1. Install the dependencies specified in the package.json at the root of this repository. Command:

```
npm ci
```

2. `tsp-client` is installed as part of the dependencies specified at the root of this repository. To convert a swagger to typespec, run the following command: `npx tsp-client convert --swagger-readme <path to your readme>`
3. Now that you have a newly converted typespec project, you should go through all files to verify the accuracy of the converted spec when compared to the original swagger definitions.
4. You should update the implementation according to the information provided under the [Data-plane: Initial migration checklist](#data-plane-initial-migration-checklist) section.

### Data-plane: Initial migration checklist

The swagger converter will not be able to accurately represent every part of every API in TypeSpec. This document outlines some common changes you may need to make to a converted TypeSpec to make it conform to your existing service API, pass validation checks, and follow best practices.

- DO configure your tspconfig.yaml. Example of a well configured tspconfig.yaml file: [example tspconfig.yaml][tspconfig]
- DO extend the `@azure-tools/typespec-azure-rulesets/data-plane` linter rule set in your tspconfig.yaml. Example:

```yaml title=tspconfig.yaml
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
```

- DO ensure your `@service` and `@server` definitions are correct in main.tsp
- DO use the built-in [url][url-type] for endpoint specification. Example:

```tsp
@server(
  "{endpoint}/widget",
  "Contoso Widget APIs",
  {
    /**
      * Supported Widget Services endpoints (protocol and hostname, for example:
      * https://westus.api.widget.contoso.com).
      */
    endpoint: url,
  }
)
```

- DO ensure that you have a security definition (`@useAuth`) specified for your service. See: [Security definitions in TypeSpec][security-definitions]. The @useAuth decorator should only be defined ONCE in the entire specification above the @server definition.
- DO ensure you have versioning enabled over your service definition. This means making sure that the `@typespec/versioning` library is important and the `@versioned` decorator is specified over the namespace. The `@versioned` decorator should be configured according to the documentation defined in this page: [Versioning][versioning]. Check for a a versioning enum and add one if it doesnt exist, see examples in the following link: https://typespec.io/docs/libraries/versioning/reference/decorators/#@TypeSpec.Versioning.versioned
- If any files are using any of the versioning decorators, make sure to import the `@typespec/versioning` libray and add a using statement. Example:

```tsp
import "@typespec/versioning";

using TypeSpec.Versioning;
```

- DO review all enum and union definitions and add documentation over each enum or union member. See: [Documentation in TypeSpec][docs]. Example of a properly documented enum:

```tsp
/** The color of a widget. */
union WidgetColor {
  string,

  /** Red Widget Color */
  Red: "Red",

  /** Green Widget Color */
  Green: "Green",

  /** Blue Widget Color */
  Blue: "Blue",
}
```

- DO ensure that all models, properties, operations, parameters, enums, unions, and alias definitions have documentation over them.

- Avoid suppressing warnings
- Operation names should be camel case
- DO use `union` instead of `enum` to define Azure enums. For more information about how to define enums for Azure services see the following documentation: [Defining enums for Azure services][no-enum]. 
- Avoid importing or using templates from the `@azure-tools/typespec-azure-resource-manager` library in a data-plane specification
- DO make client customizations in a `client.tsp` file
- Avoid importing or using `@azure-tools/typespec-client-generator-core` in other files aside from client.tsp.
- DO run `tsp compile .` on your specification and make one attempt to address all warnings. Do not attempt to address warnings more than once even if they aren't resolved.

#### Additional considerations

- DO ensure you pull in the latest `main` from the Azure/azure-rest-api-specs repo to stay up to date with latest dependencies
- DO run `npm ci` to get a clean install of the package.json dependencies
- Avoid modifying the package.json or package-lock.json files at the root of the azure-rest-api-specs repo
- Avoid adding your own package.json or package-lock.json files in your project directory
- Avoid adding multiple tspconfig.yaml files for your service specification
- DO consult [ci-fix.md][ci-fix] for fixes to common CI errors reported

## Troubleshooting tsp compile errors and warnings

Examples of common errors and warnings that should be addressed after running the `tsp compile` command:

- If you see an error with a message like: "referencing types from versioned namespace 'Azure.Core.Foundations' but didn't specify which versions with @useDependency", you should add the @useDependency decorator over each api version entry in your api versions enum. Example of a properly configured api versions enum: 

```
/** Service api versions **/
enum Versions {
  /** The 2023-11-01 api version **/
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_11_01: "2023-11-01",
}

```

- If you see an invalid-ref or unknown identifier error you are most likely missing an import to the library that declares that decorator. To find supported libraries and decorators search through the documentation of the following sites: https://azure.github.io/typespec-azure/docs/intro/ and https://typespec.io/docs/ Search through the list of supported decorators, interfaces, and other types per library until you find the correct library to import and/or include a using statement in your typespec files.
- In order to address warnings raised by the @azure-tools/typespec-azure-core search through this page for relevant solutions to apply: https://azure.github.io/typespec-azure/docs/intro/
- camelCase fixes only apply to the typespec property names, any corresponding string values you should left as is.
- String values in typespec files should be left untouched.

<!-- LINKS -->

[tspconfig]: ../specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml
[security-definitions]: https://azure.github.io/typespec-azure/docs/reference/azure-style-guide#security-definitions
[versioning]: https://typespec.io/docs/libraries/versioning/guide#implementing-versioned-apis
[docs]: https://typespec.io/docs/language-basics/documentation
[ci-fix]: ../documentation/ci-fix.md
[url-type]: https://typespec.io/docs/language-basics/built-in-types#string-types
[no-enum]: https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-enum
