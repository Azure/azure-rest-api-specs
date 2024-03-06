// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

import "./errors.tsp";
import "./patches.tsp";
import "./params.tsp";
import "./versions.tsp";

using OpenAPI;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Rest.Resource;
using Azure.Core;
using Azure.Core.Traits;

@error
@doc("Error information returned by the API")
@defaultResponse
model RestError {
  @visibility("read")
  @doc("Details of the error")
  error: ErrorData;

  @header("x-ms-error-code")
  @extension("x-ms-client-name", "ErrorCode")
  @doc("ErrorCode of the error")
  errorCode: string;
}

alias StandardServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias AzureCoreOperations = Azure.Core.ResourceOperations<
  StandardServiceTraits,
  RestError
>;

alias RestResponseBody<TBody, TStatusCode extends int32 = 200> = {
  @doc("HTTP response status code.")
  @statusCode
  statusCode: TStatusCode;

  @doc("HTTP response body.")
  @body
  result: TBody;
};

union RestResponse<TBody, TStatusCode extends int32 = 200, TError = RestError> {
  @doc("REST API response body.")
  body: RestResponseBody<TBody, TStatusCode>,

  @doc("REST API error details.")
  error: TError,
}

union RestResponse2<
  TBody1,
  TStatusCode1 extends int32,
  TBody2,
  TStatusCode2 extends int32,
  TError = RestError
> {
  @doc("REST API response body 1.")
  body1: RestResponseBody<TBody1, TStatusCode1>,

  @doc("REST API response body 2.")
  body2: RestResponseBody<TBody2, TStatusCode2>,

  @doc("REST API error details.")
  error: TError,
}

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.BaseOperations {
  @doc("Operation with common parameters, OK and ERROR responses.")
  op CommonOperation<
    TParams extends TypeSpec.Reflection.Model,
    TResponse extends TypeSpec.Reflection.Model,
    TError extends TypeSpec.Reflection.Model = RestError
  >(...CommonParams, ...TParams): RestResponse<TResponse, 200, TError>;

  @doc("Operation to create a resource.")
  op CreateOperation<
    TResource extends TypeSpec.Reflection.Model,
    TParams extends TypeSpec.Reflection.Model,
    TError extends TypeSpec.Reflection.Model = RestError
  >(...CommonParams, ...TParams): RestResponse2<
    TResource,
    200,
    TResource,
    201,
    TError
  >;

  // Suppressing warnings due to backward compatibility with
  // service and Swagger.
  #suppress "@azure-tools/typespec-azure-core/request-body-problem"
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Operation to patch a resource.")
  op PatchOperation<
    TResource extends TypeSpec.Reflection.Model,
    TParams extends TypeSpec.Reflection.Model,
    TError extends TypeSpec.Reflection.Model = RestError
  >(
    ...CommonParams,
    ...TParams,

    @doc("HTTP body content type.")
    @header
    contentType: "application/merge-patch+json",

    @doc("A JSONPatch document as defined by RFC 6902.")
    @body
    body: PatchRequest,
  ): RestResponse2<TResource, 200, {}, 204, TError>;

  @doc("Operation to cancel a resource.")
  op CancelOperation<
    TResource extends TypeSpec.Reflection.Model,
    TParams extends TypeSpec.Reflection.Model,
    TError extends TypeSpec.Reflection.Model = RestError
  >(...CommonParams, ...TParams): RestResponse<TResource, 204, TError>;

  @doc("Operation to get a resource.")
  op GetOperation<
    TResource extends TypeSpec.Reflection.Model,
    TParams extends TypeSpec.Reflection.Model,
    TError extends TypeSpec.Reflection.Model = RestError
  >(...CommonParams, ...TParams): RestResponse<TResource, 200, TError>;

  @doc("Operation to act on a resource.")
  op ActionOperation<
    TResource extends TypeSpec.Reflection.Model,
    TParams extends TypeSpec.Reflection.Model,
    TError extends TypeSpec.Reflection.Model = RestError
  >(...CommonParams, ...TParams): RestResponse<TResource, 200, TError>;

  @extension(
    "x-ms-pageable",
    {
      nextLinkName: "nextLink",
    }
  )
  @doc("Operation to list a resource.")
  op ListOperation<
    TResourceList extends TypeSpec.Reflection.Model,
    TParams extends TypeSpec.Reflection.Model = {},
    TError extends TypeSpec.Reflection.Model = RestError
  >(...CommonParams, ...TParams): RestResponse<TResourceList, 200, TError>;
}
