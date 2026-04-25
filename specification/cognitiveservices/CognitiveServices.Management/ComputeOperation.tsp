import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * The status of an async compute operation.
 */
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
@added(Versions.v2026_03_15_preview)
@removed(Versions.v2026_05_01)
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model ComputeOperationStatus
  is Azure.ResourceManager.ProxyResource<ComputeOperationStatusProperties> {
  ...ResourceNameParameter<
    Resource = ComputeOperationStatus,
    KeyName = "operationId",
    SegmentName = "computeOperations",
    NamePattern = ""
  >;
}

@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
@added(Versions.v2026_03_15_preview)
@removed(Versions.v2026_05_01)
@armResourceOperations
interface ComputeOperations {
  /**
   * Gets the status of a compute operation.
   */
  get is ArmResourceRead<
    ComputeOperationStatus,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(ComputeOperationStatus.name, "The ID of the compute operation.");
@@doc(ComputeOperationStatus.properties,
  "The properties of the compute operation status."
);

/**
 * The properties of a compute operation status.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Operation status resource does not have a provisioning state"
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
@added(Versions.v2026_03_15_preview)
@removed(Versions.v2026_05_01)
model ComputeOperationStatusProperties {
  /**
   * The start time of the operation.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * The end time of the operation.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * The status of the operation.
   */
  status?: ComputeOperationStatusType;

  /**
   * Error details if the operation failed.
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * The status type of a compute operation.
 */
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
@added(Versions.v2026_03_15_preview)
@removed(Versions.v2026_05_01)
union ComputeOperationStatusType {
  string,

  /** The operation is in progress. */
  InProgress: "InProgress",

  /** The operation has succeeded. */
  Succeeded: "Succeeded",

  /** The operation has failed. */
  Failed: "Failed",

  /** The operation has been canceled. */
  Canceled: "Canceled",
}
