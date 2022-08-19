# CI Fix Guide

Here are guides to fix some of the CI failure.

## Spell check

Please add your words to `./custom-words.txt` if you think you have the correct spell.

If your problem is some existing error name that is not a word and need to supress the error in that file (and don't want to add to custom-words.txt), you can add it to `./cSpell.txt`.

## Prettier check

Please run the following command (from an administrator Node.js command prompt if running on Windows):

```
npm install
npm run prettier-fix
```

Or if you want to fix specified service, use the complete path, not relative:

```
npm install
npm run prettier -- --write "<path to repo>/azure-rest-api-specs/specification/**/*.json"
```

Then please commit and push changes made by prettier.

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
-	When introducing a new API contract (preview or not), the new API contract must be backwards compatible with the previous GA’s API contract. 
   	- However, during a (private or public) preview cycle, a new preview API contract does not have to be backwards compatible with the previous preview API contract although it must still be backwards compatible with the latest GA API contract.
	- The cross version breaking change linter rules checks for this by comparing the new swagger with the latest GA swagger. If there is no latest GA swagger, then the latest preview if it > 1 year old. If nether a GA or preview > 1 year old exists, then the swagger is considered good.

### adding label on PR automatically
The breaking change check has two types of violations: one is breaking change in the same version but not breaking change in a new version, the other is breaking change even in a new version.
For the former, a label 'NewApiVersionRequired' will be added automatically; For the latter , a label 'BreakingChangeReviewRequired' will be added automatically. Adding each label will trigger a github comment with guildance on how to fix.

### run locally
run oad locally (the breaking change is reported by oad tool):
```
npm install -g @azure/oad
oad compare <old-spec-path> <new-spec-path> 
```
Please see [readme](https://github.com/Azure/openapi-diff/blob/main/README.md) for how to install or run tool in details.
Or you can run it in [OpenAPI Hub](https://portal.azure-devex-tools.com/tools/diff).
Refer to [Oad Docs](https://github.com/Azure/openapi-diff/tree/main/docs) for detailed description of all oad rules.

## Linter Diff Validation

The lint diff validation is to run linter against the currect spec and the spec before current PR , the final result is the differece set between the result running against current specs and the result running against the specs before current PR.
### Run linter locally:

#### Prerequisites:
npm install -g autorest

#### Given a swagger spec, run linter:
```
autorest --validation --azure-validator --use=@microsoft.azure/classic-openapi-validator@latest --use=@microsoft.azure/openapi-validator@latest --input-file=<path-to-spec> 
```
#### Given a readme file, run linter:
```
autorest --validation --azure-validator --use=@microsoft.azure/classic-openapi-validator@latest --use=@microsoft.azure/openapi-validator@latest [--tag=<readme tag>] <path-to-readme>
```

Please see [readme](https://github.com/Azure/azure-openapi-validator/blob/main/README.md) for how to install or run tool in details.
Or you can run it in [OpenAPI Hub](https://portal.azure-devex-tools.com/tools/linter).
Refer to [openapi-authoring-automated-guidelines](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/openapi-authoring-automated-guidelines.md) for detailed description of all lint rules and how-to-fix guidance.

## Avocado

Run avocado locally:

```
npm install -g @azure/avocado

avocado
```

When type avocado in command line, avocado will validate in the current directory.

Note: When running in Swagger PR pipeline, Avocado only report errors with file updates in the PR, but ignore the errors existing in base. However when running Avocado against local directory, it reports all errors existing in the files.

- Run all specs: Clone the repo `azure/azure-rest-api-specs` and run "avocado" in folder `azure/azure-rest-api-specs`.
- Run single service specs: create a folder `specification`. and move your service specs folder in `specification`. run "avocado"

Refer to [Avocado Readme](https://github.com/Azure/avocado/blob/master/README.md) for detailed description of validations and how-to-fix guidance.

## API Readiness Check

This CI check is to make sure service is ready before PR merge. Technically, the CI check send operationsList HTTP request to Azure Resource Provider. 

To fix this CI check failure, if you haven't got ARM signed off, pls get ARM signed off first then deploy ARM manifest. After deploying ARM manifest, this operationsList HTTP request will succeed and CI pass.

NOTE: If your RP is RPaaS RP, since RPaaS requires swagger merge first. In this case, you could ignore this CI check.


## Service API Readiness Test

This CI check is to test service API readiness, by running API Scenario test to verify:
- Service APIs are deployed to Azure
- API behavior is consistent with Swagger definition
- [InProgress] API behavior is compliant with Azure API guidelines, including [ARM RPC](https://github.com/Azure/azure-resource-manager-rpc) and [Microsoft Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md).

Note: Currently only applicable to management plane APIs, and target ARM region is `US West Central` - the SDP pilot region.

To fix the check, download the artifact `api_scenario_test_output` from Azure pipeline where you can find the report.html and auto generated API Scenario file as baseline, then refer to [API Scenario documentation](./api-scenario/readme.md) to run and debug it locally. After local debug, commit the API Scenario file and `readme.test.md` file into your working branch and then the CI check will use the committed API Scenario file to re-run the test.

## SDK Track2 Validation

This CI check is to run [autorest.modelerfour](https://github.com/Azure/autorest.modelerfour) for each changing tag in a PR.
Since the code generators of track2 SDK are based on the autorest.modelerfour, it's recommended ensure this validation is passed without any error and warning.
The `modelerfour` has several plugins. If a plugin report an error, you can refer to the following plugin documentations:
- [PreChecker](https://github.com/Azure/autorest/blob/main/docs/openapi/prechecker.md)

### Run locally:

#### Prerequisites:

```
npm install -g autorest
```
#### Given a swagger spec, run the validator:
```
autorest --v3 --azure-validator --use=@microsoft.azure/openapi-validator@latest --input-file=<path-to-spec> 
```
#### Given a readme file, run the validator:
```
autorest --v3 --azure-validator --semantic-validator=false --model-validator=false --use=@microsoft.azure/openapi-validator@latest [--tag=<readme tag>] <path-to-readme>
```

## Cadl Validation

This validator is to ensure the cadl & swagger files in PR are consistent and the 'cadl' folder contains 'examples' and 'package.json'

### How to fix
| Error Code | solution |
|---| ---|
|MissingPakcageJson| adding the package.json to the cadl folder|
|MissingCadlFile| adding the related cadl files into 'cadl' folder, like [https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSMaster/specification/networkanalytics/resource-manager/Microsoft.NetworkAnalytics/cadl](https://github.com/Azure/azure-rest-api-specs-pr/tree/586cb177f1bab647da7ac60907fa3aa695b67ae1/specification/networkanalytics/resource-manager/Microsoft.NetworkAnalytics/cadl)|
|MissingExamplesDirectory| the example files should be kept in the 'cadl/examples' folder, you should also check in it in PR. |
|InConsistentSwagger| the generated swagger is inconsistent with the swagger in PR, so you need to re-generate swagger from cadl, and check in it |
|SwaggerNotExistInPR| the occurs when there is cadl file in the PR but the swagger is not present in the PR, so you need to add the swagger to the PR |

## Traffic Validation

It generates traffics for all operations defined in swaggers under default tag of readme.md by using [RESTLer](https://github.com/microsoft/restler-fuzzer). Then it validates the request and response pairs from these traffics against correspondent swaggers. Finally, it provides a html report that reflects swagger accuracy.

### How to understand and improve the report
Please refer to [swagger-accuracy-report](./swagger-accuracy-report.md).

## Suppression Process

In case there are validation errors reported against your service that you believe do not apply, we have a suppression process you can follow to permanently remove these reported errors for your specs.  Refer to [Swagger Suppression Process](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/85/Swagger-Suppression-Process) for detailed guidance. 
