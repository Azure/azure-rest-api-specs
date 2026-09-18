// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// AgentServer Core task-storage wire operations
//
// These are the REST operations used by the Python and .NET resilient-task
// providers. SDK runtime methods such as RunAsync/StartAsync/GetActiveRunAsync
// are language-specific ergonomics layered above this storage contract and are
// intentionally not modeled as REST operations.
// ---------------------------------------------------------------------------

alias AgentServerTaskLeaseQueryParameters = {
  /**
   * Stable lease owner. Must be supplied together with `lease_instance_id` and
   * `lease_duration_seconds`. Lease parameters are query parameters, never body fields.
   */
  @query lease_owner?: string;

  /**
   * Ephemeral worker instance id. Must be supplied together with `lease_owner`
   * and `lease_duration_seconds`.
   */
  @query lease_instance_id?: string;

  /**
   * Lease duration in seconds. `0` force-expires the current lease; otherwise
   * values are bounded by the task-storage service.
   */
  @query lease_duration_seconds?: int32;
};

alias AgentServerTaskIdPathParameter = {
  /** The task id. */
  @path task_id: string;
};

alias AgentServerTaskIfMatchHeader = {
  /** Optimistic-concurrency precondition for patch/delete operations. */
  @header("If-Match") if_match?: string;
};

alias CreateAgentServerTaskRequest = {
  ...AgentServerTaskLeaseQueryParameters;

  /** Task creation body. */
  @body body: AgentServerTaskCreateRequest;
};

alias GetAgentServerTaskRequest = {
  ...AgentServerTaskIdPathParameter;
};

alias PatchAgentServerTaskRequest = {
  ...AgentServerTaskIdPathParameter;
  ...AgentServerTaskLeaseQueryParameters;
  ...AgentServerTaskIfMatchHeader;

  /**
   * Arbitrary JSON patch document. Supported top-level fields include status,
   * payload, tags, attachments, error, and suspension_reason.
   */
  @body body: unknown;
};

alias DeleteAgentServerTaskRequest = {
  ...AgentServerTaskIdPathParameter;
  ...AgentServerTaskIfMatchHeader;

  /** Force deletion of a non-terminal task and release any active lease. Defaults to false. */
  @query force?: boolean = false;
};

union AgentServerTaskListOrder {
  ascent: "asc",
  descent: "desc",
}

alias ListAgentServerTasksRequest = {
  /** Filter by agent name. */
  @query agent_name?: string;

  /** Filter by session id. */
  @query session_id?: string;

  /** Filter by task status. */
  @query status?: AgentServerTaskStatus;

  /** Filter by whether the task has a recorded error. */
  @query has_error?: boolean;

  /** Filter by whether the current lease is expired. */
  @query lease_expired?: boolean;

  /** Filter by lease owner. */
  @query lease_owner?: string;

  /** Tag equality filters in `key:value` form. Repeat for AND filtering. */
  @query tag?: string[];

  /** Filter by source type, for example `routine_action_delivery`. */
  @query source_type?: string;

  /** Cursor for the next page. */
  @query after?: string;

  /** Maximum number of records to return. Default 20, maximum 100. */
  @query limit?: int32 = 20;

  /** Sort order. */
  @query order?: AgentServerTaskListOrder = AgentServerTaskListOrder.descent;

  /** When true, omit attachment values from returned task records. */
  @query omit_attachment_values?: boolean = false;
};

@tag("AgentServer Task Storage")
interface AgentServerTaskStorage {
  /** Creates a durable task record. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "internal SDK storage protocol"
  @summary("Create a task")
  @operationId("createAgentServerTask")
  @post
  @route("/tasks")
  @extension("x-ms-foundry-meta", AgentServerPersistenceRequiredPreviews)
  createAgentServerTask is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.routines_v2_preview,
    CreateAgentServerTaskRequest,
    ResourceCreatedResponse<AgentServerTaskRecord>
  >;

  /** Retrieves a durable task record by id. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "internal SDK storage protocol"
  @summary("Get a task")
  @operationId("getAgentServerTask")
  @get
  @route("/tasks/{task_id}")
  @extension("x-ms-foundry-meta", AgentServerPersistenceRequiredPreviews)
  getAgentServerTask is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.routines_v2_preview,
    GetAgentServerTaskRequest,
    AgentServerTaskRecord
  >;

  /** Patches a durable task record, including status, payload, tags, attachments, and lease operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "internal SDK storage protocol"
  @summary("Patch a task")
  @operationId("patchAgentServerTask")
  @patch
  @route("/tasks/{task_id}")
  @extension("x-ms-foundry-meta", AgentServerPersistenceRequiredPreviews)
  patchAgentServerTask is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.routines_v2_preview,
    PatchAgentServerTaskRequest,
    AgentServerTaskRecord
  >;

  /** Deletes a durable task record. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "internal SDK storage protocol"
  @summary("Delete a task")
  @operationId("deleteAgentServerTask")
  @delete
  @route("/tasks/{task_id}")
  @extension("x-ms-foundry-meta", AgentServerPersistenceRequiredPreviews)
  deleteAgentServerTask is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.routines_v2_preview,
    DeleteAgentServerTaskRequest,
    NoContentResponse
  >;

  /** Lists durable task records that match the supplied filters. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "internal SDK storage protocol"
  @summary("List tasks")
  @operationId("listAgentServerTasks")
  @get
  @list
  @route("/tasks")
  @extension("x-ms-foundry-meta", AgentServerPersistenceRequiredPreviews)
  listAgentServerTasks is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.routines_v2_preview,
    ListAgentServerTasksRequest,
    AgentServerTaskListResponse
  >;
}
