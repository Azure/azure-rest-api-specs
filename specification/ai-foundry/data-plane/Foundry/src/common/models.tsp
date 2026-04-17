namespace Azure.AI.Projects;

using Azure.Core.Experimental;
using Azure.Core.Traits;
using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Versioning;

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

/** Feature opt-in keys for agent definition operations supporting hosted or workflow agents. */
union AgentDefinitionOptInKeys {
  hosted_agents_v1_preview: "HostedAgents=V1Preview",
  workflow_agents_v1_preview: "WorkflowAgents=V1Preview",

  @removed(Versions.v1)
  container_agents_v1_preview: "ContainerAgents=V1Preview",
}

union FoundryFeaturesOptInKeys {
  evaluations_v1_preview: "Evaluations=V1Preview",
  schedules_v1_preview: "Schedules=V1Preview",
  red_teams_v1_preview: "RedTeams=V1Preview",
  insights_v1_preview: "Insights=V1Preview",
  memory_stores_v1_preview: "MemoryStores=V1Preview",
}

alias WithRequiredFoundryPreviewHeader<RequiredPreviewOptInHeader extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys> = {
  /**
   * A feature flag opt-in required when using preview operations or modifying persisted preview resources.
   */
  @header("Foundry-Features")
  foundry_features: RequiredPreviewOptInHeader;
};

alias WithConditionalFoundryPreviewHeader<OptionalPreviewOptInHeader extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys> = {
  /**
   * A feature flag opt-in required when using preview operations or modifying persisted preview resources.
   */
  @header("Foundry-Features")
  foundry_features?: OptionalPreviewOptInHeader;
};

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
op FoundryDataPlanePreviewOperation<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys,
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
  AreaPreviewLabel extends FoundryFeaturesOptInKeys,
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

alias MetadataPropertyForRequest = {
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
};
alias MetadataPropertyForResponse = {
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
};

alias SseResponseOf<T> = {
  @header("Content-Type") contentType: "text/event-stream";
  @body responseBody: T;
};

// ============================================================================
// Shared Job Sources
//
// Source types shared across job types (evaluator generation, data generation,
// and future job types such as optimization). Placed in common to avoid
// duplication across job-specific model files.
// ============================================================================

@doc("The supported source types for jobs.")
union JobSourceType {
  string,

  @doc("Prompt source — inline text provided by the user.")
  Prompt: "Prompt",

  @doc("Agent source — references an agent to fetch instructions and metadata from.")
  Agent: "Agent",

  @doc("Traces source — conversation traces from Application Insights, specified by agent name and time window.")
  Traces: "Traces",

  @doc("Dataset source — reference to a dataset.")
  Dataset: "Dataset",
}

@doc("The base source model for jobs.")
@discriminator("type")
model JobSource {
  @doc("The type of source.")
  type: JobSourceType;

  @doc("Optional description of what this source represents — helps the pipeline interpret its content (e.g., 'Company refund policy document' or 'Describes the agent's core capabilities').")
  purpose?: string;
}

@doc("Prompt source — inline text provided by the user.")
model PromptJobSource extends JobSource {
  @doc("The source type for this source, which is Prompt.")
  type: "Prompt";

  @doc("Inline prompt text (e.g., agent description, policy text, supplementary context).")
  prompt: string;
}

@doc("Agent source — references an agent to fetch instructions and metadata from. Optionally includes supplementary prompt text to augment the agent's instructions.")
model AgentJobSource extends JobSource {
  @doc("The source type for this source, which is Agent.")
  type: "Agent";

  @doc("The agent name to fetch instructions from.")
  agent_name: string;

  @doc("The agent version. If not specified, the latest version is used.")
  agent_version?: string;

  @doc("Optional supplementary prompt text to augment the agent's instructions (e.g., additional context not captured in the agent definition).")
  prompt?: string;
}

@doc("Traces source — conversation traces from Application Insights.")
model TracesJobSource extends JobSource {
  @doc("The source type for this source, which is Traces.")
  type: "Traces";

  @doc("The agent name to fetch traces for.")
  agent_name: string;

  @doc("The agent version. If not specified, the latest version is used.")
  agent_version?: string;

  @doc("Start of the time window (Unix timestamp in seconds) for fetching traces.")
  start_time?: FoundryTimestamp;

  @doc("End of the time window (Unix timestamp in seconds). Defaults to current time.")
  end_time?: FoundryTimestamp;

  @doc("Maximum number of traces to retrieve.")
  max_traces?: int32 = 100;
}

@doc("Dataset source — reference to a dataset.")
model DatasetJobSource extends JobSource {
  @doc("The source type for this source, which is Dataset.")
  type: "Dataset";

  @doc("The name of the dataset.")
  name: string;

  @doc("The version of the dataset. If not specified, the latest version is used.")
  version?: string;
}
