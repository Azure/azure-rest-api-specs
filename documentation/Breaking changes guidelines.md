<deprecated. For internal contributor, please refer to https://aka.ms/AzBreakingChangesPolicy for the topic>

# Azure REST API version change guide

## Overview
This specification is aimed at providing guidance to Azure Service teams when making changes to the REST APIs. It is aimed at helping teams understand what kind changes to API requires updating the API version. The official Microsoft REST API guidelines can be found [here](https://github.com/Microsoft/api-guidelines). This document is meant to supplement the official guidance.
It will be also used as a reference by SDK teams and API reviewers when reviewing APIs

## Breaking Changes 
At a high level, changes to the contract of an API constitute a breaking change. Changes that impact backwards compatibility of an API is also considered a breaking change. Teams MAY define backwards compatibility as their business needs require. For example, Azure defines the addition of a new JSON field in a response to be not backwards compatible. Anything that would violate the _**Principle of Least Astonishment**_ is considered a breaking change in Azure. Below are some concrete examples of what constitutes a breaking change. In the below breaking change scenarios, the API version **must** be changed.

### Existing property is removed
If a property called "foo" was present in v1 of the API need to be removed, it should be done in a newer api-version
Property name has changed

### Property name has changed
If a property was called “foo” in v1 of API and the name will be changed to “bar”, this requires an API-version change since this will result in a breaking change for the client. 

### Property type has changed
Property “foo” was a “boolean” in v1 but is changed to a string. A client using the existing api-version tries to set it as a bool, but the service will fail since its now expecting a string. So, the api-version must be updated.

### Allowed values for an enum have changed
Enum “foo” had allowed values as “val1” and “val2” in v1 of API. If now, the values allowed/accepted by the service are “val1”, “val2” and “val3”, client will fail to de-serialize if “val3” comes back in the response.

### API has been removed or renamed
V1 of API contract supported PUT /resourceType1/{resourceType1_name} but the service no longer supports this method. This scenario should follow the proper Azure API deprecation policy and must be done in an updated api-version. 

### Behavior of existing API has changed
There is a functional change in what the API was doing. This will need to be determined on a case by case basis.

### Error contracts have changed

### Property is made required (from optional)
If property “foo” was optional in the request body of v1 and now it is required, this should result in an api-version change. If not changed, clients relying on older api-version will fail if this property is not passed.

### URL format has changed
Resource parameter names change from /resourceType1/{resourceType1_name} to /resourceType1/{resourceType1_id}. This will impact code generation.

### New property added to response
If a new property/field is added to the response an API, the GET-PUT pipeline will be broken. Consider the case where from portal a customer updates the value of a new property "A". Another customer does a GET of this resource using the SDK. The SDK will ignore the property since it does not understand it. From the SDK, the customer does a PUT using the model that was returned from the GET. This will overwrite the change made by the first customer from the portal. 

### New required property added to request
If a new property is made required in the request body, clients will have no way to set this and the request will fail. 

### Resource naming rules should not change
This could result in failures which would have earlier succeeded. Even if the rules become less strict, clients relying on earlier name constraints to perform local validation will fail.  

## Non-Breaking Changes
The following changes are considered backwards compatible and hence non-breaking. 

### Adding new APIs to an existing service
When a new resource types is added, it does not require API version to be updated for existing types.

### Adding read-only field to response
New property which can only be set by the server can be added to the response.

### Bug fixes to existing API
Bug fixes to existing API which don’t fall into one of the above categories of breaking changes as described above are fine
