using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Standard Azure Core traits for Azure Container Apps Sandbox operations without conditional, repeatable, or client request ID semantics. */
alias DataPlaneStandardTraits = NoConditionalRequests &
  NoRepeatableRequests &
  NoClientRequestId;

/** Response containing the total number of resources in a scope. */
model CountResponse {
  /** Total number of resources. */
  count: int32;
}

/** A standard Azure error response for a bad request. */
@error
model BadRequestErrorResult {
  /** The HTTP 400 status code. */
  @statusCode statusCode: 400;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response for an unauthorized request. */
@error
model UnauthorizedErrorResult {
  /** The HTTP 401 status code. */
  @statusCode statusCode: 401;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response when a resource is not found. */
@error
model NotFoundErrorResult {
  /** The HTTP 404 status code. */
  @statusCode statusCode: 404;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response for a resource conflict. */
@error
model ConflictErrorResult {
  /** The HTTP 409 status code. */
  @statusCode statusCode: 409;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response for a failed precondition. */
@error
model PreconditionFailedErrorResult {
  /** The HTTP 412 status code. */
  @statusCode statusCode: 412;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response when the request body is too large. */
@error
model RequestBodyTooLargeErrorResult {
  /** The HTTP 413 status code. */
  @statusCode statusCode: 413;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response when too many requests are sent. */
@error
model TooManyRequestsErrorResult {
  /** The HTTP 429 status code. */
  @statusCode statusCode: 429;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response for an internal server error. */
@error
model InternalServerErrorResult {
  /** The HTTP 500 status code. */
  @statusCode statusCode: 500;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response when the service is unavailable. */
@error
model ServiceUnavailableErrorResult {
  /** The HTTP 503 status code. */
  @statusCode statusCode: 503;

  ...Foundations.ErrorResponse;
}

/** Azure resource scope shared by Azure-scoped resource routes. */
model AzureResourceScope {
  /** Azure subscription identifier. */
  @path subscriptionId: string;

  /** Azure resource group name. */
  @path resourceGroupName: string;

  /** Sandbox group name. */
  @path sandboxGroupName: string;
}

/** Subscription scope for resource routes. */
@resource("subscriptions")
model SubscriptionScope {
  /** Azure subscription identifier. */
  @key
  @visibility(Lifecycle.Read)
  subscriptionId: string;
}

/** Resource group scope for resource routes. */
@resource("resourceGroups")
@parentResource(SubscriptionScope)
model ResourceGroupScope {
  /** Azure resource group name. */
  @key
  @visibility(Lifecycle.Read)
  resourceGroupName: string;
}

/** Sandbox group scope for resource routes. */
@resource("sandboxGroups")
@parentResource(ResourceGroupScope)
model SandboxGroupScope {
  /** Sandbox group name. */
  @key
  @visibility(Lifecycle.Read)
  sandboxGroupName: string;
}

/** An HTTP entity tag and its comparison strength. */
model EntityTagHeaderValue {
  /** The entity tag value. */
  tag?: StringSegment;

  /** Whether the entity tag uses weak comparison. */
  isWeak?: boolean;
}

/** An absolute directory path within a sandbox. */
scalar AbsoluteDirectoryPath extends string;

/** An absolute file path within a sandbox. */
scalar AbsoluteFilePath extends string;

/** A connection identifier. */
scalar ConnectionId extends string;

/** A sandbox identifier. */
scalar SandboxId extends string;

/** A segment of a string. */
model StringSegment {
  /** The source string. */
  buffer?: string;

  /** The zero-based start position in the source string. */
  offset?: int32;

  /** The number of characters in the segment. */
  length?: int32;

  /** The segment value. */
  value?: string;

  /** Whether the segment contains a value. */
  hasValue?: boolean;
}
