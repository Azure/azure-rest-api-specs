import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.NetApp;

/**
 * Active Directory Configuration resource
 */
@added(Versions.v2025_09_01_preview)
model ActiveDirectoryConfig
  is TrackedResource<ActiveDirectoryConfigProperties> {
  ...ResourceNameParameter<
    Resource = ActiveDirectoryConfig,
    KeyName = "activeDirectoryConfigName",
    SegmentName = "activeDirectoryConfigs",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$"
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy EntityTagProperty for back compatibility"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * Active Directory Configuration properties
 */
@added(Versions.v2025_09_01_preview)
model ActiveDirectoryConfigProperties {
  ...ActiveDirectoryConfigCommonProperties;

  /**
   * Azure lifecycle management.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /** Name of the Active Directory domain */
  @maxLength(255)
  domain: string;

  /** Access password from Azure KeyVault Secrets to connect Active Directory */
  secretPassword: SecretPassword;
}

/** Active Directory Configuration common properties */
@added(Versions.v2025_09_01_preview)
model ActiveDirectoryConfigCommonProperties {
  /** A domain user account with permission to create machine accounts */
  @maxLength(255)
  userName?: string;

  /** An array of DNS server IP addresses(IPv4 only) for the Active Directory */
  dns?: ipV4Address[];

  /** NetBIOS name of the SMB server. This name will be registered as a computer account in the AD and used to mount volumes */
  @maxLength(10)
  smbServerName?: string;

  /** The Organizational Unit (OU) within the Windows Active Directory */
  @maxLength(255)
  organizationalUnit?: string;

  /** The Active Directory site the service will limit Domain Controller discovery to */
  @maxLength(63)
  site?: string;

  /** Users to be added to the Built-in Backup Operator active directory group. A list of unique usernames without domain specifier */
  backupOperators?: string[];

  /** Users to be added to the Built-in Administrators active directory group. A list of unique usernames without domain specifier */
  administrators?: string[];

  /** Domain Users in the Active directory to be given SecurityPrivilege privilege (Needed for SMB Continuously available shares for SQL). A list of unique usernames without domain specifier */
  securityOperators?: string[];

  /** Status of the Active Directory */
  @visibility(Lifecycle.Read)
  activeDirectoryStatus?: ActiveDirectoryStatus;
}

/** Access password from Azure KeyVault Secrets to connect Active Directory */
@added(Versions.v2025_09_01_preview)
model SecretPassword {
  /** Properties provided by KeyVault. */
  keyVaultProperties?: SecretPasswordKeyVaultProperties;

  /** Identity used to authenticate to KeyVault. Applicable if keySource is 'Microsoft.KeyVault'. */
  identity?: SecretPasswordIdentity;
}

/** Properties of key vault to get the secrets for password. */
@added(Versions.v2025_09_01_preview)
model SecretPasswordKeyVaultProperties {
  /** The Uri of KeyVault. */
  @maxLength(255)
  keyVaultUri: url;

  /** The name of KeyVault password secret. */
  @maxLength(127)
  secretName: string;
}

/** Identity used to authenticate with key vault. */
@added(Versions.v2025_09_01_preview)
model SecretPasswordIdentity {
  /** The principal ID (object ID) of the identity used to authenticate with key vault. Read-only. */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /** The Azure resource identifier of the user assigned identity used to authenticate with key vault. Applicable if identity.type has 'UserAssigned'. It should match key of identity.userAssignedIdentities. */
  userAssignedIdentity?: string;
}

/** Active Directory Configuration patch properties */
@added(Versions.v2025_09_01_preview)
model ActiveDirectoryConfigPatchProperties {
  ...ActiveDirectoryConfigCommonProperties;

  /** Access Password from Azure KeyVault Secret to connect Active Directory on patch */
  secretPassword?: SecretPasswordPatch;
}

/** Access Password from Azure KeyVault Secret to connect Active Directory on patch */
@added(Versions.v2025_09_01_preview)
model SecretPasswordPatch {
  /** Patch Properties provided by KeyVault. */
  keyVaultProperties?: SecretPasswordKeyVaultPatchProperties;

  /** Identity used to authenticate to KeyVault. Applicable if keySource is 'Microsoft.KeyVault'. */
  identity?: SecretPasswordIdentity;
}

/** Patch Properties of key vault to get the secrets for password. */
@added(Versions.v2025_09_01_preview)
model SecretPasswordKeyVaultPatchProperties {
  /** The Uri of KeyVault. */
  @maxLength(255)
  keyVaultUri?: url;

  /** The name of KeyVault password secret. */
  @maxLength(127)
  secretName?: string;
}

@armResourceOperations
interface ActiveDirectoryConfigs {
  /** Get the details of the specified active directory configuration */
  @added(Versions.v2025_09_01_preview)
  get is ArmResourceRead<ActiveDirectoryConfig>;

  /** Create or update the specified active directory configuration */
  @added(Versions.v2025_09_01_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ActiveDirectoryConfig>;

  /** Patch the specified active directory configuration */
  @added(Versions.v2025_09_01_preview)
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    ActiveDirectoryConfig,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ActiveDirectoryConfig,
      ActiveDirectoryConfigProperties
    >,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ActiveDirectoryConfig> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Delete the specified Active Directory configuration */
  @added(Versions.v2025_09_01_preview)
  delete is ArmResourceDeleteWithoutOkAsync<ActiveDirectoryConfig>;

  /** List all active directory configurations within the resource group. */
  @added(Versions.v2025_09_01_preview)
  listByResourceGroup is ArmResourceListByParent<ActiveDirectoryConfig>;

  /** List all active directory configurations within the subscription */
  @added(Versions.v2025_09_01_preview)
  listBySubscription is ArmListBySubscription<ActiveDirectoryConfig>;
}

@@maxLength(ActiveDirectoryConfig.name, 64);
@@minLength(ActiveDirectoryConfig.name, 1);
