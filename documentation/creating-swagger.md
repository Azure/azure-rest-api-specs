# AutoRest Swagger
AutoRest is a tool for generating HTTP client libraries from Swagger files. This document explains the conventions 
and extensions used by AutoRest in processing Swagger to produce client libraries. The Swagger specification can 
be found at [Swagger RESTful API Documentation Specification](Swagger-spec2.0).

## Swagger
In this document, references to the 'spec' or to the 'swagger' refer to an instance of a Swagger file. AutoRest 
supports Swagger version 2.0. The version of Swagger being used must be included in the spec.

```json
{
  "swagger": "2.0"
  ...
}
```

## Info Object
Each spec includes an "info object."
The **title** field is used as the name of the generated client.
```json
"info": {
  "title": "MyClientName",
}
```

```
var client = new MyClientName();
```
Override the title client name by passing the `-ClientName` to AutoRest.
>autorest.exe -ClientName MyClientName

The version field specifies the service version of the API described in the spec. This is used as the default 
value for Azure clients where api-version is passed in the querystring.
```json
"info": {
  "version": "2014-04-01-preview"
```

```
https://management.azure.com/...?api-version="2014-04-01-preview"
```
## Host
The host field specifies the baseURI. (everything after the protocol and before the path).
``` json
{
  "swagger": "2.0",
  "host": "management.azure.com"
}
```

## Schemes
The schemes field is an array of transfer protocols that can be used by individual operations. AutoRest supports 
*http* and *https*. The generated client uses the first scheme from the array.
```json
{
  "swagger": "2.0",
  "schemes": [
    "https",
    "http"
  ]
  . . .
}
```

## Consumes / Produces
The *consumes* and *produces* fields declare the mime-types supported by the API. The root-level definition can 
be overridden by individual operations. AutoRest supports JSON payloads.
```json
{
  "swagger": "2.0",
  "consumes": [
    "application/json"
  ],
  "produces": [
    "application/json"
  ]
  . . .
}
```

## Paths
The paths object defines the relative paths of API endpoints (appended to the baseURI to invoke operations).
```json
"swagger": "2.0",
"paths": {
  "/tenants": {
  ...
  },
  "/subscriptions": {
  ...
  }
}
```

```
https://management.azure.com/tenants?api-version=2014-04-01-preview
OR
https://management.azure.com/subscriptions?api-version=2014-04-01-preview
```
## Path Item
Each path item in the spec defines the operations available at that endpoint. The individual operations are 
identified by the HTTP operation (sometimes referred to as HTTP verbs). AutoRest supports: **head**, **get**, 
**put**, **post**, **delete** and **patch**.

```json
{
  "swagger": "2.0",
  "paths": {
    "/stations": {
      "get": {
      ...
      },
      "put": {
      ...
```
### Operation and OperationId
Every operation must have a unique operationId. The operationId is used to determine the generated method name.
```json
"paths": {
  "/users": {
    "get": {
      "operationId": "ListUsers"
    }
  }
```

```csharp
var client = new MyClientName();
var listResult = client.ListUsers();
IList<User> users = listResult.Value;
```
All of the operations specified become methods on the client. The client API model can easily become a long and 
cumbersome list of methods. AutoRest allows grouping of operations by using a naming convention. Operation groups 
are identified by splitting the operationId by underscore.
```json
"paths": {
  "/{tenantId}/users": {
    "get": {
      "operationId": "Users_List",
      ...
```
instead of
```csharp
var listResult = client.ListUsers();
```
the method becomes part of an operation group interface

```csharp
var listResult = client.Users.List();
```
The operation group interface and the interface implementation is the "core" of the operation. Other signatures of 
this API ultimately call the "core" implementation. This allows the operations to be easily mocked for testing without 
needing to mock all signature variations. Other API signatures for the same operation are generated as extension methods.
For example, consider this `GetUserById` operation on the `SampleClient`.
```json
"/users/{userId}": {
    "get": {
      "operationId": "Users_GetById"
...
```
The generated method signature is in the `IUsers`  interface
```csharp
public interface IUsers
{
    Task<HttpOperationResponse<User>> GetByIdWithOperationResponseAsync(string userId, CancellationToken cancellationToken = default(CancellationToken));
}
```
The core signature returns a generic HttpOperationResponse which includes the HttpRequest and HttpResponse objects as 
well as the payload object. In addition to the "core" signature, there is a synchronous version and an async version 
that returns the payload object without the request and response objects.
```csharp
public static partial class UsersExtensions
{
    public static User GetById(this IUser operations, string userId) {...}

    public static async Task<User> GetByIdAsync( this IUser operations, string userId, CancellationToken cancellationToken = default(CancellationToken)) {...}
}
```

### Parameters
Each operation defines the parameters that must be supplied. An operation may not require any parameters. A parameter 
defines a name, description, schema, what request element it is `in` (AutoRest supports parameters in the **path**, **query**, 
**header**, and **body** of the request) and whether or not is it `required`.

#### Path Parameters
The value of path parameters are replaced in the templated URL path at the position specified by the name. Parameters that 
are `in` the `path` must have a `true` value for the `required` field. In this example, the `{userId}` in this operation 
is populated with the value of userId provided in the client method.
```json
"paths": {
  "/users/{userid}": {
    "get": {
      "operationId": "users_getById",
      "parameters": [
        {
          "name": "userId",
          "in": "path",
          "required": true,
          "type": "string",
          "description": "Id of the user."
        }
      ]
    }
  }
}
```
In the generated code, the path parameter is an argument of the method.
```csharp
string userId = "abcxyz";
var user = client.Users.GetById(userId);
```
>https://{host}/{basePath}/users/abcxyz

#### Query Parameters
Query parameters are appended to the request URI. They can be specified as required or optional.
```json
"paths": {
  "/users/{userId}": {
    "get": {
      "operationId": "users_getUserById",
      "parameters": [
        {
          "name": "api-version",
          "in": "query",
          "required": true,
          "type": "string",
          "description": "Version of API to invoke."
        }
      ]
    }
  }
}
```
The user doesn't need to know where the parameter is placed. Doc comments surface the required/optional distinction.

####Body Parameters
Body parameters include schema for the payload. In this example, the schema element is a `$ref` to the type details 
in the `#/definitions` section of the spec. More on the `#/definitions` later.
```json
"paths": {
  "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/checkNameAvailability": {
    "post": {
      "operationId": "StorageAccounts_CheckNameAvailability",
      "parameters": [
        {
          "name": "accountName",
          "in": "body",
          "required": true,
          "schema": {
            "$ref": "#/definitions/StorageAccountCheckNameAvailabilityParameters"
          }
        }
      ],
      ...
```

#### Header Parameters
>TODO: Header parameters

#### FormData Parameters
>Note: FormData parameters are not currently supported by AutoRest.

### Responses
Each operation defines the possible responses by HTTP status code:
```json
"/users/{userId}": {
  "get": {
    "operationId": "users_getUserById",
    "responses": {
      "200": {
        "schema": {
          "$ref": "#/definitions/user"
        }
      }
    }
  }
}
```

#### Default Response
Swagger allows for specifying a `default` response. AutoRest treats the `default` response as defining an error 
response status code unless `default` is the only status code defined. The reason for imposing this convention is 
to produce higher quality API signatures. The return type of the generated API is determined by finding a common 
base type of the success responses. In practice, if the default is considered as a potential success defintion, 
the common ancestor of success responses and error responses ends up being Object.

## Defining Model Types
The request body and response definitions become simple model types in the generated code. The models include 
basic validation methods, but are generally stateless serialization definitions.

### Model Inheritance
Swagger schema allows for specifying that one type is `allOf` other types, meaning that the entire specification of 
the referenced schema applies is included in the new schema. By convention, if a schema has an 'allOf' that references 
only one other schema, AutoRest treats this reference as an indication that the `allOf` schema represents a base 
type being extended. In this example, the generated code would include a `Dog` model that inherits from the `Pet` model.

```json
{
  "definitions": {
    "pet": {
      "properties": {
        "name": {
          "type": "string"
        },
      },
      "required": [
        "name"
      ]
    },
    "dog": {
      "allOf": [
        {
          "$ref": "#/definitions/pet"
        }
      ],
      "properties": {
        "breed": {
          "type": "string"
        },
        "required": [
          "breed"
        ]
      }
    }
  }
}
```

### Polymorphic Response Models
Besides using `allOf` to define inheritance, model definitions can indicate that the payload will include a `discriminator` 
to disambiguate polymorphic payloads. The discriminator field allows the deserializer to resolve into an instance of a more 
specific type. Suppose the Dog and Cat type are `allOf` Pet and an operation will return a Dog or a Cat. If the Pet definition 
includes a `discriminator` then payloads can be Dog or Cat. A response can be defined as a Pet model and the API signature 
will indicate Pet. At runtime, the returned object is an instance of the more specific type.
```json
{
  "definitions": {
    "pet": {
      "properties": {
        "name": {
          "type": "string",
          "discriminator": "petType"
        },
      },
      "required": [
        "name",
        "petType"
      ]
    }
  }
```


## Defining Azure Resource Types with x-ms-azure-resource (Resource Flattening)
Azure Resource Manager brings a common pattern that is leveraged to provide a more consistent programming model for users. 
Resource types all have a common set of Resource properties: id, name, location, tags...
In a resource payload, the common properties are at the top-level and the resource-specific properties are nested within 
`properties`. The top-level outer properties are sometimes referred to as the 'ARM envelope' and the inner data as the 'Resource properties.'
```json
{
    "id": "/subscriptions/{id}/resourceGroups/{group}/providers/{rpns}/{type}/{name}",
    "name": "Resource Name",
    "type": "Microsoft.ResourceProvider/type",
    "location": "North US",
    "properties": {
       "foo" : {
           "name" : "{fooA|fooB|fooC}",
           "capacity" : {number}
       },
       "bar": "flim"
    }
}
```
When the ARM payload shape is reflected directly into the client object model, the nesting of the Resource-specific 
'properties' within the 'properties' object becomes cumbersome.
```csharp
var theResource = theClient.GetResourceById(resourceId);
theResource.Properties.Foo.Name = "fooB";
theResource.Properties.Foo.Capacity = 100;
theResource.Properties.Bar = "flam";
```
To provide a **better end-user experience**, types that are identified as ARM resources are **"flattened"** in the generated C# code. 
The serialization and deserialization of Resource types hides the "properties" nesting from the user.
```csharp
var theResource = theClient.GetResourceById(resourceId);
theResource.Location = "North US";
theResource.Foo.Name = "fooB";
theResource.Foo.Capacity = 100;
```
### When will AutoRest flatten resources
If any model or its parent is marked with an extension `"x-ms-azure-resource" : true`, then AutoRest will flatten the 
Resource-specific properties by one level for that model.

### x-ms-azure-resource
In using Swagger to describe Azure Resource Manager operations, types are identified as Resources by declaring that a type 
is "allOf" the common `Resource` type. That common `Resource` type includes the `x-ms-azure-resource` Swagger extension.
```json
    "Resource": {
      "x-ms-azure-resource": true,
      "properties": {
        "id": {
          "type": "string",
          "readOnly": true,
          "description": "Resource Id"
        },
        "type": {
          "type": "string",
          "readOnly": true,
          "description": "Resource Type"
        },
        "tags": {
          "type": "object",
          "additionalProperties": {
            "type": "string"
            },
          "description": "Resource Tags"
        },
        "location": {
          "type": "string",
          "description": "Resource Location"
        },
        "name": {
          "type": "string",
          "readOnly": true,
          "description": "Resource Name"
        }
      }
    }
 ```
**Notice that the type definitions in Swagger schema use the word 'properties' to identify the 'properties' of the type. When 
looking at an ARM Resource it also has 'properties', the 'properties' term is overloaded and it looks a bit odd.**

In practice, the Resource properties may be re-used in the Swagger spec and can be defined separately. If the schema of the 
resource properties is included inline, AutoRest still needs to generate a type for the properties and does so by appending 
`Properties` to the Resource name
```json
"definitions": {
  "SomeResourceProperties": {
    "properties": {
      "bar": {
        "type": "string"
      }
    }
  },
  "SomeResource": {
    "properties": {
      "properties": {
        "$ref": "#/definitions/SomeResourceProperties"
      }
    },
    "allOf": [
      {
        "$ref": "Resource"
      }
    ]
  }
}
```
## Enums with x-ms-enum
Enum definitions in Swagger indicate that only a particular set of values may be used for a property or parameter. When 
the property is represented on the wire as a string, it would be  a natural choice to represent the property type in C# 
as an enum. However, not all enumeration values should necessarily be represented as C# enums - there are additional 
considerations, such as how often expected values might change, since adding a new value to a C# enum is a breaking change 
requiring an updated API version. Additionally, there is some metadata that is required to create a useful C# enum, such 
as a descriptive name, which is not represented in swagger.  For this reason, enums are not automatically turned into 
enum types in C# - instead they are rendered in the documentation comments for the property or parameter to indcate allowed 
values.  To indicate that an enum will rarely change and that C# enum semantics are desired, use the `x-ms-enum` exension.

In C#, an enum type is generated and is declared as the type of the related request/response object. The enum is serialized 
as the string expected by the REST API.
```json
  "accountType": {
    "type": "string",
    "enum": [
      "Standard_LRS",
      "Standard_ZRS",
      "Standard_GRS",
      "Standard_RAGRS",
      "Premium_LRS"
    ],
    "x-ms-enum": {
      "name": "AccountType",
      "modelAsString": false
    }
  }
```

### modelAsString
- true
  - When set to true the `enum` will be modeled as a `string`. No validation will happen.
- false
  - When set to false, it will be modeled as an `enum` if that language supports enums. Validation will happen, irrespective of support of enums in that language.

## Paging with x-ms-pageable
The REST API guidelines define a common pattern for paging through lists of data. The operation response is modeled in 
Swagger as the list of items and the `nextLink`. Tag the operation as `x-ms-pageable` and the generated code will include 
methods for navigating between pages.

#### x-ms-pageable extension definition
```json
{
  "x-ms-pageable" : {
    "nextLinkName": "Specify the name of the property that provides the nextLink. If your model does not have the nextLink property then specify null.",
    "itemName": "Specify the name of the property that provides the collection of pageable items. It is optional. Default value is 'value'." 
  }
}
```
#### x-ms-pageable operation definition
```json
"paths": {
  "/products": {
    "get": {
      "x-ms-pageable": {
        "nextLinkName": "nextLink"
      },
      "operationId": "products_list",
      "description": "A pageable list of Products.",
      "responses": {
        "200": {
          "schema": {
            "$ref": "#/definitions/ProductListResult"
          }
        }
      }
    }
  }
}
```
#### x-ms-pageable model definition
```json
"ProductListResult": {
  "properties": {
    "value": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/Product"
      }
    },
    "nextLink": {
      "type": "string"
    }
  }
}
```

## Control URL encoding with x-ms-skip-url-encoding
By default, `path` parameters will be URL-encoded automatically. This is a good default choice for user-provided values. 
This is not a good choice when the parameter is provided from a source where the value is known to be URL-encoded. 
The URL encoding is *NOT* an idempotent operation. For example, the percent character "%" is URL-encoded as "%25". If the 
parameter is URL-encoded again, "%25" becomes "%2525". Mark parameters where the source is KNOWN to be URL-encoded to 
prevent the automatic encoding behavior.
```json
"parameters": [
  {
    "name": "databaseName",
    "in": "path",
    "type": "string",
    "required": true,
    "x-ms-skip-url-encoding": true
  }
]
```

## Enable Asynchronous Operations with x-ms-long-running-operation
>TODO: x-ms-long-running-operation

##Global parameters
Swagger allows for parameters to be defined separately from the operation where they are used. By convention, AutoRest 
treats global parameter definitions as Client properties. For example, almost all Azure Resource Manager APIs require 
`subscriptionId` and `api-version`. These are defined as global parameters and become properties of the client.
```json
"parameters": [
  {
    "name": "subscriptionId",
    "type": "string"
  }
]
```

```csharp
var client = new MyClient();
client.SubscriptionId = "xyz-123";
```
By convention, when AutoRest sees that an operation defines a parameter as a reference to a global parameter, the generated 
method does not expose the parameter. Instead, the parameter is populated with the value from the client property.

```json
"paths": {
  "/subscriptions/{subscriptionId}/providers/MyProvider/SomeOperation": {
    "post": {
      "parameters": [{"$ref": "#/parameters/subscriptionId"}]
    }
  }
}
```
If an operation requires that a parameter is exposed as a method parameter, it is defined without referencing the global definition.
```json
"paths": {
  "/subscriptions/{subscriptionId}/providers/MyProvider/SomeOperation": {
    "post": {
      "parameters": [
        {
          "name": "subscriptionId",
          "in": "path",
          "required": true,
          "type": "string",
        }
      ]
    }
  }
}
```

## x-ms-odata
>TODO: x-ms-odata

TODO: naming standards for operations Create, CreateOrUpdate, Update (respect etag), Get, List, Delete, Patch
TODO: patch => no validate
[Swagger-spec2.0]:https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md