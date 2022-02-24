Describes the format for specifying examples for request and response of an operation in a swagger spec. It is a **dictionary** of different variations of the examples for a given operation.

## Why "x-ms-examples"?
We looked at the current mechanism/format provided by swagger specification to provide examples.
- _**For a response**_, [swagger specification says](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#response-object):
 
Field Pattern | Type | Description
---|:---:|---
{mime type} | Any | The name of the property MUST be one of the Operation `produces` values (either implicit or inherited). The value SHOULD be an example of what such a response would look like.
 
**Illustration**:
```json5
{
  "application/json": {
    "name": "Puma",
    "type": "Dog",
    "color": "Black",
    "gender": "Female",
    "breed": "Mixed"
  }
}
```
 
**_shortcomings/concerns_**: What if the service team wants to show different examples. Scenario: GET on NetworkInterface with $expand and without $expand will have an impact on the NetworkSecurityGroup property of the NIC. In the former it will be a full blown NSG and in the latter it will be a Subresource(object with one property 'id')?
 
  - _**For any model definition**_ (body parameter is a model definition; example: StorageAccountCreateParameters), [swagger specification says](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#fixed-fields-13):
 
Field Name | Type | Description
---|:---:|---
example | Any | _A free-form property to include an example of an instance for this schema._
 
**_shortcomings/concerns_**: Well this is good. But it does not provide a holistic picture of the entire request/response. We have to do extra processing to join the dots. _When a Service developer thinks about an API endpoint, he/she would think in terms of sending a request to the endpoint and receiving a response from that endpoint._
 
 
_**Hence, having an extension at every operation level in a spec, would give us the biggest bang for the buck.**_
 
## Benefits of "x-ms-examples" extension: 
- This will provide enough information about making a request against an endpoint/API.
- One can provide multiple examples for an operation and all of them are captured at one place.
- The sample data (provided by the service developer) in the extension will be used to validate the data models (as a part of the Travis CI while the PR is sent to the azure-rest-apis-specs repo).
- It forms the basis of better documentation. The doc team will leverage this in lightening up the REST API documentation.
- It will also be used to test the API/endpoint by running a live request with the help of some custom tool.

## Where do the examples live?
We would not like to pollute the swagger spec with sample data. Hence the extension will contain a reference to the sample (a json file) in an adjacent folder (examples) of the spec.

The detailed example **MUST** be specified in a separate json file in the example folder under the api-version folder.
 
For example: The location of a swagger spec for a given service in this repo looks like this: 
- azure-rest-api-specs/arm-\<serviceName\>/2016-01-01/swagger/\<serviceName\>.json. So the examples for that _**api-version**_ can reside at
- azure-rest-api-specs/arm-\<serviceName\>/2016-01-01/**examples**/createFooResource.json
 
_This will keep the spec cleaner and easy to manage._

## Where can the extension be applied in the swagger spec?
**Parent element:**  [Operation Object](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#operationObject). It is applied on the operation in the swagger spec.

## Structure of the extension
- **How the extension would look in the swagger spec?**
  - JSON schema for the extension can be found [here](https://github.com/Azure/autorest/blob/main/packages/libs/autorest-schemas/swagger-extensions.json#L1844-L1858).
```json5
{
  "info": { ... },
  "paths": {
   "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}": {
      "put": {
        "operationId": "StorageAccounts_CreateOrUpdate",
        "description": "Creates or updates a storage account.",
        "x-ms-examples": {
          "Create a storage account": { "$ref": "./examples/createStorageAccount.json" },
          "Update a storage account": { "$ref": "./examples/updateStorageAccount.json" }
        },
        "parameters": [ ... ],
        "responses": { ... }
      }
    }
  },
  "definitions": { ... }
}
```
- **Skeleton/Schema of the example provided in an individual example (json) file**
  - The JSON schema for the content to be provided in the example file can be found [here](https://github.com/Azure/autorest/blob/main/packages/libs/autorest-schemas/example-schema.json).
```json5
"x-ms-examples": {
  "example-name": { //Name of the example/scenario.  It is free-form text and should succinctly describe the scenario.
    "parameters": { //Provide examples for all the path, query, header, body, formData parameters as applicable.
       ...
    },
    "responses": { //Provide examples of the response headers and body per status code (as per the operation defined in the swagger spec) as applicable.
      "statusCode1": {
        "headers": { ... }, //Examples for location, azure-asyncoperation, retry-after response headers for long running (asynchronous) operations would be valuable
        "body": { ... }
      },
      "statuscode2": { ... }
    }
  }
}
```
- **How would the content of an example file look like?**

```json5
{
  "parameters": {
      "subscriptionId": "34adfa4f-cedf-4dc0-ba29-b6d1a69ab345",
      "resourceGroupName": "testrg123",
      "storageAccountName": "testacc6141",
      "api-version": "2016-01-01",
      "accountCreateParameters": {
        "sku": { 
          "name": 'Standard_LRS' 
        },
        "kind": 'Storage',
        "location": 'eastasia',
        "properties": { 
          "encryption": { 
            "services": { 
              "blob": { 
                "enabled": true 
              }
            },
            "keySource": 'Microsoft.Storage' 
          }
        }
      }
   },
  "responses": {
    "200": {
      "headers": {
      },
      "body": {
        "id": "/subscriptions/34adfa4f-cedf-4dc0-ba29-b6d1a69ab345/resourceGroups/testrg123/providers/Microsoft.Storage/storageAccounts/testacc6141",
        "kind": "Storage",
        "location": "eastasia",
        "name": "testacc6141",
        "properties": {
          "creationTime": "2016-04-12T19:20:33.2288820Z",
          "encryption": {
            "keySource": "Microsoft.Storage",
            "services": {
              "blob": {
                "enabled": true,
                "lastEnabledTime": "2016-04-12T19:20:33.2298823Z"
              }
            }
          },
          "primaryEndpoints": {
            "blob": "https://testacc6141.blob.core.windows.net/",
            "file": "https://testacc6141.file.core.windows.net/",
            "queue": "https://testacc6141.queue.core.windows.net/",
            "table": "https://testacc6141.table.core.windows.net/"
          },
          "primaryLocation": "eastasia",
          "provisioningState": "Succeeded",
          "statusOfPrimary": "Available"
        },
        "sku": {
          "name": "Standard_LRS",
          "tier": "Standard"
        },
        "tags": {},
        "type": "Microsoft.Storage/storageAccounts"
      }
    }
  }
}
```
