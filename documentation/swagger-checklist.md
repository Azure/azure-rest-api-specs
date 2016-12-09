# Swagger Checklist for Microsoft Azure #

*Version 0.1, 11-28-2016*
----------
Latest version: [https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-checklist.md](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-checklist.md)

Editors:</br>
"XXX", Microsoft</br>
"YYY", Microsoft</br>
"ZZZ", Microsoft


## Executive Summary ##

This document defines a Swagger checklist for Microsoft Azure, along with clarifications, refinements, interpretations and amplifications of the Swagger specification to promote interoperability and usability in tools and libraries.

## Status of this Checklist ##

This is a working draft.

## Feedback ##

If there are areas in this specification that could be clearer, or if errors or omissions are identified, Microsoft would like to be notified to provide the best possible checklist for authoring Swagger specifications.

Please direct feedback and kudos to [swagger-checklist@microsoft.com](mailto:swagger-checklist@microsoft.com).

## Table of Contents ##

[Introduction](#introduction)</br>
[Notational Conventions](#notational-conventions)</br>
[Naming - Swagger Checklist](#naming---swagger-checklist)</br>
[Operation Semantics - Swagger Checklist](#operation-semantics---swagger-checklist)</br>
[Operational - Swagger Checklist](#operation-semantics---swagger-checklist)</br>
[Documentation - Swagger Checklist](#documentation---swagger-checklist)</br>
[Appendix A: References](#appendix-a-references)</br>
[Appendix B: Acknowledgments](#appendix-b-acknowledgments)</br>
[Appendix C: Revision History](#appendix-c-revision-history)

## Introduction ##

This document defines a Swagger checklist for Microsoft Azure, along with clarifications, refinements, interpretations and amplifications of the Swagger specification to promote interoperability and usability in tools and libraries.

Each section addresses a dimension of Swagger authoring and its effectiveness for delivering the best Azure developer experiences through tools and libraries built using a Swagger specification.

## Notational Conventions ##
The keywords "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC2119](http://www.ietf.org/rfc/rfc2119.txt).

Normative statements of the checklist are presented in the following manner:

&#x25a2; *Mnnnn*: checklist text here.

OR

&#x25a2; *Snnnn*: checklist text here.

Where "M" stands for 'MUST' or 'MUST NOT' requirement. "S" stands for 'SHOULD' or 'SHOULD NOT' requirement. And, "nnnn" is replaced by a number that is unique among all the requirements in the checklist, thereby "nnnn" becomes a unique requirement identifier.


## Naming - Swagger Checklist ##

&#x25a2; *M1000*: Plural names MUST only be used to represent collections.

&#x25a2; *M1001*: List operations MUST be prefixed with "List" and MUST not be named as "GetXXXX" operations.

&#x25a2; *M1002*: List operations MUST use consistent names and semantics. List operations MUST NOT use any other names. Consistent names and semantics are:

- `List()` - lists all resources under a subscription.
- `ListByResourceGroup()` - list all resources in a resource group within a subscription.
- `ListByParent()` - where "Parent" is a context specific suffix. It lists all resource under a parent.

&#x25a2; *M1003*: Terminology in Swagger and Azure Portal MUST be the same.

Resource Model name MUST be same as singular form of the resource type. Like for virtualMachines resource type it should be VirtualMachine.
Parameter names in the apis MUST be name of the resource like virtualMachines\{virtualMachine} or virtualMachines\{virtualMachineName} both are good example but virtualMachines\{vm} is bad example. 
Any action name MUST be same as what is defined in the Rest APIs, like regenerateAdminKeys should be regenerateAdminKeys in the Swagger as well, where as regenerateKeys is bad example.


## Operation Semantics - Swagger Checklist ##

### MUST

&#x25a2; *M2000*: TODO: A Swagger specification MUST be accompanied with a document that describes management scenarios (what does this mean? x-ms-examples or a multi operation scenario?) that can be realized using operations described in the Swagger.

&#x25a2; *M2001*: Read only parameters and model properties MUST be labeled as `"readOnly": true` in Swagger.

&#x25a2; *M2002*: Boolean parameters MUST be represented as boolean in Swagger. Boolean parameters MUST NOT be represented as strings. Similarly, this requirements applies to other primitive data types such as integer, float and double. These primitive data types MUST be represented using [Swagger primitive data types](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types).

&#x25a2; *M2003*: If a format is specified along with a type, it must be from one of the supported formats - "int64", "int32", "float", "decimal", "double", "byte", "base64url", "unixtime", "date", "date-time", "duration", "date-time-rfc1123", "uuid", otherwise in codegeneration the artifact will be of the specified type and not as per the desired format. 

&#x25a2; *M2004*: Long running (asynchronous) operations MUST be modeled as [long running operations](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/creating-swagger.md#longrunning) in Swagger.

A longrunning operation MUST have a terminal success status code. At least 
 - 200 or 201 for PUT/PATCH
 - 200, 201 or 204  or all of the aforementioned for POST
 - 204 or 200 or both for delete. 
This will indicate the code generator the logic to deserialize the final success response after the polling is done. If the response has a response body then it MUST be modeled in the terminal status code.

&#x25a2; *M2005*: Required parameters MUST be accurately labeled as `"required": true` in Swagger.

&#x25a2; *M2006*: Required properties of a model definition MUST be accurately labeled as `"required": [ "propertyName1" ]` in Swagger.

&#x25a2; *M2007*: Mutability of properties MUST be marked up using [`x-ms-mutability` extension](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-mutability).

&#x25a2; *M2008*: Error definitions MUST be abstracted, modeled and reused.

&#x25a2; *M2009*: A Swagger spec MUST NOT define operations or properties or parameters for functionalities that are not currently supported by the service in the given api-version. The primary goal of the spec is that it should correctly and completely represent the underlying REST API.

&#x25a2; *M2010*: A collection model in Swagger MUST support adding more than one element to the collection. TODO: Ask for clarity.

&#x25a2; *M2011*: Operations that are exposed through private previews MUST not be described in the [public GitHub repository](https://github.com/Azure/azure-rest-api-specs). They SHOULD be described in the [private GitHub repository](https://github.com/Azure/azure-rest-api-specs-pr) instead.

&#x25a2; *M2011*: The value of the ["x-ms-client-name"](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-client-name) and ["x-ms-discriminator-value"](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-discriminator-value) MUST not be the same as the model property or the model name, otherwise the purpose is defeated.

For specifications describing the Management Plane of ARM, subscriptionId & api-version MUST always be defined in the global parameters section.
For a Given Resource, GET/PUT/PATCH MUST return the same "Resource" Model.
For PATCH operation, every property in the model for the request body MUST be optional and the property MUST not provide any default value. The absence of defualt values applies recursively to complex properties in the model definition.
The model definition for the body parameter and the response must be the same for a PUT operation. This ensures that the same entity will be reusable between GET and PUT.

Enum modelAsString: false is a MUST criteria where applicable

MUST RO: id, name, type of resource
MUST x-ms-mutability [C, R] for location of resource

### SHOULD

&#x25a2; *S2000*: If a parameter or a model property indicates that it is some "kind/type" of an artifact that can have a value from set of possible values, then it SHOULD have an `"enum": ["Array of possible values"]` constraint on that entity. It MUST also use the ["x-ms-enum"](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md#x-ms-enum) extension. If creating an enum is not possible, then the values need to be dcoumented in description. If the number of allowed values is huge, add a link to some kind of external documentation in the description, where those values are defined.

&#x25a2; *S2000*: If a model is nested more than one level deep then ["x-ms-client-flatten"](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-client-flatten) extension MUST be applied. This is mostly applicable while defining Resource Models in Azure Resource Manager where Resource Provider specific properties are present inside the "properties" property bag. TODO: SHOULD or a MUST? Exception if the model has a polymorphic discriminator.

&#x25a2; *S2000*: Parameters that are common to most of the operations (example: resourceGroupName) SHOULD be defined in the global parameters section and they MUST have the extension `"x-ms-parameter-location": "method"` applied on them. This will make sure that they do not end up being properties on the generated client.

Property "name" of the "Resource" model SHOULD not be required and it must be marked as readOnly. The name of the Resource is specified as a path parameter. There is no need to require the customer to specify it in the body parameter as well.
Every "Resource" Model MUST be tagged with "x-ms-azure-resource". This will cause the Resource to inherit from the Resource definition in the client runtime.

## Operational - Swagger Checklist ##

&#x25a2; *M3000*: Swagger authoring MUST NOT be assigned to engineers who do not have an intimate knowledge of a service endpoint and its developer experience to avoid feeding inefficiencies into teams that focus on Azure developer experiences and the rest of the Azure eco system.

&#x25a2; *M3001*: Each operation described in a Swagger specification MUST be tested prior to opening a pull request against the preview branch of the [Azure REST API Specs](https://github.com/azure/azure-rest-api-specs/) GitHub repo.



## Documentation - Swagger Checklist ##

- Every operation, model defintion, model property, parameter, response status codes must be have accurate and meaningful description about it in the description property of that entity.
&#x25a2; *M4000*: Descriptions MUST NOT contain spelling errors, grammatical errors, run off sentences and dummy texts.

Here are some [basic rules for public documentation](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-authoring-descriptions.md#basic-rules-for-public-docs-descriptions):

- Start every description with a capital letter and end it with a period (".").
- Use correct English spelling and grammar.
- Do not use the API's code-symbol capitalization style for acronyms. For example, use "URL", not "Url"; and use "ID", not "Id".
- Start the description for every operation with a verb phrase.
- Document the HTTP status codes that your REST operations return.
- Explain object definitions, parameters, and response objects as best you can.
- Do not start the documentation of model properties with the phrase "Gets or sets ..", "Gets ..", "Sets .."

## Structural - Swagger Checklist ##
- The info.version in Swagger specification MUST be exactly the same (case-sensitive) as the Api-version folder in path. Example the info.version and "/azure-rest-api-specs/arm-storage/\<api-version\>/swagger/storage.json" in this path MUST be the same (ex: "2016-01-01").
- Every spec MUST have a swagger folder in its file path.
## Appendix A: References ##

[Swagger 2.0 - OpenAPI Specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md)

[Creating Swagger (Reference Documentation)](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/creating-swagger.md)

[Authoring Good Descriptions in Swagger 2.0](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-authoring-descriptions.md)

[AutoRest Extensions for Swagger 2.0](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md)

[AutoRest Extensions for Swagger 2.0](https://github.com/Azure/autorest/tree/master/docs/extensions)

[Swagger Recommended Patterns](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-good-patterns.md)

[Linting](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/linter.md)

## Appendix B: Acknowledgments ##

This checklist is prepared and will be approved by Microsoft. Contributors to the checklist are:

- Doug Erickson, Microsoft
- Tamra Myers, Microsoft
- AA, Microsoft
- BB, Microsoft

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
