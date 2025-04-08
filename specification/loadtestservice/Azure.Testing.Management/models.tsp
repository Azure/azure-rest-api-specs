import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Azure.Testing.Shared";

using Azure.Core;
using Azure.ResourceManager;
using Azure.Testing.Shared;

namespace Azure.Testing.Management;

@doc("An Azure Testing workspace resource.")
model Workspace is TrackedResource<WorkspaceProperties> {
  ...ResourceNameParameter<Workspace>;
  ...ResourceKindProperty;
}

@doc("The Azure Testing workspace resource properties.")
model WorkspaceProperties {
  @doc("The workspace additional dynamic properties.")
  additionalProperties?: WorkspaceAdditionalProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last resource operation.")
  provisioningState?: ProvisioningState;
}

@doc("The status of the last resource operation.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Creation in progress..")
  Creating: "Creating",

  @doc("Deletion in progress..")
  Deleting: "Deleting",

  @doc("Request accepted for processing..")
  Accepted: "Accepted",
}
