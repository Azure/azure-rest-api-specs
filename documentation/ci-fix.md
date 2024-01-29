# Table of Contents

- [Table of Contents](#table-of-contents)
- [CI Fix Guide](#ci-fix-guide)
  - [Prerequisites](#prerequisites)
  - [`Swagger SpellCheck`](#swagger-spellcheck)
  - [`Swagger PrettierCheck`](#swagger-prettiercheck)
    - [Prettier reference](#prettier-reference)
  - [`Swagger ModelValidation`](#swagger-modelvalidation)
  - [`Swagger SemanticValidation`](#swagger-semanticvalidation)
  - [`Swagger BreakingChange` and `BreakingChange(Cross-Version)`](#swagger-breakingchange-and-breakingchangecross-version)
    - [Adding label on PR automatically](#adding-label-on-pr-automatically)
    - [Run `oad` locally](#run-oad-locally)
  - [`Swagger LintDiff` and `Swagger Lint(RPaaS)`](#swagger-lintdiff-and-swagger-lintrpaas)
  - [`Swagger LintDiff` for TypeSpec: troubleshooting guides](#swagger-lintdiff-for-typespec-troubleshooting-guides)
    - [`Record<unkown>` causes `AvoidAdditionalProperties` and `PropertiesTypeObjectNoDefinition`](#recordunkown-causes-avoidadditionalproperties-and-propertiestypeobjectnodefinition)
    - [`RequestBodyMustExistForPutPatch`](#requestbodymustexistforputpatch)
    - [`PatchPropertiesCorrespondToPutProperties`](#patchpropertiescorrespondtoputproperties)
  - [`Swagger Avocado`](#swagger-avocado)
    - [Get help fixing Avocado validation failures](#get-help-fixing-avocado-validation-failures)
    - [Run avocado locally](#run-avocado-locally)
  - [`Swagger ApiDocPreview`](#swagger-apidocpreview)
  - [`TypeSpec Validation`](#typespec-validation)
    - [Run `tsv` locally](#run-tsv-locally)
  - [Suppression Process](#suppression-process)
  - [Checks not covered by this guide](#checks-not-covered-by-this-guide)
  - [Obsolete checks](#obsolete-checks)

# CI Fix Guide

Short link: https://aka.ms/azsdk/ci-fix

This page provides detailed instructions on how to diagnose, reproduce, fix and get help on various [automated validation tooling] failures on your [Azure REST API specs PR].

For more help, see [aka.ms/azsdk/pr-getting-help] and [aka.ms/azsdk/support].

## Prerequisites

Most guides here require for you to have `npm` installed, which you can get by installing [Node.js](https://nodejs.org/en/download).

## `Swagger SpellCheck`

If you receive a spelling failure either fix the spelling to match or if there are words that need to be suppressed for your service then add the word to the override list in [cspell.json](https://github.com/Azure/azure-rest-api-specs/blob/main/cSpell.json). Either
add to your existing section or create a new section for your specific spec or service family if the work is more generally used in lots of files under your service.
```
 "overrides": [
    ... example of specific file override
    {
        "filename": "**/specification/hdinsight/resource-manager/Microsoft.HDInsight/preview/2015-03-01-preview/cluster.json",
        "words": [
            "saskey"
        ]
    }
    ... example of specific service family override
    {
        "filename": "**/specification/cognitiveservices/**/*.json",
        "words": [
            "flac",
            "mpga"
        ]
    }
```
Words are case-insensitive so use lower case for the word list.

If you need more information on see [cspell configuration](https://cspell.org/configuration/). 

*Note*: We are trying to move away from one shared dictionary file so try and avoid editing custom-words.txt in the root as it will likely go away in the future.

## `Swagger PrettierCheck`

First, ensure you have fulfilled `Prerequisites` as explained above.

To update all the spec files for a given service run the following:

```
# To fix all the files in the repo run from the root of the repo
cd <local_repo_clone_root>

# OPTIONAL STEP: To fix a particular service OpenAPI spec cd to that directory like
cd specification/contosowidgetmanager

# Install the dependencies to the local 'node_modules' folder.
npm install

# Run 'prettier --check' to verify the problems can be reproduced locally
npx prettier --check **/*.json

# Run 'prettier --write' to fix the problems.
npx prettier --write **/*.json
```

Then please commit and push changes made by prettier.

### Prettier reference

- [`prettier` npm package](https://www.npmjs.com/package/prettier).
- [Source: Swagger-Prettier-Check.ps1](https://github.com/Azure/azure-rest-api-specs/blob/main/eng/scripts/Swagger-Prettier-Check.ps1)
- [Pipeline: Swagger PrettierCheck](https://dev.azure.com/azure-sdk/public/_build?definitionId=6405)

## `Swagger ModelValidation`

To repro issues with `Swagger ModelValidation` locally:
```
npm install -g oav
oav validate-example <openapi-spec-path>
```
Please see [readme](https://github.com/Azure/oav/blob/bd04e228b4181c53769ed88e561dec5212e77253/README.md) for how to install or run tool in details.
Or you can run it in [OpenAPI Hub](https://portal.azure-devex-tools.com/tools/static-validation/static/errors/default).
Refer to [Semantic and Model Violations Reference](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Semantic-and-Model-Violations-Reference.md) for detailed description of validations and how-to-fix guidance.
Refer to [Swagger-Example-Generation](https://github.com/Azure/oav/blob/develop/documentation/example-generation.md) for example automatic generation.

## `Swagger SemanticValidation`

To repro issues with `Swagger SemanticValidation` locally:
```
npm install -g oav
oav validate-spec <openapi-spec-path>
```
Please see [readme](https://github.com/Azure/oav/blob/bd04e228b4181c53769ed88e561dec5212e77253/README.md) for how to install or run tool in details.
Or you can run it in [OpenAPI Hub](https://portal.azure-devex-tools.com/tools/static-validation/static/errors/default)
Refer to [Semantic and Model Violations Reference](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Semantic-and-Model-Violations-Reference.md) for detailed description of validations and how-to-fix guidance.

## `Swagger BreakingChange` and `BreakingChange(Cross-Version)`

- An API contract is identified by its api-version value. Once published, no changes to this API contract are allowed. This applies regardless of whether the API contract is for private preview, public preview, or GA (stable).
    - The same-version breaking change linter rules check for changes to an existing api-version OpenAPI spec.
        - When introducing a new API contract (preview or not), the new API contract must be backwards compatible with the previous GA’s API contract.
            - However, during a (private or public) preview cycle, a new preview API contract does not have to be backwards compatible with the previous preview API contract although it must still be backwards compatible with the latest GA API contract.
            - The cross version breaking change linter rules checks for this by comparing the new OpenAPI spec with the latest GA OpenAPI spec. If there is no latest GA OpenAPI spec, then the latest preview if it > 1 year old. If nether a GA or preview > 1 year old exists, then the OpenAPI spec is considered good.

### Adding label on PR automatically

The breaking change check has two types of violations: one is breaking change in the same version but not breaking change in a new version, the other is breaking change even in a new version.
For the former, a label 'NewApiVersionRequired' will be added automatically; For the latter, a label 'BreakingChangeReviewRequired' will be added automatically. Adding each label will trigger a github comment with guldance on how to fix.

### Run `oad` locally

To repro issues with "breaking changes" checks, you can locally run the tool that powers them [Azure/openapi-diff](https://github.com/Azure/openapi-diff) aka `oad`:
```
npm install -g @azure/oad
oad compare <old-spec-path> <new-spec-path>
```
Please see [readme](https://github.com/Azure/openapi-diff/blob/main/README.md) for how to install or run tool in details.
Or you can run it in [OpenAPI Hub](https://portal.azure-devex-tools.com/tools/diff).
Refer to [Oad Docs](https://github.com/Azure/openapi-diff/tree/main/docs) for detailed description of all oad rules.

## `Swagger LintDiff` and `Swagger Lint(RPaaS)`

The [LintDiff validation tool](https://github.com/Azure/azure-openapi-validator) runs linting rules against specification difference. Two specifications are compared: the specification as it would be when proposed PR is merged, vs the specification as seen before the PR is merged.

Refer to [openapi-authoring-automated-guidelines](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/openapi-authoring-automated-guidelines.md) for detailed description of all lint rules and how-to-fix guidance.  
If that guidance is not enough, please also refer to the [LintDiff rules.md doc](https://github.com/Azure/azure-openapi-validator/blob/main/docs/rules.md). It links to `.md` files related to given error, containing instructions how to fix them.

To reproduce LintDiff failures locally, see [CONTRIBUTING.md / How to locally reproduce a LintDiff failure occurring on a PR](https://github.com/Azure/azure-openapi-validator/blob/main/CONTRIBUTING.md#how-to-locally-reproduce-a-lintdiff-failure-occurring-on-a-pr).

## `Swagger LintDiff` for TypeSpec: troubleshooting guides

### `Record<unkown>` causes `AvoidAdditionalProperties` and `PropertiesTypeObjectNoDefinition`

The use of `Record<unkown>` in TypeSpec is discouraged, and there is a TypeSpec lint rule to enforce this.  If you still need to use `Record<unknown>`, the OpenAPI spec generated will cause many LintDiff errors of types `AvoidAdditionalProperties` and `PropertiesTypeObjectNoDefinition`.  You will need to suppress both the TypeSpec violation (in TypeSpec source code) and the LintDiff violations (in `readme.md`).

### `RequestBodyMustExistForPutPatch`

We believe this is a false positive: https://github.com/Azure/azure-openapi-validator/issues/641.  Until fixed, spec authors should **not** suppress the violations in `readme.md`, but rather have label `Approved-LintDiff` applied to their PR to ignore the errors.

### `PatchPropertiesCorrespondToPutProperties`

We believe this is a false positive: https://github.com/Azure/azure-openapi-validator/issues/642.  Until fixed, spec authors should **not** suppress the violations in `readme.md`, but rather have label `Approved-LintDiff` applied to their PR to ignore the errors.

### `@singleton` causes `EvenSegmentedPathForPutOperation` and `XmsPageableForListCalls`

If `EvenSegmentedPathForPutOperation` and/or `XmsPageableForListCalls` are failing for OpenAPI generated from TypeSpec using `@singleton` (OpenAPI path ends with `/default`), we believe this is a false positive: https://github.com/Azure/azure-openapi-validator/issues/646.  Until fixed, spec authors should **not** suppress the violations in `readme.md`, but rather have label `Approved-LintDiff` applied to their PR to ignore the errors.

## `Swagger Avocado`

>[!IMPORTANT]
> `Swagger Avocado` check is not a blocking for merging your PR, even if it fails. 
> It is left to the discretion of the PR reviewer if the Avocado failure actually 
> needs to be addressed or suppressed.

### Get help fixing Avocado validation failures

Refer to [Avocado README](https://github.com/Azure/avocado/blob/master/README.md) for detailed description of validations and how-to-fix guidance.

### Run avocado locally

```
npm install -g @azure/avocado

avocado
```

When type avocado in command line, avocado will validate in the current directory.

Note: When running in OpenAPI spec PR pipeline, Avocado only report errors with file updates in the PR, but ignore the errors existing in base. However when running Avocado against local directory, it reports all errors existing in the files.

- Run all specs: Clone the repo `azure/azure-rest-api-specs` and run "avocado" in folder `azure/azure-rest-api-specs`.
- Run single service specs: create a folder `specification`. and move your service specs folder in `specification`. run "avocado"

## `Swagger ApiDocPreview`

If you see `Swagger ApiDocPreview ` check fail with a failure [like this one](https://github.com/Azure/azure-rest-api-specs/pull/24841/checks?check_run_id=15056283615):

| Rule | Message |
|-|-|
| ❌ RestBuild error | "logUrl":"https://apidrop.visualstudio.com/Content%20CI/_build/results?buildId=373646&view=logs&j=fd490c07-0b22-5182-fac9-6d67fe1e939b",<br/>"detail":"Run.ps1 failed with exit code 1 " |

Refer to [troubleshooting REST API documentation](https://eng.ms/docs/products/azure-developer-experience/design/api-docs-troubleshooting).

## `TypeSpec Validation`

This validator will help ensure your TypeSpec project follows [standard conventions](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/typespec-structure-guidelines.md) as well ensures that the [generated OpenAPI spec](https://azure.github.io/typespec-azure/docs/emitters/typespec-autorest) files are in-sync with your project.

### Run `tsv` locally

```
cd <repo>
git checkout <your-branch>
git merge <target-branch>
npm ci
npx tsv <path-to-your-spec>
git commit; git push (if any changes)

# example 
npx tsv specification/contosowidgetmanager/Contoso.WidgetManager
```
Then check any errors that might be outputted and address any issues as needed. If there are changed files after the runit generally means
that the generated OpenAPI spec files were not in-sync with the TypeSpec project and you should include those changes in your pull request as well. 

## Suppression Process

In case there are validation errors reported against your service that you believe do not apply, we have a suppression process you can follow to permanently remove these reported errors for your specs. Refer to the [suppression guide](https://aka.ms/pr-suppressions) for detailed guidance.

## Checks not covered by this guide

If you have an issue with a check that is not covered by this guide and the help at [aka.ms/azsdk/pr-getting-help] is not enough, 
please reach out on the Teams channel: [aka.ms/azsdk/support/specreview-channel].

## Obsolete checks

Following checks have been removed from the validation toolchain as of August 2023.

- API Readiness Check
- Service API Readiness Test
- Traffic validation

[automated validation tooling]: https://eng.ms/docs/products/azure-developer-experience/design/api-specs/api-tooling
[Azure REST API specs PR]: https://eng.ms/docs/products/azure-developer-experience/design/api-specs-pr/api-specs-pr
[aka.ms/azsdk/pr-getting-help]: https://aka.ms/azsdk/pr-getting-help
[aka.ms/azsdk/support/specreview-channel]: https://aka.ms/azsdk/support/specreview-channel
[aka.ms/azsdk/support]: https://aka.ms/azsdk/support
