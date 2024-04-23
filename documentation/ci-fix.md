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
    - [`@singleton` causes `EvenSegmentedPathForPutOperation` and `XmsPageableForListCalls`](#singleton-causes-evensegmentedpathforputoperation-and-xmspageableforlistcalls)
    - [`AvoidAnonymousParameter`, `AvoidAnonymousTypes`, `IntegerTypeMustHaveFormat`](#avoidanonymousparameter-avoidanonymoustypes-integertypemusthaveformat)
    - [`AvoidAnonymousTypes` inside a 202 response](#avoidanonymoustypes-inside-a-202-response)
    - [`OAuth2Auth` causes `XmsEnumValidation`](#oauth2auth-causes-xmsenumvalidation)
  - [`Swagger Avocado`](#swagger-avocado)
    - [Get help fixing Avocado validation failures](#get-help-fixing-avocado-validation-failures)
    - [Run avocado locally](#run-avocado-locally)
  - [`Swagger ApiDocPreview`](#swagger-apidocpreview)
  - [`TypeSpec Validation`](#typespec-validation)
    - [Run `tsv` locally](#run-tsv-locally)
  - [APIView Failures: troubleshooting guides](#apiview-failures-troubleshooting-guides)
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
Refer to [Semantic and Model Violations Reference](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Semantic-and-Model-Violations-Reference.md) for detailed description of validations and how-to-fix guidance.
Refer to [Swagger-Example-Generation](https://github.com/Azure/oav/blob/develop/documentation/example-generation.md) for example automatic generation.

## `Swagger SemanticValidation`

To repro issues with `Swagger SemanticValidation` locally:
```
npm install -g oav
oav validate-spec <openapi-spec-path>
```
Please see [readme](https://github.com/Azure/oav/blob/bd04e228b4181c53769ed88e561dec5212e77253/README.md) for how to install or run tool in details.
Refer to [Semantic and Model Violations Reference](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Semantic-and-Model-Violations-Reference.md) for detailed description of validations and how-to-fix guidance.

## `Swagger BreakingChange` and `BreakingChange(Cross-Version)`

See [aka.ms/azsdk/pr-brch-deep](https://aka.ms/azsdk/pr-brch-deep). If you want a quick read, see only [the `summary` section](https://aka.ms/azsdk/pr-brch-deep#summary).

### Run `oad` locally

To repro issues with "breaking changes" checks, you can locally run the tool that powers them: [Azure/openapi-diff](https://github.com/Azure/openapi-diff), aka `oad`:
```
npm install -g @azure/oad
oad compare <old-spec-path> <new-spec-path>
```
Please see [readme](https://github.com/Azure/openapi-diff/blob/main/README.md) for how to install or run tool in details.
Refer to [Oad Docs](https://github.com/Azure/openapi-diff/tree/main/docs) for detailed description of all oad rules.

## `Swagger LintDiff` and `Swagger Lint(RPaaS)`

The [LintDiff validation tool](https://github.com/Azure/azure-openapi-validator) runs linting rules against specification difference. Two specifications are compared: the specification as it would be when proposed PR is merged, vs the specification as seen before the PR is merged.

Refer to [openapi-authoring-automated-guidelines](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/openapi-authoring-automated-guidelines.md) for detailed description of all lint rules and how-to-fix guidance.  
If that guidance is not enough, please also refer to the [LintDiff rules.md doc](https://github.com/Azure/azure-openapi-validator/blob/main/docs/rules.md). It links to `.md` files related to given error, containing instructions how to fix them.

To reproduce LintDiff failures locally, see [CONTRIBUTING.md / How to locally reproduce a LintDiff failure occurring on a PR](https://github.com/Azure/azure-openapi-validator/blob/main/CONTRIBUTING.md#how-to-locally-reproduce-a-lintdiff-failure-occurring-on-a-pr).

## `Swagger LintDiff` for TypeSpec: troubleshooting guides

Check `Swagger LintDiff` may fail for the OpenAPI generated from TypeSpec, even if there are no warnings or errors reported from the TypeSpec compiler.  Causes include bugs in the TypeSpec OpenAPI emitter, bugs in LintDiff rules, incompatibilities between TypeSpec and LintDiff, or checks duplicated in TypeSpec and LintDiff.

We are working to address the root causes (where possible).  Until then, we recommend you [suppress](#suppression-process) these LintDiff errors, using a "permanent suppression" with a descriptive "reason", so we can revert your suppression when the root cause is fixed.

### `Record<unkown>` causes `AvoidAdditionalProperties` and `PropertiesTypeObjectNoDefinition`

The use of `Record<unkown>` in TypeSpec is discouraged, and there is a TypeSpec lint rule to enforce this.  If you still need to use `Record<unknown>`, the OpenAPI spec generated will cause many LintDiff errors of types `AvoidAdditionalProperties` and `PropertiesTypeObjectNoDefinition`.  You will need to suppress both the TypeSpec violation (in TypeSpec source code) and the LintDiff violations.

### `RequestBodyMustExistForPutPatch`

We believe this is a false positive: https://github.com/Azure/azure-openapi-validator/issues/641

### `PatchPropertiesCorrespondToPutProperties`

We believe this is a false positive: https://github.com/Azure/azure-openapi-validator/issues/642

### `@singleton` causes `EvenSegmentedPathForPutOperation` and `XmsPageableForListCalls`

If `EvenSegmentedPathForPutOperation` and/or `XmsPageableForListCalls` are failing for OpenAPI generated from TypeSpec using `@singleton` (OpenAPI path ends with `/default`), we believe this is a false positive: https://github.com/Azure/azure-openapi-validator/issues/646

### `AvoidAnonymousParameter`, `AvoidAnonymousTypes`, `IntegerTypeMustHaveFormat`

Data-plane specs can suppress violations of the following rules, since they only exist for the benefit of SDKs generated from swagger, and data-plane SDKs are generated directly from TypeSpec.  Resource-manager specs should **not** suppress violations of these rules, since resource-manager SDKs are generated from OpenAPI, and rely on these errors being fixed.

* `AvoidAnonymousParameter`
* `AvoidAnonymousTypes`
* `IntegerTypeMustHaveFormat`

### `AvoidAnonymousTypes` inside a 202 response

As an exception to the previous note, resource-manager specs **may** be able to suppress `AvoidAnonymousTypes`, but only if the error is inside a 202 response from a long-running operation (LRO).  It is known that SDKs do not need to generate type names for such responses.

### `OAuth2Auth` causes `XmsEnumValidation`

TypeSpec using `OAuth2Auth` may generate the following OpenAPI:

```
"type": {
  "type": "string",
  "description": "OAuth2 authentication",
  "enum": [
    "oauth2"
  ]
},
```

Which causes error `XmsEnumValidation`.  The recommended workaround is to add `omit-unreachable-types: true` to your `tspconfig.yaml`.

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

If none of the above helped, please reach out on [TypeSpec Discussions Teams channel].

## APIView Failures: troubleshooting guides
Various APIViews are generated as part of the Azure REST API specs PR build. Among these are TypeSpec and Swagger as well as any other language that is being generated in the run. When everything is successful you should see a comment box similar to the picture below showing the APIViews generated for TypeSpec or Swagger, plus all other languages being generated.

![alt text](image-3.png)

#### If an expected APIView was not generated, follow the step below to troubleshoot.

- On the CI check click on `details` > `View Azure DevOps build log for more details` to view the devOps logs.
- Investigate the CI job for the languge with error. TypeSpec and Swagger APIViews are generated as part of the `AzureRestApiSpecsPipeline` stage in the `TypeSpecAPIView` and `SwaggerAPIView` jobs respectively, while APIViews for other SDK languges are generated in their respective language jobs in the `SDK Automation` stage.
- Ensure that all previous checks in the job are green before proceeding. 

#### Diagnosing APIView failure for SDK Language (not Swagger or TypeSpec)
1. Check for an unexpected skip of the `Publish SDK APIView Artifact to Pipeline Artifacts` and `Generate SDK APIView` step.
2. Look in `SDK Automation` step to verify that the API token generation completed successfully.
3. Search logs for `Read Temp File`
4. Below `Read Temp File` find the .json object and search within to locate the `apiViewArtifact` property.
5. If not present, the APIView parser for the language failed to generate the `APIView Token Artifacts`.
6. Please contact [APIView Support Teams Channel] for assistance.

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
[TypeSpec Discussions Teams channel]: https://teams.microsoft.com/l/channel/19%3A906c1efbbec54dc8949ac736633e6bdf%40thread.skype/TypeSpec%20Discussion%20%F0%9F%90%AE?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47
[APIView Support Teams Channel]: https://teams.microsoft.com/l/channel/19%3A3adeba4aa1164f1c889e148b1b3e3ddd%40thread.skype/APIView?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47
