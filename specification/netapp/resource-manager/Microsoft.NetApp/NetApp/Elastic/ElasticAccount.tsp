import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./../models.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;

/**
 * NetApp elastic account resource
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model ElasticAccount is TrackedResource<ElasticAccountProperties> {
  ...ResourceNameParameter<
    Resource = ElasticAccount,
    KeyName = "accountName",
    SegmentName = "elasticAccounts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * NetApp elastic account properties
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model ElasticAccountProperties {
  /**
   * Azure lifecycle management.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /** Encryption settings */
  encryption?: ElasticEncryption;
}

/**
 * Encryption settings
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model ElasticEncryption {
  /** The encryption keySource (provider). Possible values (case-insensitive): Microsoft.NetApp, Microsoft.KeyVault */
  keySource?: KeySource;

  /** Properties provided by KeyVault. Applicable if keySource is 'Microsoft.KeyVault'. */
  keyVaultProperties?: ElasticKeyVaultProperties;

  /** Identity used to authenticate to KeyVault. Applicable if keySource is 'Microsoft.KeyVault'. */
  identity?: ElasticEncryptionIdentity;
}

/**
 * Properties of key vault.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model ElasticKeyVaultProperties {
  /** The Uri of KeyVault. */
  keyVaultUri?: url;

  /** The name of KeyVault key. */
  @minLength(1)
  @maxLength(127)
  @pattern("^[a-zA-Z0-9-]{1,127}$")
  keyName?: string;

  /** The resource ID of KeyVault. */
  keyVaultResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /** Status of the KeyVault connection. */
  @visibility(Lifecycle.Read)
  status?: ElasticKeyVaultStatus;
}

/**
 * KeyVault status
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union ElasticKeyVaultStatus {
  string,

  /** KeyVault connection created but not in use */
  Created: "Created",

  /** KeyVault connection in use by SMB Volume */
  InUse: "InUse",

  /** KeyVault connection Deleted */
  Deleted: "Deleted",

  /** Error with the KeyVault connection */
  Error: "Error",

  /** KeyVault connection Updating */
  Updating: "Updating",
}

/**
 * Identity used to authenticate with key vault.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model ElasticEncryptionIdentity {
  /** The principal ID (object ID) of the identity used to authenticate with key vault. Read-only. */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /** The ARM resource identifier of the user assigned identity used to authenticate with key vault. Applicable if identity.type has 'UserAssigned'. It should match key of identity.userAssignedIdentities. */
  userAssignedIdentity?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  /**
   * ClientId of the multi-tenant Entra ID Application. Used to access cross-tenant keyvaults.
   */
  @added(Versions.v2025_12_15_preview)
  federatedClientId?: string;
}

@armResourceOperations
interface ElasticAccounts {
  /** Get the NetApp Elastic Account */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  get is ArmResourceRead<ElasticAccount>;

  /** Create or update the specified NetApp Elastic Account within the resource group */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticAccount>;

  /** Patch the specified NetApp Elastic Account */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    ElasticAccount,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ElasticAccount,
      ElasticAccountProperties
    >,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ElasticAccount> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Delete the specified NetApp elastic account */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  delete is ArmResourceDeleteWithoutOkAsync<ElasticAccount>;

  /** List and describe all NetApp elastic accounts in the resource group. */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  listByResourceGroup is ArmResourceListByParent<ElasticAccount>;

  /** List and describe all NetApp elastic accounts in the subscription. */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  listBySubscription is ArmListBySubscription<ElasticAccount>;
}

@@clientName(ElasticAccounts.createOrUpdate::parameters.resource, "body");
@@clientName(ElasticAccounts.update::parameters.properties, "body");
