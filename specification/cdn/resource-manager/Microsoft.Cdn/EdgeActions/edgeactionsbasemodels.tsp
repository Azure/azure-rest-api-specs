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
  properties?: EdgeActionPropertiesUpdate;

  @doc("The sku type of the edge action")
  sku?: SkuTypeUpdate;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;
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
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isDefaultVersion: EdgeActionIsDefaultVersion;

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

/** Error details for operations */
model ErrorDetails {
  @doc("Error code.")
  code: string;

  @doc("Detailed error message.")
  message: string;
}
