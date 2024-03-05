// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "./errors.tsp";
import "./patches.tsp";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest.Resource;

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

op CommonOperation<TParams, TResponse, TError = RestError>(
  ...CommonParams,
  ...TParams,
): RestResponse<TResponse, 200, TError>;

op CreateOperation<TResource, TParams, TError = RestError>(
  ...CommonParams,
  ...TParams,
): RestResponse2<TResource, 200, TResource, 201, TError>;

op PatchOperation<TResource, TParams, TError = RestError>(
  ...CommonParams,
  ...TParams,

  @doc("HTTP body content type.")
  @header
  contentType: "application/merge-patch+json",

  @doc("A JSONPatch document as defined by RFC 6902.")
  @body
  body: PatchRequest,
): RestResponse2<TResource, 200, {}, 204, TError>;

op CancelOperation<TResource, TParams, TError = RestError>(
  ...CommonParams,
  ...TParams,
): RestResponse<TResource, 204, TError>;

op GetOperation<TResource, TParams, TError = RestError>(
  ...CommonParams,
  ...TParams,
): RestResponse<TResource, 200, TError>;

op ActionOperation<TResource, TParams, TError = RestError>(
  ...CommonParams,
  ...TParams,
): RestResponse<TResource, 200, TError>;

@extension(
  "x-ms-pageable",
  {
    nextLinkName: "nextLink",
  }
)
op ListOperation<TResourceList, TParams = {}, TError = RestError>(
  ...CommonParams,
  ...TParams,
): RestResponse<TResourceList, 200, TError>;
