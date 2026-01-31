import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../Discovery.Management.Shared/all.tsp";
import "./bookshelfPrivateEndpointConnection.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.Discovery.Shared;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Bookshelf tracked resource")
model Bookshelf is TrackedResource<BookshelfProperties> {
  ...ResourceNameParameter<Bookshelf>;
}

@doc("Key Vault Properties with clientId selection")
@added(Versions.v2026_02_01_preview)
model BookshelfKeyVaultProperties is KeyVaultProperties {
  @doc("The client ID of the identity to use for accessing the Key Vault. Must be a workload identity assigned to the Bookshelf resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identityClientId: string;
}

@doc("Bookshelf properties")
model BookshelfProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("User assigned identity IDs to be used by knowledgebase workloads.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2026_02_01_preview)
  workloadIdentities?: Record<Azure.ResourceManager.CommonTypes.UserAssignedIdentity | null>;

  @doc("Whether or not to use a customer managed key when encrypting data at rest")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2026_02_01_preview)
  // Typically this would be something like "KeySource = 'Microsoft.KeyVault' or 'Microsoft.Discovery'". Encryption is all done by downstream services, so keeping this API simplified.
  customerManagedKeys?: CustomerManagedKeys;

  @doc("The key to use for encrypting data at rest when customer managed keys are enabled. Required if Customer Managed Keys is enabled.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2026_02_01_preview)
  keyVaultProperties?: BookshelfKeyVaultProperties;

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
    Private Endpoint Subnet ID for private endpoint connections.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2026_02_01_preview)
  privateEndpointSubnetId?: Microsoft.Discovery.Shared.SubnetId;

  /**
    Search Subnet ID for search resources.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2026_02_01_preview)
  searchSubnetId?: Microsoft.Discovery.Shared.SubnetId;

  ...MoboConfigurationWithMrg;

  /** The bookshelf data plane API URI */
  @visibility(Lifecycle.Read)
  bookshelfUri?: url;
}

@armResourceOperations
interface Bookshelves {
  get is ArmResourceRead<Bookshelf>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Bookshelf>;
  update is ArmResourcePatchAsync<Bookshelf, BookshelfProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Bookshelf>;
  listByResourceGroup is ArmResourceListByParent<Bookshelf>;
  listBySubscription is ArmListBySubscription<Bookshelf>;
}
