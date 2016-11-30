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



## Operation Semantics - Swagger Checklist ##

&#x25a2; *M2000*: A Swagger specification MUST be accompanied with a document that describes management scenarios that can be realized using operations described in the Swagger.

&#x25a2; *M2001*: Read only parameters MUST be labeled as read only in Swagger.

&#x25a2; *M2002*: Boolean parameters MUST be represented as boolean in Swagger. Boolean parameters MUST NOT be represented as strings. Similarly, this requirements applies to other primitive data types such as integer, float and double. These primitive data types MUST be represented using [Swagger primitive data types](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types).

&#x25a2; *M2003*: Long running operations MUST be modeled as [long running operations](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/creating-swagger.md#longrunning) in Swagger.

&#x25a2; *M2004*: Required parameters MUST be labeled as required in Swagger.

&#x25a2; *M2005*: A collection of references that are read only MUST be marked as read only in Swagger.

&#x25a2; *M2006*: Mutability of properties MUST be marked up using [`x-ms-mutability` extension](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-mutability).

&#x25a2; *M2007*: Error definitions MUST be abstracted, modeled and reused instead of introducing a plethora of error definitions that look the same with different names.

&#x25a2; *M2008*: A Swagger spec MUST NOT define operations or properties or parameters for functionalities that MAY work in the future.

For example, `OutBoundNATRule` is a model that exists in a the networking Swagger but it is not supported by the Networking RP.

&#x25a2; *M2009*: A collection model in Swagger MUST support adding more than one element to the collection.

&#x25a2; *M2010*: Operations that are exposed through private previews MUST not be described in Swaggers in the [public GitHub repository](https://github.com/Azure/azure-rest-api-specs).


## Operational - Swagger Checklist ##

&#x25a2; *M3000*: Swagger authoring MUST NOT be assigned to engineers who do not have an intimate knowledge of a service endpoint and its developer experience to avoid feeding inefficiencies into teams that focus on Azure developer experiences and the rest of the Azure eco system.

For example, if Swagger authoring were assigned to new hires or vendors it would feed inefficiencies into downstream consumption and developer experiences.

&#x25a2; *M3001*: Each operation described in a Swagger specification MUST be tested prior to opening a pull request against the preview branch of the [Azure REST API Specs](https://github.com/azure/azure-rest-api-specs/) GitHub repo.

## Documentation - Swagger Checklist ##

&#x25a2; *M4000*: Descriptions MUST NOT contain spelling errors, grammatical errors, run off sentences and dummy texts.

Here are some [basic rules for public documentation](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-authoring-descriptions.md#basic-rules-for-public-docs-descriptions):

- Start every description with a capital letter and end it with a period (".").
- Use correct English spelling and grammar.
- Do not use the API's code-symbol capitalization style for acronyms. For example, use "URL", not "Url"; and use "ID", not "Id".
- Start the description for every operation with a verb phrase.
- Document the HTTP status codes that your REST operations return.
- Explain object definitions, parameters, and response objects as best you can.

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
