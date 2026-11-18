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
@removed(Versions.`2026-10-01`)
@renamedFrom(Versions.`2026-10-01`, "SkuTypeUpdate")
model SkuTypeUpdateV1 {
  /** The name of the SKU */
  name?: string;

  /** The tier of the SKU */
  tier?: string;
}

/** The SKU fields in the update model. Do not include sku in PATCH requests; any supplied sku, including null or the existing value, is rejected. */
@added(Versions.`2026-10-01`)
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
@added(Versions.`2027-01-01-preview`)
union EdgeActionVersionExecutionState {
  string,

  /** Executes when no execution filter is exercised, and may also execute through an associated filter. Selected by swapDefault. */
  Default: "Default",

  /** Executes only when an associated execution filter is exercised. */
  Active: "Active",

  /** Never executes because no trigger is configured. */
  Inactive: "Inactive",
}

/** The status of the latest accepted code deployment. */
@added(Versions.`2027-01-01-preview`)
union EdgeActionDeploymentStatus {
  string,

  /** No code deployment has been durably accepted. */
  NotStarted: "NotStarted",

  /** An accepted code deployment is not terminal. */
  InProgress: "InProgress",

  /** Code deployment succeeded. */
  Succeeded: "Succeeded",

  /** Code deployment failed. */
  Failed: "Failed",

  /** Code deployment was canceled. */
  Canceled: "Canceled",
}

/** The status of an operation */
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
  @added(Versions.`2027-01-01-preview`)
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
@removed(Versions.`2026-10-01`)
@renamedFrom(Versions.`2026-10-01`, "EdgeActionUpdate")
model EdgeActionUpdateV1 {
  @doc("The resource-specific properties for this resource.")
  properties?: EdgeActionPropertiesUpdate;

  @doc("The sku type of the edge action")
  sku?: SkuTypeUpdateV1;

  ...ArmTagsProperty;
}

/** The type used for update operations of the EdgeAction. */
@added(Versions.`2026-10-01`)
model EdgeActionUpdate {
  @doc("The resource-specific properties for this resource.")
  @removed(Versions.`2027-01-01-preview`)
  properties?: EdgeActionPropertiesUpdate;

  @doc("The SKU of the Edge Action. Do not include sku in PATCH requests; any supplied sku, including null or the existing value, is rejected.")
  @removed(Versions.`2027-01-01-preview`)
  sku?: SkuTypeUpdate;

  ...ArmTagsProperty;
}

@@doc(
  EdgeActionUpdate.tags,
  "Resource tags. For PATCH requests, omitted tags are preserved, an empty tags object clears all tags, and supplied tags replace the entire tag collection. Null tags are rejected."
);

/** The type used to update an Edge Action version's tags. */
@added(Versions.`2027-01-01-preview`)
model EdgeActionVersionUpdate {
  ...ArmTagsProperty;
}

@@doc(
  EdgeActionVersionUpdate.tags,
  "Resource tags. Omitted tags are preserved, an empty object clears all tags, and supplied tags replace the entire collection. Null tags are rejected."
);

/** Represents an edge action properties */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EdgeActionPropertiesUpdate {}

@doc("Represents an edge action version")
model EdgeActionVersionProperties {
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "deploymentType")
  @doc("The deployment type")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  deploymentTypeV1: EdgeActionVersionDeploymentType;

  @added(Versions.`2026-10-01`)
  @doc("The deployment type for the Edge Action version. Set this value when creating the version. When updating an existing version, any supplied value must match the existing value.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  deploymentType: EdgeActionVersionDeploymentType;

  @doc("The validation status")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.`2025-12-01-preview`)
  validationStatus?: EdgeActionVersionValidationStatus;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "isDefaultVersion")
  @doc("The active state")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isDefaultVersionV1: EdgeActionIsDefaultVersion;

  @added(Versions.`2026-10-01`)
  @removed(Versions.`2027-01-01-preview`)
  @doc("Indicates whether this is the default version. When creating a version, if the Edge Action has no default version, the service makes the new version the default even when false is supplied. If another default version exists, supplying true is rejected. When updating an existing version, any supplied value must match the existing value. Use swapDefault to change the default version.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isDefaultVersion: EdgeActionIsDefaultVersion;

  /** How this version receives traffic. Use swapDefault to select the default version. */
  @added(Versions.`2027-01-01-preview`)
  @visibility(Lifecycle.Read)
  versionExecutionState: EdgeActionVersionExecutionState;

  /** The status of the latest accepted code deployment. */
  @added(Versions.`2027-01-01-preview`)
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
  @removed(Versions.`2027-01-01-preview`)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;
}

/** Edge action operation properties */
model EdgeActionOperationProperties {
  @doc("The resource id of the operation.")
  resourceId: string;

  @doc("The GUID representing operationID.")
  operationId: string;

  @doc("The current status of the operation.")
  status: OperationStatus;

  @doc("The operation type.")
  operationType: string;

  @doc("The start time of the operation.")
  startTime?: utcDateTime;

  @doc("The end time of the operation (if completed).")
  endTime?: utcDateTime;

  @doc("Error details, if applicable.")
  error?: ErrorDetails;
}

/** The flat operation-status response returned by the Azure-AsyncOperation polling endpoint. */
@added(Versions.`2026-10-01`)
@example(
  #{
    resourceId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/testrg/providers/Microsoft.Cdn/edgeActionOperations/00000000-0000-0000-0000-000000000000",
    operationId: "00000000-0000-0000-0000-000000000000",
    status: "Succeeded",
    operationType: "update",
    startTime: utcDateTime.fromISO("2026-10-01T12:00:00Z"),
    endTime: utcDateTime.fromISO("2026-10-01T12:00:10Z"),
  },
  #{ title: "Successful version code deployment status" }
)
model EdgeActionOperation is EdgeActionOperationProperties;

@@Azure.Core.lroStatus(EdgeActionOperation.status);
@@Azure.Core.lroErrorResult(EdgeActionOperation.error);

/** The synchronous result's JSON object, whose fields depend on the originating operation. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Operation results and success snapshots have heterogeneous response fields, not user-editable resource configuration."
@added(Versions.`2027-01-01-preview`)
model EdgeActionOperationResultPayload is Record<unknown>;

/** The preview operation-status record served by Azure-AsyncOperation, not the operation's final result. */
@added(Versions.`2027-01-01-preview`)
model EdgeActionOperationStatus {
  /** The status-resource URL, previously returned as resourceId. */
  @visibility(Lifecycle.Read)
  id: string;

  /** The operation identifier, previously returned as operationId. */
  @visibility(Lifecycle.Read)
  name: string;

  /** The current status of the operation. Failed operations still return HTTP 200 from the status endpoint. */
  @visibility(Lifecycle.Read)
  status: OperationStatus;

  /** The operation type. */
  @visibility(Lifecycle.Read)
  operationType: string;

  /** The start time of the operation. */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /** The end time of the completed operation. */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /** The error detail for a failed or canceled operation. */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  /** The originating operation's synchronous response snapshot, present only after success. */
  @visibility(Lifecycle.Read)
  properties?: EdgeActionOperationResultPayload;
}

@@Azure.Core.lroStatus(EdgeActionOperationStatus.status);
@@Azure.Core.lroErrorResult(EdgeActionOperationStatus.error);

/** Polling delay in seconds for preview operations. */
@added(Versions.`2027-01-01-preview`)
model EdgeActionRetryAfterHeader {
  /** The delay in seconds before the next poll. */
  @header("Retry-After")
  @minValue(10)
  @maxValue(600)
  retryAfter?: int32;
}

/** Headers repeated while the operation result is pending. */
@added(Versions.`2027-01-01-preview`)
model EdgeActionOperationResultPollingHeaders {
  /** The absolute URL to poll for the operation result. */
  @Azure.Core.pollingLocation
  @header("Location")
  location: url;

  ...EdgeActionRetryAfterHeader;
}

/** Completion with the originating operation's synchronous response body, whose schema varies by operation. */
@added(Versions.`2027-01-01-preview`)
model EdgeActionOperationCompletedResult {
  /** The originating operation completed successfully. */
  @statusCode statusCode: 200;

  /** The originating operation's synchronous result, whose JSON shape varies by operation. */
  @body body: EdgeActionOperationResultPayload;
}

/** Error details for operations */
model ErrorDetails {
  @doc("Error code.")
  code: string;

  @doc("Detailed error message.")
  message: string;
}
