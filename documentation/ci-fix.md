# CI Fix Guide

Short link: https://aka.ms/azsdk/ci-fix

This page provides detailed instructions on how to diagnose, reproduce, fix and get help on various [automated validation tooling] failures on your [Azure REST API specs PR].

## Prerequisites

Most guides here require for you to have `npm` installed, which you can get by installing [Node.js](https://nodejs.org/en/download).

## Spell check

Please add your words to `./custom-words.txt` if you think you have the correct spell.

If your problem is some existing error name that is not a word and need to suppress the error in that file (and don't want to add to custom-words.txt), you can add it to `./cSpell.txt`.

## Prettier check

First, ensure you have fulfilled `Prerequisites` as explained above.

To update all the spec files for a given service run the following:

```
# To fix all the files in the repo run from the root of the repo
cd <local_repo_clone_root>

# OPTIONAL STEP: To fix a particular service swagger cd to that directory like
cd specification/contosowidgetmanager

# Install the dependencies to the local 'node_modules' folder.
npm install

# Run 'prettier --check' to verify the problems can be reproduced locally
npx prettier --check **/*.json

# Run 'prettier --write' to fix the problems.
npx prettier --write **/*.json
```

Then please commit and push changes made by prettier.

Reference: [prettier](https://www.npmjs.com/package/prettier).

## Model Validation

Run Model Validation locally:
```
npm install -g oav
oav validate-example <swagger-spec-path>
```
Please see [readme](https://github.com/Azure/oav/blob/bd04e228b4181c53769ed88e561dec5212e77253/README.md) for how to install or run tool in details.
Or you can run it in [OpenAPI Hub](https://portal.azure-devex-tools.com/tools/static-validation/static/errors/default).
Refer to [Semantic and Model Violations Reference](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Semantic-and-Model-Violations-Reference.md) for detailed description of validations and how-to-fix guidance.
Refer to [Swagger-Example-Generation](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/393/Swagger-Example-Generation) for example automatic generation.

## Semantic Validation

Run Semantic Validation locally:
```
npm install -g oav
oav validate-spec <swagger-spec-path>
```
Please see [readme](https://github.com/Azure/oav/blob/bd04e228b4181c53769ed88e561dec5212e77253/README.md) for how to install or run tool in details.
Or you can run it in [OpenAPI Hub](https://portal.azure-devex-tools.com/tools/static-validation/static/errors/default)
Refer to [Semantic and Model Violations Reference](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Semantic-and-Model-Violations-Reference.md) for detailed description of validations and how-to-fix guidance.

## Breaking Change Check

- An API contract is identified by its api-version value. Once published, no changes to this API contract are allowed. This applies regardless of whether the API contract is for private preview, public preview, or GA (stable).
    - The same-version breaking change linter rules check for changes to an existing api-version swagger.
        - When introducing a new API contract (preview or not), the new API contract must be backwards compatible with the previous GA’s API contract.
            - However, during a (private or public) preview cycle, a new preview API contract does not have to be backwards compatible with the previous preview API contract although it must still be backwards compatible with the latest GA API contract.
            - The cross version breaking change linter rules checks for this by comparing the new swagger with the latest GA swagger. If there is no latest GA swagger, then the latest preview if it > 1 year old. If nether a GA or preview > 1 year old exists, then the swagger is considered good.

### Adding label on PR automatically

The breaking change check has two types of violations: one is breaking change in the same version but not breaking change in a new version, the other is breaking change even in a new version.
For the former, a label 'NewApiVersionRequired' will be added automatically; For the latter, a label 'BreakingChangeReviewRequired' will be added automatically. Adding each label will trigger a github comment with guildance on how to fix.

### Run locally

run oad locally (the breaking change is reported by oad tool):
```
npm install -g @azure/oad
oad compare <old-spec-path> <new-spec-path>
```
Please see [readme](https://github.com/Azure/openapi-diff/blob/main/README.md) for how to install or run tool in details.
Or you can run it in [OpenAPI Hub](https://portal.azure-devex-tools.com/tools/diff).
Refer to [Oad Docs](https://github.com/Azure/openapi-diff/tree/main/docs) for detailed description of all oad rules.

## LintDiff Validation

The [LintDiff validation tool](https://github.com/Azure/azure-openapi-validator) runs linting rules against specification difference. Two specifications are compared: the specification as it would be when proposed PR is merged, vs the specification as seen before the PR is merged.

Refer to [openapi-authoring-automated-guidelines](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/openapi-authoring-automated-guidelines.md) for detailed description of all lint rules and how-to-fix guidance.  
If that guidance is not enough, please also refer to the [LintDiff rules.md doc](https://github.com/Azure/azure-openapi-validator/blob/main/docs/rules.md). It links to `.md` files related to given error, containing instructions how to fix them.

To reproduce LintDiff failures locally, see [CONTRIBUTING.md / How to locally reproduce a LintDiff failure occurring on a PR](https://github.com/Azure/azure-openapi-validator/blob/main/CONTRIBUTING.md#how-to-locally-reproduce-a-lintdiff-failure-occurring-on-a-pr).

## Avocado

### Get help fixing Avocado validation failures

Refer to [Avocado README](https://github.com/Azure/avocado/blob/master/README.md) for detailed description of validations and how-to-fix guidance.

### Run avocado locally

```
npm install -g @azure/avocado

avocado
```

When type avocado in command line, avocado will validate in the current directory.

Note: When running in Swagger PR pipeline, Avocado only report errors with file updates in the PR, but ignore the errors existing in base. However when running Avocado against local directory, it reports all errors existing in the files.

- Run all specs: Clone the repo `azure/azure-rest-api-specs` and run "avocado" in folder `azure/azure-rest-api-specs`.
- Run single service specs: create a folder `specification`. and move your service specs folder in `specification`. run "avocado"

## API Doc Preview

If you see `Swagger ApiDocPreview ` check fail with a failure [like this one](https://github.com/Azure/azure-rest-api-specs/pull/24841/checks?check_run_id=15056283615):

| Rule | Message |
|-|-|
| ❌ RestBuild error | "logUrl":"https://apidrop.visualstudio.com/Content%20CI/_build/results?buildId=373646&view=logs&j=fd490c07-0b22-5182-fac9-6d67fe1e939b",<br/>"detail":"Run.ps1 failed with exit code 1 " |

Then refer to [this TSG](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/79/Generation-of-docs-on-learn.microsoft.com?anchor=%22swagger-apidocpreview%22-build-is-failing).

## TypeSpec Validation

This validator is to ensure the TypeSpec & swagger files in PR are consistent and passing validation.

### How to fix

| Error Code                   | Severity | Solution                                                                                                                                                                                                                                                                                     |
|------------------------------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| MissingTypeSpecFile          | Error    | Adding the related TypeSpec project into {RP-Name} folder, like [Qumulo.Management](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/liftrqumulo/Qumulo.Management)                                                                                                     |
| MissingExamplesDirectory     | Error    | The example files should be kept in the 'examples' folder under the TypeSpec project,the typespec-autorest emitter will copy them into the output folder and create corresponding 'x-ms-examples' in the swagger automatically when geneates the swagger, you should also check in it in PR. |
| InConsistentSwagger          | Error    | The generated swagger is inconsistent with the swagger in PR, so you need to re-generate swagger from TypeSpec project and check in it.                                                                                                                                                      |
| SwaggerNotExistInPR          | Error    | It occurs when there is a TypeSpec file in the PR but the generated swagger is not present in the PR, so you need to add the swagger to the PR.                                                                                                                                              |
| GeneratedSwaggerNotFound     | Error    | It occurs when there is a TypeSpec file in the PR but there is no swagger produced by the typespec-autorest emitter, so you need to check the tspconfig.yaml to see if it has the wrong configuration, like 'output-dir' or 'azure-resource-provider-folder'.                                |
| MissingTypeSpecProjectConfig | Warning  | The configuration of '@azure-tools/typespec-autorest' including 'output-file','azure-resource-provider-folder' are used to customize the generated swagger file name and folder structure, it's recommended to use them in the 'tspconfig.yaml', here is a [sample tspconfig.yaml].          |

See [typespec-autorest](https://azure.github.io/typespec-azure/docs/emitters/typespec-autorest) for more information about how the swagger is generated from the TypeSpec project.

## Suppression Process

In case there are validation errors reported against your service that you believe do not apply, we have a suppression process you can follow to permanently remove these reported errors for your specs. Refer to the [suppression guide](https://aka.ms/pr-suppressions) for detailed guidance.

## Obsolete tools

Following tools have been removed from the validation toolchain as of August 2023.

- API Readiness Check
- Service API Readiness Test
- Traffic validation

[automated validation tooling]: https://eng.ms/docs/products/azure-developer-experience/design/api-specs/api-tooling
[Azure REST API specs PR]: https://eng.ms/docs/products/azure-developer-experience/design/api-specs-pr/api-specs-pr
[sample tspconfig.yaml]: https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L11
