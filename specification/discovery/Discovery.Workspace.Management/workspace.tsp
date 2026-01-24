import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "../Discovery.Management.Shared/all.tsp";
import "../Discovery.Management.Shared/control-plane.tsp";
import "./workspacePrivateEndpointConnection.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.Discovery.Shared;
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

  @removed(Versions.v2026_02_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("List of linked Storages.")
  storageIds?: Array<Microsoft.Discovery.Shared.DiscoveryStorageId>;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("List of linked SuperComputers.")
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

  @doc("Whether or not to use a customer managed key when encrypting data at rest")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2026_02_01_preview)
  // Typically this would be something like "KeySource = 'Microsoft.KeyVault' or 'Microsoft.Discovery'". Encryption is all done by downstream services, so keeping this API simplified.
  customerManagedKeys?: CustomerManagedKeys;

  @doc("The key to use for encrypting data at rest when customer managed keys are enabled.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2026_02_01_preview)
  keyVaultProperties?: KeyVaultProperties;

  @doc("The Log Analytics Cluster to use for debug logs. This is required when Customer Managed Keys are enabled.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2026_02_01_preview)
  logAnalyticsClusterId?: Microsoft.Discovery.Shared.LogAnalyticsClusterId;

  @doc("List of private endpoint connections.")
  @visibility(Lifecycle.Read)
  @added(Microsoft.Discovery.Versions.v2026_02_01_preview)
  @identifiers(#["id"])
  privateEndpointConnections?: Azure.ResourceManager.CommonTypes.PrivateEndpointConnection[];

  @doc("Whether or not public network access is allowed for this resource. For security reasons, it is recommended to disable it whenever possible.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2026_02_01_preview)
  publicNetworkAccess?: PublicNetworkAccess;

  /**
    Agent Subnet ID for agent resources.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2026_02_01_preview)
  agentSubnetId?: Microsoft.Discovery.Shared.SubnetId;

  /**
    Private Endpoint Subnet ID for private endpoint connections.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2026_02_01_preview)
  privateEndpointSubnetId?: Microsoft.Discovery.Shared.SubnetId;

  /**
    Function Subnet ID for workspace resources.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2026_02_01_preview)
  workspaceSubnetId?: Microsoft.Discovery.Shared.SubnetId;

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
