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

Please direct feedback and kudios to [swagger-checklist@microsoft.com](mailto:swagger-checklist@microsoft.com)

## Table of Contents ##

Introduction</br>
Notational Conventions</br>
Checklist</br>
[Appendix A: References](#appendix-a-references)</br>
Appendix B: Acknowledgments</br>
Appendix C: Revision History

## Introduction ##

xx

## Notational Conventions ##
The keywords "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC2119](http://www.ietf.org/rfc/rfc2119.txt).

Normative statements of the checklist are presented in the following manner:

*Rnnnn*: checklist text here.

Where "nnnn" is replaced by a number that is unique among all the requirements in the checklist, thereby "nnnn" becomes a unique requirement identifier.


## Naming - Swagger Checklist ##

*R1000*: Plural names MUST only be used to represent collections.

*R1001*: List operations MUST be prefixed with "List" and MUST not be named as "GetXXXX" operations.

*R1002*: Terminology in Swagger and Azure Portal MUST be the same.



## Operation Semantics - Swagger Checklist ##

*R2000*: A Swagger specification MUST be accompanied with a document that describes management scenarios that can be realized using operations describe din the Swagger.

*R2001*: Read only parameters MUST be labeled as read only in Swagger.

*R2002*: Boolean parameters MUST be represented as boolean in Swagger. Boolean parameters MUST NOT be represented as strings. Similarly, this requirements applies to other primitive data types such as integer, float and double. These primitive data types MUST be represented using [Swagger primitive data types](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types).

*R2003*: Long running operations MUST be modeled as long running operations in Swagger.

*R2004*: Required parameters MUST be labeled as required in Swagger

*R2005*: A collection of references that are read only MUST be marked as read only in Swagger.

*R2006*: Mutability of properties MUST be marked up using `x-ms-mutability` extension

*R2007*: Error definitions MUST be abstracted, modeled and reused instead of introducing a plethora of error definitions that look the same with different names.

*R2008*: A Swagger spec MUST NOT define operations or properties or parameters for functionalities that MAY work in the future.

For example, `OutBoundNATRule` is a model that exists in a the networking Swagger but it it not supported by the Networking RP.

*R2009*: A collection model in Swagger MUST support adding more than one element to the collection.

*R2010*: Operations that are exposed through private previews MUST note be described in Swaggers in the public GitHub repository.


## Operational - Swagger Checklist ##

*R3000*: Swagger authoring MUST NOT be assigned to new hires or interns or vendors or FTEs <= L61 to avoid feeding inefficiencies into teams that focus on Azure developer experiences and the rest of the Azure eco system.

*R3001*: Each operation described in a Swagger specification MUST be tested prior to opening a pull request against the preview branch of the [Azure REST API Specs](https://github.com/azure/azure-rest-api-specs/) GitHub repo.

## Documentation - Swagger Checklist ##

*R4000*: Descriptions MUST NOT contain spelling errors, grammatical errors, run off sentences and dummy texts.

## Appendix A: References ##

[Swagger 2.0 - OpenAPI Specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md)

[Creating Swagger (Reference Documentation)](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/creating-swagger.md)

[Authoring Good Descriptions in Swagger 2.0](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-authoring-descriptions.md)

[AutoRest Extensions for Swagger 2.0](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md)

[AutoRest Extensions for Swagger 2.0](https://github.com/Azure/autorest/tree/master/docs/extensions)

[Swagger Recommended Patterns](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-good-patterns.md)

[Linting](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/linter.md)

