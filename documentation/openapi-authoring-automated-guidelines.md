# OpenAPI Specifications Authoring - Automated Guidelines #

This document lists the set of automated rules that can be validated against OpenAPI(swagger) spec by running [validation tools](https://github.com/Azure/adx-documentation-pr/blob/master/tools/tools.md). Please visit [here for Manual guidelines](openapi-authoring-manual-guidelines.md).

It is a requirement to conform to all manual and automated rules with severity "Error" before sending a pull request for review.

We request OpenAPI(Swagger) spec authoring be assigned to engineers who have an intimate knowledge of a service endpoint and its developer experience to avoid feeding inefficiencies into teams that focus on Azure developer experiences and the rest of the Azure eco-system.

## Index
* [Error vs. Warning](#error-vs-warning)
* [Automated Rules](#automated-rules)
  * [ARM Violations](#arm-violations)
    * [ARM Errors](#arm-errors)
    * [ARM Warnings](#arm-warnings)
  * [SDK Violations](#sdk-violations)
    * [SDK Errors](#sdk-errors)
    * [SDK Warnings](#sdk-warnings)
  * [Documentation](#documentation)
    * [Documentation Errors](#documentation-errors)
* [Rule Descriptions](#rule-descriptions)

## Error vs Warning
- Rules with severity "Error" have to be addressed for the OpenAPI(swagger) spec to be approved by the reviewers. If there is a strong reason for why the rule cannot be addressed in an OpenAPI(swagger) spec it will be a permanent exception, then [suppression process](https://github.com/Azure/adx-documentation-pr/wiki/Swagger-Validation-Errors-Suppression) must be followed.

- Rules with severity "Warning" are either strong recommendations made by Azure developer experience team for better SDK/Documentation experience or they point out something to evaluate, for example, the warning for booleans asks the user to evaluate whether the property should be a boolean or not. 

## Automated Rules

### ARM Violations

#### ARM Errors

| Id | Rule Name | Applies to |
| --- | --- | --- |
| [R3012](#R3012)	| [APIVersionPattern](#R3012)	| ARM OpenAPI(swagger) specs |
| [R3019](#R3019)	| [ARMResourcePropertiesBag](#R3019)	| ARM and Data plane OpenAPI(swagger) specs |
| [R3014](#R3014)	| [BodyPropertiesNamesCamelCase](#R3014) | ARM and Data plane OpenAPI(swagger) specs |
| [R3016](#R3016)	| [DefinitionsPropertiesNamesCamelCase](#R3016)  | ARM and Data plane OpenAPI(swagger) specs |
| [R3006](#R3006)	| [BodyTopLevelProperties](#R3006) | ARM OpenAPI(swagger) specs |
| [R3008](#R3008)	| [CollectionObjectPropertiesNaming](#R3008) | ARM and Data plane OpenAPI(swagger) specs |
| [R2044](#R2044)	| [InvalidVerbUsed](#R2044) | ARM and Data plane OpenAPI(swagger) specs |
| [R3023](#R3023)	| [OperationsAPIImplementation](#R3023) | ARM OpenAPI(swagger) specs |
| [R3007](#R3007)	| [PutGetPatchResponseSchema](#R3007) | ARM and Data plane OpenAPI(swagger) specs |
| [R3025](#R3025)	| [TrackedResourceGetOperation](#R3025) | ARM OpenAPI(swagger) specs |
| [R3026](#R3026)	| [TrackedResourcePatchOperation](#R3026) | ARM OpenAPI(swagger) specs |
| [R2059](#R2059)	| [UniqueResourcePaths](#R2059) | ARM OpenAPI(swagger) specs |
| [R2016](#R2016)	| [PatchBodyParametersSchema](#R2016) | ARM and Data plane OpenAPI(swagger) specs |
| [R2062](#R2062)	| [XmsResourceInPutResponse](#R2062) | ARM OpenAPI(swagger) specs |
| [R3027](#R3027)	| [TrackedResourceListByResourceGroup](#R3027) | ARM OpenAPI(swagger) specs |
| [R3028](#R3028)	| [TrackedResourceListBySubscription](#R3028) | ARM OpenAPI(swagger) specs |
| [R3011](#R3011)	| [DescriptionMustNotBeNodeName](#R3011) | ARM and Data plane OpenAPI(swagger) specs |
| [R2020](#R2020) | [RequiredPropertiesMissingInResourceModel](#R2020) | ARM OpenAPI(swagger) specs |

#### ARM Warnings

| Id | Rule Name | Applies to |
| --- | --- | --- |
| [R3018](#R3018)	| [EnumInsteadOfBoolean](#R3018) | ARM and Data plane OpenAPI(swagger) specs |
| [R3017](#R3017)	| [GuidUsage](#R3017) | ARM and Data plane OpenAPI(swagger) specs |
| [R2057](#R2057)	| [InvalidSkuModel](#R2057) | ARM OpenAPI(swagger) specs |
| [R3010](#R3010)	| [TrackedResourceListByImmediateParent](#R3010) | ARM OpenAPI(swagger) specs |
| [R2004](#R2004)	| [NonApplicationJsonType](#R2004) | ARM OpenAPI(swagger) specs |

### SDK Violations

#### SDK Errors

| Id | Rule Name | Applies to |
| --- | --- | --- |
| [R2024](#R2024) | [AnonymousBodyParameter](#R2024) | ARM and Data plane OpenAPI(swagger) specs |
| [R2026](#R2026) | [AvoidAnonymousTypes](#R2026) | ARM and Data plane OpenAPI(swagger) specs |
| [R2014](#R2014)	| [SubscriptionIdParameterInOperations](#R2014)	| ARM and Data plane OpenAPI(swagger) specs |
| [R2027](#R2027)	| [DefaultMustBeInEnum](#R2027) | ARM and Data plane OpenAPI(swagger) specs |
| [R1001](#R1001)	| [OperationIdNounInVerb](#R1001)	| ARM and Data plane OpenAPI(swagger) specs |
| [R2055](#R2055)	| [OneUnderscoreInOperationId](#R2055) | ARM and Data plane OpenAPI(swagger) specs |
| [R2003](#R2003)	| [ValidFormats](#R2003)	 | ARM and Data plane OpenAPI(swagger) specs |
| [R2005](#R2005)	| [LongRunningResponseStatusCode](#R2005) | ARM and Data plane OpenAPI(swagger) specs |
| [R2008](#R2008)	| [MutabilityWithReadOnlyRule](#R2008) | ARM and Data plane OpenAPI(swagger) specs |
| [R2025](#R2025)	| [NextLinkPropertyMustExist](#R2025)	| ARM and Data plane OpenAPI(swagger) specs |
| [R2028](#R2028) | [NonEmptyClientName](#R2028) | ARM and Data plane OpenAPI(swagger) specs |
| [R2060](#R2060) | [PageableRequires200Response](#R2060) | ARM and Data plane OpenAPI(swagger) specs |
| [R2019](#R2019)	| [ResourceHasXMsResourceEnabled](#R2019) | ARM OpenAPI(swagger) specs |
| [R2058](#R2058) | [XmsPathsMustOverloadPaths](#R2058) | ARM and Data plane OpenAPI(swagger) specs |
| [R2012](#R2012)	| [XmsClientNameParameter](#R2012) | ARM and Data plane OpenAPI(swagger) specs |
| [R2013](#R2013)	| [XmsClientNameProperty](#R2013) | ARM and Data plane OpenAPI(swagger) specs |
| [R2047](#R2047)	| [NamePropertyDefinitionInParameter](#R2047) | ARM and Data plane OpenAPI(swagger) specs |
| [R2056](#R2056)	| [RequiredReadOnlyProperties](#R2056) | ARM and Data plane OpenAPI(swagger) specs |
| [R2054](#R2054)	| [SecurityDefinitionsStructure](#R2054) | ARM OpenAPI(swagger) specs |
| [R2006](#R2006)	| [ControlCharactersNotAllowed](#R2006) | ARM and Data plane OpenAPI(swagger) specs |
| [R2009](#R2009)	| [ArraySchemaMustHaveItems](#R2009) | ARM and Data plane OpenAPI(swagger) specs |
| [R3013](#R3013)	| [DeleteMustNotHaveRequestBody](#R3013) | ARM and Data plane OpenAPI(swagger) specs |

#### SDK Warnings

| Id | Rule Name | Applies to |
| --- | --- | --- |
| [R4000](#R4000-2) | [ParameterDescriptionRequired](#R4000-2) | ARM and Data plane OpenAPI(swagger) specs |
| [R4000](#R4000-3) | [DescriptiveDescriptionRequired](#R4000-3) | ARM and Data plane OpenAPI(swagger) specs |
| [R4000](#R4000-4) | [DescriptionAndTitleMissing](#R4000-4) | ARM and Data plane OpenAPI(swagger) specs |
| [R4000](#R4000-5) | [OperationDescriptionOrSummaryRequired](#R4000-5)  | ARM and Data plane OpenAPI(swagger) specs |
| [R2001](#R2001)	| [AvoidNestedProperties](#R2001) | ARM and Data plane OpenAPI(swagger) specs |
| [R4002](#R4002)	| [LocationMustHaveXmsMutability](#R4002) | ARM OpenAPI(swagger) specs |
| [R2066](#R2066)	| [PostOperationIdContainsUrlVerb](#R2066) | ARM and Data plane OpenAPI(swagger) specs |
| [R2015](#R2015) | [ParameterNotDefinedInGlobalParameters](#R2015) | ARM and Data plane OpenAPI(swagger) specs |
| [R1010](#R1010) | [AvoidMSDNReferences](#R1010) | ARM and Data plane OpenAPI(swagger) specs |
| [R2017](#R2017)	| [PutRequestResponseScheme](#R2017) | ARM and Data plane OpenAPI(swagger) specs |
| [R1009](#R1009) | [DeleteInOperationName](#R1009) | ARM and Data plane OpenAPI(swagger) specs |
| [R1005](#R1005) | [GetInOperationName](#R1005) | ARM and Data plane OpenAPI(swagger) specs |
| [R1003](#R1003) | [ListInOperationName](#R1003) | ARM and Data plane OpenAPI(swagger) specs |
| [R1006](#R1006)	| [PutInOperationName](#R1006) | ARM and Data plane OpenAPI(swagger) specs |
| [R1007](#R1007) | [PatchInOperationName](#R1007) | ARM and Data plane OpenAPI(swagger) specs |
| [R1011](#R1011) | [HttpsSupportedScheme](#R1011) | ARM OpenAPI(swagger) specs |
| [R2065](#R2065) | [LicenseHeaderMustNotBeSpecified](#R2065) | ARM and Data plane OpenAPI(swagger) specs |
| [R2018](#R2018) | [XmsEnumValidation](#R2018) | ARM and Data plane OpenAPI(swagger) specs |
| [R3060](#R3060) | [XmsPageableListByRGAndSubscriptions](#R3060) | ARM OpenAPI(swagger) specs |
| [R2063](#R2063) | [OperationIdNounConflictingModelNames](#R2063) | ARM and Data plane OpenAPI(swagger) specs |
| [R2064](#R2064) | [LROStatusCodesReturnTypeSchema](#R2064) | ARM and Data plane OpenAPI(swagger) specs |
| [R2023](#R2023) | [SummaryAndDescriptionMustNotBeSame](#R2023) | ARM and Data plane OpenAPI(swagger) specs |

### Documentation

#### Documentation Errors

| Id | Rule Name | Applies to |
| --- | --- | --- |
| [D5001](#D5001) | [XmsExamplesRequired](#D5001) | ARM and Data plane OpenAPI(swagger) specs |

## Rule Descriptions

### <a name="R3012" />R3012 APIVersionPattern 
**Category** : ARM Error

**Applies to**: ARM OpenAPI(swagger) specs

**Output Message**: API Version must be in the format: yyyy-MM-dd, optionally followed by -preview, -alpha, -beta, -rc, -privatepreview.

**Description**: The API Version paramemter MUST be in the Year-Month-Date format (i.e. 2016-07-04.)  NOTE that this is the en-US ordering of month and date.  

The date MAY optionally be followed by one of:
* -preview - Indicates the API version is in (public) preview
* -alpha
* -beta
* -rc (release candidate)
* -privatepreview

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), API version should follow a consistent date format.

**How to fix the violation**: Adopt API version format as indicated by the rule.

**Impact on generated code**: The API version specified wil be used by the generated client.

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3014" />R3014 BodyPropertiesNamesCamelCase
### <a name="R3016" />R3016 DefinitionsPropertiesNamesCamelCase
**Category** : ARM Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message**: Property named: "{0}", must follow camelCase style. Example: "{1}".
**Output Message**: Property named: "{0}", for definition: "{1}" must follow camelCase style. Example: "{2}".

**Description**: Property names must use lowerCamelCase style. 
If the property is a single word (ex: foo, bar, etc.) it will be all lowercase. 
Two-letter acronmys (ex: ID, IO, IP, etc.) should be capitalized. 
Three-letter acronyms (ex: API, URL, etc.) should only have the first letter capitalized (ex: Api, Url, etc.) 
For more capitalization guidance, see: [https://msdn.microsoft.com/en-us/library/141e06ef(v=vs.71).aspx](https://msdn.microsoft.com/en-us/library/141e06ef(v=vs.71).aspx)

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), properties should follow camel case format as specified at [https://msdn.microsoft.com/en-us/library/141e06ef(v=vs.71).aspx](https://msdn.microsoft.com/en-us/library/141e06ef(v=vs.71).aspx).

**How to fix the violation**: Adopt camel case format as indicated by the rule. Please note that this may require a service side update and may cause a breaking change.

**Impact on generated code**: Serialization of the property by the SDK will follow casing as defined in the spec file. Make sure casing matches the service implementation.

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3025" />R3025 TrackedResourceGetOperation
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Tracked resource '{0}' must have a get operation.

**Description**: Verifies if a tracked resource has a corresponding GET operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each tracked resource must have a GET operation.

**How to fix the violation**: Add a GET operation that returns the tracked resource pointed out by the rule - if the operation does not exist for the service, this fix requires a service side change. 
If the resource pointed by the rule is not a tracked resource, this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding GET operation only if it's present in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3026" />R3026 TrackedResourcePatchOperation
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Tracked resource '{0}' must have patch operation that at least supports the update of tags.

**Description**: Verifies if a tracked resource has a corresponding PATCH operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each tracked resource must have a PATCH operation supporting at least the update of tags.

**How to fix the violation**: Add a PATCH operation that allows at least the update of tags for the tracked resource - if the operation does not exist for the service, this fix requires a service side change. 
If the resource pointed by the rule is not a tracked resource, this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding PATCH operation only if it's present in the specification. If PATCH operation only supports updating tags, then you will potentially have two operations in the SDK: "Update" & "CreateOrUpdate", the first updates only tags while the second allows updating a bigger set of properties, which is not the best customer experience. Please strongly consider adding all mutable properties to the "Update" operation.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3027" />R3027 TrackedResourceListByResourceGroup
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: The tracked resource, '{0}', must have a list by resource group operation.

**Description**: Verifies if a tracked resource has a corresponding ListByResourceGroup operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each tracked resource must have a corresponding ListByResourceGroup operation.

**How to fix the violation**: Add a corresponding ListByResourceGroup operation for the tracked resource - if the operation does not exist for the service, this fix requires a service side change. If the operation already exists and it is not named following the naming convention "ListbyResourceGroup", consider updating the operation name. 
If the resource pointed by the rule is not a tracked resource or the operation that allows listing by resource group does not follow the naming convention "ListByResourceGroup", this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding ListByResourceGroup operation as included in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3028" />R3028 TrackedResourceListBySubscription
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: The tracked resource, '{0}', must have a list by subscriptions operation.

**Description**: Verifies if a tracked resource has a corresponding ListByResourceGroup operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each tracked resource must have a corresponding ListBySubscription operation.

**How to fix the violation**: Add a corresponding ListBySubscription operation for the tracked resource - if the operation does not exist for the service, this fix requires a service side change. If the operation already exists and it is not named following the naming conventions: List, ListBySubscriptionId, ListBySubscription or ListBySubscriptions, consider updating the operation name. 
If the resource pointed by the rule is not a tracked resource or the operation that allows listing by subscription ID does not follow the naming convention mentioned above, this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding ListBySubscription operation as included in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3010" />R3010 TrackedResourceListByImmediateParent
**Category** : ARM Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: The child tracked resource, '{0}' with immediate parent '{1}', must have a list by immediate parent operation.

**Description**: Verifies if a tracked resource has a corresponding list by immediate parent operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each tracked resource must have a corresponding "list by immediate parent" operation.

**How to fix the violation**: Add an operation that allows listing the tracked resource by its immediate parent - if the operation does not exist for the service, this fix requires a service side change. If the operation already exists, please double check the name of the operation, our rule is matching the parent and child resource names to the operation names, if those don't match 100%, this warning may be a false positive, please evaluate whether the named picked is appropriate or needs update. 
If the resource pointed by the rule is not a tracked resource this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding "list by immediate parent" operation as included in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3018" />R3018 EnumInsteadOfBoolean
**Category** : ARM Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Booleans are not descriptive and make them hard to use. Consider using string enums with allowed set of values defined. Property: {0}.

**Description**: Booleans properties are not descriptive in all cases and can make them to use, evaluate whether is makes sense to keep the property as boolean or turn it into an enum. 

**Why the rule is important**: Evaluate whether the property is really a boolean or not, the intent is to consider if there could be more than 2 values possible for the property in the future or not. If the answer is no, then a boolean is fine, if the answer is yes, there could be other values added in the future, making it an enum can help avoid breaking changes in the SDKs in the future.

**How to fix the violation**: Create an enum property, follow autorest [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) guidelines.

**Impact on generated code**: Boolean property will turn into a String or an Enum (if SDK language supports it), this will depend on "modelAsString" property value as specified in [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) guidelines.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R4002" />R4002	LocationMustHaveXmsMutability
**Category** : SDK Warning

**Applies to** : ARM OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2028" />R2028 NonEmptyClientName
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2066" />R2066	PostOperationIdContainsUrlVerb
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2009" />R2009 ArraySchemaMustHaveItems
**Category** : SDK Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2012" />R2012 XmsClientNameParameter
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2013" />R2013 XmsClientNameProperty
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1010" />R1010 AvoidMsdnReferences
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: For better generated code quality, remove all references to "msdn.microsoft.com".

**Description**: The documentation is being generated from the OpenAPI(swagger) and published at "docs.microsoft.com". From that perspective, documentation team would like to avoid having links to the "msdn.microsoft.com" in the OpenAPI(swagger) and SDK documentations.

**Why the rule is important**: Facilitate decoupling of "msdn.microsoft.com" from "docs.microsoft.com".

**How to fix the violation**: Please avoid using referenes to "msdn.microsoft.com" in title and descriptions.

**Impact on generated code**: N/A.

**Examples**: N/A.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1009" />R1009 DeleteInOperationName
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1005" />R1005 GetInOperationName
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1003" />R1003 ListInOperationName
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Since operation '{0}' response has model definition '{1}', it should be of the form "*_list*".

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines when response contains array of items.

**Why the rule is important**: Per ARM SDK guidelines, each 'GET' operation on a resource should have "list" in the name when operation has [x-ms-pageable](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-pageable) extension. Guidelines are in place for a more consistent customer experience among ARM services SDKs.

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_List`, `NOUN_ListBy***` or `List`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_List
* Resources_ListBySubscriptions
* List

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1006" />R1006 PutInOperationName
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: 'PUT' operation '{0}' should use method name 'Create'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines.

**Why the rule is important**: Per ARM SDK guidelines, each 'PUT' operation on a resource should have "create" in the name. Guidelines are in place for a more consistent customer experience among ARM services SDKs.

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_Create` or `Create`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_Create
* Resources_CreateOrUpdate
* Create

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1007" />R1007 PatchInOperationName
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: 'PATCH' operation '{0}' should use method name 'Update'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines.

**Why the rule is important**: Per ARM SDK guidelines, each 'PATCH' operation on a resource should have "update" in the name. Guidelines are in place for a more consistent customer experience among ARM services SDKs.

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_Update` or `Update`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_Update
* Update

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3017" />R3017 GuidUsage
**Category** : ARM Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Guid used in model definition '{1}' for property '{0}'. Usage of Guid is not recommanded. If GUIDs are absolutely required in your service, please get sign off from the Azure API review board.

**Description**: Verifies whether format is specified as "uuid" or not.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), GUID usage are discouraged.

**How to fix the violation**: If GUIDs are absolutely required in your service, please get sign off from the Azure API review board.

**Impact on generated code**: Based on each language generator, this may affect SDK.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1011" />R1011 HttpsSupportedScheme
**Category** : SDK Warning

**Applies to** : ARM OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2004" />R2004 NonApplicationJsonType
**Category** : ARM Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Only content-type 'application/json' is supported by ARM..

**Description**: Verifies whether operation supports "application/json" as consumes or produces section.

**Why the rule is important**: Per [ARM SDK guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/common-api-details.md#client-request-headers) only content-type 'application/json' is supported.

**How to fix the violation**: Make sure to include only 'application/json' in the spec consumes/produces. Make sure your service supports 'application/json'.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2059" />R2059 UniqueResourcePaths
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Multiple resource providers are not allowed in a single spec. More than one the resource paths were found: '{0}'.

**Description**: Verifies whether more than one resource providers exists in the specification or not.

**Why the rule is important**: Per the [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each OpenAPI(swagger) specification must contain one resource provider.

**How to fix the violation**: One OpenAPI(swagger) specification must have one resource provider. Please create multiple OpenAPI(swagger) specs, each for one provider. Please refer
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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2006" />R2006 ControlCharactersNotAllowed
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: May not contain control characters:  Characters:'{0}' in:'{1}'

**Description**: Verifies whether if a specification does not have any control characters in it.
Control characters are not allowed in a specification.

**Why the rule is important**: Per ARM guidelines, a specification must not contain any control characters.

**How to fix the violation**: Remove the control characters in the specification.

**Examples**: A list of control characters in unicode can be found [here](https://unicode-table.com/en/).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2008" />R2008 MutabilityWithReadOnly
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2058" />R2058 XmsPathsMustOverloadPaths 
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2001" />R2001 AvoidNestedProperties
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Consider using x-ms-client-flatten to provide a better end user experience

**Description**: Nested properties can result into bad user experience especially when creating request objects. `x-ms-client-flatten` flattens the model properties so that the users can analyze and set the properties much more easily.

**Why the rule is important**: Overly nested properties (especially required ones) can result into a non optimal user experience.

**How to fix the violation**: Either eliminate nesting or use the `x-ms-client-flatten` property for a better user experience. More details about the extension can be found [here](https://github.com/Azure/azure-rest-api-specs/blob/dce4da0d748565efd2ab97a43d0683c2979a974a/documentation/swagger-extensions.md#x-ms-client-flatten).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3008" />R3008 CollectionObjectPropertiesNaming
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Collection object '{0}' returned by list operation '{1}' with 'x-ms-pageable' extension, has no property named 'value'. 

**Description**: Per ARM guidelines, a model returned by an `x-ms-pageable` operation must have a property named `value`. This property indicates what type of array the object is.

**Why the rule is important**: To maintain consistency on how `x-ms-pageable` operations and corresponding response objects are modeled and to enable execution of other validation rules based on this consistent structure. More documentation about the extension can be found [here](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md#x-ms-pageable).

**How to fix the violation**: Ensure that the response object has a property named `value` of `array` type.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2027" />R2027 DefaultMustBeInEnum
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2047" />R2047 NamePropertyDefinitionInParameter
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R1001" />R1001 OperationIdNounVerb
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2055" />R2055 OneUnderscoreInOperationId
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3023" />R3023 OperationsAPIImplementation
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Operations API must be implemented for '{0}'.

**Description**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each RP must expose an operations API that returns information about all the operations available with the service.

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


Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2015" />R2015 ParameterNotDefinedInGlobalParameters
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Parameter "{0}" is referenced but not defined in the global parameters section of Service Definition

**Description**: Per ARM guidelines, if `subscriptionId` is used anywhere as a path parameter, it must always be defined as global parameter. `api-version` is almost always an input parameter in any ARM spec and must also be defined as a global parameter.

**Why the rule is important**: To reduce duplication, maintain consistent structure in ARM specifications.

**Impact on generated code**: `subscriptionId` and `api-version` are created as client properties in the generated code.

**How to fix the violation**: Ensure `subscriptionId` and `api-version` are declared in the global parameters section of the document.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2020" />R2020 RequiredPropertiesMissingInResourceModel
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Model definition '{0}' must have the properties 'name', 'id' and 'type' in its hierarchy and these properties must be marked as readonly.

**Description**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), a `Resource` model must have the `name`, `id` and `type` properties defined as `readOnly` in its hierarchy.

**Why the rule is important**: `name`, `type` and `id` are readonly properties set on the service end. Also, per ARM guidelines each `Resource` type model must have these properties defined in its hierarchy. An example `Resource` definition can be found [here](https://github.com/Azure/azure-rest-api-specs-pr/blob/master/common-types/resource-management/v1/types.json#L3).

**How to fix the violation**: Ensure the `Resource` type model has the properties `name`, `type` and `id` and they are marked as `readOnly:true`. 

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2056" />R2056 RequiredReadOnlyProperties
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

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

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2014" />R2014 SubscriptionIdParameterInOperations
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Parameter "subscriptionId" is not allowed in the operations section, define it in the global parameters section instead/Parameter "{0}" is referenced but not defined in the global parameters section of Service Definition

**Description**: `subscriptionId` must not be an operation parameter and must be declared in the global parameters section.

**Why the rule is important**: Per ARM guidelines, `subscriptionId` must be set as a property on the generated client instead of the method signature. 

**How to fix the violation**: Remove `subscriptionId` from the operation parameters and add it to the global parameters section if it doesn't exist there.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2003" />R2003 ValidFormats
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: '{0}' is not a known format.

**Description**: Only valid types are allowed for properties.

**Why the rule is important**: Invalid formats can cause errors during code generation or result in erraneous generated code.

**How to fix the violation**: Ensure format defined for property is valid. Please refer [here](https://github.com/Azure/autorest/blob/81d4d31d06637f4f9ef042d7f2ec64cfea29892f/docs/developer/validation-rules/valid-formats.md) for allowed types in OpenAPI.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="D5001" />D5001 XmsExamplesRequired
**Category** : Documentation Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Please provide x-ms-examples describing minimum/maximum property set for response/request payloads for operations.{0}.

**Description**: Verifies whether [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples) are provided for each operation or not.

**Why the rule is important**: [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples) are used in model validation. [Benefits](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#benefits-of-x-ms-examples-extension)

**How to fix the violation**: Please refer the documentation of [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples).

**Impact on generated code**: N/A.

**Examples**: Please refer the documentation of [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2065" />R2065 LicenseHeaderMustNotBeSpecified
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: License header must not be specified inside x-ms-code-generation-settings. The license can vary for different SDKs generated and is passed via command line/config file when generating the SDK.

**Description**: `x-ms-code-generation-settings` must not have the license section specified in the OpenAPI documents since each generated SDK can have a different licensing header. This information must be provided either from the command line or the configuration file when actually generating the sdk.

**How to fix the violation**: Ensure the `x-ms-code-generation-settings` section does not have `header` property.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2025" />R2025 NextLinkPropertyMustExist
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: The property '{0}' specified by nextLinkName does not exist in the 200 response schema. Please, specify the name of the property that provides the nextLink. If the model does not have the nextLink property then specify null.

**Description**: Per definition of AutoRest [x-ms-pageable extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable), the property specified by nextLinkName must exist in the 200 response schema.

**Why the rule is important**: Generated SDK may not work, as the nextLink won't be tied to a property of the response schema. 

**How to fix the violation**: Please refer the documentation of [x-ms-pageable](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable).

**Impact on generated code**: NextLink may be broken as property may not be found, paging may not work. Please note this may cause a breaking change in the generated SDK.

**Examples**: Please refer the documentation of [x-ms-pageable](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable) and [examples](https://github.com/Azure/azure-rest-api-specs/tree/master/documentation/x-ms-pageable).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2060" />R2060 PageableRequires200Response
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: A response for the 200 HTTP status code must be defined to use x-ms-pageable.

**Description**: Per definition of AutoRest [x-ms-pageable extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable), the response shema must contain a 200 response schema.

**Why the rule is important**: Pageable operation needs to have a response schema to be used by the SDK to serialize/deserialize the result. 

**How to fix the violation**: Add a 200 status code response with corresponding schema. Please refer the documentation of [x-ms-pageable](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable). Note that this may require a service side change and may be a breaking change.

**Impact on generated code**: Response schema is used to serialize/deserialize result, if 200 response is not specified, the generated SDK operation may not return the proper results, with the link its next page.

**Examples**: Please refer the documentation of [x-ms-pageable](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2024" />R2024 AnonymousBodyParameter
### <a name="R2026" />R2026 AvoidAnonymousTypes
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Inline/anonymous models must not be used, instead define a schema with a model name in the "definitions" section and refer to it. This allows operations to share the models.

**Description**: This rule appears when you define a model type inline, rather than in the definitions section. If the model represents the same type as another parameter in a different operation, then it becomes impossible to reuse that same class for both operations.

**Why the rule is important**: Anonymous parameters will be autogenerated as non-descriptive parameters which the client will not be able to share across operations or provide good documentation for, thereby resulting in poor user experience.

**How to fix the violation**: Move the schema to the definitions section and reference it using $ref.

**Impact on generated code**: 

**Before**

Spec:
```json5
…
"parameters":[
    {
        "name": "foo",
        "in": "body",
        "schema": {
            "type": "object",
            "properties": {
                …
            }
        }
    }
]
…
```
Generated code:
```csharp
public class FooParameter1 {
    …
}
```
**After**

Spec:
```json5
…
"parameters": [
    {
        "name": "foo",
        "in": "body",
        "schema": {
            "$ref": "#/definition/FooCreationSettings"
        }
    }
],
…
"definitions": {
    "FooCreationSettings": {
        "type": "object",
        "properties": {
            …
        }
    }
}
…
```
Generated code:
```csharp
public class FooCreationSettings {
    …
}
```

**Examples**: N/A.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3019" />R3019 ArmResourcePropertiesBag
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Top level property names should not be repeated inside the properties bag for ARM resource '{0}'. Properties [{1}] conflict with ARM top level properties. Please rename these.

**Description**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), top level properties should not be repeated inside the properties bag for ARM resources.

**Why the rule is important**: [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md).

**How to fix the violation**: Rename or remove conflicting property. Note that this may require a change on the service side and may cause a breaking change.

**Examples**: 
**Bad example**: "id" property is repeated in the model, as "Resource" already contains "id".
```json5
"VersionedApplicationType": {
  "description": "The versioned application type resource",
  "properties": {
    "properties": {
      "id": {
        "type": "string",
        "description": "The name of the application type"
      }
    }
  },
  "allOf": [
  {
    "$ref": "#/definitions/Resource"
  }
  ]
},
"Resource":{  
  "properties":{  
    "id":{  
      "readOnly":true,
      "type":"string",
      "description":"Fully qualified resource Id for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
    },
    "name":{  
      "readOnly":true,
      "type":"string",
      "description":"The name of the resource"
    },
    "type":{  
      "readOnly":true,
      "type":"string",
      "description":"The type of the resource. Ex- Microsoft.Compute/virtualMachines or Microsoft.Storage/storageAccounts."
    }
  },
  "x-ms-azure-resource": true
}
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3006" />R3006 BodyTopLevelProperties
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Top level properties should be one of name, type, id, location, properties, tags, plan, sku, etag, managedBy, identity. Model definition '{0}' has extra properties ['{1}'].

**Description**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), top level properties of a resource should be only ones from the allowed set.

**Why the rule is important**: [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md). 

**How to fix the violation**: Consider moving extra properties into "properties" bag of the resource model.

**Examples**: 
**Bad example**: "extraProperty" is not allowed at top level of the resource model.
```json5
"VersionedApplicationType": {
  "description": "The versioned application type resource",
  "properties": {
    "extraProperty": {
      "type": "string",
      "description": "Extra property description"
    }
  },
  "allOf": [
  {
    "$ref": "#/definitions/Resource"
  }
  ]
}
```
**Good example**: Notice that "extraProperty" is inside "properties" bag, and not at top level.
```json5
"VersionedApplicationType": {
  "description": "The versioned application type resource",
  "properties": {
    "properties":{
      "extraProperty": {
        "type": "string",
        "description": "Extra property description"
      }
    }
  },
  "allOf": [
  {
    "$ref": "#/definitions/Resource"
  }
  ]
}
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2057" />R2057 InvalidSkuModel
**Category** : ARM Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Sku Model definition '{0}' is not valid. A Sku model must have 'name' property. It can also have 'tier', 'size', 'family', 'capacity' as optional properties.

**Description**: Sku model definition needs to follow [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md) and can contain only a certain set of properties as described in the message. 

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md).

**How to fix the violation**: Update the sku model definition.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2018" />R2018 XmsEnumValidation
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: The enum types should have x-ms-enum type extension set with appropriate options. Property name: {0}.

**Description**: AutoRest defines [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) to provide more flexibily for enum types, please refer to the documentation.

**Why the rule is important**: Including [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) provides more flexibilty for enum types in SDK generated code.

**How to fix the violation**: Include the [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) per indicated in its documentation. Consider setting "modelAsString": true, if you'd like the enum to be modeled as a string in generated SDKs, no enum validation will happen, though the values are exposed to the user for a better experience.

**Examples**: Please refer to [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2063" />R2063 OperationIdNounConflictingModelNames
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: OperationId has a noun that conflicts with one of the model names in definitions section. The model name will be disambiguated to '{0}Model'. Consider using the plural form of '{1}' to avoid this. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: The first part of an operation Id separated by an underscore i.e., `Noun` in a `Noun_Verb` should not conflict with names of the models defined in the definitions section. If this happens, AutoRest appends `Model` to the name of the model to resolve the conflict (`NounModel` in given example) with the name of the client itself (which will be named as `Noun` in given example). This can result in an inconsistent user experience.

**Why the rule is important**: To ensure all models are named consistently and exactly as defined in the spec.

**How to fix the violation**: Ensure operation Ids are named in such a way that the `Noun` in `Noun_Verb` is of the plural form and does not conflict with the names of any models in the definitions section of the spec.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2054" />R2054 SecurityDefinitionsStructure
**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Every OpenAPI(swagger) spec/configuration must have a security definitions section and it must adhere to the structure described [here](https://github.com/Azure/autorest/tree/master/docs/developer/validation-rules/security-definitions-structure-validation.md)

**Description**: Each OpenAPI json document must contain a security definitions section and the section must adhere to a certain format.

**Why the rule is important**: Missing security definitions section does not describe the Azure services security model accurately. This is an ARM specific requirement which describes the security mechanism to access the services.

**How to fix the violation**: Ensure that the document has a security definition section as described [here](https://github.com/Azure/autorest/tree/master/docs/developer/validation-rules/security-definitions-structure-validation.md)

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2019" />R2019 ResourceHasXMsResourceEnabled
**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: A 'Resource' definition must have x-ms-azure-resource extension enabled and set to true.

**Description**: A 'Resource' definition must have x-ms-azure-resource extension enabled and set to true. This will indicate that the model is an Azure resource.

**Why the rule is important**: This will ensure that the 'Resource' definition is designed correctly in code generation.Please refer [here](./swagger-extensions.md#x-ms-azure-resource) for further details.

**How to fix the violation**: Ensure that the 'Resource' definition has x-ms-azure-resource extension enabled and set to true.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2017" />R2017 PutRequestResponseScheme
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: A PUT operation request body schema should be the same as its 200 response schema, to allow reusing the same entity between GET and PUT. If the schema of the PUT request body is a superset of the GET response body, make sure you have a PATCH operation to make the resource updatable. Operation: '{0}' Request Model: '{1}' Response Model: '{2}'

**Description**: The request & reponse('200') schema of the PUT operation must be same.

**Why the rule is important**: This will provide a consistent experience to the user, i.e. the user could use the same model object to perform various operations. Also, within the SDK, this will encourage reuse of the same model objects.

**How to fix the violation**: Ensure the request & reponse('200') schema of the PUT operation must be same. This might involve a service side change which will result cause a breaking change in the generated SDK.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2005" />R2005 LongRunningResponseStatusCode
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: A '{0}' operation '{1}' with x-ms-long-running-operation extension must have a valid terminal success status code {2}.

**Description**: The allowed response status codes for a long DELETE operation are "200", "204". The allowed response status codes for a POST operation are "200", "201" & "204". The allowed response status codes for a PUT operation are  "200" & "201".

**Why the rule is important**: This will ensure that the DELETE/POST/PUT operations are designed correctly.Please refer [here](./swagger-extensions.md#x-ms-long-running-operation) for further details.

**How to fix the violation**: Ensure that the DELETE/POST/PUT operations have the allowed response codes.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2044" />R2044 InvalidVerbUsed
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Permissible values for HTTP Verb are DELETE, GET, PUT, PATCH, HEAD, OPTIONS, POST, TRACE.

**Description**: Each operation definition must have a HTTP verb and it must be DELETE/GET/PUT/PATCH/HEAD/OPTIONS/POST/TRACE.

**Why the rule is important**: DELETE/GET/PUT/PATCH/HEAD/OPTIONS/POST/TRACE are the only valid HTTP operations.

**How to fix the violation**: Provide a correct HTTP verb.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3007" />R3007 PutGetPatchResponseSchema
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: {0} has different responses for PUT/GET/PATCH operations. The PUT/GET/PATCH operations must have same schema response.

**Description**: For a given path with PUT, GET and PATCH operations, the schema of the response must be the same.

**Why the rule is important**: This will provide a consistent experience to the user, i.e. the user could use the same model object to perform various operations. Also, within the SDK, this will encourage reuse of the same model objects.

**How to fix the violation**: Ensure that, for a given path with PUT, GET and PATCH operations, the schema of the response is same. This might involve a service side change which will result in a breaking change in the generated SDK.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3013" />R3013 DeleteMustNotHaveRequestBody
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: 'Delete' operation '{0}' must not have a request body.

**Description**: The request body of a delete operation must be empty.

**Why the rule is important**: This will ensure that the delete operation aligns with the [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md).

**How to fix the violation**: Ensure that the request body of the delete operation is empty. This may involve a service side change and may cause a breaking change in the generated SDK.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2062" />R2062 XmsResourceInPutResponse
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: The 200 response model for an ARM PUT operation must have x-ms-azure-resource extension set to true in its hierarchy. Operation: '{0}' Model: '{1}'.

**Description**: The 200 response model for an ARM PUT operation must have x-ms-azure-resource extension set to true in its hierarchy. Operation: '{0}' Model: '{1}'.

**Why the rule is important**: This will ensure that the PUT operation actually returns a resource model.Please refer [here](./swagger-extensions.md#x-ms-azure-resource) for details on x-ms-azure-resource extension.

**How to fix the violation**: Ensure that the 200 response model for an ARM PUT operation must have x-ms-azure-resource extension set to true in its hierarchy.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3060" />R3060 XmsPageableListByRGAndSubscriptions
**Category** : SDK Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: For the tracked resource '{0}', the x-ms-pageable extension values must be same for list by resource group and subscriptions operations.

**Description**: When a tracked resource has list by resource group and subscription operations, the x-ms-pageable extension values must be same for both operations. A tracked resource is a resource with a 'location' property as required. If this rule flags a resource which does not have a 'location' property, then it might be a false positive.

**Why the rule is important**: This will provide a consistent experience to the user, i.e. the user could expect the same behavior for both list by subscription and resource group. Please refer [here](./swagger-extensions.md#x-ms-pageable) for details on the x-ms-pageable extension.

**How to fix the violation**: Ensure that when a tracked resource has list by resource group and subscription operations, the x-ms-pageable extension values are same for both operations. This might involve a service side change which will result in a breaking change in the generated SDK.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2064" />R2064 LROStatusCodesReturnTypeSchema
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: 200/201 Responses of long running operations must have a schema definition for return type. OperationId: '{0}', Response code: '{1}'

**Description**: The '200'/'201' responses of the long running operation must have a schema definition. 

**Why the rule is important**: Please refer [here](./swagger-extensions.md#x-ms-long-running-operation) for details on the x-ms-long-running-operation. The '201' response code indicates 'Created' & '200' response code indicates 'Success'. In either case, it is logical for the response to be the same.

**How to fix the violation**: Ensure that the '200'/'201' responses of the long running operation has a schema definition. This might involve a service side change which will result in a breaking change in the generated SDK.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2016" />R2016 PatchBodyParametersSchema
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Properties of a PATCH request body must not be {0}. PATCH operation: '{1}' Model Definition: '{2}' Property: '{3}'

**Description**: A request parameter of the Patch Operation must not have a required/default value.

**Why the rule is important**: A PATCH operation is used to update properties of a resource. So, If the resource has 'X' number of properties and if you wish to change one of them, then a PATCH request could be sent with a value for that specified property. In other words, all the properties in the PATCH request are updated. Now, if any of the values are marked as required/default, it would force the system to update it always which is not the intention of the PATCH operation.

**How to fix the violation**: Ensure that the request parameter of the Patch Operation does not have a required/default value.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R4000-2" />R4000 ParameterDescriptionRequired
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: {0} lacks 'description' property. Consider adding a 'description' element. Accurate description is essential for maintaining reference documentation.

**Description**: A parameter must have 'description' property.

**Why the rule is important**: Appropriate documentation could not be generated without the 'description' property.

**How to fix the violation**: For each parameter, provide a 'description' property.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R4000-3" />R4000 DescriptiveDescriptionRequired
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: The value provided for description is not descriptive enough. Accurate and descriptive description is essential for maintaining reference documentation.

**Description**: The value of the 'description' property must be descriptive. It cannot be spaces or empty description.

**Why the rule is important**: Appropriate documentation could not be generated without a detailed 'description' value.

**How to fix the violation**: For each 'description' property, provide a detailed description value.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R4000-4" />R4000 DescriptionAndTitleMissing
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: {0} lacks 'description' and 'title' property. Consider adding a 'description'/'title' element. Accurate description/title is essential for maintaining reference documentation.

**Description**: The definition must have at least one of the properties - description/title.

**Why the rule is important**: Appropriate documentation could not be generated without the 'description'/'title' property.

**How to fix the violation**: For each definition, provide atleast one of the properties - description/title.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R4000-5" />R4000 OperationDescriptionOrSummaryRequired
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: {0} lacks 'description' and 'summary' property. Consider adding a 'description'/'summary' element. Accurate description/summary is essential for maintaining reference documentation.

**Description**: Every operation must have a 'description'/'summary' property.

**Why the rule is important**: Appropriate documentation could not be generated without the 'description'/'summary' property.

**How to fix the violation**: For each operation, provide atleast one of the property - description/summary.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R2023" />R2023 SummaryAndDescriptionMustNotBeSame
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: The summary and description values should not be same.

**Description**: Each operation has a summary and description values. They must not be same.

**Why the rule is important**: The summary must provide a short summary of the operation. The description must provide a detailed description of the operation. This will ensure that all the operations are well documented. 

**How to fix the violation**: Provide a short summary for the summary section and a detailed description for the description section.

**Good Examples**: The following operation is a good example:
```
......
......
"put": {
  "summary": "Creates or Updates an availabilty set",
  "description": "This operation creates or updates an availability set. This takes the resourceGroupName and availabiltySetName as input. If an availability set with the same name exists, then the same is updated. Else a new availabilty set is created.",
  .....
  .....
}
......
......
```

**Bad Examples**: The following would be invalid:
```
......
......
"put": {
  "summary": "Creates or Updates an availabilty set",
  "description": "Creates or Updates an availabilty set",
  .....
  .....
}
......
......
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3011" />R3011 DescriptionMustNotBeNodeName
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Description must not match the name of the node it is supposed to describe.

**Description**: Description section must provide details on the current operation or model. Using the name of node in description does not provide any value.

**Why the rule is important**: The description must provide a detailed description of the current context. This will ensure that all the operations and models are well documented. 

**How to fix the violation**: Provide detailed description of the node in the description section.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)
