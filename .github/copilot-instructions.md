# Copilot instructions

## Converting a specification from swagger to typespec

Users can convert a specification from swagger to typespec by using `tsp-client` a CLI designed to help developers throughout various stages of typespec development.

### Instructions for converting a specification from swagger to typespec

1. Install the dependencies specified in the package.json at the root of this repository. Command:
```
npm install
```
2. `tsp-client` is installed as part of the dependencies specified at the root of this repository. To convert a swagger to typespec, run the following command: `npx tsp-client convert --swagger-readme <path to your readme>`
3. Now that you have a newly converted typespec project, you should go through all files to verify the accuracy of the converted spec. Likewise, you should update the implementation according to the information provided under the [Data-plane: Initial migration checklist](#data-plane-initial-migration-checklist) section.


### Data-plane: Initial migration checklist

The swagger converter will not be able to accurately represent every part of every API in TypeSpec. This document outlines some common changes you may need to make to a converted TypeSpec to make it conform to your existing service API, pass validation checks, and follow best practices.

- DO configure your tspconfig.yaml. See: [example tspconfig.yaml][tspconfig]
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

- DO ensure that you have a security definition (`@useAuth`) specified for your service. See: [Security definitions in TypeSpec][security-definitions]. The @useAuth decorator should only be defined once above the @server definition.
- DO ensure you have versioning (`@versioned`) enabled over your service definition. See: [Versioning][versioning]
- If any files are using any of the versioning decorators, make sure to import the `@typespec/versioning` libray and add a use statement. Example:
```tsp
import "@typespec/versioning";

using TypeSpec.Versioning;
```

- DO review all enum and union definitions and add documentation over each enum or union member. See: [Documentation in TypeSpec][docs]. Example:


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

- Avoid suppressing warnings

- DO use `union` instead of `enum` to define Azure enums. See: [Defining enums for Azure services][no-enum]. Example:

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

- Avoid importing or using templates from the `@azure-tools/typespec-azure-resource-manager` library in a data-plane specification
- DO make client customizations in a `client.tsp` file
- Avoid importing or using `@azure-tools/typespec-client-generator-core` in other files aside from client.tsp.
- DO run `tsp compile .` on your specification and make 1 attempt to address all warnings.

#### Additional considerations

- DO ensure you pull in the latest `main` from the Azure/azure-rest-api-specs repo to stay up to date with latest dependencies
- DO run `npm ci` to get a clean install of the package.json dependencies
- Avoid modifying the package.json or package-lock.json files at the root of the azure-rest-api-specs repo
- Avoid adding your own package.json or package-lock.json files in your project directory
- Avoid adding multiple tspconfig.yaml files for your service specification
- DO consult [ci-fix.md][ci-fix] for fixes to common CI errors reported

## Troubleshooting tsp compile errors and warnings

- If you see an invalid-ref or unknown identifier error you are most likely missing an import to the library that declares that decorator. To find supported libraries and decorators search through the documentation of the following sites: https://azure.github.io/typespec-azure/docs/intro/ and https://typespec.io/docs/
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
