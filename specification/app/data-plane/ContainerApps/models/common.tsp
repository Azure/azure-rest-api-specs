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
  /** HTTP response status code. */
  @statusCode statusCode: 400;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response for an unauthorized request. */
@error
model UnauthorizedErrorResult {
  /** HTTP response status code. */
  @statusCode statusCode: 401;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response when a resource is not found. */
@error
model NotFoundErrorResult {
  /** HTTP response status code. */
  @statusCode statusCode: 404;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response for a resource conflict. */
@error
model ConflictErrorResult {
  /** HTTP response status code. */
  @statusCode statusCode: 409;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response for a failed precondition. */
@error
model PreconditionFailedErrorResult {
  /** HTTP response status code. */
  @statusCode statusCode: 412;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response when the request body is too large. */
@error
model RequestBodyTooLargeErrorResult {
  /** HTTP response status code. */
  @statusCode statusCode: 413;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response when too many requests are sent. */
@error
model TooManyRequestsErrorResult {
  /** HTTP response status code. */
  @statusCode statusCode: 429;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response for an internal server error. */
@error
model InternalServerErrorResult {
  /** HTTP response status code. */
  @statusCode statusCode: 500;

  ...Foundations.ErrorResponse;
}

/** A standard Azure error response when the service is unavailable. */
@error
model ServiceUnavailableErrorResult {
  /** HTTP response status code. */
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

/** EntityTagHeaderValue wire model. */
model EntityTagHeaderValue {
  /** tag value. */
  tag?: StringSegment;

  /** isWeak value. */
  isWeak?: boolean;
}

/** AbsoluteDirectoryPath wire model. */
scalar AbsoluteDirectoryPath extends string;

/** AbsoluteFilePath wire model. */
scalar AbsoluteFilePath extends string;

/** Strongly-typed connection identifier. ConnectionId is intentionally string-based rather than Guid-based because existing Cosmos DB documents contain connection IDs in mixed formats — some with hyphens (Guid "D" format: a1b2c3d4-e5f6-...) and some without (Guid "N" format: a1b2c3d4e5f6...). Converting to a Guid-backed typed ID would normalize all lookups to the "D" format via Guid.ToString(), breaking reads/deletes of documents stored with the "N" format since Cosmos DB performs exact string matching on document IDs. */
scalar ConnectionId extends string;

/** SandboxId wire model. */
scalar SandboxId extends string;

/** StringSegment wire model. */
model StringSegment {
  /** buffer value. */
  buffer?: string;

  /** offset value. */
  offset?: int32;

  /** length value. */
  length?: int32;

  /** value value. */
  value?: string;

  /** hasValue value. */
  hasValue?: boolean;
}
