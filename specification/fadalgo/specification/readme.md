# DevTest Center SDK

DevTest Center (Fidalgo) OpenAPI spec.

- common-types comes from shared types. A copy of this can be found in the api-spec repo
- devtestcenter: this contains the Microsoft.DevTestCenter OpenAPI (Swagger) spec

# Generating spec

To generate the SDK, run the generate_sdk.ps1. Current it will generate CSharp or Powershell (not both at once).

generate_sdk.ps1 -version '2021-01-01-alpha'


To generate Powershell, run with "-ps" switch



# Spec validation

See https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/ci-fix.md#ci-fix-guide for how to setup and configure validations locally

Make things pretty:
prettier -- --write "devtestcenter/**/*.json"

Model Validation:
oav validate-example <swagger-spec-path>
oav validate-example devtestcenter/resource-manager/Microsoft.DevTestCenter/preview/2021-01-01-alpha/devtestcenter.json

Semantic validation:
oav validate-example <swagger-spec-path>
oav validate-spec devtestcenter/resource-manager/Microsoft.DevTestCenter/preview/2021-01-01-alpha/devtestcenter.json

(RPaaS) Linter validation:
- Make sure no Errors, there's existing warnings. The rules warn about using bools (but the rule states its fine to ignore), and rule on missing systemData from list operations.

npx autorest --reset && npx autorest --validation --azure-validator --message-format=json --openapi-type=arm --use=@microsoft.azure/classic-openapi-validator@1.1.4 --use=@microsoft.azure/openapi-validator@1.5.0 --tag=v2021-01-01-alpha devtestcenter/resource-manager/Microsoft.DevTestCenter/readme.md
