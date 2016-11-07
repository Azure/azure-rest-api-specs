# Swagger spec style guide

Less style guide and more "cheat sheet," the following sections describe which fields or content are currently supported by [docs.microsoft.com](http://docs.microsoft.com), the toolchain, and the [Swagger/OpenAPI specification](http://swagger.io/specification/).

This document will be updated as features and support are added to the toolchain and docs.microsoft.com. As more features and support are added, this will become more of a style guide.

## Documentation field support by object type

Not all Swagger documentation fields (summary, description, title) are supported by all Swagger object types. This is an [OpenAPI](http://swagger.io/specification/) specification restriction, not a docs.ms.com or toolchain restriction. The following table specifies which fields can be used for which object types in a Swagger *.json.

| Object type | summary | description | title |
|-------------:|:-----------:|:-----------:|:-----------:|
| [operation](http://swagger.io/specification/#operationObject) | X | X |  |
| [parameter](http://swagger.io/specification/#parameterObject) |  | X |  |
| [schema object](http://swagger.io/specification/#schemaObject) |  | X | X |

* `summary` and `title` fields are appropriate for short-form documentation of 120 characters or less.
* `description` is for long-form content, and can contain examples of use ("examples" in this context should not to be confused with the [examples](#examples-field-support) field).
* `title` is **not currently displayed** on [docs.microsoft.com](http://docs.microsoft.com).

## GitHub-flavored Markdown (GFM)

[GitHub-flavored Markdown](https://help.github.com/articles/github-flavored-markdown) (GFM) is not yet supported in the `description` field.

The Swagger specification itself supports GFM in the `description` field of several object types. However, AutoRest currently passes through GFM formatting tags directly, so `**my bolded text**` (with the asterisks) will end up in your generated clients' docs. Don't use GFM in Swagger spec descriptions **yet**.

## HTML

Do **not** put HTML tags in any of the documentation fields.

## `examples` field

You *should* populate the [examples](http://swagger.io/specification/#exampleObject) field, but it is not yet rendered on docs.microsoft.com.

## Overwrites

Not all fields support overwrites. For example, only the `summary` and `description` fields of a Swagger spec can be overwritten in REST API documentation. See the DocFx documentation for lists of which fields can be overwritten:

* [REST API](https://dotnet.github.io/docfx/tutorial/intro_overwrite_files.html#rest-api-model)
* [Managed reference](https://dotnet.github.io/docfx/tutorial/intro_overwrite_files.html#managed-reference-model)