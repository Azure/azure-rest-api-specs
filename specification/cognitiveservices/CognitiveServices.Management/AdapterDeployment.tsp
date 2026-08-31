import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";
import "./ManagedComputeDeployment.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * An independently managed LoRA adapter attached to a Managed Compute
 * deployment.
 */
@added(Versions.v2026_07_15_preview)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Resource tags are extensible key-value pairs."
  tags?: Record<string>;

  /** The concurrency token for this adapter deployment. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Cognitive Services uses the lowercase etag envelope property."
  @visibility(Lifecycle.Read)
  etag?: string;
}

/** Properties of an adapter deployment. */
@added(Versions.v2026_07_15_preview)
model AdapterDeploymentProperties {
  /**
   * The Project Models version produced by Foundry fine-tuning. Updating this
   * value starts rolling replacement of the active adapter generation.
   */
  sourceModelId: string;

  /**
   * The immutable ARM ID of the compatible Managed Compute deployment.
   */
  targetDeploymentId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts/managedComputeDeployments";
    }
  ]>;

  /**
   * The source model version currently admitted for inference. During
   * replacement this remains the prior generation until atomic cutover.
   */
  @visibility(Lifecycle.Read)
  activeSourceModelId?: string;

  /** The provisioning state of the adapter deployment. */
  @visibility(Lifecycle.Read)
  provisioningState?: AdapterDeploymentProvisioningState;

  /** Whether the adapter can currently serve inference requests. */
  @visibility(Lifecycle.Read)
  servingState?: AdapterDeploymentServingState;

  /** Service-authenticated validation results for the active generation. */
  @visibility(Lifecycle.Read)
  validation?: AdapterDeploymentValidation;

  /** Revocation details when security policy has disabled this adapter. */
  @visibility(Lifecycle.Read)
  revocation?: AdapterDeploymentRevocation;

  /** Information about the most recently requested lifecycle operation. */
  @visibility(Lifecycle.Read)
  lastOperation?: AdapterDeploymentLastOperation;
}

/** Provisioning states for an adapter deployment resource. */
@added(Versions.v2026_07_15_preview)
union AdapterDeploymentProvisioningState {
  string,

  /** The create request was accepted. */
  Accepted: "Accepted",

  /** The initial adapter generation is being prepared. */
  Creating: "Creating",

  /** A replacement generation is being prepared. */
  Updating: "Updating",

  /** The active generation is ready across every healthy parent replica. */
  Succeeded: "Succeeded",

  /** The latest lifecycle operation failed. */
  Failed: "Failed",

  /** The latest lifecycle operation was canceled. */
  Canceled: "Canceled",

  /** The adapter is draining and being removed. */
  Deleting: "Deleting",
}

/** Serving availability independent of the latest management operation. */
@added(Versions.v2026_07_15_preview)
union AdapterDeploymentServingState {
  string,

  /** No generation has been admitted for inference. */
  NotReady: "NotReady",

  /** The active generation is available for inference. */
  Ready: "Ready",

  /** The service is restoring the active generation on one or more replicas. */
  Reconciling: "Reconciling",

  /** Security policy has removed the adapter from routing. */
  Revoked: "Revoked",
}

/** Adapter format values validated by the serving runtime. */
@added(Versions.v2026_07_15_preview)
union AdapterDeploymentFormat {
  string,

  /** Hugging Face PEFT LoRA adapter format. */
  PeftLora: "PeftLora",
}

/** Service-authenticated validation results for the active adapter generation. */
@added(Versions.v2026_07_15_preview)
model AdapterDeploymentValidation {
  /** Source model version for which these values were validated. */
  sourceModelId: string;

  /** Exact base-model asset ID recorded on the adapter source. */
  sourceBaseModelId: string;

  /** Exact base-model asset ID served by the parent deployment. */
  targetBaseModelId: string;

  /** Adapter serialization and runtime format. */
  adapterFormat: AdapterDeploymentFormat;

  /** Validated LoRA rank. */
  rank: int32;

  /** Validated base-model modules modified by the adapter. */
  targetModules: string[];

  /** Capacity values evaluated when admitting this generation. */
  capacity: AdapterDeploymentCapacityValidation;

  /** Time at which the service completed this validation. */
  validatedAt: utcDateTime;
}

/** Capacity values evaluated for adapter admission. */
@added(Versions.v2026_07_15_preview)
model AdapterDeploymentCapacityValidation {
  /** Maximum active adapters supported by the target runtime and fleet. */
  adapterCountLimit: int32;

  /** Number of active adapters after admitting this generation. */
  adapterCountAfterAdmission: int32;

  /** Maximum LoRA rank supported by the target runtime. */
  rankLimit: int32;

  /** Service-estimated memory required by this adapter, in bytes. */
  estimatedAdapterMemoryBytes: int64;

  /** Adapter memory available before this generation was admitted, in bytes. */
  availableAdapterMemoryBytes: int64;
}

/** Safe customer-visible details for an administrative revocation. */
@added(Versions.v2026_07_15_preview)
model AdapterDeploymentRevocation {
  /** Stable policy or security reason code. */
  reasonCode: string;

  /** Time at which the adapter was removed from routing. */
  revokedAt: utcDateTime;

  /** Safe support and audit correlation identifier. */
  correlationId: string;
}

/** Lifecycle operation types reported by an adapter deployment. */
@added(Versions.v2026_07_15_preview)
union AdapterDeploymentOperationType {
  string,

  /** Initial adapter deployment creation. */
  Create: "Create",

  /** Replacement of the active source model version. */
  Replace: "Replace",

  /** Adapter deployment deletion. */
  Delete: "Delete",
}

/** Lifecycle operation states reported by an adapter deployment. */
@added(Versions.v2026_07_15_preview)
union AdapterDeploymentOperationState {
  string,

  /** The operation request was accepted. */
  Accepted: "Accepted",

  /** The operation is running. */
  Running: "Running",

  /** The operation completed successfully. */
  Succeeded: "Succeeded",

  /** The operation failed. */
  Failed: "Failed",

  /** The operation was canceled. */
  Canceled: "Canceled",
}

/** Rollback outcomes for a failed or canceled replacement. */
@added(Versions.v2026_07_15_preview)
union AdapterDeploymentRollbackResult {
  string,

  /** No rollback was required. */
  NotRequired: "NotRequired",

  /** Rollback completed successfully. */
  Succeeded: "Succeeded",

  /** Rollback failed. */
  Failed: "Failed",
}

/** Safe domain error details returned for adapter deployment failures. */
@added(Versions.v2026_07_15_preview)
model AdapterDeploymentErrorDetail {
  /** Stable machine-readable error code. */
  code: string;

  /** Safe customer-facing error message. */
  message: string;

  /** Request property or resource targeted by the error. */
  target?: string;

  /** Nested safe error details. */
  @identifiers(#[])
  details?: AdapterDeploymentErrorDetail[];
}

/** The most recently requested adapter lifecycle operation. */
@added(Versions.v2026_07_15_preview)
model AdapterDeploymentLastOperation {
  /** The type of lifecycle operation. */
  type: AdapterDeploymentOperationType;

  /** The current or terminal operation state. */
  status: AdapterDeploymentOperationState;

  /** The source requested by a create or replacement operation. */
  requestedSourceModelId?: string;

  /** A safe identifier used to correlate logs and support requests. */
  correlationId: string;

  /** The time at which the operation started. */
  startedAt: utcDateTime;

  /** The time at which the operation reached a terminal state. */
  completedAt?: utcDateTime;

  /** The rollback result when a replacement does not complete successfully. */
  rollbackResult?: AdapterDeploymentRollbackResult;

  /** Safe error details when the operation failed. */
  error?: AdapterDeploymentErrorDetail;
}

/** Parameters used to filter adapter deployments. */
@added(Versions.v2026_07_15_preview)
model AdapterDeploymentListParameters {
  /**
   * Filters by target deployment, source model version, provisioning state,
   * or a supported conjunction of those predicates.
   */
  @query("$filter")
  filter?: string;
}

/** A paginated collection of adapter deployments. */
@added(Versions.v2026_07_15_preview)
model AdapterDeploymentListResult {
  /** Adapter deployments in this page. */
  @pageItems
  @visibility(Lifecycle.Read)
  value: AdapterDeployment[];

  /** URL used to retrieve the next page, when one exists. */
  @nextLink
  nextLink?: url;
}

/** The result of requesting cancellation of an adapter operation. */
@added(Versions.v2026_07_15_preview)
model AdapterDeploymentCancelResult {
  /** The resulting state of the operation targeted by cancellation. */
  status: AdapterDeploymentOperationState;

  /** The operation type targeted by cancellation. */
  operationType: AdapterDeploymentOperationType;

  /** The source generation that remains active after cancellation. */
  activeSourceModelId?: string;

  /** The staged source generation removed by cancellation. */
  canceledSourceModelId?: string;

  /** A safe identifier used to correlate logs and support requests. */
  correlationId: string;
}

/** Standard conditional headers accepted by adapter PUT operations. */
alias AdapterDeploymentPutConditions = {
  /** Applies replacement only when the current resource ETag matches. */
  @header("If-Match")
  ifMatch?: string;

  /** Use `*` for create-only behavior. */
  @header("If-None-Match")
  ifNoneMatch?: string;
};

/** Conditional header required when deleting an adapter deployment. */
alias AdapterDeploymentDeleteConditions = {
  /** Applies deletion only when the current resource ETag matches. */
  @header("If-Match")
  ifMatch?: string;
};

@added(Versions.v2026_07_15_preview)
@armResourceOperations
interface AdapterDeployments {
  /** Gets an adapter deployment by name. */
  get is ArmResourceRead<AdapterDeployment>;

  /** Creates an adapter deployment or replaces its source model version. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AdapterDeployment,
    Parameters = AdapterDeploymentPutConditions
  >;

  /** Lists adapter deployments associated with the Cognitive Services account. */
  list is ArmResourceListByParent<
    AdapterDeployment,
    Parameters = AdapterDeploymentListParameters,
    Response = ArmResponse<AdapterDeploymentListResult>
  >;

  /** Cancels an in-progress create or replacement before atomic cutover. */
  cancel is ArmResourceActionAsync<
    AdapterDeployment,
    void,
    Response = ArmResponse<AdapterDeploymentCancelResult>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<
        Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
        AdapterDeploymentCancelResult,
        string
      >
  >;

  /** Drains requests and deletes an adapter deployment. */
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
  "The complete adapter deployment resource to create or replace."
);
