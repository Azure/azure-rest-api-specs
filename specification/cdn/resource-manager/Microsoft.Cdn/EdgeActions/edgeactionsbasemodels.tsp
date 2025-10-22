import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Cdn;

model SkuType {
  name: string;
  tier: string;
}

enum EdgeActionVersionDeploymentType {
  zip,
  file,
  others,
}

enum EdgeActionVersionValidationStatus {
  Succeeded,
  Failed,
}

enum EdgeActionIsDefaultVersion {
  True,
  False,
}

enum OperationStatus {
  Running,
  Succeeded,
  Failed,
  Canceled,
}

@pattern("[a-zA-Z0-9]+")
@maxLength(50)
scalar smallString extends string;

@doc("ARM resource identifier for attached routes")
scalar AttachedResourceId extends Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Cdn/Profiles/afdEndpoints/routes";
  }
]>;

@doc("ARM resource identifier for edge action versions")
scalar EdgeActionVersionId extends Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Cdn/edgeActions/versions";
  }
]>;

@doc("The status of the current operation")
@Azure.Core.lroStatus
enum ProvisioningState {
  @doc("The operation completed successfully")
  Succeeded,

  @doc("The operation failed")
  Failed,

  @doc("The operation was canceled")
  Canceled,

  @doc("Initial provisioning in progress")
  Provisioning,

  @doc("Upgrade in progress")
  Upgrading,
}

model EdgeActionAttachment {
  @doc("The edge action attachment id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The attached resource Id")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  attachedResourceId: AttachedResourceId;
}

model EdgeActionAttachmentResponse {
  @doc("Non changing guid to identity edge action")
  @visibility(Lifecycle.Read)
  edgeActionId: string;
}

@doc("Represents an edge action properties")
model EdgeActionProperties {
  @doc("The provisioning state of the edge action")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("A list of attachments for the edge action")
  @visibility(Lifecycle.Read)
  attachments: EdgeActionAttachment[];
}

@doc("Represents an edge action version")
model EdgeActionVersionProperties {
  @doc("The deployment type")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  deploymentType: EdgeActionVersionDeploymentType;

  @doc("The validation status")
  @visibility(Lifecycle.Read)
  validationStatus: EdgeActionVersionValidationStatus;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The active state")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isDefaultVersion: EdgeActionIsDefaultVersion;

  @doc("The last update time in UTC for package update")
  @visibility(Lifecycle.Read)
  lastPackageUpdateTime: utcDateTime;
}

model EdgeActionExecutionFilterProperties {
  @doc("The referenced versionId of the edgeaction version")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  versionId: EdgeActionVersionId;

  @doc("The last update time in UTC for the execution filter")
  @visibility(Lifecycle.Read)
  lastUpdateTime: utcDateTime;

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

model VersionCode {
  @doc("The version code deployment content ")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  content: string;

  @doc("The version code name")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;
}

model EmptyBody {}

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

model ErrorDetails {
  @doc("Error code.")
  code: string;

  @doc("Detailed error message.")
  message: string;
}
