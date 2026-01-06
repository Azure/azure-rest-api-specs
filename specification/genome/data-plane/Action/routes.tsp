import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Genome;

/**
 * Retrieves a complete list of all available actions in the system. Each action
 * includes metadata such as name, description, required input parameters, tags,
 * and estimated duration.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom action retrieval operation for listing available actions"
@summary("Get all available actions")
@route("/v1/actions")
@get
op getActions is Azure.Core.Foundations.Operation<{}, ActionListResponse>;

/**
 * Retrieves detailed information about a specific action using its unique
 * identifier. Returns action metadata including name, description, required input
 * parameters schema, tags, and estimated execution duration.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom action retrieval by ID operation"
@summary("Get action by ID")
@route("/v1/actions/{actionId}")
@get
op getActionById is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the action to retrieve
     */
    @path
    actionId: string;
  },
  ActionResponse
>;

/**
 * Creates a new execution instance for the specified action. The execution is
 * queued and will be processed asynchronously. Returns an execution ID that can
 * be used to track progress and retrieve results.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom action execution creation operation"
@summary("Create a new action execution")
@route("/v1/actions/{actionId}/executions")
@post
op createActionExecution is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the action to execute
     */
    @path
    actionId: string;

    /** Request body for creating action execution */
    @body
    body: ActionExecutionRequest;
  },
  ActionExecutionResponse
>;

/**
 * Retrieves a list of all executions for the specified action with optional
 * filtering by status and pagination support.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom action executions retrieval operation"
@summary("Get executions for a specific action")
@route("/v1/actions/{actionId}/executions")
@get
op getActionExecutions is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the action
     */
    @path
    actionId: string;

    /**
     * Filter executions by status
     */
    @query("status")
    status?: ActionExecutionStatus;

    /**
     * Maximum number of results to return (1-100)
     */
    @maxValue(100)
    @minValue(1)
    @query("limit")
    limit?: int32 = 20;

    /**
     * Number of results to skip
     */
    @query("offset")
    offset?: int32;
  },
  ActionExecutionListResponse
>;

/**
 * Retrieves detailed information about a specific action execution including
 * input parameters, results, progress, and error information if applicable.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom action execution detail retrieval operation"
@summary("Get action execution details by ID")
@route("/v1/actions/{actionId}/executions/{executionId}")
@get
op getActionExecutionById is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the action
     */
    @path
    actionId: string;

    /**
     * Unique identifier of the execution
     */
    @path
    executionId: string;
  },
  ActionExecutionDetailResponse
>;

/**
 * Retrieves all action executions across all actions with comprehensive
 * filtering, sorting, and pagination capabilities. Useful for monitoring
 * execution history and system-wide execution status.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom all action executions retrieval operation"
@summary("Get all action executions")
@route("/v1/actionExecutions")
@get
op getAllActionExecutions is Azure.Core.Foundations.Operation<
  {
    /**
     * Filter executions by status
     */
    @query("status")
    status?: ActionExecutionStatus;

    /**
     * Filter executions by action ID
     */
    @query("actionId")
    actionId?: string;

    /**
     * Filter executions by user ID
     */
    @query("userId")
    userId?: string;

    /**
     * Maximum number of results to return (1-100)
     */
    @maxValue(100)
    @minValue(1)
    @query("limit")
    limit?: int32 = 20;

    /**
     * Number of results to skip
     */
    @query("offset")
    offset?: int32;

    /**
     * Field to sort by
     */
    @query("sortBy")
    sortBy?: Paths8JxwviV1ActionexecutionsGetParameters5Schema = Paths8JxwviV1ActionexecutionsGetParameters5Schema.queuedAt;

    /**
     * Sort order
     */
    @query("sortOrder")
    sortOrder?: Paths1Aud0QxV1ActionexecutionsGetParameters6Schema = Paths1Aud0QxV1ActionexecutionsGetParameters6Schema.desc;
  },
  ActionExecutionListResponse
>;
