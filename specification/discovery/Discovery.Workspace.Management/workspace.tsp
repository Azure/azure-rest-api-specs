import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "../Discovery.Management.Shared/all.tsp";
import "../Discovery.Shared/shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Workspace tracked resource")
model Workspace is TrackedResource<WorkspaceProperties> {
  ...ResourceNameParameter<Workspace>;
}

@doc("Workspace properties")
model WorkspaceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("List of linked Storages.")
  @extension("x-ms-identifiers", #["id"])
  storageIds?: Array<Microsoft.Discovery.Shared.DiscoveryStorageId>;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("List of linked SuperComputers.")
  @extension("x-ms-identifiers", #["id"])
  supercomputerIds?: Array<Microsoft.Discovery.Shared.SuperComputerId>;

  @doc("workspace API endpoint Uri.")
  @visibility(Lifecycle.Read)
  workspaceApiUri?: url;

  @doc("workspace User Interface Uri.")
  @visibility(Lifecycle.Read)
  workspaceUiUri?: url;

  @doc("Identity IDs used for leveraging Workspace resources.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  workspaceIdentity: Microsoft.Discovery.Identity;

  ...MoboConfigurationWithMrg;
}

@armResourceOperations
interface Workspaces {
  get is ArmResourceRead<Workspace>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Workspace>;
  update is ArmResourcePatchAsync<Workspace, WorkspaceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Workspace>;
  listByResourceGroup is ArmResourceListByParent<Workspace>;
  listBySubscription is ArmListBySubscription<Workspace>;
}
