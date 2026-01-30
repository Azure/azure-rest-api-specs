import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_conversation_message.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Discovery.DataPlane.Shared;

@versioned(Microsoft.Discovery.Workspace.Versions)
namespace Microsoft.Discovery.Workspace;

@doc("Task assignee information.")
model TaskAssignee {
  @doc("The unique identifier of the assignee.")
  id: string;

  @doc("Type of assignee (User, Application, System, or custom type).")
  type: ByType;
}

@doc("Request body for starting a task.")
model StartTaskRequest {
  @doc("Assignee that will execute the task. Optional.")
  assignee?: TaskAssignee;
}

@doc("Task execution result.")
model TaskResult {
  @doc("The text content of the task result.")
  text?: string;

  @doc("Array of storage asset identifiers related to the result.")
  @added(Versions.`2026-02-01-preview`)
  storageAssetIds?: StorageAssetId[];

  @doc("Array of data asset identifiers related to the result.")
  @removed(Versions.`2026-02-01-preview`)
  dataAssetIds?: string[];

  @doc("Array of citations supporting the result.")
  @added(Versions.`2025-07-01-preview`)
  @removed(Versions.`2026-02-01-preview`)
  citations?: Citation[];
}

@doc("Task comment.")
model TaskComment {
  @doc("When the comment was created.")
  createdAt: utcDateTime;

  @doc("ID of the user or application who created the comment.")
  createdBy: string;

  @doc("Type of creator (User, Application, System, or custom type).")
  createdByType: ByType;

  @doc("The comment text content.")
  text: string;
}

@doc("Execution history entry for a task.")
model ExecutionHistoryEntry {
  @doc("Timestamp when the entry was created (ISO 8601 UTC format).")
  createdAt: utcDateTime;

  @doc("The action that was performed (controlled vocabulary; semi-open).")
  action: string;

  @doc("Identifier of who created this entry (GUID for user | resourceId for application | arbitrary string for other types).")
  createdBy: string;

  @doc("Type of entity that created this entry (User, Application, System, or custom type).")
  createdByType: ByType;

  @doc("Brief summary of the execution event.")
  @maxLength(2048)
  summary?: string;

  @doc("Detailed completion message.")
  responseMessageText?: string;

  @doc("Run or message ID for full details.")
  responseMessageId?: string;

  @doc("Freeform key-value pairs for additional details.")
  additionalDetails?: Record<string>;
}

@doc("Task status enumeration.")
union TaskStatus {
  /** The task is newly created */
  new: "new",

  /** The task is on hold */
  onHold: "onHold",

  /** The task has been completed */
  complete: "complete",

  /** The task has been removed */
  removed: "removed",

  /** The task has been flagged for human review */
  flaggedHuman: "flaggedHuman",

  /** The task has been flagged for AI review */
  flaggedAi: "flaggedAi",

  /** The task is currently executing */
  executing: "executing",

  /** The task execution is done */
  executionDone: "executionDone",

  /** The task has become stale */
  stale: "stale",

  /** The task has failed */
  failed: "failed",

  /** The task is incomplete */
  incomplete: "incomplete",

  string,
}

@doc("Task resource.")
@resource("tasks")
@parentResource(Investigation)
model Task {
  @doc("The unique identifier of the task.")
  @visibility(Lifecycle.Read)
  @key("taskName")
  @maxLength(38)
  name: string;

  @doc("The title of the task.")
  title: string;

  @doc("The priority of the task (higher numbers = higher priority).")
  @minValue(1)
  priority?: int32;

  @doc("The description of the task.")
  description?: string;

  @doc("Array of validation requirements for the task.")
  validationRequirements?: string[];

  @doc("ID of the parent task if this is a subtask.")
  parentId?: string;

  @doc("IDs of tasks that must complete before this task can be executed.")
  dependsOn?: string[];

  @doc("IDs of tasks that are related to this task.")
  relatedTo?: string[];

  @doc("Application or user assigned to this task.")
  assignedTo?: TaskAssignee;

  @doc("Comments or notes about the task.")
  comments?: TaskComment[];

  @doc("The current status of the task.")
  status: TaskStatus;

  ...DataPlaneResource;

  @doc("History of execution events for this task.")
  executionHistory?: ExecutionHistoryEntry[];

  @doc("The investigation identifier associated with the task.")
  investigationId: string;

  @doc("Task execution result with text and storage assets.")
  result?: TaskResult;

  @doc("List of storage assets related to the task.")
  @added(Versions.`2026-02-01-preview`)
  storageAssetIds?: StorageAssetId[];

  @doc("List of data assets related to the task.")
  @removed(Versions.`2026-02-01-preview`)
  dataAssetIds?: string[];
}

@doc("Task creation request.")
model TaskCreate {
  @doc("The title of the task.")
  title: string;

  @doc("The priority of the task (higher numbers = higher priority).")
  @minValue(1)
  priority?: int32;

  @doc("The description of the task.")
  description?: string;

  @doc("Array of validation requirements for the task.")
  validationRequirements?: string[];

  @doc("ID of the parent task if this is a subtask.")
  parentId?: string;

  @doc("IDs of tasks that must complete before this task can be executed.")
  dependsOn?: string[];

  @doc("IDs of tasks that are related to this task.")
  relatedTo?: string[];

  @doc("Application or user assigned to this task.")
  assignedTo?: TaskAssignee;

  @doc("Comments or notes about the task.")
  comments?: TaskComment[];

  @doc("Type of entity that created the task (User, Application, System, or custom type).")
  createdByType: ByType;

  @doc("The investigation identifier associated with the task.")
  investigationId: string;

  @doc("List of storage assets related to the task.")
  @added(Versions.`2026-02-01-preview`)
  storageAssetIds?: StorageAssetId[];

  @doc("List of data assets related to the task.")
  @removed(Versions.`2026-02-01-preview`)
  dataAssetIds?: string[];
}

@doc("Task update request.")
model TaskUpdate {
  @doc("The title of the task.")
  title?: string;

  @doc("The priority of the task (higher numbers = higher priority).")
  @minValue(1)
  priority?: int32;

  @doc("The description of the task.")
  description?: string;

  @doc("Array of validation requirements for the task.")
  validationRequirements?: string[];

  @doc("ID of the parent task if this is a subtask.")
  parentId?: string;

  @doc("IDs of tasks that must complete before this task can be executed.")
  dependsOn?: string[];

  @doc("IDs of tasks that are related to this task.")
  relatedTo?: string[];

  @doc("Application or user assigned to this task.")
  assignedTo?: TaskAssignee;

  @doc("Comments or notes about the task.")
  comments?: TaskComment[];

  @doc("The current status of the task.")
  status?: TaskStatus;

  @doc("Task execution result with text and storage assets.")
  result?: TaskResult;

  @doc("List of storage assets related to the task.")
  @added(Versions.`2026-02-01-preview`)
  storageAssetIds?: StorageAssetId[];

  @doc("List of data assets related to the task.")
  @removed(Versions.`2026-02-01-preview`)
  dataAssetIds?: string[];
}

interface Tasks {
  @doc("Get a task by ID.")
  get is ResourceRead<Task>;

  @doc("List tasks with optional OData filters.")
  list is Azure.Core.ResourceList<
    Task,
    QueryParametersTrait<{
      @doc("OData filter expression. Supported fields: investigationId, status, createdByType, priority, createdAt, lastModifiedAt. Example: status eq 'new' or status eq 'executing'")
      @query
      filter?: string;
    }>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create a new task.")
  @route("/projects/{projectName}/investigations/{investigationName}/tasks")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @pattern(resourceNamePattern)
      investigationName: string;

      @doc("Task creation request.")
      @body
      body: TaskCreate;
    },
    Task
  >;

  @doc("Patch (partial update) a task (e.g. status, description, validation requirements, dependencies, result).")
  update is StandardResourceOperations.ResourceCreateOrUpdate<Task>;

  @doc("Delete a task by ID.")
  delete is ResourceDelete<Task>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Start execution of a task.")
  @route("/projects/{projectName}/investigations/{investigationName}/tasks/{taskName}:start")
  @post
  start is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @pattern(resourceNamePattern)
      investigationName: string;

      @doc("The task name.")
      @path
      @pattern(resourceNamePattern)
      taskName: string;

      @doc("Start task request body.")
      @body
      body?: StartTaskRequest;
    },
    Task
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Add a comment to a task.")
  @route("/projects/{projectName}/investigations/{investigationName}/tasks/{taskName}:addComment")
  @post
  addComment is Azure.Core.Foundations.Operation<
    {
      @doc("The task name.")
      @path
      @pattern(resourceNamePattern)
      taskName: string;

      @doc("The project name.")
      @path
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @pattern(resourceNamePattern)
      investigationName: string;

      @doc("Comment to add.")
      @body
      body: TaskComment;
    },
    Task
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Add an execution history entry to a task.")
  @route("/projects/{projectName}/investigations/{investigationName}/tasks/{taskName}:addExecutionHistory")
  @post
  addExecutionHistory is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @pattern(resourceNamePattern)
      investigationName: string;

      @doc("The task name.")
      @path
      @pattern(resourceNamePattern)
      taskName: string;

      @doc("Execution history entry to add.")
      @body
      body: ExecutionHistoryEntry;
    },
    Task
  >;
}
