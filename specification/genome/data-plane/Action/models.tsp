import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Genome;

/**
 * Status of action execution
 */
union ActionExecutionStatus {
  string,

  /**
   * Queued
   */
  Queued: "Queued",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Failed
   */
  Failed: "Failed",
}

/** Field to sort by */
union Paths8JxwviV1ActionexecutionsGetParameters5Schema {
  string,

  /**
   * queuedAt
   */
  queuedAt: "queuedAt",

  /**
   * startedAt
   */
  startedAt: "startedAt",

  /**
   * completedAt
   */
  completedAt: "completedAt",
}

/** Sort order */
union Paths1Aud0QxV1ActionexecutionsGetParameters6Schema {
  string,

  /**
   * asc
   */
  asc: "asc",

  /**
   * desc
   */
  desc: "desc",
}

/**
 * Response containing a list of all available actions
 */
model ActionListResponse {
  /**
   * List of available actions
   */
  actions: ActionResponse[];

  /**
   * Total number of actions available in the system
   */
  totalCount: int32;
}

/**
 * Detailed information about a specific action
 */
model ActionResponse {
  /**
   * Unique identifier for the action
   */
  actionId: string;

  /**
   * Human-readable name of the action
   */
  actionName: string;

  /**
   * Detailed description of what the action does
   */
  actionDescription: string;

  /**
   * JSON Schema defining the required and optional input parameters for executing
   * this action
   */
  requiredInputParameters: Record<string>;

  /**
   * Tags for categorizing and filtering actions
   */
  tags?: string[];

  /**
   * Estimated time range for action execution
   */
  estimatedDuration?: string;
}

/**
 * Standard error response format for authentication and authorization errors
 */
model CommonError {
  /** Error details */
  error?: CommonErrorError;
}

/** Detailed error information */
model CommonErrorError {
  /**
   * Error code
   */
  code?: string;

  /**
   * Human-readable error message
   */
  message?: string;
}

/**
 * Standard error response format for general errors
 */
model ErrorResponse {
  /**
   * Error type
   */
  error?: string;

  /**
   * Human-readable error message
   */
  message?: string;
}

/**
 * Request for creating a new action execution
 */
model ActionExecutionRequest {
  /**
   * Action-specific input parameters. The structure must match the action's
   * required input parameters schema.
   */
  inputParameters: Record<string>;

  /**
   * Optional metadata for the execution
   */
  metadata?: ExecutionMetadata;
}

/**
 * Optional metadata for the execution
 */
model ExecutionMetadata {
  /**
   * ID of the user executing the action
   */
  userId?: string;

  /**
   * Source system or application initiating the execution
   */
  source?: string;
}

/**
 * Response after creating an action execution
 */
model ActionExecutionResponse {
  /**
   * Unique identifier for the execution
   */
  executionId: string;

  /**
   * ID of the action being executed
   */
  actionId: string;

  /**
   * Status of action execution
   */
  status: ActionExecutionStatus;

  /**
   * Timestamp when the execution was queued
   */
  queuedAt: utcDateTime;

  /**
   * Human-readable message about the execution
   */
  message?: string;
}

/**
 * Response containing a list of action executions with pagination
 */
model ActionExecutionListResponse {
  /**
   * List of action execution summaries
   */
  executions: ActionExecutionSummaryResponse[];

  /**
   * Pagination information
   */
  pagination?: PaginationResponse;
}

/**
 * Summary information about an action execution
 */
model ActionExecutionSummaryResponse {
  /**
   * Unique identifier for the execution
   */
  executionId: string;

  /**
   * ID of the action
   */
  actionId: string;

  /**
   * Name of the action
   */
  actionName?: string;

  /**
   * Status of action execution
   */
  status: ActionExecutionStatus;

  /**
   * Timestamp when the execution was queued
   */
  queuedAt: utcDateTime;

  /**
   * Timestamp when the execution completed
   */
  completedAt?: utcDateTime;

  /**
   * Execution duration in human-readable format
   */
  duration?: string;

  /**
   * ID of the user who initiated the execution
   */
  userId?: string;
}

/**
 * Pagination information
 */
model PaginationResponse {
  /**
   * Total number of items across all pages
   */
  totalCount?: int32;

  /**
   * Number of items per page
   */
  limit?: int32;

  /**
   * Number of items skipped
   */
  offset?: int32;

  /**
   * Whether there are more items available
   */
  hasNext?: boolean;

  /**
   * Whether there are previous items
   */
  hasPrevious?: boolean;
}

/**
 * Detailed information about an action execution
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ActionExecutionDetailResponse extends ActionExecutionResponse {
  /**
   * Timestamp when the execution started
   */
  startedAt?: utcDateTime;

  /**
   * Timestamp when the execution completed
   */
  completedAt?: utcDateTime;

  /**
   * Timestamp when the execution failed
   */
  failedAt?: utcDateTime;

  /**
   * Input parameters provided for the execution
   */
  inputParameters?: Record<string>;

  /**
   * Result of the action execution
   */
  result?: Record<string>;

  /**
   * Error information if execution failed
   */
  error?: ExecutionErrorResponse;

  /**
   * Progress information for in-progress executions
   */
  progress?: ExecutionProgressResponse;

  /**
   * Additional metadata about the execution
   */
  metadata?: Record<string>;
}

/**
 * Error information if execution failed
 */
model ExecutionErrorResponse {
  /**
   * Error code
   */
  code: string;

  /**
   * Error message
   */
  message: string;

  /**
   * Additional error details
   */
  details?: string;
}

/**
 * Progress information for in-progress executions
 */
model ExecutionProgressResponse {
  /**
   * Current step being executed
   */
  currentStep?: string;

  /**
   * Number of steps completed
   */
  stepsCompleted?: int32;

  /**
   * Total number of steps in the execution
   */
  totalSteps?: int32;
}
