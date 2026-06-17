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
@@copyProperties(
  OpenAI.Error,
  {
    details?: OpenAI.Error[],
    additionalInfo?: Record<unknown>,
    debugInfo?: Record<unknown>,
  }
);

alias ApiError = OpenAI.Error;

alias AcceptJsonHeader = {
  @header accept: "application/json";
};

/**
 * @deprecated Use `UserDelegationHeader` (`x-ms-user-identity`) instead.
 * Optional request header carrying an opaque per-user isolation key forwarded to the agent
 * endpoint. When present, the service scopes endpoint-scoped data access (responses,
 * conversations, sessions) to the supplied user.
 */
#deprecated "Use UserDelegationHeader (x-ms-user-identity) instead. This header will be removed in a future version."
alias UserIsolationKeyHeader = {
  /** @deprecated Use x-ms-user-identity instead. Opaque per-user isolation key used to scope endpoint-scoped data to a specific end user. */
  @header("x-ms-user-isolation-key") user_isolation_key?: string;
};

/**
 * Optional request header carrying an opaque per-user identity for delegation.
 * When present and the caller has the `agents/endpoint/delegateViaUserId` RBAC permission,
 * the service scopes endpoint-scoped data (responses, conversations, sessions) to the
 * supplied user identity instead of the caller's own identity.
 * If the caller has delegation RBAC but does not pass this header, the caller's own identity is used.
 */
alias UserDelegationHeader = {
  /** Opaque per-user identity string used to scope endpoint-scoped data to a specific end user. The caller must have the `agents/endpoint/delegateViaUserId` RBAC permission. */
  @header("x-ms-user-identity") user_identity?: string;
};

/**
 * Platform-injected request header carrying a per-request run token (JWT) for identity propagation.
 * On container protocol 2.0.0+, the platform mints this token per inbound call and injects it
 * into the request. The container **MUST** propagate this token on all outbound calls to Foundry
 * platform services and other agents (A2A). SDK clients do not set this header directly —
 * it is set by the platform when forwarding requests to the agent container.
 *
 * **Who sets it:** The Foundry platform (not the SDK caller).
 * **Who reads it:** The agent container (via SDK helpers or manual extraction).
 * **Who forwards it:** The agent container, on outbound tool/A2A calls.
 */
alias FoundryRunTokenHeader = {
  /** Platform-minted per-request run token (JWT) carrying caller identity and session context. Set by the platform, not by SDK callers. The container must propagate this on outbound calls. */
  @extension("x-ms-foundry-meta", #{ platform_injected: true })
  @header("x-foundry-run-token") foundry_run_token?: string;
};

/**
 * Platform-injected request header carrying the foundation token for session-binding validation.
 * Contains infrastructure claims (sessionId, agentGuid) used for triple-equality validation
 * between FT and RT on the receiving side of A2A calls.
 *
 * **Who sets it:** The Foundry platform egress proxy (not the SDK caller or the container).
 * **Who reads it:** The receiving Foundry service (platform-internal validation only).
 * **Not customer-facing:** The container never reads, sets, or forwards this header.
 * It is stamped automatically by the egress proxy on outbound A2A calls and validated
 * on the receiving platform side. Included in the API spec for wire-level completeness only.
 */
alias FoundryFoundationTokenHeader = {
  /** Platform-injected foundation token for session-binding validation. Set by the egress proxy, not by SDK callers or container code. */
  @extension("x-ms-foundry-meta", #{ platform_injected: true })
  @header("x-foundry-foundation-token") foundry_foundation_token?: string;
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "OpenAI Response schemas can be intentionally combined for documentation clarity"
op OpenAIOperation<
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
>(...Params): Response | AzureRangeErrorResponse<ErrorResponse>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
op OpenAIOperationWithPreview<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys,
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
>(...WithConditionalFoundryPreviewHeader<AreaPreviewLabel>, ...Params):
  | Response
  | AzureRangeErrorResponse<ErrorResponse>;

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

// Common properties shared across all job source types. Spread into per-context
// source variants alongside a context-specific discriminated base (e.g.,
// `EvaluatorGenerationJobSource`). Modeled as an `alias` (not a `model`) since
// it is a single-property fragment used purely for spreading — declaring a
// named model adds no value over inlining the property.
alias JobSourceDescription = {
  @doc("Optional description of what this source represents — helps the pipeline interpret its content (e.g., 'Company refund policy document' or 'Describes the agent's core capabilities').")
  description?: string;
};

@doc("Prompt source — inline text provided by the user. Reusable shape spread into per-context discriminated subtypes.")
model PromptJobSource {
  ...JobSourceDescription;

  @doc("The source type for this source, which is Prompt.")
  type: "prompt";

  @doc("Inline prompt text (e.g., agent description, policy text, supplementary context).")
  prompt: string;
}

@doc("Agent source — references an agent to fetch instructions and metadata from. For prompt agents, fetches the agent's system prompt. For other agent types, fetches available metadata (description, configuration). Add a separate prompt source entry to `sources[]` to provide supplementary text alongside the agent. Reusable shape spread into per-context discriminated subtypes.")
model AgentJobSource {
  ...JobSourceDescription;

  @doc("The source type for this source, which is Agent.")
  type: "agent";

  @doc("The agent name to fetch instructions from.")
  agent_name: string;

  @doc("The agent version. If not specified, the latest version is used.")
  agent_version?: string;
}

@doc("Traces source — conversation traces from Application Insights. Reusable shape spread into per-context discriminated subtypes.")
model TracesJobSource {
  ...JobSourceDescription;

  @doc("The source type for this source, which is Traces.")
  type: "traces";

  @doc("The unique agent ID used to filter traces. Provide either `agent_id` or `agent_name` — at least one is required.")
  agent_id?: string;

  @doc("The agent name to fetch traces for. Provide either `agent_id` or `agent_name` — at least one is required.")
  agent_name?: string;

  @doc("The agent version. If not specified, traces for ALL versions of the agent are included within the time window.")
  agent_version?: string;

  @doc("Start of the time window (Unix timestamp in seconds) for fetching traces.")
  start_time: FoundryTimestamp;

  @doc("End of the time window (Unix timestamp in seconds). Defaults to current time.")
  end_time?: FoundryTimestamp;
}

@doc("Dataset source — reference to a dataset. Reusable shape spread into per-context discriminated subtypes.")
model DatasetJobSource {
  ...JobSourceDescription;

  @doc("The source type for this source, which is Dataset.")
  type: "dataset";

  @doc("The name of the dataset.")
  name: string;

  @doc("The version of the dataset. If not specified, the latest version is used.")
  version?: string;
}
