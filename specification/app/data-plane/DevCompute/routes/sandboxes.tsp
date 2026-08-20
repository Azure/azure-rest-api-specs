using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.DevCompute;

alias DataPlaneStandardTraits = NoConditionalRequests &
  NoRepeatableRequests &
  NoClientRequestId &
  TraitOverride<VersionParameterTrait<void>>;

alias GetSandboxCountParameters = {
  @path subscriptionId: string;
  @path resourceGroupName: string;
  @path sandboxGroupName: string;
  ...ApiVersionParameter;
};

/** The request has succeeded. */
model GetSandboxCountResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response content type. */
  @header contentType: "text/plain" | "application/json" | "text/json";

  /** Total sandbox count. */
  @body body: Int32OrString;
}

alias GetSandboxCountErrors = ErrorResponse<401> | InternalServerErrorNoBody;

@tag("DataPlaneSandboxAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/count")
@get
@summary("Gets the total count of sandboxes.")
op getSandboxCount is Foundations.Operation<
  GetSandboxCountParameters,
  GetSandboxCountResponse,
  DataPlaneStandardTraits,
  GetSandboxCountErrors
>;

alias ListSandboxesParameters = {
  @path subscriptionId: string;
  @path resourceGroupName: string;
  @path sandboxGroupName: string;

  /** Page number to retrieve. */
  @minValue(1)
  @maxValue(2147483647)
  @query
  Page?: Int32OrString;

  /** Number of items to return per page. */
  @minValue(1)
  @maxValue(100)
  @query
  PageSize?: Int32OrString;

  /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
  @query labels?: string;

  ...ApiVersionParameter;
};

/** The request has succeeded. */
model ListSandboxesResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response content type. */
  @header contentType: "text/plain" | "application/json" | "text/json";

  /** Sandboxes returned by the request. */
  @body body: SandboxResponseView[];
}

alias ListSandboxesErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | InternalServerErrorNoBody;

@tag("DataPlaneSandboxAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes")
@get
@summary("Lists sandboxes with pagination support.")
op listSandboxes is Foundations.Operation<
  ListSandboxesParameters,
  ListSandboxesResponse,
  DataPlaneStandardTraits,
  ListSandboxesErrors
>;

alias DeleteSandboxParameters = {
  @path subscriptionId: string;
  @path resourceGroupName: string;
  @path sandboxGroupName: string;
  @path id: string;
  ...ApiVersionParameter;
};

/** The request has succeeded. */
model DeleteSandboxResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;
}

/** There is no content to send for this request, but the headers may be useful. */
model DeleteSandboxNoContentResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

alias DeleteSandboxErrors = ErrorResponse<401> | InternalServerErrorNoBody;

@tag("DataPlaneSandboxAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}")
@delete
@summary("Deletes a sandbox.")
op deleteSandbox is Foundations.Operation<
  DeleteSandboxParameters,
  DeleteSandboxResponse | DeleteSandboxNoContentResponse,
  DataPlaneStandardTraits,
  DeleteSandboxErrors
>;

alias GetSandboxParameters = {
  @path subscriptionId: string;
  @path resourceGroupName: string;
  @path sandboxGroupName: string;
  @path id: string;
  ...ApiVersionParameter;
};

/** The request has succeeded. */
model GetSandboxResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response content type. */
  @header contentType: "text/plain" | "application/json" | "text/json";

  /** Sandbox returned by the request. */
  @body body: SandboxResponseView;
}

alias GetSandboxErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

@tag("DataPlaneSandboxAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}")
@get
@summary("Gets a specific sandbox by ID.")
op getSandbox is Foundations.Operation<
  GetSandboxParameters,
  GetSandboxResponse,
  DataPlaneStandardTraits,
  GetSandboxErrors
>;

alias GetSandboxStatsParameters = {
  @path subscriptionId: string;
  @path resourceGroupName: string;
  @path sandboxGroupName: string;
  @path id: string;
  ...ApiVersionParameter;
};

/** The request has succeeded. */
model GetSandboxStatsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response content type. */
  @header contentType: "text/plain" | "application/json" | "text/json";

  /** Sandbox resource usage statistics. */
  @body body: SandboxStatsResponseView;
}

alias GetSandboxStatsErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

@tag("DataPlaneSandboxAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/stats")
@get
@summary("Gets resource usage statistics for a sandbox.")
op getSandboxStats is Foundations.Operation<
  GetSandboxStatsParameters,
  GetSandboxStatsResponse,
  DataPlaneStandardTraits,
  GetSandboxStatsErrors
>;

alias GenerateSandboxTokenParameters = {
  @path subscriptionId: string;
  @path resourceGroupName: string;
  @path sandboxGroupName: string;
  @path id: string;
  @query("api-version") apiVersion?: Versions;
  @header contentType: "application/json" | "text/json" | "application/*+json";
  @body body: null | SandboxGenerateTokenRequestView;
};

/** The request has succeeded. */
@removed(Versions.v2026_09_01)
model GenerateSandboxTokenResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response content type. */
  @header contentType: "text/plain" | "application/json" | "text/json";

  /** Generated sandbox execution token. */
  @body body: SandboxExecutionTokenResponseView;
}

alias GenerateSandboxTokenErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody
  | ServiceUnavailableNoBody;

@tag("DataPlaneSandboxAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/generateSandboxToken")
@post
@summary("Generates a sandbox execution token.")
@removed(Versions.v2026_09_01)
op generateSandboxToken is Foundations.Operation<
  GenerateSandboxTokenParameters,
  GenerateSandboxTokenResponse,
  DataPlaneStandardTraits,
  GenerateSandboxTokenErrors
>;

alias CreateSandboxesBatchParameters = {
  @path subscriptionId: string;
  @path resourceGroupName: string;
  @path sandboxGroupName: string;
  @query("api-version") apiVersion?: Versions;
  @header contentType: "application/json" | "text/json" | "application/*+json";
  @body body: BatchSandboxRequestView;
};

/** The request has succeeded and a new resource has been created as a result. */
@removed(Versions.v2026_09_01)
model CreateSandboxesBatchResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response content type. */
  @header contentType: "text/plain" | "application/json" | "text/json";

  /** Batch sandbox creation result. */
  @body body: BatchSandboxResponseView;
}

alias CreateSandboxesBatchErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

@tag("DataPlaneSandboxAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/batch")
@put
@summary("Creates multiple sandboxes in a single batch request.")
@removed(Versions.v2026_09_01)
op createSandboxesBatch is Foundations.Operation<
  CreateSandboxesBatchParameters,
  CreateSandboxesBatchResponse,
  DataPlaneStandardTraits,
  CreateSandboxesBatchErrors
>;
