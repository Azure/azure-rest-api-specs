Before creating or initializing a TypeSpec project, you must know your org name, service name, and the type of service: data-plane or control-plane (ARM).

Then create a new project directory under the `specification/<orgName>/resource-manager/<RPNamespace>/<ServiceName>` or `specification/<orgName>/data-plane/<ServiceName>` path, following the guidelines below.

```
specification/
└── <orgName1>/
    ├── cspell.yaml
    └── resource-manager/
        ├── readme.md			ß NOTE: For ARM schema validation; see bullet #2 below
        └── <RPNamespace>/		ß NOTE: Control-plane only (not data-plane)
            └── <ServiceName1>/	ß Customer-facing service name; each version gets Documentation & SDK package
                ├── tspconfig.yaml	ß TypeSpec files
                ├── main.tsp
                ├── models.tsp
                ├── readme.md		ß autorest readme with YAML blocks
                └── examples/		ß TypeSpec example folder
                    └── <api-version>/	ß One folder per service version described in TypeSpec
                        └── <example .json files>
                └── preview/ and stable/
                    └── <api-version>/	ß One folder per service version described in OpenAPI. These folders are created and populated by compiling the TypeSpec folder for the service.
                        ├── <OpenAPI .json files>
                        └── examples/	ß OpenAPI example folder
                            └── <example .json files>
            └── <ServiceName2>/	// Customer-facing service name; contents identical to above structure
    └── data-plane/
        └── <ServiceName3>/	// Customer-facing service name; contents identical to above structure
```

Use the `./specification/widget` directory as a reference for creating your own project directory.

Only after the project directory is created according to the above guidelines may you run the `azsdk_init_typespec_project` tool to initialize the project.

## Converting a specification from swagger to typespec

Users can convert a specification from swagger to typespec by using `tsp-client` a CLI designed to help developers throughout various stages of typespec development.

### Instructions for converting a specification from swagger to typespec

1. Install the dependencies specified in the package.json at the root of this repository. Command:

```
npm ci
```

2. `tsp-client` is installed as part of the dependencies specified at the root of this repository. To convert a swagger to typespec, run the following command: `npx tsp-client convert --swagger-readme <path to your readme>`
3. Now that you have a newly converted typespec project, you should go through all files to verify the accuracy of the converted spec when compared to the original swagger definitions.
4. For both data plane and management plane specifications, you should update the implementation according to the information provided under the [Initial migration checklist](#initial-migration-checklist) section.

### Initial migration checklist

The swagger converter will not be able to accurately represent every part of every API in TypeSpec. This document outlines some common changes you may need to make to a converted TypeSpec to make it conform to your existing service API, pass validation checks, and follow best practices.

- Avoid extensive refactoring of the converted spec. The goal is to get a working spec that can compile successfully and then iteratively improve it.

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
- AVOID adding new namespaces.
- Make sure the versions enum is declared under the existing namespace defined in main.tsp. Avoid adding it anywhere else. Ensure the `@versioned` decorator is specified over the namespace in main.tsp. Pass the versions enum to the `@versioned` decorator. Example of a typical structure for versioning:

```tsp
// this is the main.tsp file


@versioned(Versions)
namespace Contoso.WidgetManager;
/** Service api versions **/
enum Versions {
  /** The 2023-11-01 api version **/
  v2023_11_01: "2023-11-01",
}
```

- All models, enums, unions, and operations should be added under the main namespace declared in the project.
- Avoid having models, enums, unions, operations, and other types declared outside of a namespace.
- If any files are using any of the versioning decorators, such as `@added`, `@removed`, `@changedType`, make sure to import the `@typespec/versioning` library and add a using statement. Example:

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

- DO ensure that all models, properties, operations, parameters, enums, unions, and alias definitions have documentation over them. TypeSpec convention recommends using the doc comment format `/** <docs go here> */` to add documentation, example:

```tsp
/** The color of a widget. */
model Widget {
  /** Widget name */
  name: string
}
```

- DO define your visibility decorators with the appropriate value from the Lifecycle class.
- Avoid suppressing warnings
- Operation names should be camel case
- DO use `union` instead of `enum` to define Azure enums. For more information about how to define enums for Azure services see the following documentation: [Defining enums for Azure services][no-enum].
- DO make client customizations in a `client.tsp` file
- Avoid importing or using `@azure-tools/typespec-client-generator-core` in other files aside from client.tsp.
- DO run `azsdk_run_typespec_validation` MCP tool on your specification and make one attempt to address all warnings. Do not attempt to address warnings more than once even if they aren't resolved.
- Attempt to address any FIXME or TODO comments in the spec. If you are unable to address them, leave them untouched

#### Additional considerations

- DO ensure you pull in the latest `main` from the Azure/azure-rest-api-specs repo to stay up to date with latest dependencies
- DO run `npm ci` to get a clean install of the package.json dependencies
- Avoid modifying the package.json or package-lock.json files at the root of the azure-rest-api-specs repo
- Avoid adding your own package.json or package-lock.json files in your project directory
- Avoid adding multiple tspconfig.yaml files for your service specification
- DO consult [ci-fix.md][ci-fix] for fixes to common CI errors reported

## Troubleshooting TypeSpec validation errors and warnings

Examples of common errors and warnings that should be addressed after running the `azsdk_run_typespec_validation` MCP tool:

- If you see an error with a message like: "referencing types from versioned namespace 'Azure.Core.Foundations' but didn't specify which versions with @useDependency", you should add the @useDependency decorator over each api version entry in your api versions enum. Example of a properly configured api versions enum:

```
/** Service api versions **/
enum Versions {
  /** The 2023-11-01 api version **/
  v2023_11_01: "2023-11-01",
}

```

- If you see an invalid-ref or unknown identifier error you are most likely missing an import to the library that declares that decorator. To find supported libraries and decorators search through the documentation of the following sites: https://azure.github.io/typespec-azure/docs/intro/ and https://typespec.io/docs/ Search through the list of supported decorators, interfaces, and other types per library until you find the correct library to import and/or include a using statement in your typespec files.
- In order to address warnings raised by the @azure-tools/typespec-azure-core search through this page for relevant solutions to apply: https://azure.github.io/typespec-azure/docs/intro/
- camelCase fixes only apply to the typespec property names, any corresponding string values you should left as is.
- String values in typespec files should be left untouched.
