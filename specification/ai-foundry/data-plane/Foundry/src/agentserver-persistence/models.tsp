// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

const AgentServerPersistenceContract = #{
  contract: "agentserver-persistence",
  usage: "cross-language-sdk-persistence",
};

const AgentServerPersistenceRequiredPreviews = #{
  contract: "agentserver-persistence",
  usage: "cross-language-sdk-persistence",
  required_previews: #[FoundryFeaturesOptInKeys.routines_v2_preview],
};

// ---------------------------------------------------------------------------
// AgentServer Core durable task persistence contract
// ---------------------------------------------------------------------------

/** Status values persisted on an AgentServer durable task record. */
@extension("x-ms-foundry-meta", AgentServerPersistenceContract)
union AgentServerTaskStatus {
  string,
  pending: "pending",
  inProgress: "in_progress",
  suspended: "suspended",
  completed: "completed",
}

/**
 * Lease details on an AgentServer durable task record.
 * The lease is the optimistic ownership/fencing token for a single worker instance.
 */
@extension("x-ms-foundry-meta", AgentServerPersistenceContract)
model AgentServerTaskLease {
  /** Stable lease owner, typically scoped to the agent and session. */
  owner: string;

  /** Ephemeral worker instance identifier. */
  instance_id: string;

  /** Fencing generation. Increments whenever a different instance re-acquires the lease. */
  generation: int32 = 0;

  /** ISO 8601 UTC instant after which the lease is expired. */
  expires_at: string;

  /** Number of times ownership changed via expiry. */
  expiry_count: int32 = 0;
}

/**
 * Provenance and recovery-routing metadata for an AgentServer durable task record.
 */
@extension("x-ms-foundry-meta", AgentServerPersistenceContract)
model AgentServerTaskSource {
  /** Source system or producer type. */
  type: string;

  /** Routine name that produced the task, when applicable. */
  routine_name?: string;

  /** Routine run identifier that produced the task, when available. */
  routine_run_id?: string;

  /** Dispatch identifier associated with the source event. */
  dispatch_id?: string;

  /** Correlation identifier for the source action that created the task. */
  action_correlation_id?: string;

  /** ISO 8601 UTC instant when the source object was created. */
  created_at?: string;

  /** ISO 8601 UTC instant when the source object was last updated. */
  updated_at?: string;

  /** Forward-compatible source extension fields. */
  ...Record<unknown>;
}

/**
 * Client-facing representation of an AgentServer durable task record.
 */
@extension("x-ms-foundry-meta", AgentServerPersistenceContract)
model AgentServerTaskRecord {
  /** Envelope discriminator. Always `task`. */
  object: "task";

  /** Stable task identifier. */
  id: string;

  /** Agent scope that owns this task. */
  agent_name: string;

  /** Session scope that owns this task. */
  session_id: string;

  /** Current task status. */
  status: AgentServerTaskStatus;

  /** Human-readable title. */
  @maxLength(256)
  title: string;

  /** Optional human-readable description. */
  @maxLength(1024)
  description: string | null;

  /** Active lease details, or null when no lease is held. */
  lease: AgentServerTaskLease | null;

  /** Arbitrary JSON payload used by the agent as task input or mutable task state. */
  payload: unknown | null;

  /** String tags associated with this task. */
  tags: Record<string> | null;

  /** Source/provenance metadata that identifies the task producer. */
  source: AgentServerTaskSource | null;

  /** JSON-serializable attachment values keyed by attachment name. */
  attachments: Record<unknown> | null;

  /** Structured terminal error details. */
  error: AgentServerTaskError | null;

  /** Reason the task was suspended. */
  @maxLength(256)
  suspension_reason: string | null;

  /** ISO 8601 UTC creation timestamp. */
  created_at: string;

  /** ISO 8601 UTC last-update timestamp. */
  updated_at: string;

  /** ISO 8601 UTC timestamp of the first transition to `in_progress`, or null. */
  started_at: string | null;

  /** ISO 8601 UTC completion timestamp, or null. */
  completed_at: string | null;

  /** Optimistic-concurrency token. */
  etag: string;
}

/** Request body for creating an AgentServer durable task record. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Keeping for backward compatibility."
@extension("x-ms-foundry-meta", AgentServerPersistenceContract)
model AgentServerTaskCreateRequest {
  /** Optional caller-supplied task identifier. If omitted, the provider generates one. */
  id?: string;

  /** Agent scope that owns this task. */
  agent_name: string;

  /** Session scope that owns this task. */
  session_id: string;

  /** Human-readable title. */
  @maxLength(256)
  title: string;

  /** Optional human-readable description. */
  @maxLength(1024)
  description?: string;

  /** Initial task status. Defaults to `pending`. */
  status?: AgentServerTaskStatus = AgentServerTaskStatus.pending;

  /** Initial arbitrary JSON task payload. */
  payload?: unknown;

  /** Initial string tags. */
  tags?: Record<string>;

  /** Source/provenance metadata that identifies the task producer. */
  source?: AgentServerTaskSource;

  /** Initial JSON-serializable attachment values keyed by attachment name. */
  attachments?: Record<unknown>;
}

/** Structured error persisted on a task record. */
@extension("x-ms-foundry-meta", AgentServerPersistenceContract)
model AgentServerTaskError {
  /** Error type discriminator, such as `timeout` or `retries_exhausted`. */
  type: string;

  /** Human-readable error message. */
  message: string;

  /** Optional machine-readable error code. Defaults to `error` when omitted by the caller. */
  code?: string = "error";

  /** Additional structured error fields. */
  ...Record<unknown>;
}

/** Cursor-paged list response for AgentServer durable task records. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Keeping for backward compatibility."
@extension("x-ms-foundry-meta", AgentServerPersistenceContract)
model AgentServerTaskListResponse {
  /** Object discriminator. Always `list`. */
  object: "list";

  /** Page of matching task records. */
  @pageItems
  data: AgentServerTaskRecord[];

  /** First task id represented in this page. */
  first_id?: string;

  /** Whether more records are available. */
  has_more: boolean;

  /** Cursor to pass as `after` for the next page when `has_more` is true. */
  @continuationToken
  last_id?: string;
}
