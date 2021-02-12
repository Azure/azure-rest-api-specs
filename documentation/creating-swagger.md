# Creating Swagger (Reference documentation)
AutoRest is a tool for generating HTTP client libraries from Swagger files. This document explains the conventions 
and extensions used by AutoRest in processing Swagger to produce client libraries. The Swagger specification can 
be found at [Swagger RESTful API Documentation Specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md).

This page is intended to serve as reference documentation. If you have any questions about a specific part of a Swagger file or how AutoRest uses it to generate code, this is the correct place.

1. [Swagger](#Swagger)
2. [Info Object](#InfoObject)
3. [Host](#Host)
4. [Schemes](#Schemes)
5. [Consumes / Produces](#ConsumesProduces)
6. [Paths](#Paths)
7. [Path Item](#PathItem)
  1. [Operation and OperationId](#OperationOperationId)
  2. [Parameters](#Parameters)
    1. [Path Parameters](#PathParameters)
    2. [Query Parameters](#QueryParameters)
    3. [Body Parameters](#BodyParameters)
    4. [Header Parameters](#HeaderParameters)
    5. [FormData Parameters](#FormDataParameters)
  3. [Responses](#Responses)
    1. [Default Response](#DefaultResponse)
    2. [Negative Responses](#NegativeResponses)
8. [Defining Model Types](#DefiningModel)
  1. [Model Inheritance](#ModelInheritance)
  2. [Polymorphic Response Models](#PolymorphicResponse)
9. [ResourceFlattening](#ResourceFlattening)
  1. [Conditions](#Conditions)
  2. [x-ms-azure-resource](#x-ms-azure-resource)
10. [Enums with x-ms-enum](#Enum-x-ms-enum)
  1. [Structure](#enum-structure)
  2. [Understanding modelAsString](#modelAsString)
11. [Paging with x-ms-pageable](#Paging-x-ms-pageable)
  1. [Structure](#paging-structure)
  2. [Pageable Operation](#pageOperation)
  3. [Pageable Model](#pageModel)
12. [URL Encoding](#UrlEncoding)
13. [Long Running operation](#longrunning)
14. [Global parameters](#globalParam)

## Swagger<a name="Swagger"></a>
In this document, references to the 'spec' or to the 'swagger' refer to an instance of a Swagger file. AutoRest 
supports Swagger version 2.0. The version of Swagger being used must be included in the spec.

```json5
{
  "swagger": "2.0"
  ...
}
```

## Info Object<a name="InfoObject"></a>
Each spec includes an "info object."
The **title** field is used as the name of the generated client.
```json5
"info": {
  "title": "MyClientName",
}
```

```csharp
var client = new MyClientName();
```
Override the title client name by passing the `-ClientName` to AutoRest.
>autorest.exe -ClientName MyClientName

The version field specifies the service version of the API described in the spec. This is used as the default 
value for Azure clients where api-version is passed in the querystring.
```json5
"info": {
  "version": "2014-04-01-preview"
```

```
https://management.azure.com/...?api-version="2014-04-01-preview"
```
## Host<a name="Host"></a>
The host field specifies the baseURI. (everything after the protocol and before the path).
``` json
{
  "swagger": "2.0",
  "host": "management.azure.com"
}
```

## Schemes<a name="Schemes"></a>
The schemes field is an array of transfer protocols that can be used by individual operations. AutoRest supports 
*http* and *https*. The generated client uses the first scheme from the array.
```json5
{
  "swagger": "2.0",
  "schemes": [
    "https",
    "http"
  ]
  . . .
}
```

## Consumes / Produces<a name="ConsumesProduces"></a>
The *consumes* and *produces* fields declare the mime-types supported by the API. The root-level definition can 
be overridden by individual operations. AutoRest supports JSON payloads.
```json5
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

## Paths<a name="Paths"></a>
The paths object defines the relative paths of API endpoints (appended to the baseURI to invoke operations).
```json5
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
## Path Item<a name="PathItem"></a>
Each path item in the spec defines the operations available at that endpoint. The individual operations are 
identified by the HTTP operation (sometimes referred to as HTTP verbs). AutoRest supports: **head**, **get**, 
**put**, **post**, **delete** and **patch**.

```json5
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
### Operation and OperationId<a name="OperationOperationId"></a>
Every operation must have a unique operationId. The operationId is used to determine the generated method name.
```json5
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
```json5
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
```json5
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

### Parameters<a name="Parameters"></a>
Each operation defines the parameters that must be supplied. An operation may not require any parameters. A parameter 
defines a name, description, schema, what request element it is `in` (AutoRest supports parameters in the **path**, **query**, 
**header**, and **body** of the request) and whether or not is it `required`.

#### Path Parameters<a name="PathParameters"></a>
The value of path parameters are replaced in the templated URL path at the position specified by the name. Parameters that 
are `in` the `path` must have a `true` value for the `required` field. In this example, the `{userId}` in this operation 
is populated with the value of userId provided in the client method.
```json5
"paths": {
  "/users/{userId}": {
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

#### Query Parameters<a name="QueryParameters"></a>
Query parameters are appended to the request URI. They can be specified as required or optional.
```json5
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

#### Body Parameters<a name="BodyParameters"></a>
Body parameters include schema for the payload. In this example, the schema element is a `$ref` to the type details 
in the `#/definitions` section of the spec. More on the `#/definitions` later.
```json5
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

#### Header Parameters<a name="HeaderParameters"></a>
Header parameters are sent as part of the HTTP request header.
In general, reserved headers (`Content-Length`, `Content-Type`, ...) should not be documented since their values are derivable (e.g. from the request body) and not really part of the protocol specified by the OpenAPI definition.
Rather, they are part of the REST standard that the protocol is supposed to adhere to anyway.

However, there are rare scenarios for making the `Content-Type` customizable as part of a request, e.g. in case of a binary/stream request body.
The media type of binary request bodies is not reliably derivable: Maybe the service endpoint accepts PNG, JPEG or BMP images, which is expressed in OpenAPI using
``` yaml
consumes:
  - image/png
  - image/jpeg
  - image/bmp
```
and give the request body type `file`.
Now, when a request is made, the protocol has to somehow communicate to the server which of the media types the body has.
Since there is a range of possibilities (and it's certainly not a protocol's job to parse and classify binary data), we suggest adding a `Content-Type` header parameter to the operation's definition.
Unless one provides an `enum` restriction for that parameter, [AutoRest](https://github.com/Azure/autorest) will automatically make the parameter an enum with values drawn from the `consumes` declaration.
This allows for deduplication and hence prevents potential bugs.
More information on how [AutoRest](https://github.com/Azure/autorest) treats a `Content-Type` header parameter can be found [here](https://github.com/Azure/autorest/tree/master/Samples/test/stream-with-content-type).

#### FormData Parameters<a name="FormDataParameters"></a>
>Note: FormData parameters are not currently supported by AutoRest.

### Responses<a name="Responses"></a>
Each operation defines the possible responses by HTTP status code:
```json5
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

#### Default Response<a name="DefaultResponse"></a>
Swagger allows for specifying a `default` response. AutoRest treats the `default` response as defining an error 
response status code unless `default` is the only status code defined. The reason for imposing this convention is 
to produce higher quality API signatures. The return type of the generated API is determined by finding a common 
base type of the success responses. In practice, if the default is considered as a potential success definition, 
the common ancestor of success responses and error responses ends up being Object.

### Negative Responses<a name="NegativeResponses"></a>
You can describe all the [possible HTTP Response status codes](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html) in the responses section of an operation. AutoRest generated code will deserialize the response for all the described response status codes as per their definition in the swagger. If a response status code is not defined then generated code will align to the default response behavior as described above.
- If **a schema is provided** for the negative response codes then this will have an impact on the return type of the generated method. 
  - For example: if a schema was provided for 200, and 400 was also described with a schema then,
    - the **return type** would be the Common Ancestor of both the schemas. In most cases there is nothing common between a positive and a negative response code. Hence the return type will be an `Object`. Note:This may not be very helpful to the customer
    - an exception **will NOT be thrown for 400** and the generated method will deserialize the response body as per the schema of "400".
    - any other negative response code will be treated as per the "default" response status code defined in the swagger for that operation.
- If **a schema is NOT provided** for the negative response codes then this will **NOT** have an impact on the return type of the generated method.
  - For example: if a schema was provided for 200 and 404 was described as one of the responses. However, 404 does not have a schema. In this scenario,
    - the **return type** of the generated method will be based upon the schema defined in "200".
    - an **exception will NOT be thrown** for 404 response status code
    - any other negative response code will be treated as per the "default" response status code defined in the swagger for that operation.
```json5
"/users/{userId}": {
  "get": {
    "operationId": "users_getUserById",
    "responses": {
      "200": {
       "description": "Provides User Information.",
        "schema": {
          "$ref": "#/definitions/user"
        }
      },
      "400": {
        "description": "Bad Request. ResponseBody will be deserialized as per the Error definition 
                        mentioned in schema. Exception will not be thrown.",
        "schema": {
          "$ref": "#/definitions/Error"
        }
      },
      "404": {
        "description": "Resource Not Found, ResponseBody will be null as there is no schema definition.
                        Exception will not be thrown.",
      },
      "default": {
        "description": "Default Response. It will be deserialized as per the Error definition 
                        specified in the schema. Exception will be thrown.",
        "schema": {
          "$ref": "#/definitions/Error"
        }
      }
    }
  }
}
```
### Custom Paths<a name="CustomPaths"></a>
Swagger 2.0 has a built-in limitation on paths. Only one operation can be mapped to a path and http method. There are some APIs, however, where multiple distinct operations are mapped to the same path and same http method. For example `GET /mypath/query-drive?op=file` and `GET /mypath/query-drive?op=folder` may return two different model types (stream in the first example and JSON model representing Folder in the second). Since Swagger does not treat query parameters as part of the path the above 2 operations may not co-exist in the standard "paths" element.

To overcome this limitation an "x-ms-paths" extension was introduced parallel to "paths". Urls under "x-ms-paths" are allowed to have query parameters for disambiguation, however they are removed during model parsing.

```json5
"paths":{
   "/pets": {
        "get": {
            "parameters": [
                {
                     "name": "name",
                     "required": true
                }
            ]
        }
   }
},
"x-ms-paths":{   
   "/pets?color={color}": {
        "get": {}
   },
}

```

Please note, that the use of "x-ms-paths" should be minimized to the above scenarios. Since any metadata inside the extension is not part of the default swagger specification, it will not be available to non-AutoRest tools.

## Defining Model Types<a name="DefiningModel"></a>
The request body and response definitions become simple model types in the generated code. The models include 
basic validation methods, but are generally stateless serialization definitions.

### Understanding the importance of "type" keyword while defining model types.
"Type-specific" keywords such as properties, items, minLength, etc. do not enforce a type on the schema. It works the other way around – when an instance is validated against a schema, these keywords only apply when the instance is of the corresponding type, otherwise they are ignored. Here's the relevant part of the [JSON Schema Validation](https://tools.ietf.org/html/draft-fge-json-schema-validation-00#section-4.1) spec:

> 4.1. Keywords and instance primitive types
Some validation keywords only apply to one or more primitive types. When the primitive type of the instance cannot be validated by a given keyword, validation for this keyword and instance SHOULD succeed.

For example, consider this schema:

```yaml
definitions:
  Something:
    properties:
      id:
        type: integer
    required: [id]
    minLength: 8
```
It's a valid schema, even though it combines object-specific keywords properties and required and string-specific keyword minLength. This schema means:
- If the instance is an object, it must have an integer property named id. For example, `{"id": 4}` and `{"id": -1, "foo": "bar"}` are valid, but `{}` and `{"id": "ACB123"}` are not.
- If the instance is a string, it must contain at least 8 characters. `"Hello, world!"` is valid, but `""` and `abc` are not.
- Any instances of other types are valid - `true`, `false`, `-1.234`, `[]`, `[1, 2, 3]`, `[1, "foo", true]`, etc.
(Except `null` - OpenAPI 2.0 does not have the `null` type and does not support `null` except in extension properties. OpenAPI 3.0 supports the `null` value for schemas with nullable: true.)

If there are tools that infer the `type` from other keywords (for example, handle schemas with no `type` but with `properties` as always objects), then these tools are not exactly following the OpenAPI Specification and JSON Schema.

> Bottom line: If a schema must always be an object, add `"type": "object"` explicitly. Otherwise you might get unexpected results.

**Credits** - Stack Overflow [link](https://stackoverflow.com/questions/47374980/schema-object-without-a-type-attribute-in-swagger-2-0).

### Model Inheritance<a name="ModelInheritance"></a>
Swagger schema allows for specifying that one type is `allOf` other types, meaning that the entire specification of 
the referenced schema applies is included in the new schema. By convention, if a schema has an 'allOf' that references 
only one other schema, AutoRest treats this reference as an indication that the `allOf` schema represents a base 
type being extended. In this example, the generated code would include a `Dog` model that inherits from the `Pet` model.

```json5
{
  "definitions": {
    "pet": {
      "description": "Defines the Pet model.",
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
      "description": "Defines the Dog model.",
      "required": [
        "breed"
      ],
      "properties": {
        "breed": {
          "type": "string"
        }
      },
      "allOf": [
        {
          "$ref": "#/definitions/pet"
        }
      ]
    }
  }
}
```

### Polymorphic Response Models<a name="PolymorphicResponse"></a>
Besides using `allOf` to define inheritance, model definitions can indicate that the payload will include a `discriminator` 
to disambiguate polymorphic payloads. The discriminator field allows the deserializer to resolve into an instance of a more 
specific type. Suppose the Dog and Cat type are `allOf` Pet and an operation will return a Dog or a Cat. If the Pet definition 
includes a `discriminator` then payloads can be Dog or Cat. A response can be defined as a Pet model and the API signature 
will indicate Pet. At runtime, the returned object is an instance of the more specific type.
```json5
{
  "definitions": {
    "Pet": {
      "type": "object",
      "discriminator": "petType",
      "properties": {
        "name": {
          "type": "string"
        },
        "petType": {
          "type": "string"
        }
      },
      "required": [
        "name",
        "petType"
      ]
    },
    "Cat": {
      "description": "A representation of a cat",
      "allOf": [
        {
          "$ref": "#/definitions/Pet"
        },
        {
          "type": "object",
          "properties": {
            "huntingSkill": {
              "type": "string",
              "description": "The measured skill for hunting",
              "default": "lazy",
              "enum": [
                "clueless",
                "lazy",
                "adventurous",
                "aggressive"
              ]
            }
          },
          "required": [
            "huntingSkill"
          ]
        }
      ]
    },
    "Dog": {
      "description": "A representation of a dog",
      "allOf": [
        {
          "$ref": "#/definitions/Pet"
        },
        {
          "type": "object",
          "properties": {
            "packSize": {
              "type": "integer",
              "format": "int32",
              "description": "the size of the pack the dog is from",
              "default": 0,
              "minimum": 0
            }
          },
          "required": [
            "packSize"
          ]
        }
      ]
    }
  }
}
```

## Defining Azure Resource Types with x-ms-azure-resource (Resource Flattening)<a name="ResourceFlattening"></a>
Azure Resource Manager brings a common pattern that is leveraged to provide a more consistent programming model for users. 
Resource types all have a common set of Resource properties: id, name, location, tags...
In a resource payload, the common properties are at the top-level and the resource-specific properties are nested within 
`properties`. The top-level outer properties are sometimes referred to as the 'ARM envelope' and the inner data as the 'Resource properties.'
```json5
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
### When will AutoRest flatten resources?<a name="Conditions"></a>
If any model or its parent is marked with an extension `"x-ms-azure-resource" : true`, then AutoRest will flatten the 
Resource-specific properties by one level for that model.

### x-ms-azure-resource<a name="x-ms-azure-resource"></a>
In using Swagger to describe Azure Resource Manager operations, types are identified as Resources by declaring that a type 
is "allOf" the common `Resource` type. That common `Resource` type includes the `x-ms-azure-resource` Swagger extension.
```json5
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
```json5
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
## Enums with x-ms-enum<a name="Enum-x-ms-enum"></a>
Enum definitions in Swagger indicate that only a particular set of values may be used for a property or parameter. When 
the property is represented on the wire as a string, it would be  a natural choice to represent the property type in C# 
as an enum. However, not all enumeration values should necessarily be represented as C# enums - there are additional 
considerations, such as how often expected values might change, since adding a new value to a C# enum is a breaking change 
requiring an updated API version. Additionally, there is some metadata that is required to create a useful C# enum, such 
as a descriptive name, which is not represented in swagger.  For this reason, enums are not automatically turned into 
enum types in C# - instead they are rendered in the documentation comments for the property or parameter to indicate allowed 
values.  To indicate that an enum will rarely change and that C# enum semantics are desired, use the `x-ms-enum` extension.

In C#, an enum type is generated and is declared as the type of the related request/response object. The enum is serialized 
as the string expected by the REST API.
```json5
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

### x-ms-enum extension structure <a name="enum-structure"></a>
```json5
{
  "x-ms-enum": {
    "name" : "Specify the name for the Enum."
    "modelAsString": "true/false."
  }
}
```
### modelAsString<a name="modelAsString"></a>
- **true**
  - When set to `true` the `enum` will be modeled as a `string`. No validation will happen.
- **false**
  - When set to `false`, it will be modeled as an `enum` if that language supports enums. Validation will happen, irrespective of support of enums in that language.

## Paging with x-ms-pageable<a name="Paging-x-ms-pageable"></a>
The REST API guidelines define a common pattern for paging through lists of data. The operation response is modeled in 
Swagger as the list of items and the `nextLink`. Tag the operation as `x-ms-pageable` and the generated code will include 
methods for navigating between pages.

#### x-ms-pageable extension structure<a name="paging-structure"></a>
```json5
{
  "x-ms-pageable" : {
    "nextLinkName": "Specify the name of the property that provides the nextLink. 
                     If your model does not have the nextLink property then specify null.",
    "itemName": "Specify the name of the property that provides the collection 
                 of pageable items. It is optional. Default value is 'value'.",
    "operationName": "Specify the name of the Next operation. It is optional. Default value is 'XXXNext' where XXX is the name of the operation." 
  }
}
```
#### x-ms-pageable operation definition<a name="pageOperation"></a>
```json5
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
#### x-ms-pageable model definition<a name="pageModel"></a>
```json5
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

## Control URL encoding with x-ms-skip-url-encoding<a name="UrlEncoding"></a>
By default, `path` parameters will be URL-encoded automatically. This is a good default choice for user-provided values. 
This is not a good choice when the parameter is provided from a source where the value is known to be URL-encoded. 
The URL encoding is *NOT* an idempotent operation. For example, the percent character "%" is URL-encoded as "%25". If the 
parameter is URL-encoded again, "%25" becomes "%2525". Mark parameters where the source is KNOWN to be URL-encoded to 
prevent the automatic encoding behavior.
```json5
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

## Enable Asynchronous Operations with x-ms-long-running-operation<a name="longrunning"></a>
Some requests like creating/deleting a resource cannot be carried out immediately. In such a situation, the server 
sends a 201 (Created) or 202 (Accepted) and provides a link to monitor the status of the request. When such an operation 
is marked with extension `"x-ms-long-running-operation": true,` in Swagger, the generated code will know how to fetch 
the link to monitor the status. It will keep on polling at regular intervals till the request reaches one of the 
terminal states`Succeeded|Failed|Canceled`.
```json5
"paths": {
  "/products/{name}": {
    "put": {
      "operationId": "products_create",
      "x-ms-long-running-operation": true,
      "description": "A pageable list of Products.",
      "parameters": [
        {
          "name": "name",
          "in": "path",
          "required": true,
          "type": "string",
          "description": "The name of the Product."
        },
        {
          "name": "parameters",
          "in": "body",
          "required": true,
          "schema": {
            "$ref": "#/definitions/ProductCreateParameters"
          },
          "description": "The parameters to provide for the created product."
        }
      ],
      "responses": {
        "200": {
          "schema": {
            "$ref": "#/definitions/Product"
          }
        },
        "202": {
          "description": ""
        }
      }
    }
  }
}
```

## Global parameters<a name="globalParam"></a>
Swagger allows for parameters to be defined separately from the operation where they are used. By convention, AutoRest 
treats global parameter definitions as Client properties. For example, almost all Azure Resource Manager APIs require 
`subscriptionId` and `api-version`. These are defined as global parameters and become properties of the client.
```json5
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

```json5
"paths": {
  "/subscriptions/{subscriptionId}/providers/MyProvider/SomeOperation": {
    "post": {
      "parameters": [{"$ref": "#/parameters/subscriptionId"}]
    }
  }
}
```
If an operation requires that a parameter is exposed as a method parameter, it is defined without referencing the global definition.
```json5
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
[Swagger-spec2.0](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md)
