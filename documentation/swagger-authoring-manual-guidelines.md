# Manual Guidelines for Swagger Authoring #

This document lists the set of manual guidelines that need to be followed while authoring swagger specs. 

[Swagger validation tools](https://github.com/Azure/adx-documentation-pr/blob/master/tools/tools.md) validate a large set of rules. These are listed in [Automated rules document](swagger-authoring-automated-guidelines.md).

Manual guidelines are the rules that could not be automated and would have to be verified manually by swagger authors before sending a pull request. 

It is a requirement to conform to all manual and automated rules with severity "Error" before sending a pull request for review.

## Error vs Warning
- Rules with severity "Error" have to be addressed for the swagger to be approved by the reviewers. If there is a strong reason for why the rule cannot be addressed in a swagger spec, escalation process has to be followed to get sign off from management.

- Rules with severity "Warning" are strong recommendations made by Azure developer experience team for better SDK/Documentation experience. It is NOT a requirement to address them.

## Manual Rules

| Rule | Severity | Category |
| --- | --- | --- |
| Resource Model name MUST be same as singular form of the resource type. Like for virtualMachines resource type it should be VirtualMachine | Error |  |
| Read only parameters of the model properties MUST be labeled as "readOnly": true in Swagger | Error |  |
| Required parameters MUST be accurately labeled as "required": true in Swagger | Error |  |
| Required properties of a model definition MUST be accurately labeled as "required": [ "propertyName1" ] in Swagger |	Error |  |
| A Swagger spec MUST NOT define operations or properties or parameters for functionalities that are not currently supported by the service in the given api-version. The primary goal of the spec is that it MUST correctly and completely represent the underlying REST API. For example, NetworkInterface.ipConfigurations is described as a collection. However, it does not support adding more than one IP configuration | Error | |
| A collection model in Swagger MUST support adding more than one element to the collection | Error	|  |
| Operations that are exposed through private previews MUST NOT be described in the public GitHub repository. They MUST be described in the private GitHub repository instead | Error | |
| Parameters that are common to most of the operations (example: resourceGroupName) SHOULD be defined in the global parameters section and they MUST have the extension "x-ms-parameter-location": "method" applied on them. This will make sure that they do not end up being properties on the generated client | Error | SDK Violation |
| Each operation described in a Swagger specification MUST be tested prior to opening a pull request against the preview/master branch of the Azure REST API Specs GitHub repo | Error |  |
| Plural names in parameters and model properties MUST only be used to represent collections | Warning | SDK Violation |
| Terminology in Swagger and Azure Portal MUST be the same | Warning | |
| Parameter names in the apis MUST be name of the resource like virtualMachines{virtualMachine} or virtualMachines{virtualMachineName} both are good example but virtualMachines{vm} is bad example | Warning | |
| Mutability of properties MUST be marked up using [`x-ms-mutability` extension](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-mutability) | Warning | |
| Error definitions MUST be abstracted, modeled and reused | Warning | |
| A Swagger specification MUST use "x-ms-codegeneration-settings": { "name": "<ServiceName>Client" } for providing a better name to the generated client | Warning | SDK Violation |
| "externalDocs" property MUST have both "url" and "description" accurately provided. More details can be found here | Warning | SDK Violation |
| Odata parameters like "$filter" MUST document the properties on which the object can be filtered on and the supported operators in the description | Warning | SDK Violation |
| Odata parameters like "$filter" MUST have an externalDocs that provides good examples of how the "$filter" parameter can be used | Warning | SDK Violation |
| Parameters or properties that can only accept one value MUST be marked as "required" and they MUST have an "enum" array constraint with one valid value in it | Warning | SDK Violation |
| If a parameter or a model property indicates that it is some "kind/type" of an artifact that can have a value from set of possible values, then it SHOULD have an "enum": ["Array of possible values"] constraint on that entity. It MUST also use the "x-ms-enum" extension. If creating an enum is not possible, then the values need to be documented in description. If the number of allowed values is huge, add a link to some kind of external documentation in the description, where those values are defined | Warning | SDK Violation |
| If a swagger specification has a "fully" pageable operation and a "single-page" only operation then the generated code in C# will generate Page1.cs and Page.cs. They will differ on nextLink. To avoid this it is best advised that all the operations SHOULD defined as "fully" pageable in the specification | Warning | SDK Violation |
| Swagger authoring MUST NOT be assigned to engineers who do not have an intimate knowledge of a service endpoint and its developer experience to avoid feeding inefficiencies into teams that focus on Azure developer experiences and the rest of the Azure eco-system | Warning | |
| Descriptions MUST NOT contain spelling errors, grammatical errors, run off sentences and dummy texts | Warning | SDK Violation |
| The description/summary MUST use correct English spelling and grammar | Warning | SDK Violation |
| One MUST NOT use the API's code-symbol capitalization style for acronyms. For example, use "URL", NOT "Url"; and use "ID", NOT "Id" | Warning | SDK Violation |
| The description for every operation MUST start with a verb phrase | Warning | SDK Violation |
| The HTTP status codes returned by every REST operation MUST be documented | Warning | SDK Violation |
| The documentation of model properties MUST NOT start with the phrase "Gets or sets ..", "Gets ..", "Sets .." | Warning | SDK Violation |
| The "title" and "description" property of the "info" object in the swagger specification MUST NOT have the phrase client or .NET in it. The specification is used for different purposes and is used for generating REST clients in different languages | Warning | SDK Violation |
| The description MUST specify the units of quantifiable properties/parameters. Example properties like size MUST specify the units (bytes, MB, GB, etc.) | Warning | SDK Violation |
| All the negative response status code descriptions MUST be defined in the description of the "default" status code (if the intention is for documentation purpose only). Example: "description": "'404' - 'Not found'.\n'400' - 'Bad request'.\n'500': 'Internal Server Error'."' | Warning | SDK Violation |


