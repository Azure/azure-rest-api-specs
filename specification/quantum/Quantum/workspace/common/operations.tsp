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
  error: ErrorData;

  @header("x-ms-error-code")
  @extension("x-ms-client-name", "ErrorCode")
  ErrorCode: string;
}

alias RestResponseBody<TBody, TStatusCode extends int32 = 200> = {
  @statusCode statusCode: TStatusCode;
  @body result: TBody;
};

union RestResponse<TBody, TStatusCode extends int32 = 200, TError = RestError> {
  body: RestResponseBody<TBody, TStatusCode>,
  error: TError,
}

union RestResponse2<
  TBody1,
  TStatusCode1 extends int32,
  TBody2,
  TStatusCode2 extends int32,
  TError = RestError
> {
  body1: RestResponseBody<TBody1, TStatusCode1>,
  body2: RestResponseBody<TBody2, TStatusCode2>,
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
  @header contentType: "application/merge-patch+json",

  @doc("A JSONPatch document as defined by RFC 6902")
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
