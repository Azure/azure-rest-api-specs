# OpenAPI Specifications Authoring - Automated Guidelines #

This document lists the set of automated rules that can be validated against OpenAPI(swagger) spec by running [validation tools](https://github.com/Azure/adx-documentation-pr/wiki/OpenAPI-Validation-tools). Please visit [here for Manual guidelines](openapi-authoring-manual-guidelines.md).

It is a requirement to conform to all manual and automated rules with severity "Error" before sending a pull request for review.

We request OpenAPI(Swagger) spec authoring be assigned to engineers who have an intimate knowledge of a service endpoint and its developer experience to avoid feeding inefficiencies into teams that focus on Azure developer experiences and the rest of the Azure eco-system.

## Index
* [Error vs. Warning](#error-vs-warning)
* [Automated Rules](#automated-rules)
  * [RPC Violations](#rpc-violations)
    * [RPC Errors](#rpc-errors)
    * [RPC Warnings](#rpc-warnings)
  * [SDK Violations](#sdk-violations)
    * [SDK Errors](#sdk-errors)
    * [SDK Warnings](#sdk-warnings)
* [Rule Descriptions](#rule-descriptions)

## Error vs Warning
- Rules with severity "Error" have to be addressed for the OpenAPI(swagger) spec to be approved by the reviewers. If there is a strong reason for why the rule cannot be addressed in an OpenAPI(swagger) spec it will be a permanent exception, then [suppression process](https://github.com/Azure/adx-documentation-pr/wiki/Swagger-Validation-Errors-Suppression) must be followed.

- Rules with severity "Warning" are either strong recommendations made by Azure developer experience team for better SDK/Documentation experience or they point out something to evaluate, for example, the warning for booleans asks the user to evaluate whether the property should be a boolean or not. 

## Automated Rules

### RPC Violations

#### RPC Errors

| Id | Rule Name | Output Message |Severity | 
| --- | --- | --- | --- |
| [M3012](#M3012)	| [APIVersionPattern](#M3012)	| API Version must be in the format: yyyy-MM-dd, optionally followed by -preview, -alpha, -beta, -rc, -privatepreview.	|  Error |
| M3019	| ARMResourcePropertiesBag	| Top level property names should not be repeated inside the properties bag for ARM resource '{0}'. Properties [{1}] conflict with ARM top level properties. Please rename these. | Error |
| [M3016](#M3016)	| [BodyPropertiesNamesCamelCase](#M3016) | Property named: "{0}", must follow camelCase style. Example: "{1}". | Error |
| [M3016](#M3016)	| [DefinitionsPropertiesNamesCamelCase](#M3016)  | Property named: "{0}", for definition: "{1}" must follow camelCase style. Example: "{2}". | Error |
| M3006	| BodyTopLevelProperties | Top level properties should be one of name, type, id, location, properties, tags, plan, sku, etag, managedBy, identity. Extra properties found: "{0}". | Error |
| [R3008](#R3008)	| CollectionObjectPropertiesNaming | Collection object {0} returned by list operation {1} with 'x-ms-pageable' extension, has no property named 'value'. | Error |
| M2044	| HttpVerbValidation | Permissible values for HTTP Verb are delete,get,put,patch,head,options,post. | Error |
| [R3023](#R3023)	| OperationsAPIImplementation | Operations API must be implemented for '{0}'. | Error |
| M3007	| PutGetPatchResponseValidation | {0} has different responses for PUT/GET/PATCH operations. The PUT/GET/PATCH operations must have same schema response. | Error |
| M3003	| RequiredPropertiesMustExist | Required property does not appear in the list of properties | Error |
| M3001 | ResourceModelValidation | Model definition '{0}' must have the properties 'name', 'id' and 'type' in its hierarchy and these properties must be marked as readonly. | Error |
| M3027	| TrackedResourceGetOperationValidation | Tracked resource '{0}' must have a get operation | Error |
| [R3026](#R3026)	| TrackedResourcePatchOperationValidation | Tracked resource '{0}' must have patch operation that at least supports the update of tags | Error |
| [R2059](#R2059)	| UniqueResourcePaths | Multiple resource providers are not allowed in a single spec. More than one the resource paths were found: '{0}'. | Error |
| M3013	| DeleteMustNotHaveRequestBody | 'Delete' operation must not have a request body. | Error |
| M2016	| PatchBodyParametersSchemaValidation | Properties of a PATCH request body must not be {0}. PATCH operation: '{1}' Model Definition: '{2}' Property: '{3}' | Error |
| M2062	| PutResponseResourceValidation | The 200 response model for an ARM PUT operation must have x-ms-azure-resource extension set to true in its hierarchy. Operation: '{0}' Model: '{1}'. | Error |
| [R3027](#R3027)	| TrackedResourceListByResourceGroup | The tracked resource, '{0}', must have a list by resource group operation. | Error |
| [R3028](#R3028)	| TrackedResourceListBySubscription | The tracked resource, '{0}', must have a list by subscriptions operation. | Error |
| [R3011](#R3011)	| DescriptionMustNotBeNodeName | The description provided for a given node (property, parameter, etc.) must not be the same as the name assigned to the node. | Error |
| [R2020](#R2020) | RequiredPropertiesMissingInResourceModel | A `Resource` model must have `name`, `id` and `type` properties defined. | Error |

#### RPC Warnings

| Id | Rule Name | Output Message |Severity | 
| --- | --- | --- | --- |
| M2061	| ProvidersPathValidation |	Type values \"{0}\" have default value(s), please consider parameterizing them | Warning |
| [R3018](#R3018)	| BooleanPropertyNotRecommended	| Booleans are not descriptive and make them hard to use. Instead use string enums with allowed set of values defined. |	Warning |
| [R3017](#R3017)	| GuidUsage | Guid used in model definition '{1}' for property '{0}'. Usage of Guid is not recommanded. If GUIDs are absolutely required in your service, please get sign off from the Azure API review board. | Warning |
| M2057	| SkuModelValidation | Sku Model is not valid. A Sku model must have 'name' property. It can also have 'tier', 'size', 'family', 'capacity' as optional properties. | Warning |
| [R3010](#R3010)	| TrackedResourceListByImmediateParent | The child tracked resource, '{0}' with immediate parent '{1}', must have a list by immediate parent operation. | Warning |

### SDK Violations

#### SDK Errors

| Id | Rule Name | Output Message |Severity | 
| --- | --- | --- | --- |
| M2026 | AvoidAnonymousTypes, AnonymousBodyParameter |	Inline/anonymous models must not be used, instead define a schema with a model name in the "definitions" section and refer to it. This allows operations to share the models. | Error |
| [R2014](#R2014)	| OperationParametersValidation	| Parameter "subscriptionId" is not allowed in the operations section, define it in the global parameters section instead | Error |
| [R2027](#R2027)	| DefaultMustBeInEnum | The default value is not one of the values enumerated as valid for this element. | Error |
| M1004	| ListByOperationsValidation | Operation must be one of List() - lists all resources under a subscription.  ListByResourceGroup() - list all resources in a resource group within a subscription. ListByParent() - where ""Parent"" is a context specific suffix. It lists all resource under a parent. | Error |
| [R1001](#R1001)	| OperationIdNounInVerb	| Per the Noun_Verb convention for Operation Ids, the noun '{0}' should not appear after the underscore. | Error |
| [R2055](#R2055)	| OneUnderscoreInOperationId | Only 1 underscore is permitted in the operation id, following Noun_Verb conventions.  | Error |
| [R2014](#R2014)	| ServiceDefinitionParameters | Parameter "{0}" is referenced but not defined in the global parameters section of Service Definition |Error |
| M2043	| SupportedSchemesWarning | Azure Resource Management only supports HTTPS scheme. | Error | 
| [R2003](#R2003)	| ValidFormats | '{0}' is not a known format.	| Error |
| M2005	| LongRunningResponseValidationRule | A '{0}' operation '{1}' with x-ms-long-running-operation extension must have a valid terminal success status code {2}. | Error |
| [R2008](#R2008)	| MutabilityWithReadOnlyRule | When property is modeled as "readOnly": true then x-ms-mutability extension can only have "read" value. When property is modeled as "readOnly": false then applying x-ms-mutability extension with only "read" value is not allowed. Extension contains invalid values: '{0}'. | Error |
| M2025	| NextLinkPropertyMustExist	| The property '{0}' specified by nextLinkName does not exist in the 200 response schema. \nPlease, specify the name of the property that provides the nextLink. If the model does not have the nextLink property then specify null. | Error |
| [R2028](#R2028) | [NonEmptyClientName](#R2028) | Empty x-ms-client-name property | Error |
| M2060 | PageableRequires200Response | A response for the 200 HTTP status code must be defined to use x-ms-pageable | Error |
| M2019	| ResourceIsMsResourceValidation | A 'Resource' definition must have x-ms-azure-resource extension enabled and set to true. |	Error |
| [R2058](#R2058) |XmsPathsMustOverloadPaths | Paths in `x-ms-paths` must overload a normal path in the paths section, i.e. a path in the `x-ms-paths` must either be same as a path in the paths section or a path in the paths sections followed by additional parameters. | Error |
| [R2012](#R2012)	| [XmsClientNameParameter](#R2012) | Value of 'x-ms-client-name' cannot be the same as '{0}' Property/Model. | Error |
| [R2013](#R2013)	| [XmsClientNameProperty](#R2013) | Value of 'x-ms-client-name' cannot be the same as '{0}' Property/Model. | Error |
| M2047	| ParameterNameValidation | Parameter Must have the "name" property defined with non-empty string as its value | Error |
| [R2056](#R2056)	| RequiredReadOnlyProperties | Property '{0}' is a required property. It should not be marked as 'readonly'. | Error |
| M2054	| SecurityDefinitionsStructureValidation | An OpenAPI(swagger) spec must have security definitions and must adhere to the specific structure. | Error |
| [R2006](#R2006)	| ControlCharactersNotAllowed | Specification must not contain any control characters. | Error |
| [R2009](#R2009)	| ArraySchemaMustHaveItems | A property of type `Array` must have `items` defined in its `Schema`. | Error |
| [R2022](#R2022) | [XmsExamplesRequired](#R2022) | Please provide x-ms-examples describing minimum/maximum property set for response/request payloads for operations.{0} | Error |
| [R2064](#R2064) | [LicenseMissing](#R2064) | Please provide correct licensing information here. Acceptable value: "name": "MICROSOFT\_MIT\_NO\_VERSION" | Error |

#### SDK Warnings

| Id | Rule Name | Output Message |Severity | 
| --- | --- | --- | --- |
| M4000 | ModelTypeIncomplete |	This definition lacks the property 'description', which is required for model types	| Warning |
| M4000 | ParameterDescriptionRequired, OperationDescriptionRequired  | {0} lacks 'description' property. Consider adding a 'description' element. Accurate description is essential for maintaining reference documentation. | Warning |
 M4000 | DescriptiveDescriptionRequired | The value provided for description is not descriptive enough. Accurate and descriptive description is essential for maintaining reference documentation. | Warning |
| [R2001](#R2001)	| AvoidNestedProperties | Consider using x-ms-client-flatten to provide a better end user experience | Warning |
| [R4002](#R4002)	| LocationMustHaveXmsMutability | The "location" property of "Resource" model definition in ARM MUST have "x-ms-mutability": ["create", "read"] extension. | Warning |
| [R2064](#R2064)	| PostOperationIdContainsUrlVerb | A POST operation OperationId must contain the verb at the end of the url related to the operation. | Warning |
| [R2015](#R2015) | ParameterNotDefinedInGlobalParameters | Parameters `subscriptionId` and `api-version` must be declared as global parameters. | Warning |
| [R1010](#R1010) | [AvoidMSDNReferences](#R1010) |	For better generated code quality, remove all references to "msdn.microsoft.com". | Warning |
| [R2004](#R2004)	| [NonApplicationJsonType](#R2004) | Please make sure that media types other than 'application/json' are supported by your service. | Warning |
| M2063	| BodyParametersValidation | A body parameter must be named 'parameters'. | Warning |
| M2017	| PutRequestResponseValidation | A PUT operation request body schema should be the same as its 200 response schema, to allow reusing the same entity between GET and PUT. If the schema of the PUT request body is a superset of the GET response body, make sure you have a PATCH operation to make the resource updatable. Operation: '{0}' Request Model: '{1}' Response Model: '{2}' | Warning |
| [R1009](#R1009) | [DeleteInOperationName](#R1009) | 'DELETE' operation '{0}' should use method name 'Delete'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change. | Warning |
| [R1005](#R1005) | [GetInOperationName](#R1005) | 'GET' operation '{0}' should use method name 'Get' or Method name start with 'List'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change. | Warning |
| [R1003](#R1003) | [ListInOperationName](#R1003) | Since operation '{0}' response has model definition '{1}', it should be of the form "*_list*" | Warning |
| [R1006](#R1006)	| [PutInOperationName](#R1006) | 'PUT' operation '{0}' should use method name 'Create'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change. | Warning |
| [R1007](#R1007) | [PatchInOperationName](#R1007) | 'PATCH' operation '{0}' should use method name 'Update'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change. | Warning |
| [R1011](#R1011) | [HttpsSupportedScheme](#R1011) | 'Azure Resource Management only supports HTTPS scheme. | Warning |
| [R2065](#R2065) | [LicenseHeaderMustNotBeSpecified](#R2065) | License header must not be specified inside `x-ms-code-generation` settings of OpenAPI document. | Warning |

## Rule Descriptions

### <a name="M3012" />M3012 APIVersionPattern
**Output Message**: API Version must be in the format: yyyy-MM-dd, optionally followed by -preview, -alpha, -beta, -rc, -privatepreview.

**Description**: The API Version paramemter MUST be in the Year-Month-Date format (i.e. 2016-07-04.)  NOTE that this is the en-US ordering of month and date.  

The date MAY optionally be followed by one of:
* -preview - Indicates the API version is in (public) preview
* -alpha
* -beta
* -rc (release candidate)
* -privatepreview

**Good Examples**: Examples of valid version patterns include:
* 2016-07-04
* 2016-07-04-preview

**Bad Examples**: The following would be invalid:
* 97-07-04 - Date should be YYYY, not YY
* 2016/07/04 - Date should use "-", not "/"
* 1842-07-04 - Year should be accurate; we didn't have Azure in 1842 :(
* 2150-07-04 - Year should be current, not in the future; though we'll hopefully get here eventually :)
* 2016-07-04-publicpreview - Use "-preview" to indicate a public preview
* 2016-07-04-rc0 - Just use "rc", not "rc" + number

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="M3016" />M3016 PropertiesNamesCamelCase
**Output Message**: Property named: "{0}", must follow camelCase style. Example: "{1}".
**Output Message**: Property named: "{0}", for definition: "{1}" must follow camelCase style. Example: "{2}".

**Description**: Property names must use lowerCamelCase style. 
If the property is a single word (ex: foo, bar, etc.) it will be all lowercase. 
Two-letter acronmys (ex: ID, IO, IP, etc.) should be capitalized. 
Three-letter acronyms (ex: API, URL, etc.) should only have the first letter capitalized (ex: Api, Url, etc.) 
For more capitalization guidance, see: [https://msdn.microsoft.com/en-us/library/141e06ef(v=vs.71).aspx](https://msdn.microsoft.com/en-us/library/141e06ef(v=vs.71).aspx)

**Good Examples**: Examples of lowerCamelCase style:
* camelCase
* foo
* bar
* fooBarBaz
* resourceKey
* resourceApiKey

**Bad Examples**: The following would be invalid:
* PascalCase
* UpperCamelCase
* resourceAPIKey

**Bad Examples**: The following violate these guidelines but would not be caught by automation: 
* alllowercase - If there are multiple words, please capitalize starting with the second word
* miXeDcApItAlIzAtIoN - Please capitalize the first letter of each word (and not seemingly random letters)

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3025" />R3025 TrackedResourceGetOperationValidation
**Output Message**: Tracked resource '{0}' must have a get operation.

**Description**: Verifies if a tracked resource has a corresponding GET operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per ARM guidelines, each tracked resource must have a GET operation.

**How to fix the violation**: Add a GET operation that returns the tracked resource pointed out by the rule - if the operation does not exist for the service, this fix requires a service side change. 
If the resource pointed by the rule is not a tracked resource, this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding GET operation only if it's present in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3026" />R3026 TrackedResourcePatchOperationValidation
**Output Message**: Tracked resource '{0}' must have patch operation that at least supports the update of tags.

**Description**: Verifies if a tracked resource has a corresponding PATCH operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per ARM guidelines, each tracked resource must have a PATCH operation supporting at least the update of tags.

**How to fix the violation**: Add a PATCH operation that allows at least the update of tags for the tracked resource - if the operation does not exist for the service, this fix requires a service side change. 
If the resource pointed by the rule is not a tracked resource, this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding PATCH operation only if it's present in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3027" />R3027 TrackedResourceListByResourceGroup
**Output Message**: The tracked resource, '{0}', must have a list by resource group operation.

**Description**: Verifies if a tracked resource has a corresponding ListByResourceGroup operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per ARM guidelines, each tracked resource must have a corresponding ListByResourceGroup operation.

**How to fix the violation**: Add a corresponding ListByResourceGroup operation for the tracked resource - if the operation does not exist for the service, this fix requires a service side change. If the operation already exists and it is not named following the naming convention "ListbyResourceGroup", consider updating the operation name. 
If the resource pointed by the rule is not a tracked resource or the operation that allows listing by resource group does not follow the naming convention "ListByResourceGroup", this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding ListByResourceGroup operation as included in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3028" />R3028 TrackedResourceListBySubscription
**Output Message**: The tracked resource, '{0}', must have a list by subscriptions operation.

**Description**: Verifies if a tracked resource has a corresponding ListByResourceGroup operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per ARM guidelines, each tracked resource must have a corresponding ListBySubscription operation.

**How to fix the violation**: Add a corresponding ListBySubscription operation for the tracked resource - if the operation does not exist for the service, this fix requires a service side change. If the operation already exists and it is not named following the naming conventions: List, ListBySubscriptionId, ListBySubscription or ListBySubscriptions, consider updating the operation name. 
If the resource pointed by the rule is not a tracked resource or the operation that allows listing by subscription ID does not follow the naming convention mentioned above, this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding ListBySubscription operation as included in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3010" />R3010 TrackedResourceListByImmediateParent
**Output Message**: Validates if the child tracked resources have list by immediate parent operation.

**Description**: Verifies if a tracked resource has a corresponding list by immediate parent operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per ARM guidelines, each tracked resource must have a corresponding "list by immediate parent" operation.

**How to fix the violation**: Add an operation that allows listing the tracked resource by its immediate parent - if the operation does not exist for the service, this fix requires a service side change. If the operation already exists, please double check the name of the operation, our rule is matching the parent and child resource names to the operation names, if those don't match 100%, this warning may be a false positive, please evaluate whether the named picked is appropriate or needs update. 
If the resource pointed by the rule is not a tracked resource this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding "list by immediate parent" operation as included in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3018" />R3018 EnumInsteadOfBoolean
**Output Message**: Booleans are not descriptive and make them hard to use. Instead use string enums with allowed set of values defined.

**Description**: Booleans properties are not descriptive in all cases and can make them to use, evaluate whether is makes sense to keep the property as boolean or turn it into an enum. 

**Why the rule is important**: Evaluate whether the property is really a boolean or not, the intent is to consider if there could be more than 2 values possible for the property in the future or not. If the answer is no, then a boolean is fine, if the answer is yes, there could be other values added in the future, making it an enum can help avoid breaking changes in the SDKs in the future.

**How to fix the violation**: Create an enum property, follow autorest [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) guidelines.

**Impact on generated code**: Boolean property will turn into a String or an Enum (if SDK language supports it), this will depend on "modelAsString" property value as specified in [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) guidelines.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R4002" />R4002	LocationMustHaveXmsMutability
**Output Message**: Property 'location' must have '\"x-ms-mutability\":[\"read\", \"create\"]' extension defined. Resource Model: '{0}'

**Description**: A tracked resource's `location` property must have the `x-ms-mutability` properties set as `read`, `create`.

**Why the rule is important**: Location is a property that is set once and non-updatable for a tracked resource. Hence, per ARM guidelines the only operations allowed are `read` and `create`.

**How to fix the violation**: Ensure that the `location` property in the tracked resource's hierarchy has `x-ms-mutability` correctly set to `read` and `create`.
For example:
```
"location": {
  "type": "string",
  "description": "location of the resource",
  "x-ms-mutability": [ "create", "read" ]
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2028" />R2028 NonEmptyClientName
**Output Message**: Empty x-ms-client-name property.

**Description**: The [`x-ms-client-name`](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-client-name) extension is used to change the name of a parameter or property in the generated code.

**Why the rule is important**: This value cannot be empty, because we need to use it as the identifier for a property or model.

**How to fix the violation**: Add a non-empty value for `x-ms-client-name`.

**Impact on generated code**: Generated SDK code will expose the corresponding client name on property or model.

**Examples**:
```
...
"x-ms-client-name": "name"
...
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2064" />R2064	PostOperationIdContainsUrlVerb
**Output Message**: OperationId should contain the verb: '{0}' in:'{1}'

**Description**: A POST operation's operationId should contain the verb indicated at the end of the corresponding url.

**Why the rule is important**: The url indicates the action performed by it, the corresponding POST operationId should therefore contain this verb for semantic consistency.

**How to fix the violation**: Ensure that the operationId for POST operation contains the verb indicated at the end of the url.

**Good Examples**: Examples of url and corresponding POST operationIds:
* Url: /foo/{someResource}/activate
* OperationId: SomeResourceTypes_ActivateResource

**Bad Examples**: Examples of url and corresponding POST operationIds:
* Url: /foo/{someResource}/activate
* OperationId: SomeResourceTypes_StartResource

**Impact on generated code**: Method generated for the POST operation will be named as indicated after the '__underscore__'. For eg., OperationId *SomeResourceTypes_ActivateResource* will generate a method named *ActivateResource*

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2009" />R2009 ArraySchemaMustHaveItems
**Output Message**: Please provide an items property for array type: '{0}'.

**Description**: A schema of `array` type must always contain an `items` property. without it, AutoRest will fail to generate an SDK.

**Why the rule is important**: AutoRest needs to know the type of item contained in the array so that it can correctly generate the corresponding code.

**How to fix the violation**: Correctly specify the `items` section for given array type. The items can be of any primitive type or can be a reference to another object type.

**Good Examples**:
Example with primitive type.
```
"MyPrimitiveArray":{
  "type": "array",
  "items": {
    type: "number"
  }
}
```
Example with object reference type
```
"MyComplexArray":{
  "type": "array",
  "items": {
    "$ref": "#/definitions/MySimpleObject"
  }
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2012" />R2012 XmsClientNameParameter
**Output Message**: Value of 'x-ms-client-name' cannot be the same as '{0}' Property/Model.

**Description**: The [`x-ms-client-name`](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-client-name) extension is used to change the name of a parameter or property in the generated code. By using the 'x-ms-client-name' extension, a name can be defined for use specifically in code generation, separately from the name on the wire. It can be used for query parameters and header parameters, as well as properties of schemas. This name is case sensitive.

**Why the rule is important**: This value cannot be same as parameter name or property name, because having the same name invalidates the usage.

**How to fix the violation**: Please specify non-empty `x-ms-client-name`, different from the model/property name that you'd like to be generated.

**Impact on generated code**: Generated SDK code will expose the corresponding client name on property or model.

**Examples**:
```
"parameters": {
    "ApiVersionParameter": {
      "name": "x-ms-version",
      "x-ms-client-name": "version",
      "in": "header",
      "required": false,
      "type": "string",
      "x-ms-global": true,
      "enum": [
        "2015-04-05",
        "2014-02-14",
        "2013-08-15",
        "2012-02-12",
        "2011-08-18",
        "2009-09-19",
        "2009-07-17",
        "2009-04-14"
      ],
      "default": "2015-04-05",
      "description": "Specifies the version of the operation to use for this request."
    }
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2013" />R2013 XmsClientNameProperty
**Output Message**: Value of 'x-ms-client-name' cannot be the same as '{0}' Property/Model.

**Description**: The [`x-ms-client-name`](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-client-name) extension is used to change the name of a parameter or property in the generated code. By using the 'x-ms-client-name' extension, a name can be defined for use specifically in code generation, separately from the name on the wire. It can be used for query parameters and header parameters, as well as properties of schemas. This name is case sensitive.

**Why the rule is important**: This value cannot be same as parameter name or property name, because having the same name invalidates the usage.

**How to fix the violation**: Please specify non-empty `x-ms-client-name`, different from the model/property name that you'd like to be generated.

**Impact on generated code**: Generated SDK code will expose the corresponding client name on property or model.

**Examples**:
```
{
  "definitions": {
    "Product": {
      "x-ms-external" : true,
      "properties": {
        "product_id": {
          "type": "string",
          "x-ms-client-name": "SKU"
        }
     }
  }
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1010" />R1010 AvoidMsdnReferences
**Output Message**: For better generated code quality, remove all references to "msdn.microsoft.com".

**Description**: The documentation is being generated from the swagger and published at "docs.microsoft.com". From that perspective, documentation team would like to avoid having links to the "msdn.microsoft.com" in the swagger and SDK documentations.

**Why the rule is important**: Facilitate decoupling of "msdn.microsoft.com" from "docs.microsoft.com".

**How to fix the violation**: Please avoid using referenes to "msdn.microsoft.com" in title and descriptions.

**Impact on generated code**: N/A.

**Examples**: N/A.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1009" />R1009 DeleteInOperationName
**Output Message**: 'DELETE' operation '{0}' should use method name 'Delete'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines.

**Why the rule is important**: Per ARM SDK guidelines, each 'DELETE' operation on a resource should have "delete" in the name. Guidelines are in place for a more consistent customer experience among ARM services SDKs.

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_Delete` or `Delete`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_Delete
* Delete
* StorageAccounts_delete
* delete

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1005" />R1005 GetInOperationName
**Output Message**: 'GET' operation '{0}' should use method name 'Get' or Method name start with 'List'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines.

**Why the rule is important**: Per ARM SDK guidelines, each 'GET' operation on a resource should have "get" or "list" in the name. Guidelines are in place for a more consistent customer experience among ARM services SDKs

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_Get`, `NOUN_List`, `Get` or `List`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_Get
* Resources_List
* Get
* List

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1003" />R1003 ListInOperationName
**Output Message**: Since operation '{0}' response has model definition '{1}', it should be of the form "*_list*".

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines when response contains array of items.

**Why the rule is important**: Per ARM SDK guidelines, each 'GET' operation on a resource should have "list" in the name when operation has [x-ms-pageable](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-pageable) extension. Guidelines are in place for a more consistent customer experience among ARM services SDKs.

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_List`, `NOUN_ListBy***` or `List`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_List
* Resources_ListBySubscriptions
* List

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1006" />R1006 PutInOperationName
**Output Message**: 'PUT' operation '{0}' should use method name 'Create'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines.

**Why the rule is important**: Per ARM SDK guidelines, each 'PUT' operation on a resource should have "create" in the name. Guidelines are in place for a more consistent customer experience among ARM services SDKs.

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_Create` or `Create`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_Create
* Resources_CreateOrUpdate
* Create

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1007" />R1007 PatchInOperationName
**Output Message**: 'PATCH' operation '{0}' should use method name 'Update'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines.

**Why the rule is important**: Per ARM SDK guidelines, each 'PATCH' operation on a resource should have "update" in the name. Guidelines are in place for a more consistent customer experience among ARM services SDKs.

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_Update` or `Update`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_Update
* Update

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3017" />R3017 GuidUsage
**Output Message**: Guid used in model definition '{1}' for property '{0}'. Usage of Guid is not recommanded. If GUIDs are absolutely required in your service, please get sign off from the Azure API review board.

**Description**: Verifies whether format is specified as "uuid" or not.

**Why the rule is important**: Per ARM guidelines, GUID usage are discouraged.

**How to fix the violation**: If GUIDs are absolutely required in your service, please get sign off from the Azure API review board.

**Impact on generated code**: Based on each language generator, this may affect SDK.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1011" />R1011 HttpsSupportedScheme
**Output Message**: Azure Resource Management only supports HTTPS scheme.

**Description**: Verifies whether specification supports HTTPS scheme or not.

**Why the rule is important**: All the ARM specification should support HTTPS endpoint.

**How to fix the violation**: Please add `schemes` to the specification as shown in example below.

**Impact on generated code**: N/A.

**Examples**:
```
"schemes": [
  "https"
]
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2004" />R2004 NonApplicationJsonType
**Output Message**: Please make sure that media types other than 'application/json' are supported by your service.

**Description**: Verifies whether operation supports "application/json" as consumes or produces section.

**Why the rule is important**: Per the ARM SDK guidelines, the AutoRest is used to generated the language SDKs. All the supported language generator currently handles "application/json" but some SDKs may support other content-types. This rule is in place to warn the swagger writter that not all the SDKs would work with other content-types.

**How to fix the violation**: Please consult with AutoRest to ensure that the content type desired can be supported.

**Impact on generated code**: If the other than `application/json` type is provided, not all SDKs would support that content-type.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2059" />R2059 UniqueResourcePaths
**Output Message**: Multiple resource providers are not allowed in a single spec. More than one the resource paths were found: '{0}'.

**Description**: Verifies whether more than one resource providers exists in the specification or not.

**Why the rule is important**: Per the ARM guidelines, each swagger specification must contain one resource provider.

**How to fix the violation**: One swagger specification must have one resource provider. Please create multiple swaggers, each for one provider. Please refer
[Literate Configuration](https://github.com/Azure/autorest/blob/185e337137c990b9cc1b8ebbb272e76eeeef43a1/docs/user/literate-file-formats/configuration.md).

**Impact on generated code**: N/A.

**Examples**: 
**Bad Examples**: Following example contains 2 resource providers. **Microsoft.Compute** and **Microsoft.Network**.
```
"paths": {
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces": {
      "get": {
        "tags": [
          "NetworkInterfaces"
        ],
        "operationId": "NetworkInterfaces_ListVirtualMachineScaleSetVMNetworkInterfaces",
        "description": "Gets information about all network interfaces in a virtual machine in a virtual machine scale set.",
        "parameters": [
          {
            "name": "resourceGroupName",
            "in": "path",
            "required": true,
            "type": "string",
            "description": "The name of the resource group."
          },
      ....
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways": {
      "get": {
        "tags": [
          "ApplicationGateways"
        ],
        "operationId": "ApplicationGateways_List",
        "description": "Lists all application gateways in a resource group.",
        "parameters": [
          {
            "name": "resourceGroupName",
            "in": "path",
            "required": true,
            "type": "string",
            "description": "The name of the resource group."
          },
      ....
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2006" />R2006 ControlCharactersNotAllowed
**Output Message**: May not contain control characters:  Characters:'{0}' in:'{1}'

**Description**: Verifies whether if a specification does not have any control characters in it.
Control characters are not allowed in a specification.

**Why the rule is important**: Per ARM guidelines, a specification must not contain any control characters.

**How to fix the violation**: Remove the control characters in the specification.

**Examples**: A list of control characters in unicode can be found [here](https://unicode-table.com/en/).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2008" />R2008 MutabilityWithReadOnly
**Output Message**:  When property is modeled as "readOnly": true then x-ms-mutability extension can only have "read" value. When property is modeled as "readOnly": false then applying x-ms-mutability extension with only "read" value is not allowed. Extension contains invalid values: '{0}'

**Description**: Verifies whether a model property which has a readOnly property set has the appropriate `x-ms-mutability` options. If `readonly: true`, `x-ms-mutability` must be `["read"]`. If `readonly: false`, `x-ms-mutability` can be any of the `x-ms-mutability` options. More details about this extension can be found [here]( https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-mutability).

**Why the rule is important**: Not adhering to the rule violates how the x-ms-mutability extension works. A property cannot be `readonly: true` and yet allow `x-ms-mutability` as `["create", "update"]`. 

**How to fix the violation**: Based on the value of the `readOnly` property, assign appropriate `x-ms-mutability` options. 

**Bad Example**:
```
  "prop0":{
    "type": "string",
    "readOnly":true,
    "x-ms-mutability": ["read", "update"]
  }
```
**Good Example**:
```
  "prop0":{
    "type": "string",
    "readOnly": false,
    "x-ms-mutability": ["read", "update"]
  }
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2058" />R2058 XmsPathsMustOverloadPaths 
**Output Message**: Paths in x-ms-paths must overload a normal path in the paths section, i.e. a path in the x-ms-paths must either be same as a path in the paths section or a path in the paths sections followed by additional parameters. 

**Description**: The `x-ms-paths` extension allows us to overload an existing path based on path parameters. We cannot specify an `x-ms-paths` without a path that already exists in the `paths` section. For more details about this extension please refere [here](https://github.com/Azure/azure-rest-api-specs/blob/dce4da0d748565efd2ab97a43d0683c2979a974a/documentation/swagger-extensions.md#x-ms-paths).

**Why the rule is important**: The `x-ms-paths` overload an existing path only, not adhering to this rule would violate the applicability of the extension itself.

**How to fix the violation**: Ensure that the `x-ms-paths` is overloading an existing url path in the `paths` section.

**Good Example**:
```
  "paths":{
    "/foo":{
      ...
    }
  },
  "x-ms-paths":{
    "/foo?op=baz":{
      ...
    }
  }
```
**Bad Example**:
```
  "paths":{
    "/foo":{
      ...
    }
  },
  "x-ms-paths":{
    "/bar?op=baz":{
      ...
    }
  }
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2001" />R2001 AvoidNestedProperties
**Output Message**: Consider using x-ms-client-flatten to provide a better end user experience

**Description**: Nested properties can result into bad user experience especially when creating request objects. `x-ms-client-flatten` flattens the model properties so that the users can analyze and set the properties much more easily.

**Why the rule is important**: Overly nested properties (especially required ones) can result into a non optimal user experience.

**How to fix the violation**: Either eliminate nesting or use the `x-ms-client-flatten` property for a better user experience. More details about the extension can be found [here](https://github.com/Azure/azure-rest-api-specs/blob/dce4da0d748565efd2ab97a43d0683c2979a974a/documentation/swagger-extensions.md#x-ms-client-flatten).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3008" />R3008 CollectionObjectPropertiesNaming
**Output Message**: Collection object '{0}' returned by list operation '{1}' with 'x-ms-pageable' extension, has no property named 'value'. 

**Description**: Per ARM guidelines, a model returned by an `x-ms-pageable` operation must have a property named `value`. This property indicates what type of array the object is.

**Why the rule is important**: To maintain consistency on how `x-ms-pageable` operations and corresponding response objects are modeled and to enable execution of other validation rules based on this consistent structure. More documentation about the extension can be found [here](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md#x-ms-pageable).

**How to fix the violation**: Ensure that the response object has a property named `value` of `array` type.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2027" />R2027 DefaultMustBeInEnum
**Output Message**: The default value is not one of the values enumerated as valid for this element.

**Description**: The value assigned as a default for an enum property must be present in the enums' list.

**Why the rule is important**: Generated SDKs in types languages may fail to compile if we try to enforce a default value that is not a part of the enums defined in the list and in other languages may fail in serialization/deserialization phases.

**How to fix the violation**: Ensure that the default desired actually exists in the enums' list.

**Bad Example**:
```
"status":{
  "type": "string",
  "enum": [
    "Succeeded",
    "Updating",
    "Deleting",
    "Failed"
  ],
  "default": "Terminated"
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2047" />R2047 NamePropertyDefinitionInParameter
**Output Message**: Parameter Must have the "name" property defined with non-empty string as its value.

**Description**: A parameter must have a `name` property for the SDK to be properly generated. 

**Why the rule is important**: AutoRest fails to generate code if the `name` property is not provided for a parameter.

**How to fix the violation**: Add a non-empty `name` property to the parameter.

**Good Example**:
```
"MyParam":{
  "name":"myParam",
  "type": "string",
  "in": "path",
  "description": "sample param"
}
```

**Bad Example**:
```
"MyParam":{
  "type": "string",
  "in": "path",
  "description": "sample param"
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1001" />R1001 OperationIdNounVerb
**Output Message**: Per the Noun_Verb convention for Operation Ids, the noun '{0}' should not appear after the underscore.

**Description**: OperationId should be of the form `Noun_Verb`. 

**Impact on generated code**: AutoRest breaks the operation id into its `Noun` and `Verb` where `Noun` becomes name of the operations class and the `Verb` becomes the name of the method in that class, i.e., operations are grouped inside the operations class named after the noun. Not adhering to this format can either cause AutoRest to fail or can generate semantically incorrect SDK.

**How to fix the violation**: Ensure operationId is of the form `Noun_Verb`.

**Bad Example**:
```
Activate_Certificate
CertificateActivate
```
**Good Example**:
```
Certificate_Activate
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2055" />R2055 OneUnderscoreInOperationId
**Output Message**: Only 1 underscore is permitted in the operation id, following Noun_Verb conventions.

**Description**: An operationId can have exaclty one underscore, not adhering to it can cause errors in code generation.

**Why the rule is important**: Given an operationId of the form `Noun_Verb`, AutoRest breaks the operation id into its `Noun` and `Verb` where `Noun` becomes name of the operations class and the `Verb` becomes the name of the method in that class. Not adhering to this format can cause AutoRest to fail during code generation.

**How to fix the violation**: Ensure operationId is of the form `Noun_Verb` and contains exactly one underscore.

**Bad Example**:
```
Activate_Primary_Certificate
```
**Good Example**:
```
PrimaryCertificate_Activate
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3023" />R3023 OperationsAPIImplementation
**Output Message**: Operations API must be implemented for '{0}'.

**Description**: Per ARM guidelines, each RP must expose an operations API that returns information about all the operations available with the service.

**Why the rule is important**: For better user experience. Users can query the service to get a list of all possible operations on a service and decide what they have to do.

**How to fix the violation**: Add an operations API endpoint (if not already present) and add details regarding this endpoint in the corresponding OpenAPI document. Examples can be found for most RPs in this repo.

**Example**: A typical operations path would look like
```
"/providers/Microsoft.ResourceProviderName/operations": {
    "get": {
        "tags": [
            "Operations"
        ],
        "description": "Lists all of the available RP operations.",
        "operationId": "ListOperations",
        "parameters": [{
            "$ref": "#/parameters/apiVersionParameter"
        }],
        "responses": {
            "200": {
                "description": "OK. The request has succeeded.",
                "schema": {
                    "$ref": "#/definitions/OperationListResult"
                }
            },
            "default": {
                "description": "Resource Provider error response describing why the operation failed.",
                "schema": {
                    "$ref": "#/definitions/ErrorResponse"
                }
            }
        },
        "x-ms-pageable": {
            "nextLinkName": "nextLink"
        }
    }
}
```
A typical `OperationsList` and `Operation` model would look like
```

"Operation": {
  "description": "REST API operation",
  "type": "object",
  "properties": {
    "name": {
      "description": "Operation name: {provider}/{resource}/{operation}",
      "type": "string"
    },
    "display": {
      "description": "The object that represents the operation.",
      "properties": {
        "provider": {
          "description": "Service provider: Microsoft.ResourceProvider",
          "type": "string"
        },
        "resource": {
          "description": "Resource on which the operation is performed: Profile, endpoint, etc.",
          "type": "string"
        },
        "operation": {
          "description": "Operation type: Read, write, delete, etc.",
          "type": "string"
        }
      }
    }
  }
},
"OperationListResult": {
  "description": "Result of the request to list Resource Provider operations. It contains a list of operations and a URL link to get the next set of results.",
  "properties": {
    "value": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/Operation"
      },
      "description": "List of Resource Provider operations supported by the Resource Provider resource provider."
    },
    "nextLink": {
      "type": "string",
      "description": "URL to get the next set of operation list results if there are any."
    }
  }
},
```


Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2015" />R2015 ParameterNotDefinedInGlobalParameters
**Output Message**: Parameter "{0}" is referenced but not defined in the global parameters section of Service Definition

**Description**: Per ARM guidelines, if `subscriptionId` is used anywhere as a path parameter, it must always be defined as global parameter. `api-version` is almost always an input parameter in any ARM spec and must also be defined as a global parameter.

**Why the rule is important**: To reduce duplication, maintain consistent structure in ARM specifications.

**Impact on generated code**: `subscriptionId` and `api-version` are created as client properties in the generated code.

**How to fix the violation**: Ensure `subscriptionId` and `api-version` are declared in the global parameters section of the document.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2020" />R2020 RequiredPropertiesMissingInResourceModel
**Output Message**: Model definition '{0}' must have the properties 'name', 'id' and 'type' in its hierarchy and these properties must be marked as readonly.

**Description**: Per ARM guidelines, a `Resource` model must have the `name`, `id` and `type` properties defined as `readOnly` in its hierarchy.

**Why the rule is important**: `name`, `type` and `id` are readonly properties set on the service end. Also, per ARM guidelines each `Resource` type model must have these properties defined in its hierarchy. An example `Resource` definition can be found [here](https://github.com/Azure/azure-rest-api-specs-pr/blob/master/common-types/resource-management/v1/types.json#L3).

**How to fix the violation**: Ensure the `Resource` type model has the properties `name`, `type` and `id` and they are marked as `readOnly:true`. 

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2056" />R2056 RequiredReadOnlyProperties
**Output Message**: Property '{0}' is a required property. It should not be marked as 'readonly'.

**Description**: A model property cannot be both `readOnly` and `required`. A `readOnly` property is something that the server sets when returning the model object while `required` is a property to be set when sending it as a part of the request body.

**Why the rule is important**: SDK generation fails when this rule is violated.

**How to fix the violation**: Ensure that the given property is either marked as `readonly: true` or `required` but not both.

**Bad Example**:
```
"MyModel": {
  "properties":{
    "MyProp":{
      "type": "string",
      "description": "sample prop",
      "readOnly": true
    }
  },
  "required": ["MyProp"]
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2014" />R2014 SubscriptionIdParameterInOperations/ServiceDefinitionParameters
**Output Message**: Parameter "subscriptionId" is not allowed in the operations section, define it in the global parameters section instead/Parameter "{0}" is referenced but not defined in the global parameters section of Service Definition

**Description**: `subscriptionId` must not be an operation parameter and must be declared in the global parameters section.

**Why the rule is important**: Per ARM guidelines, `subscriptionId` must be set as a property on the generated client instead of the method signature. 

**How to fix the violation**: Remove `subscriptionId` from the operation parameters and add it to the global parameters section if it doesn't exist there.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2003" />R2003 ValidFormats
**Output Message**: '{0}' is not a known format.

**Description**: Only valid types are allowed for properties.

**Why the rule is important**: Invalid formats can cause errors during code generation or result in erraneous generated code.

**How to fix the violation**: Ensure format defined for property is valid. Please refer [here](https://github.com/Azure/autorest/blob/81d4d31d06637f4f9ef042d7f2ec64cfea29892f/docs/developer/validation-rules/valid-formats.md) for allowed types in OpenAPI.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2022" />R2022 XmsExamplesRequired
**Output Message**: Please provide x-ms-examples describing minimum/maximum property set for response/request payloads for operations.{0}.

**Description**: Verifies whether [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples) are provided for each operation or not.

**Why the rule is important**: [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples) are used in model validation. [Benefits](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#benefits-of-x-ms-examples-extension)

**How to fix the violation**: Please refer the documentation of [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples).

**Impact on generated code**: N/A.

**Examples**: Please refer the documentation of [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2065" />R2065 LicenseHeaderMustNotBeSpecified
**Output Message**: License header must not be specified inside x-ms-code-generation settings. This is different for different sdks generated and is passed via command line/config file when generating the sdk.

**Description**: `x-ms-code-generation-settings` must not have the license section specified in the OpenAPI documents since each SDK has a different licensing header, this information must be provided either from the command line or the configuration file when actually generating the sdk.

**Why the rule is important**: License information must not be specified in the `x-ms-code-generation-settings` OpenAPI document since different SDKs have different headers.

**How to fix the violation**: Ensure the `x-ms-code-generation-settings` does not have `header` section.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [RPC](#rpc-violations): [Errors](#rpc-errors) or [Warnings](#rpc-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)
