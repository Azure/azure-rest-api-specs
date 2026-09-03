import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * An independently managed LoRA adapter attached to a managed compute deployment.
 */
@added(Versions.v2026_09_15_preview)
@parentResource(Account)
model AdapterDeployment
  is Azure.ResourceManager.ProxyResource<AdapterDeploymentProperties> {
  ...ResourceNameParameter<
    Resource = AdapterDeployment,
    KeyName = "adapterDeploymentName",
    SegmentName = "adapterDeployments",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9._-]{0,63}$"
  >;

  /**
   * Resource tags used for organization and governance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The account child supports independent tags."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags are extensible key-value pairs."
  tags?: Record<string>;

  /**
   * The concurrency token for this adapter deployment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Cognitive Services uses the lowercase etag envelope property."
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of an adapter deployment.
 */
@added(Versions.v2026_09_15_preview)
model AdapterDeploymentProperties {
  /**
   * The immutable Project Models version produced by Foundry fine-tuning.
   * The identifier uses the Azure AI project model URI format.
   * The service validates LoRA weight type, protected status, provenance,
   * compatibility metadata, and registration state.
   */
  sourceModelId: string;

  /**
   * The name of the compatible managed compute parent deployment.
   * The service resolves this name within the adapter's owning account; full
   * ARM resource IDs and cross-account references are not accepted. It cannot
   * equal the adapter deployment's resource name. Updating this value
   * re-targets the adapter while its source model remains unchanged.
   */
  targetDeploymentName: string;

  /**
   * The managed compute deployment currently serving the adapter.
   * During re-targeting this remains the prior deployment until atomic cutover.
   */
  @visibility(Lifecycle.Read)
  activeTargetDeploymentName?: string;

  /**
   * The provisioning state of the adapter deployment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AdapterDeploymentProvisioningState;

  /**
   * Information about the most recently requested lifecycle operation.
   */
  @visibility(Lifecycle.Read)
  lastOperation?: AdapterDeploymentLastOperation;
}

/**
 * Provisioning states for an adapter deployment resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Canceled operations leave the resource in failed or its prior succeeded state; the resource contract does not expose a canceled state."
@added(Versions.v2026_09_15_preview)
union AdapterDeploymentProvisioningState {
  string,

  /** The create request was accepted. */
  Accepted: "accepted",

  /**
   * The adapter is being staged on a new target while the prior target
   * continues serving requests.
   */
  Updating: "updating",

  /** The adapter is ready across every healthy serving replica. */
  Succeeded: "succeeded",

  /** No globally consistent adapter target is available. */
  Failed: "failed",
}

/**
 * Lifecycle operation types reported by an adapter deployment.
 */
@added(Versions.v2026_09_15_preview)
union AdapterDeploymentOperationType {
  string,

  /** Creates the adapter deployment. */
  Create: "create",

  /** Re-targets the adapter deployment. */
  Update: "update",

  /** Deletes the adapter deployment. */
  Delete: "delete",
}

/**
 * Lifecycle operation states reported by an adapter deployment.
 */
@added(Versions.v2026_09_15_preview)
union AdapterDeploymentOperationState {
  string,

  /** The operation was accepted. */
  Accepted: "accepted",

  /** The operation is running. */
  Running: "running",

  /** The operation completed successfully. */
  Succeeded: "succeeded",

  /** The operation failed. */
  Failed: "failed",
}

/**
 * Rollback outcomes for a failed re-target operation.
 */
@added(Versions.v2026_09_15_preview)
union AdapterDeploymentRollbackResult {
  string,

  /** No rollback was required. */
  NotRequired: "not_required",

  /** Rollback completed successfully. */
  Succeeded: "succeeded",

  /** Rollback failed. */
  Failed: "failed",
}

/**
 * Domain error codes returned by adapter deployment operations.
 */
@added(Versions.v2026_09_15_preview)
union AdapterDeploymentErrorCode {
  string,

  /** The adapter source is invalid. */
  InvalidAdapterSource: "invalid_adapter_source",

  /** The adapter format is unsupported. */
  AdapterFormatNotSupported: "adapter_format_not_supported",

  /** The base-model provenance is missing. */
  BaseModelProvenanceMissing: "base_model_provenance_missing",

  /** The source and target base models do not match. */
  BaseModelMismatch: "base_model_mismatch",

  /** The target deployment is invalid. */
  InvalidTargetDeployment: "invalid_target_deployment",

  /** The adapter deployment name is invalid. */
  InvalidAdapterDeploymentName: "invalid_adapter_deployment_name",

  /** The source model was not found. */
  ModelNotFound: "model_not_found",

  /** The adapter deployment was not found. */
  AdapterDeploymentNotFound: "adapter_deployment_not_found",

  /** The target deployment is not ready. */
  TargetDeploymentNotReady: "target_deployment_not_ready",

  /** The adapter deployment already exists. */
  AdapterDeploymentAlreadyExists: "adapter_deployment_already_exists",

  /** Adapter deployments prevent the requested parent operation. */
  AdapterDeploymentsExist: "adapter_deployments_exist",

  /** The adapter source is already in use. */
  AdapterDeploymentSourceInUse: "adapter_deployment_source_in_use",

  /** The target deployment's adapter limit was exceeded. */
  AdapterLimitExceeded: "adapter_limit_exceeded",

  /** A conditional request precondition failed. */
  PreconditionFailed: "precondition_failed",

  /** Loading the adapter failed. */
  AdapterLoadFailed: "adapter_load_failed",

  /** Rolling back the adapter failed. */
  AdapterRollbackFailed: "adapter_rollback_failed",

  /** Replica convergence timed out. */
  ConvergenceTimedOut: "convergence_timed_out",

  /** Request draining timed out. */
  DrainTimedOut: "drain_timed_out",

  /** Security policy revoked the adapter. */
  AdapterRevoked: "adapter_revoked",

  /** The request rate is too high. */
  TooManyRequests: "too_many_requests",

  /** The service is temporarily unavailable. */
  ServiceUnavailable: "service_unavailable",
}

/**
 * Safe domain error details returned for adapter deployment failures.
 */
@added(Versions.v2026_09_15_preview)
model AdapterDeploymentErrorDetail {
  /**
   * Stable machine-readable error code.
   */
  code: AdapterDeploymentErrorCode;

  /**
   * Safe customer-facing error message.
   */
  message: string;

  /**
   * Request property or resource targeted by the error.
   */
  target?: string;

  /**
   * Nested safe error details.
   */
  @identifiers(#["code", "target"])
  details?: AdapterDeploymentErrorDetail[];
}

/**
 * The most recently requested adapter lifecycle operation.
 */
@added(Versions.v2026_09_15_preview)
model AdapterDeploymentLastOperation {
  /**
   * The type of lifecycle operation.
   */
  type: AdapterDeploymentOperationType;

  /**
   * The current or terminal operation state.
   */
  status: AdapterDeploymentOperationState;

  /**
   * The target deployment requested by a create or re-target operation.
   */
  requestedTargetDeploymentName?: string;

  /**
   * A safe identifier used to correlate logs and support requests.
   */
  correlationId: string;

  /**
   * The time at which the operation started.
   */
  startedAt: utcDateTime;

  /**
   * The time at which the operation reached a terminal state.
   */
  completedAt?: utcDateTime;

  /**
   * The rollback result when a re-target operation does not complete.
   */
  rollbackResult?: AdapterDeploymentRollbackResult;

  /**
   * Safe error details when the operation failed.
   */
  error?: AdapterDeploymentErrorDetail;
}

/**
 * Parameters used to filter adapter deployments.
 */
@added(Versions.v2026_09_15_preview)
model AdapterDeploymentListParameters {
  /**
   * Filters by target deployment, source model version, provisioning state,
   * or a supported conjunction of those predicates.
   */
  @query("$filter")
  filter?: string;
}

/**
 * A paginated collection of adapter deployments.
 */
@added(Versions.v2026_09_15_preview)
model AdapterDeploymentListResult {
  /**
   * Adapter deployments in this page.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value: AdapterDeployment[];

  /**
   * URL used to retrieve the next page, when one exists.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Standard conditional headers accepted by adapter PUT operations.
 */
alias AdapterDeploymentPutConditions = {
  /**
   * Applies the re-target operation only when the current resource ETag
   * matches.
   */
  @header("If-Match")
  ifMatch?: string;

  /**
   * Use `*` for create-only behavior.
   */
  @header("If-None-Match")
  ifNoneMatch?: string;
};

/**
 * Conditional header required when deleting an existing adapter deployment.
 */
alias AdapterDeploymentDeleteConditions = {
  /**
   * Applies deletion only when the current resource ETag matches.
   */
  @header("If-Match")
  ifMatch: string;
};

alias AdapterDeploymentLroHeaders = ArmAsyncOperationHeader<FinalResult = AdapterDeployment> &
  Azure.Core.Foundations.RetryAfterHeader;

@added(Versions.v2026_09_15_preview)
@armResourceOperations
interface AdapterDeployments {
  /**
   * Gets an adapter deployment by name.
   */
  get is ArmResourceRead<AdapterDeployment>;

  /**
   * Creates an adapter deployment or re-targets it to another compatible
   * managed compute deployment. The source model ID is immutable. Create
   * requests use `If-None-Match: *`; re-target requests use `If-Match`.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AdapterDeployment,
    LroHeaders = AdapterDeploymentLroHeaders,
    Parameters = AdapterDeploymentPutConditions,
    Response =
      | (ArmResourceUpdatedResponse<AdapterDeployment> &
          AdapterDeploymentLroHeaders)
      | ArmResourceCreatedResponse<
          AdapterDeployment,
          AdapterDeploymentLroHeaders
        >
  >;

  /**
   * Lists adapter deployments associated with the Cognitive Services account.
   */
  list is ArmResourceListByParent<
    AdapterDeployment,
    Parameters = AdapterDeploymentListParameters,
    Response = ArmResponse<AdapterDeploymentListResult>
  >;

  /**
   * Drains requests and deletes an adapter deployment and its serving snapshot.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    AdapterDeployment,
    Parameters = AdapterDeploymentDeleteConditions,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(
  AdapterDeployment.name,
  "The account-unique adapter deployment name and inference identity."
);
@@doc(
  AdapterDeployment.properties,
  "Properties of the Cognitive Services adapter deployment."
);
@@encodedName(AdapterDeployment.etag, "application/json", "etag");
@@doc(
  AdapterDeployments.createOrUpdate::parameters.resource,
  "The complete adapter deployment resource to create or re-target."
);
