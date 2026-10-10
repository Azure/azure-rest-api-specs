import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ClientGenerator.Core;

namespace Microsoft.Cdn;

/** The SKU type for the edge action */
model SkuType {
  /** The name of the SKU */
  name: string;

  /** The tier of the SKU */
  tier: string;
}

/** The SKU type for update operations */
model SkuTypeUpdate {
  /** The name of the SKU */
  name?: string;

  /** The tier of the SKU */
  tier?: string;
}

/** The deployment type for edge action versions */
union EdgeActionVersionDeploymentType {
  string,

  /** ZIP file deployment */
  zip: "zip",

  /** Single file deployment */
  file: "file",

  /** Other deployment types */
  others: "others",
}

/** The validation status for edge action versions */
union EdgeActionVersionValidationStatus {
  string,

  /** Validation succeeded */
  Succeeded: "Succeeded",

  /** Validation failed */
  Failed: "Failed",
}

/** Indicates whether this is the default version */
union EdgeActionIsDefaultVersion {
  string,

  /** This is the default version */
  True: "True",

  /** This is not the default version */
  False: "False",
}

/** When the edge action version executes. */
@added(Versions.`2026-10-01`)
union EdgeActionVersionExecutionState {
  string,

  /** Executes when no Execution Filter is exercised. Selected by swapDefault. An associated Execution Filter may additionally trigger execution; the state remains Default. */
  Default: "Default",

  /** Executes when its associated Execution Filter is exercised, and only then. */
  Active: "Active",

  /** Never executes because nothing exists to trigger it. */
  Inactive: "Inactive",
}

/** The deployment status for edge action version code. */
@added(Versions.`2026-10-01`)
union EdgeActionDeploymentStatus {
  string,

  /** No code deployment has been durably accepted. */
  NotStarted: "NotStarted",

  /** A code deployment has been durably accepted and is not terminal. */
  InProgress: "InProgress",

  /** Code deployment succeeded. */
  Succeeded: "Succeeded",

  /** Code deployment failed. */
  Failed: "Failed",

  /** Code deployment was canceled. */
  Canceled: "Canceled",
}

/** The status of an operation */
@Azure.Core.lroStatus
union OperationStatus {
  string,

  /** Operation is running */
  Running: "Running",

  /** Operation succeeded */
  Succeeded: "Succeeded",

  /** Operation failed */
  Failed: "Failed",

  /** Operation was canceled */
  Canceled: "Canceled",
}

/** Polling guidance for an asynchronous EdgeActions operation. */
@added(Versions.`2026-10-01`)
model EdgeActionRetryAfterHeader {
  /** The Retry-After header can indicate how long the client should wait before polling the operation status. */
  @header("Retry-After")
  @minValue(10)
  @maxValue(600)
  retryAfter?: int32;
}

// The ARM asynchronous contract requires the result endpoint to repeat Location on every
// non-final 202, so a client that retains only the most recent response can still poll.
/** Polling headers returned by the operation-result endpoint while the result is not final. */
@added(Versions.`2026-10-01`)
model EdgeActionOperationResultPollingHeaders {
  /** The URL to poll for the result of this operation. */
  @Azure.Core.pollingLocation
  @header("Location")
  location: url;

  ...EdgeActionRetryAfterHeader;
}

/** Polling headers for an asynchronous EdgeActions PUT response. */
@added(Versions.`2026-10-01`)
model EdgeActionPutLroHeaders<FinalResult extends TypeSpec.Reflection.Model> {
  ...ArmAsyncOperationHeader<
    StatusMonitor = EdgeActionOperationStatus,
    UrlValue = ResourceLocation<EdgeActionOperationStatus>,
    FinalResult = FinalResult
  >;
  ...EdgeActionRetryAfterHeader;
}

/** Resource replacement accepted for asynchronous processing. */
@added(Versions.`2026-10-01`)
@doc("Resource '{name}' update operation succeeded", Resource)
model EdgeActionResourceUpdatedLroResponse<Resource extends Azure.ResourceManager.Foundations.SimpleResource> {
  ...ArmResourceUpdatedResponse<Resource>;
  ...EdgeActionPutLroHeaders<Resource>;
}

@pattern("[a-zA-Z0-9]+")
@maxLength(50)
scalar smallString extends string;

@doc("Azure resource identifier for attached routes")
scalar AttachedResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Cdn/Profiles/afdEndpoints/routes",
    }
  ]>;

@doc("Azure resource identifier for edge action versions")
scalar EdgeActionVersionId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Cdn/edgeActions/versions",
    }
  ]>;

/** The status of the current operation */
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Upgrade in progress")
  Upgrading: "Upgrading",

  /** Deletion is in progress. */
  @added(Versions.`2026-10-01`)
  Deleting: "Deleting",
}

/** Edge action attachment information */
model EdgeActionAttachment {
  @doc("The edge action attachment id")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.`2025-12-01-preview`)
  id?: string;

  @doc("The attached resource Id")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  attachedResourceId: AttachedResourceId;
}

/** Edge action attachment response */
@clientName("EdgeActionAttachmentResult", "csharp")
model EdgeActionAttachmentResponse {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility with 2024-07-22-preview"
  @doc("Non changing guid to identity edge action")
  @extension("x-ms-mutability", #["read", "update", "create"])
  edgeActionId: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@doc("Represents an edge action properties")
model EdgeActionProperties {
  @doc("The provisioning state of the edge action")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("A list of attachments for the edge action")
  @visibility(Lifecycle.Read)
  attachments: EdgeActionAttachment[];
}

/** The type used for update operations of the EdgeAction. */
model EdgeActionUpdate {
  @doc("The resource-specific properties for this resource.")
  @removed(Versions.`2026-10-01`)
  properties?: EdgeActionPropertiesUpdate;

  @doc("The sku type of the edge action")
  @removed(Versions.`2026-10-01`)
  sku?: SkuTypeUpdate;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;
}

/** The type used for update operations of the EdgeActionVersion. */
@added(Versions.`2026-10-01`)
model EdgeActionVersionUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

/** Represents an edge action properties */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EdgeActionPropertiesUpdate {}

@doc("Represents an edge action version")
model EdgeActionVersionProperties {
  @doc("The deployment type")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  deploymentType: EdgeActionVersionDeploymentType;

  @doc("The validation status")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.`2025-12-01-preview`)
  validationStatus?: EdgeActionVersionValidationStatus;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The active state")
  @removed(Versions.`2026-10-01`)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isDefaultVersion: EdgeActionIsDefaultVersion;

  /** How this version receives traffic. */
  @added(Versions.`2026-10-01`)
  @visibility(Lifecycle.Read)
  versionExecutionState: EdgeActionVersionExecutionState;

  /** The status of the latest accepted code deployment. */
  @added(Versions.`2026-10-01`)
  @visibility(Lifecycle.Read)
  deploymentStatus: EdgeActionDeploymentStatus;

  @doc("The last update time in UTC for package update")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.`2025-12-01-preview`)
  lastPackageUpdateTime?: utcDateTime;
}

/** Properties for edge action execution filter */
model EdgeActionExecutionFilterProperties {
  @doc("The referenced versionId of the edgeaction version")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  versionId: EdgeActionVersionId;

  @doc("The last update time in UTC for the execution filter")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.`2025-12-01-preview`)
  lastUpdateTime?: utcDateTime;

  @doc("Custom Header Key associated with the execution filter")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  executionFilterIdentifierHeaderName: string;

  @doc("Custom Header Value associated with the execution filter")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  executionFilterIdentifierHeaderValue: string;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Version code information for edge action */
model VersionCode {
  @doc("The version code deployment content ")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  content: string;

  @doc("The version code name")
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "name")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  namePreview: string;
}

/** Error details for operations */
model ErrorDetails {
  @doc("Error code.")
  code: string;

  @doc("Detailed error message.")
  message: string;
}

/**
 * The current status of an Edge Action asynchronous operation. This is the body served by the
 * `Azure-AsyncOperation` polling URL, and it follows the Azure Resource Manager asynchronous
 * operation status format: `id` addresses the status resource, `name` is the operation
 * identifier, and `properties` carries the operation outcome once the operation succeeds.
 * `percentComplete` and nested `operations` are intentionally omitted, because the service
 * reports neither. There is no `resourceId`: the preview api-versions returned that name
 * carrying the operation status resource URL, which is the value `id` now carries, so this is
 * a rename rather than a dropped field. The identifier of the resource the operation ran
 * against is not recorded on the operation, so no field claims to supply it.
 */
@added(Versions.`2026-10-01`)
model EdgeActionOperationStatus {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The success snapshot is the body the originating operation would have returned synchronously, so its shape varies by operation. Microsoft.DBforMySQL OperationStatusExtendedResult sets the same precedent."
  @doc("Edge Action specific properties for the operation status resource. Only present when the operation ended with a Succeeded status.")
  @visibility(Lifecycle.Read)
  properties?: Record<unknown>;

  @doc("The current status of the operation.")
  @visibility(Lifecycle.Read)
  status: OperationStatus;

  @doc("The fully qualified identifier of the operation status resource itself, which is the URL used to read this status. Preview api-versions returned this same value under the name resourceId.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The name of the operation status resource, which is the operation identifier.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The operation type.")
  @visibility(Lifecycle.Read)
  operationType: string;

  @doc("The start time of the operation.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("The end time of the operation (if completed).")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("The error detail, present when the operation ended with a Failed or Canceled status.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * The operation completed. The body is the response the originating operation would have produced
 * had it run synchronously, so its shape depends on that operation and is not one fixed schema.
 * There is no `status` field here; the outcome is the HTTP status code.
 */
@added(Versions.`2026-10-01`)
model EdgeActionOperationCompletedResult is OkResponse;

// The Location result route declares no 200 schema. Its body is whatever the originating
// operation would have returned synchronously, and OpenAPI cannot key a body to the operation an
// id names. Reusing EdgeActionOperationStatus here would advertise status and error fields the
// result contract does not have, so the earlier `EdgeActionOperationResult is
// EdgeActionOperationStatus` alias was removed. Published stable precedent for a schema-less
// result 200 alongside a typed status 200: Microsoft.ApiManagement stable 2024-05-01
// operationStatuses.json, Microsoft.Synapse stable 2020-12-01 operations.json, and
// Microsoft.RecoveryServices RecoveryServicesBackup stable 2016-06-01.
