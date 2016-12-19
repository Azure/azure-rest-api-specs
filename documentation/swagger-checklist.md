# Swagger Checklist for Microsoft Azure #

*Version 0.1, 12-15-2016*
----------
Latest version: [https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-checklist.md](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-checklist.md)

Editors:</br>
Asir Selvasingh, Microsoft</br>
Amar Zavery, Microsoft</br>
Mark Cowlishaw, Microsoft</br>
Johan Stenberg, Microsoft</br>
Kirthi Krishnamraju, Microsoft</br>


## Executive Summary ##

This document defines a Swagger checklist for Microsoft Azure, along with clarifications, refinements, interpretations and amplifications of the Swagger specification to promote interoperability and usability in tools and libraries.

### Intended Audience ###

This checklist is for any software engineer or Azure service team who develops and offers a REST API for managing or accessing Azure resources.

## Status of this Checklist ##

This is a **working draft**.

## Feedback ##

If there are areas in this specification that could be clearer, or if errors or omissions are identified, Microsoft would like to be notified to provide the best possible checklist for authoring Swagger specifications.

Please direct feedback and kudos to [swagger-checklist@microsoft.com](mailto:swagger-checklist@microsoft.com).

## Table of Contents ##

[Introduction](#introduction)</br>
[Notational Conventions](#notational-conventions)</br>
[Validation Tools for Swagger Checklist](#validation-tools-for-swagger-checklist)</br>
[Naming - Swagger Checklist](#naming---swagger-checklist)</br>
[Operation Semantics [MUST]- Swagger Checklist](#must)</br>
[Operation Semantics [SHOULD] - Swagger Checklist](#should)</br>
[Operational - Swagger Checklist](#operational---swagger-checklist)</br>
[Documentation - Swagger Checklist](#documentation---swagger-checklist)</br>
[Structural - Swagger Checklist](#structural---swagger-checklist)</br>
[Appendix A: References](#appendix-a-references)</br>
[Appendix B: Acknowledgments](#appendix-b-acknowledgments)</br>
[Appendix C: Revision History](#appendix-c-revision-history)

## Introduction ##

This document defines a Swagger checklist for Microsoft Azure, along with clarifications, refinements, interpretations and amplifications of the Swagger specification to promote interoperability and usability in tools and libraries.

Each section addresses a dimension of Swagger authoring and its effectiveness for delivering the best Azure developer experiences through tools and libraries built using a Swagger specification.

This checklist is a current snapshot of requirements for developing Swagger specifications. The checklist will be continuously updated to reflect issues uncovered during Swagger specification reviews.

## Notational Conventions ##

The keywords "*MUST*", "*MUST NOT*", "REQUIRED", "SHALL", "SHALL NOT", "*SHOULD*", "*SHOULD NOT*", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC2119](http://www.ietf.org/rfc/rfc2119.txt).

Normative statements of the checklist are presented in the following manner:

- [ ] **Mnnnn**: checklist text here.

OR

- [ ] **Snnnn**: checklist text here.

Where "M" stands for '*MUST*' or '*MUST NOT*' requirement. "S" stands for '*SHOULD*' or '*SHOULD NOT*' requirement. And, "nnnn" is replaced by a number that is unique among all the requirements in the checklist, thereby "nnnn" becomes a unique requirement identifier.

## Validation Tools for Swagger Checklist ##

Today, there are tools available for validating a sizable portion of this checklist. Please install these tools on your development machine and use them to validate your Swaggers as you build them. 

-	[AutoRest Linter](https://github.com/Azure/autorest/wiki/linting) – Linter statically analyzes a Swagger for errors and violations of requirements outlined in this checklist. Linter should be run when Swaggers are created or updated. Linter will be continously updated to validate newer requirements.

-	[Swagger Model Validator](https://github.com/Azure/openapi-validation-tools) - Model Validator validates models defined for body parameters and responses, and matches them against the expected input and output of an operation. To make this real, test examples are required to be specified in a Swagger for every operation defined in a Swagger. Test examples are integrated into a Swagger using the ["x-ms-examples"](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md) extension, which will be used to test against the defined models. Sample test examples for this extension can be found in the [Redis Cache Swagger](https://github.com/Azure/azure-rest-api-specs/blob/master/arm-redis/2016-04-01/swagger/redis.json ). 

The Azure Developer Experience team will continue to deliver rich tools to validate this checklist.

## Naming - Swagger Checklist ##

- [ ] **M1000**: Plural names in parameters and model properties MUST only be used to represent collections.

- [ ] **M1001**: Each operation *MUST* contain an OperationId of the form "RESOURCE_METHOD" a.k.a "NOUN_VERB", where "RESOURCE" represents the resource or object the operation addresses, and METHOD is a short name for the operation being performed "Get, Start, Delete, Create, List", etc.

- [ ] **M1002**: If the NOUN in the OperationId "NOUN_VERB" matches with the name of the Model definition then the NOUN in the operationId *MUST* use the plural form of NOUN to avoid collision in the namespace.

- [ ] **M1003**: List operations *MUST* be prefixed with "List" and *MUST NOT* be named as "GetXXXX" operations.

- [ ] **M1004**: List operations *MUST* use consistent names and semantics. List operations *MUST* NOT use any other names. Consistent names and semantics are:

  - `List()` - lists all resources under a subscription.
  - `ListByResourceGroup()` - list all resources in a resource group within a subscription.
  - `ListByParent()` - where "Parent" is a context specific suffix. It lists all resource under a parent.

- [ ] **M1005**: Get operations *MUST* use the METHOD name "Get"

- [ ] **M1006**: PUT operations *MUST* use the METHOD Name "Create"

- [ ] **M1007**: PATCH operations *MUST* use the METHOD Name "Update"

- [ ] **M1008**: POST operations *MUST* use a METHOD Name that matches the semantic operation on the resource, for example "Start" or "Stop"

- [ ] **M1009**: DELETE operations *MUST* use the METHOD Name "Delete"

- [ ] **M1010**: Terminology in Swagger and Azure Portal *MUST* be the same.

- [ ] **M1011**: Resource Model name *MUST* be same as singular form of the resource type. Like for virtualMachines resource type it should be VirtualMachine.

- [ ] **M1012**: Parameter names in the apis *MUST* be name of the resource like virtualMachines\{virtualMachine} or virtualMachines\{virtualMachineName} both are good example but virtualMachines\{vm} is bad example. 

- [ ] **M1013**: Any action name *MUST* be same as what is defined in the Rest APIs, like regenerateAdminKeys should be regenerateAdminKeys in the Swagger as well, where as regenerateKeys is bad example.


## Operation Semantics - Swagger Checklist ##

### MUST

- [ ] **M2000**: A Swagger specification *MUST* be accompanied with a document that describes end-to-end management scenarios that can be realized using operations described in the Swagger.

- [ ] **M2001**: Read only parameters and model properties *MUST* be labeled as `"readOnly": true` in Swagger.

- [ ] **M2002**: Boolean parameters *MUST* be represented as boolean in Swagger. Boolean parameters *MUST* NOT be represented as strings. Similarly, this requirements applies to other primitive data types such as integer, float and double. These primitive data types *MUST* be represented using [Swagger primitive data types](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types).

- [ ] **M2003**: If a format is specified along with a type, it *MUST* be from one of the supported formats - "int64", "int32", "float", "decimal", "double", "byte", "base64url", "unixtime", "date", "date-time", "duration", "date-time-rfc1123", "uuid", otherwise in codegeneration the artifact will be of the specified type and not as per the desired format. 

- [ ] **M2004**: Long running (asynchronous) operations *MUST* be modeled as [long running operations](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/creating-swagger.md#longrunning) in Swagger.

- [ ] **M2005**: A longrunning operation *MUST* have a terminal success status code. At least 
   - 200 or 201 for PUT/PATCH
   - 200, 201 or 204  or all of the aforementioned for POST
   - 204 or 200 or both for delete. 
   This will indicate the code generator, how to deserialize the final success response after the polling is done. If the response has a response body then it *MUST* be modeled in the terminal status code.
</br>

- [ ] **M2006**: Required parameters *MUST* be accurately labeled as `"required": true` in Swagger.

- [ ] **M2007**: Required properties of a model definition *MUST* be accurately labeled as `"required": [ "propertyName1" ]` in Swagger.

- [ ] **M2008**: Mutability of properties *MUST* be marked up using [`x-ms-mutability` extension](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-mutability).

- [ ] **M2009**: Error definitions *MUST* be abstracted, modeled and reused.

- [ ] **M2010**: A Swagger spec *MUST NOT* define operations or properties or parameters for functionalities that are not currently supported by the service in the given api-version. The primary goal of the spec is that it *MUST* correctly and completely represent the underlying REST API.

- [ ] **M2011**: A collection model in Swagger *MUST* support adding more than one element to the collection.

For example, [NetworkInterface.ipConfigurations](https://github.com/Azure/azure-rest-api-specs/blob/4131049f9bdb477c4aea6f4e3f588a7153fc5606/arm-network/2016-06-01/swagger/network.json#L6516) is described as a collection. However, it does not support adding more than one IP configuration. 

- [ ] **M2012**: Operations that are exposed through private previews *MUST NOT* be described in the [public GitHub repository](https://github.com/Azure/azure-rest-api-specs). They *MUST* be described in the [private GitHub repository](https://github.com/Azure/azure-rest-api-specs-pr) instead.

- [ ] **M2013**: The value of the ["x-ms-client-name"](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-client-name) and ["x-ms-discriminator-value"](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-discriminator-value) *MUST NOT* be the same as the model property or the model name, otherwise the purpose is defeated.

- [ ] **M2014**: For specifications describing the Management Plane of ARM, "subscriptionId" & "api-version" *MUST* always be defined in the global parameters section.

- [ ] **M2015**: For a Given Resource, GET/PUT/PATCH *MUST* return the same "Resource" Model.

- [ ] **M2016**: For PATCH operation, every property in the model for the request body *MUST* be optional and the property *MUST NOT* provide any default value. The absence of default values applies recursively to complex properties in the model definition.

- [ ] **M2017**: The model definition for the body parameter and the response *MUST* be the same for a PUT operation. This ensures that the same entity will be reusable between GET and PUT.

- [ ] **M2018**: A parameter or a model property having an `"enum": []` constraint, *MUST* have an  ["x-ms-enum"](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md#x-ms-enum) extension and the extension's "modelAsString" property *MUST* be set to `false` where applicable.

- [ ] **M2019**: Every "Resource" Model *MUST* be tagged with ["x-ms-azure-resource"](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md#x-ms-azure-resource). This will indicate Autorest to make the Resource model inherit from the Resource definition in the client runtime.

- [ ] **M2020**: The "Resource" model definition in ARM, *MUST* have "id", "name" and "type" properties marked as `"readOnly": true`.

- [ ] **M2021**: The "location" property of "Resource" model definition in ARM, *MUST* have ["x-ms-mutability": ["create", "read"]](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-mutability) extension. Usually the "location" property is also a required property of the model definition.

- [ ] **M2022**: Every operation in the swagger specification *MUST* have an ["x-ms-examples"](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md) extension applied with scenarios that provide the *MINIMUM* AND *MAXIMUM* properties of the request and response payload. Please feel free to provide more example scenarios for a particular operation.

- [ ] **M2023**: a Swagger specification *MUST* use `"x-ms-codegeneration-settings": { "name": "<ServiceName>Client" }` for providing a better name to the generated client.

- [ ] **M2024**: Operations that return a single page and have the response schema {"value": [Array of items] }, *MUST* apply the ["x-ms-pageable"](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md#x-ms-pageable) with it's `"nextLinkName"` property explicitly set to `"null"`. This will ensure that value property gets unwrapped into an IEnumerable.

- [ ] **M2025**: If the `"nextLinkName"` property of the ["x-ms-pageable"](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md#x-ms-pageable) extension is defined with a value, then the Model definition *MUST* also have a property named with the same value for nextLink.

- [ ] **M2026**: Model types (request body, response body, complex model properties) *MUST NOT* be defined inline. They *MUST* be defined explicitly in the `"defintions: { . . . }` section of the swagger specification.

- [ ] **M2027**: If a property or a parameter has an `"enum": []` constraint and it also has a `"default"` value then the default value *MUST* be one of the values specified in the enum. It is *RECOMMENDED* that the default value be the first element in the "enum" array.

- [ ] **M2028**: The value of [`x-ms-client-name` extension](https://github.com/Azure/autorest/blob/master/Documentation/swagger-extensions.md#x-ms-client-name) *MUST NOT* be an empty string, because it will be used as the identifier of the artifact in the generated client.

- [ ] **M2029**: Every path in the `"paths": { . . . }` object *MUST* be unique and *MUST NOT* be equivalent. 
  - `/paths/path1/{param1}` and `/paths/path1/{param2}` are equivalent paths and are *NOT* allowed.

- [ ] **M2030**: Properties that are marked as `"required"` *MUST* exist in the `properties: { }` object of the model definition ([Schema Object](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#schemaObject)) or one of its ancestors.

- [ ] **M2031**: Every model defined in the definitions section of the swagger specification *MUST* have a `"type"` property. The list of supported data types in 2.0 swagger specification can be found [here](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types).

- [ ] **M2032**: Operations *MUST NOT* have both a `body` parameter and a `formData` parameter.

- [ ] **M2033**: Operations *MUST* have **exactly one** `body` parameter.

- [ ] **M2034**: Operations *MUST* have unique (name + in combination) parameters.

- [ ] **M2035**: Operations *MUST* have a unique operationId in the swagger specification.

- [ ] **M2036**: Path parameters declared in the path string *MUST* have matching parameter definitions (either at the path-level or the operation) and vice-versa (extra definitions or declarations are *NOT* allowed).

- [ ] **M2037**: Path parameter declarations *MUST NOT* allow empty names (/path/{} is not valid).

- [ ] **M2038**: Paths *MUST* have unique (name + in combination) parameters.

- [ ] **M2039**: Any local (model or parameter) reference *MUST* start with `"#"`. Example `"#/parameters/subscriptionId"` or `"#/definitions/Resource"`.

- [ ] **M2040**: Any external (model or parameter) reference, whether a relative or absolute file or URL reference *MUST* adhere to the [JSON pointer reference syntax](https://tools.ietf.org/html/rfc6901). `"<(absolute|relative) (file|url) path>#<(definitions|parameters|or any other key that needs to be accessed in the json object at that location)"`. The pointer reference traverses ahead with a forward slash. Example: `"$ref": "./spec2.json#/definitions/Model1"`.

- [ ] **M2041**: Circular composition/inheritance for Schema Objects *MUST NOT* be present. A specification can have circular references everywhere except in composition/inheritance.

- [ ] **M2042**: The items property for Schema Objects, or schema-like objects (non-body parameters), *MUST* be required when type is set to array. More details can be found [here](https://github.com/OAI/OpenAPI-Specification/issues/174).

- [ ] **M2043**: The  schemes array in the swagger spec for any HTTP protocol based Azure REST service *MUST* only have "https" as the supported scheme. It *MUST* be `"schemes": ["https"]`

- [ ] **M2044**: A swagger specification *MUST NOT* have any operation with an HTTP verb outside this (case-insensitive) list ["DELETE", "GET", "PUT", "PATCH", "HEAD", "OPTIONS", "POST"].

- [ ] **M2045**: An example specified in a specification as per the swagger specification for a response *MUST* be in the response object keyed on the "MIME-TYPE". More details can be found [here](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#exampleObject).

- [ ] **M2046**: An example specified in a specification as per the swagger specification for a model in the request body *MUST* be specified in the free-form example property of that model definition. More details can be found [here](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#fixed-fields-13).

- [ ] **M2047**: A parameter object *MUST* have a `"name"` property defined with a non-empty string as its value.

- [ ] **M2048**: A parameter object *MUST* have an `"in"` property defined with a non-empty string. The value can be one of "query", "header", "path", "body", "formData".

- [ ] **M2049**: Every operation *MUST* have a "default" status code in the "responses" section. The "default" corresponds to the error returned by the operation.

- [ ] **M2050**: "externalDocs" property *MUST* have both "url" and "description" accurately provided. More details can be found [here](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#external-documentation-object).

- [ ] **M2051**: Odata parameters like "$filter" *MUST* document the properties on which the object can be filtered on  and the supported operators in the description.

- [ ] **M2052**: Odata parameters like "$filter" *MUST* have an externalDocs that provides good examples of how the "$filter" parameter can be used.

- [ ] **M2053**: Parameters or properties that can only accept one value *MUST* be marked as "required" and they *MUST* have an "enum" array constraint with one valid value in it.

- [ ] **M2054**: Every swagger spec *MUST* have a "securityDefinitions" object accurately defined. An example can be found over [here](https://github.com/Azure/azure-rest-api-specs/blob/master/arm-analysisservices/2016-05-16/swagger/analysisservices.json#L26).

- [ ] **M2055**: An operationId in the swagger spec *MUST NOT* be split by more than one underscore. Please use the "tags" array for adding extra names.

- [ ] **M2056**: If the service (in Azure) only supports PATCHING tags on a Resource in the PATCH operation and has a PUT on the same resource which is named as "CreateOrUpdate", then it *MUST NOT* expose the "PATCH" operation in the swagger spec. 

### SHOULD

- [ ] **S2000**: If a parameter or a model property indicates that it is some "kind/type" of an artifact that can have a value from set of possible values, then it *SHOULD* have an `"enum": ["Array of possible values"]` constraint on that entity. It *MUST* also use the ["x-ms-enum"](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md#x-ms-enum) extension. If creating an enum is not possible, then the values need to be documented in description. If the number of allowed values is huge, add a link to some kind of external documentation in the description, where those values are defined.

- [ ] **S2001**: If a model is nested more than one level deep then ["x-ms-client-flatten"](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-client-flatten) extension *MUST* be applied. This is mostly applicable while defining Resource Models in Azure Resource Manager where Resource Provider specific properties are present inside the "properties" property bag. TODO: *SHOULD* or a *MUST*? Exception if the model has a polymorphic discriminator.

- [ ] **S2002**: Parameters that are common to most of the operations (example: resourceGroupName) *SHOULD* be defined in the global parameters section and they *MUST* have the extension `"x-ms-parameter-location": "method"` applied on them. This will make sure that they do not end up being properties on the generated client.

- [ ] **S2002**: Property `"name"`of the `"Resource"` model *SHOULD NOT* be required and it must be marked as readOnly. The name of the Resource is specified as a path parameter. There is no need to require the customer to specify it in the body parameter as well.

- [ ] **S2003**: If a swagger specification has a "fully" pageable operation and a "single-page" only operation then the generated code in C# will generate Page1.cs and Page.cs. They will differ on nextLink. To avoid this it is best advised that all the operations *SHOULD* defined as "fully" pageable in the specification.

- [ ] **S2004**: Produces and Consumes global arrays *SHOULD* have "application/json" as the supported MIME-TYPE. If the operation needs to have a different one then it can override it.


## Operational - Swagger Checklist ##

- [ ] **M3000**: Swagger authoring *MUST NOT* be assigned to engineers who do not have an intimate knowledge of a service endpoint and its developer experience to avoid feeding inefficiencies into teams that focus on Azure developer experiences and the rest of the Azure eco-system.

- [ ] **M3001**: Each operation described in a Swagger specification *MUST* be tested prior to opening a pull request against the preview/master branch of the [Azure REST API Specs](https://github.com/azure/azure-rest-api-specs/) GitHub repo.

## Documentation - Swagger Checklist ##

- [ ] **M4000**: Every operation, model definition, model property, parameter, response status codes *MUST* have accurate and meaningful description about it in the description property of that entity. It *MUST NOT* be over or under described.

- [ ] **M4001**: Descriptions *MUST* NOT contain spelling errors, grammatical errors, run off sentences and dummy texts.

Here are some [basic rules for public documentation](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-authoring-descriptions.md#basic-rules-for-public-docs-descriptions):

- [ ] **M4002**: Every description *MUST* start with a capital letter and end it with a period (".").

- [ ] **M4003**: The description/summary *MUST* use correct English spelling and grammar.

- [ ] **M4004**: One *MUST NOT* use the API's code-symbol capitalization style for acronyms. For example, use "URL", *NOT* "Url"; and use "ID", *NOT* "Id".

- [ ] **M4005**: The description for every operation *MUST* start with a verb phrase.

- [ ] **M4006**: The HTTP status codes returned by every REST operation *MUST* be documented.

- [ ] **M4007**: The documentation of model properties *MUST NOT* start with the phrase "Gets or sets ..", "Gets ..", "Sets .."

- [ ] **M4008**: The "title" and "description" property of the "info" object in the swagger specification *MUST NOT* have the phrase client or .NET in it. The specification is used for different purposes and is used for generating REST clients in different languages.

- [ ] **M4009** The description *MUST* specify the units of quantifiable properties/parameters. Example properties like size *MUST* specify the units (bytes, MB, GB, etc.)

- [ ] **M4010**: All the negative response status code descriptions *MUST* be defined in the description of the "default" status code (if the intention is for documentation purpose only). Example: `"description": "'404' - 'Not found'.\n'400' - 'Bad request'.\n'500': 'Internal Server Error'."'`

## Structural - Swagger Checklist ##

- [ ] **M5000**: The `info.version` in Swagger specification *MUST* be exactly the same (case-sensitive) as the Api-version folder in path. Example the info.version and "/azure-rest-api-specs/arm-storage/\<api-version\>/swagger/storage.json" in this path *MUST* be the same (ex: "2016-01-01").

- [ ] **M5001**: Every specification *MUST* have a swagger folder in its file path.

- [ ] **M5003**: Examples provided using the ["x-ms-examples"](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md) extension MUST be present in the examples folder under the api-version folder. Example: `<service-name>/<api-version>/examples/<scenario-name>.json`.

- [ ] **M5004**: The top level property of a specification that describes the version of the swagger specification that the specification adheres to, *MUST* be set to `"swagger": "2.0"`.

- [ ] **M5005**: All the management plane swagger specifications *MUST* have the base folder name in the format `"arm-<service-name>/"` and the data plane swagger specifications *MUST* have the base folder name in the format `"<service-name>/"`.

## Appendix A: References ##

[Swagger 2.0 - OpenAPI Specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md)

[Creating Swagger (Reference Documentation)](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/creating-swagger.md)

[Authoring Good Descriptions in Swagger 2.0](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-authoring-descriptions.md)

[Supported Extensions for Swagger 2.0](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md)

[Swagger Recommended Patterns](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-good-patterns.md)

[Linting](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/linter.md)

## Appendix B: Acknowledgments ##

This checklist is prepared and will be approved by Microsoft. Contributors to the checklist are:

- Doug Erickson, Microsoft
- Tamra Myers, Microsoft

## Appendix C: Revision History ##

<table>
  <tr>
    <th>Date</th>
    <th>Version</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>12-15-2016</td>
    <td>0.1</td>
    <td>First draft</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</table>
