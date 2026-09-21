import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "../models.tsp";
import "./ExternalResourceEnums.tsp";

using Azure.ResourceManager;
using Azure.Core;
using Versioning;
using Rest;
using Http;

namespace Microsoft.NetApp;

/**
 * External Cluster resource, representing a cluster on an external NetApp ONTAP system
 */
@added(Versions.v2026_08_15_preview)
@resource("externalClusters")
model ExternalCluster
  is Azure.ResourceManager.TrackedResource<ExternalClusterProperties> {
  ...ResourceNameParameter<
    Resource = ExternalCluster,
    KeyName = "externalClusterName",
    SegmentName = "externalClusters",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * External Cluster properties
 */
@added(Versions.v2026_08_15_preview)
model ExternalClusterProperties {
  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /**
   * Intercluster LIFs, external cluster IPs for cluster peer connection
   */
  interclusterLifsIpAddresses: ipV4Address[];

  /**
   * Key Vault authentication configuration for cluster peering passphrase
   */
  clusterPeerPassphraseKeyVault: KeyVaultClusterPeerPassphraseProperties;
}

/**
 * External Cluster properties for PATCH operations
 */
@added(Versions.v2026_08_15_preview)
model ExternalClusterPatchProperties {
  /**
   * Intercluster LIFs, external cluster IPs for cluster peer connection
   */
  interclusterLifsIpAddresses?: ipV4Address[];

  /**
   * Key Vault authentication configuration for cluster peering passphrase
   */
  clusterPeerPassphraseKeyVault?: KeyVaultClusterPeerPassphrasePatchProperties;
}

/**
 * Key Vault authentication properties for PATCH operations
 */
@added(Versions.v2026_08_15_preview)
model KeyVaultClusterPeerPassphrasePatchProperties {
  /**
   * The Azure Key Vault URI where the passphrase for cluster peering handshake is stored
   */
  keyVaultUri?: url;

  /**
   * The name of the secret in Azure Key Vault. Passphrase for cluster peering handshake is stored in this secret.
   */
  @minLength(1)
  @maxLength(127)
  @pattern("^[a-zA-Z0-9-]+$")
  secretName?: string;

  /**
   * The ARM resource identifier of the user assigned identity used to authenticate with key vault. If not provided, system-assigned identity will be used.
   */
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/**
 * Key Vault authentication properties
 */
@added(Versions.v2026_08_15_preview)
model KeyVaultClusterPeerPassphraseProperties {
  /**
   * The Azure Key Vault URI where the passphrase for cluster peering handshake is stored
   */
  keyVaultUri: url;

  /**
   * The name of the secret in Azure Key Vault. Passphrase for cluster peering handshake is stored in this secret.
   */
  @minLength(1)
  @maxLength(127)
  @pattern("^[a-zA-Z0-9-]+$")
  secretName: string;

  /**
   * The ARM resource identifier of the user assigned identity used to authenticate with key vault. If not provided, system-assigned identity will be used.
   */
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}
/**
 * List of External Cluster resources
 */
@added(Versions.v2026_08_15_preview)
model ExternalClusterList is Azure.Core.Page<ExternalCluster>;

@added(Versions.v2026_08_15_preview)
@armResourceOperations
interface ExternalClusters {
  /**
   * Get the External Cluster
   */
  get is ArmResourceRead<ExternalCluster>;

  /**
   * Create or update the specified External Cluster
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExternalCluster>;

  /**
   * Patch the specified External Cluster
   */
  @patch
  update is ArmCustomPatchAsync<
    ExternalCluster,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ExternalCluster,
      ExternalClusterPatchProperties
    >,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ExternalCluster> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the specified External Cluster
   */
  delete is ArmResourceDeleteWithoutOkAsync<ExternalCluster>;

  /**
   * List all External Clusters in the resource group
   */
  listByResourceGroup is ArmResourceListByParent<
    ExternalCluster,
    Response = ArmResponse<ExternalClusterList>
  >;

  /**
   * List all External Clusters in the subscription
   */
  listBySubscription is ArmListBySubscription<
    ExternalCluster,
    Response = ArmResponse<ExternalClusterList>
  >;
}
