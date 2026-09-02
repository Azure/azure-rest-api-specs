# OpenAPI Specifications Authoring - Manual Guidelines #

This document lists the set of manual guidelines that need to be followed while authoring OpenAPI(swagger) specs. 

[OpenAPI (Swagger) validation tools](https://github.com/Azure/adx-documentation-pr/blob/master/tools/tools.md) validate a large set of rules. These are listed in [Automated rules document](openapi-authoring-automated-guidelines.md).

Manual guidelines are the rules that could not be automated and would have to be verified manually by OpenAPI(swagger) spec authors before sending a pull request. 

It is a requirement to conform to all manual and automated rules with severity "Error" before sending a pull request for review.

We request OpenAPI(Swagger) spec authoring be assigned to engineers who have an intimate knowledge of a service endpoint and its developer experience to avoid feeding inefficiencies into teams that focus on Azure developer experiences and the rest of the Azure eco-system.

## Error vs Warning
- Rules with severity "Error" have to be addressed for the OpenAPI(swagger) spec to be approved by the reviewers. 

- Rules with severity "Warning" are either strong recommendations made by Azure developer experience team for better SDK/Documentation experience or they point out something to evaluate, for example, the warning for booleans asks the user to evaluate whether the property should be a boolean or not. 

## Manual Rules

### Errors

| Rule | Severity | Category | Applies to |
| --- | --- | --- | --- |
| Resource Model name MUST be same as singular form of the resource type. Like for virtualMachines resource type it should be VirtualMachine | Error |  | ARM OpenAPI(Swagger) specs |
| Required parameters MUST be accurately labeled as "required": true in OpenAPI(Swagger) spec | Error |  | ARM and Data plane OpenAPI(Swagger) specs |
| Read only parameters of the model properties MUST be labeled as "readOnly": true in OpenAPI(Swagger) spec | Error |  | ARM and Data plane OpenAPI(Swagger) specs |
| Required parameters MUST be accurately labeled as "required": true in OpenAPI(Swagger) spec | Error |  | ARM and Data plane OpenAPI(Swagger) specs |
| Required properties of a model definition MUST be accurately labeled as "required": [ "propertyName1" ] in OpenAPI(Swagger) spec | Error |  | ARM and Data plane OpenAPI(Swagger) specs |
| An OpenAPI(Swagger) spec MUST NOT define operations or properties or parameters for functionalities that are not currently supported by the service in the given api-version. The primary goal of the spec is that it MUST correctly and completely represent the underlying REST API. For example, NetworkInterface.ipConfigurations is described as a collection. However, it does not support adding more than one IP configuration | Error | | ARM and Data plane OpenAPI(Swagger) specs |
| A collection model in OpenAPI(Swagger) spec MUST support adding more than one element to the collection | Error |  | ARM and Data plane OpenAPI(Swagger) specs |
| Operations that are exposed through private previews MUST NOT be described in the public GitHub repository. They MUST be described in the private GitHub repository instead | Error | | ARM and Data plane OpenAPI(Swagger) specs |
| Parameters that are common to most of the operations (example: resourceGroupName) SHOULD be defined in the global parameters section and they MUST have the extension "x-ms-parameter-location": "method" applied on them. This will make sure that they do not end up being properties on the generated client | Error | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| Each operation described in a OpenAPI(Swagger) specification MUST be tested prior to opening a pull request against the preview/master branch of the Azure REST API Specs GitHub repo | Error |  | ARM and Data plane OpenAPI(Swagger) specs |

### Warnings
| Rule | Severity | Category | Applies to |
| --- | --- | --- | --- |
| Plural names in parameters and model properties MUST only be used to represent collections | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| Terminology in OpenAPI(Swagger) and Azure Portal MUST be the same | Warning | | ARM and Data plane OpenAPI(Swagger) specs |
| Parameter names in the apis MUST be name of the resource like virtualMachines{virtualMachine} or virtualMachines{virtualMachineName} both are good example but virtualMachines{vm} is bad example | Warning | | ARM and Data plane OpenAPI(Swagger) specs |
| Mutability of properties MUST be marked up using [`x-ms-mutability` extension](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-mutability) | Warning | | ARM and Data plane OpenAPI(Swagger) specs |
| Error definitions MUST be abstracted, modeled and reused | Warning | | ARM and Data plane OpenAPI(Swagger) specs |
| An OpenAPI(Swagger) specification MUST use "x-ms-codegeneration-settings": { "name": "<ServiceName>Client" } for providing a better name to the generated client | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| "externalDocs" property MUST have both "url" and "description" accurately provided. More details can be found [here](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#external-documentation-object) | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| Odata parameters like "$filter" MUST document the properties on which the object can be filtered on and the supported operators in the description | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| Odata parameters like "$filter" MUST have an externalDocs that provides good examples of how the "$filter" parameter can be used | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| Parameters or properties that can only accept one value MUST be marked as "required" and they MUST have an "enum" array constraint with one valid value in it | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| If a parameter or a model property indicates that it is some "kind/type" of an artifact that can have a value from set of possible values, then it SHOULD have an "enum": ["Array of possible values"] constraint on that entity. It MUST also use the "x-ms-enum" extension. If creating an enum is not possible, then the values need to be documented in description. If the number of allowed values is huge, add a link to some kind of external documentation in the description, where those values are defined | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| If an OpenAPI(swagger) spec specification has a "fully" pageable operation and a "single-page" only operation then the generated code in C# will generate Page1.cs and Page.cs. They will differ on nextLink. To avoid this it is best advised that all the operations SHOULD defined as "fully" pageable in the specification | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| Descriptions MUST NOT contain spelling errors, grammatical errors, run off sentences and dummy texts | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| The description/summary MUST use correct English spelling and grammar | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| Abbreviations must conform to the convention mentioned [here](https://msdn.microsoft.com/en-us/library/141e06ef(v=vs.71).aspx). For example, use "Url", NOT "URL"; and use "ID", NOT "Id" | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| The description for every operation MUST start with a verb phrase | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| The HTTP status codes returned by every REST operation MUST be documented | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| The documentation of model properties MUST NOT start with the phrase "Gets or sets ..", "Gets ..", "Sets .." | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| The "title" and "description" property of the "info" object in the OpenAPI(swagger) specification MUST NOT have the phrase client or .NET in it. The specification is used for different purposes and is used for generating REST clients in different languages | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| The description MUST specify the units of quantifiable properties/parameters. Example properties like size MUST specify the units (bytes, MB, GB, etc.) | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |
| All the negative response status code descriptions MUST be defined in the description of the "default" status code (if the intention is for documentation purpose only). Example: "description": "'404' - 'Not found'.\n'400' - 'Bad request'.\n'500': 'Internal Server Error'."' | Warning | SDK Violation | ARM and Data plane OpenAPI(Swagger) specs |


