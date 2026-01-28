import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Azure.AI.Projects;

using Azure.Core.Experimental;
using Azure.Core.Traits;
using TypeSpec.OpenAPI;
using TypeSpec.Http;

/** Error response for API failures. */
@error
model ApiErrorResponse {
  error: ApiError;
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(OpenAI.Error,
  {
    details?: OpenAI.Error[],
    additionalInfo?: Record<unknown>,
    debugInfo?: Record<unknown>,
  }
);

alias FoundryDataPlaneAzureTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests &
  FoundryDataPlaneApiVersionParameter;

alias FoundryAzureOperations<ExtraTraits> = Azure.Core.ResourceOperations<ExtraTraits &
  FoundryDataPlaneAzureTraits>;

alias ApiError = OpenAI.Error;

alias FoundryDataPlaneApiVersionParameter = {
  @doc("The API version to use for this operation.")
  @query("api-version")
  apiVersion: string;
};

alias AcceptJsonHeader = {
  @header accept: "application/json";
};

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
op FoundryDataPlaneOperation<
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
>(...Params, ...FoundryDataPlaneApiVersionParameter): Response | ErrorResponse;

enum FoundryPreviewOptInKeys {
  container_agents_v1: "ContainerAgents=v1",
  hosted_agents_v1: "HostedAgents=v1",
  workflow_agents_v1: "WorkflowAgents=v1",
  evaluations_v1: "Evaluations=v1",
  red_teams_v1: "RedTeams=v1",
  insights_v1: "Insights=v1",
  memory_stores_v1: "MemoryStores=v1",
}

alias WithRequiredFoundryPreviewHeader<RequiredPreviewOptInHeader extends FoundryPreviewOptInKeys> = {
  /**
   * A feature flag opt-in required when using preview operations or modifying persisted preview resources.
   */
  @header("Foundry-Beta")
  foundry_beta: RequiredPreviewOptInHeader;
};

alias WithConditionalFoundryPreviewHeader<FeatureOptInHeaders> = {
  /**
   * A feature flag opt-in required when using preview operations or modifying persisted preview resources.
   */
  @header("Foundry-Beta")
  foundry_beta?: FeatureOptInHeaders;
};

alias FoundryPreviewExtensionKey = "x-ms-foundry-meta";

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
op FoundryDataPlanePreviewOperation<
  AreaPreviewLabel,
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
> is FoundryDataPlaneOperation<
  {
    ...WithConditionalFoundryPreviewHeader<AreaPreviewLabel>;
    ...Params;
  },
  Response,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
op OpenAIOperation<
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
>(...Params): Response | ErrorResponse;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
op OpenAIOperationWithPreview<
  AreaPreviewLabel,
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
>(
  ...WithConditionalFoundryPreviewHeader<AreaPreviewLabel>,
  ...Params,
): Response | ErrorResponse;

@doc("The response data for a requested list of items.")
model AgentsPagedResult<T> {
  /** The requested list of items. */
  @pageItems
  data: T[];

  /** The first ID represented in this list. */
  first_id?: string;

  /** The last ID represented in this list. */
  @continuationToken
  last_id?: string;

  /** A value indicating whether there are additional values available not captured in this list. */
  has_more: boolean;
}

alias AssetBase = {
  @doc("Asset ID, a unique identifier for the asset")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The name of the resource")
  @visibility(Lifecycle.Read)
  @key
  name: string;

  @doc("The version of the resource")
  @visibility(Lifecycle.Read)
  version: string;

  @doc("The asset description text.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
};

alias ResourceCreatedResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<201> &
  T;

alias OkResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<200> &
  T;

alias PageLimitQueryParameter = {
  /**
   * A limit on the number of objects to be returned. Limit can range between 1 and 100, and the
   * default is 20.
   */
  @query limit?: int32 = 20;
};

union PageOrder {
  "asc",
  "desc",
}

alias PageOrderQueryParameter = {
  /**
   * Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and`desc`
   * for descending order.
   */
  @query order?: PageOrder;
};

alias PageAfterQueryParameter = {
  /**
   * A cursor for use in pagination. `after` is an object ID that defines your place in the list.
   * For instance, if you make a list request and receive 100 objects, ending with obj_foo, your
   * subsequent call can include after=obj_foo in order to fetch the next page of the list.
   */
  @query @continuationToken after?: string;
};

alias PageBeforeQueryParameter = {
  /**
   * A cursor for use in pagination. `before` is an object ID that defines your place in the list.
   * For instance, if you make a list request and receive 100 objects, ending with obj_foo, your
   * subsequent call can include before=obj_foo in order to fetch the previous page of the list.
   */
  @query before?: string;
};

alias CommonPageQueryParameters = {
  ...PageLimitQueryParameter;
  ...PageOrderQueryParameter;
  ...PageAfterQueryParameter;
  ...PageBeforeQueryParameter;
};

model MetadataPropertyForRequest {
  /**
   * Set of 16 key-value pairs that can be attached to an object. This can be
   * useful for storing additional information about the object in a structured
   * format, and querying for objects via API or the dashboard.
   *
   * Keys are strings with a maximum length of 64 characters. Values are strings
   * with a maximum length of 512 characters.
   */
  @extension("x-oaiTypeLabel", "map")
  metadata?: Record<string>;
}
model MetadataPropertyForResponse {
  /**
   * Set of 16 key-value pairs that can be attached to an object. This can be
   * useful for storing additional information about the object in a structured
   * format, and querying for objects via API or the dashboard.
   *
   * Keys are strings with a maximum length of 64 characters. Values are strings
   * with a maximum length of 512 characters.
   */
  @extension("x-oaiTypeLabel", "map")
  metadata: Record<string> | null;
}

alias SseResponseOf<T> = {
  @header("Content-Type") contentType: "text/event-stream";
  @body responseBody: T;
};
