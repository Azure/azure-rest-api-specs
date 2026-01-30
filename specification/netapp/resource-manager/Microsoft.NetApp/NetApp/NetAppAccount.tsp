import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ResourceManager;
using Azure.Core;
using Http;
using Versioning;
using Rest;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;
/**
 * NetApp account resource
 */
model NetAppAccount
  is Azure.ResourceManager.TrackedResource<AccountProperties> {
  ...ResourceNameParameter<
    Resource = NetAppAccount,
    KeyName = "accountName",
    SegmentName = "netAppAccounts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$"
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy EntityTagProperty for back compatibility"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@minLength(1)
@maxLength(255)
scalar UserName extends string;

/**
 * List of NetApp account resources
 */
model NetAppAccountList is Azure.Core.Page<NetAppAccount>;

/**
 * NetApp account properties
 */
model AccountProperties {
  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Active Directories
   */
  @identifiers(#["activeDirectoryId"])
  activeDirectories?: ActiveDirectory[];

  /**
   * Entra ID configuration for the account.
   */
  @added(Versions.v2025_12_15_preview)
  entraIdConfig?: EntraIdConfig;

  /**
   * Encryption settings
   */
  encryption?: AccountEncryption;

  /**
   * Shows the status of disableShowmount for all volumes under the subscription, null equals false
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  disableShowmount?: boolean | null;

  /**
   * Domain for NFSv4 user ID mapping. This property will be set for all NetApp accounts in the subscription and region and only affect non ldap NFSv4 volumes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  nfsV4IDDomain?: VfsV4IDDomain | null;

  /**
   * MultiAD Status for the account
   */
  @visibility(Lifecycle.Read)
  multiAdStatus?: MultiAdStatus;

  /**
   * LDAP Configuration for the account.
   */
  @added(Versions.v2025_07_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_08_01_preview)
  @removed(Versions.v2025_09_01)
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  ldapConfiguration?: LdapConfiguration;
}

/**
 * Entra ID configuration for the account.
 */
@added(Versions.v2025_12_15_preview)
model EntraIdConfig {
  /**
   * ApplicationId of the app created by customer to provide authentication and required API permissions for Microsoft Graph endpoint.
   */
  @minLength(36)
  @maxLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  applicationId: string;

  /**
   * Domain of the Active directory synced to Entra ID for hybrid identities.
   */
  @maxLength(255)
  @pattern("^(?=.*[a-zA-Z])(?!.*\\.\\.)(?!.*-\\.)(?!.*\\.-)[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?)+$")
  domain: string;

  /**
   * Using ServerNamePrefix, FQDN (Fully Qualified Domain Name) will be generated for SMB share, using this FQDN, SMB Share will be mounted on Entra Joined VM.
   */
  @minLength(1)
  @maxLength(10)
  @pattern("^[A-Za-z0-9](?:[A-Za-z0-9-]{0,8}[A-Za-z0-9])?$")
  serverNamePrefix: string;

  /**
   * Using AKV config, certificate will be fetched, which will contain private key & public certificate, that correspond to the public certificate which is uploaded on the application created by customer. This will be used further for authentication.
   */
  entraIdAkvConfig?: EntraIdAkvConfig;
}

/**
 * Using AKV config, certificate will be fetched, which will contain private key & public certificate, that correspond to the public certificate which is uploaded on the application created by customer. This will be used further for authentication.
 */
@added(Versions.v2025_12_15_preview)
model EntraIdAkvConfig {
  /**
   * The Azure Key Vault URI where the Entra ID credentials are stored.
   */
  azureKeyVaultUri: url;

  /**
   * The name of the certificate in Azure Key Vault.
   */
  @minLength(1)
  @maxLength(127)
  certificateName: string;

  /**
   * The ARM resource identifier of the user assigned identity used to authenticate with key vault.
   */
  userAssignedIdentity?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/**
 * NetApp account properties for PATCH operations
 */
@added(Versions.v2025_12_15_preview)
model AccountPropertiesPatch {
  /**
   * Active Directories
   */
  @identifiers(#["activeDirectoryId"])
  activeDirectories?: ActiveDirectory[];

  /**
   * Entra ID configuration for the account.
   */
  entraIdConfig?: EntraIdConfigPatch;

  /**
   * Encryption settings
   */
  encryption?: AccountEncryption;

  /**
   * Shows the status of disableShowmount for all volumes under the subscription, null equals false
   */
  disableShowmount?: boolean;

  /**
   * Domain for NFSv4 user ID mapping. This property will be set for all NetApp accounts in the subscription and region and only affect non ldap NFSv4 volumes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  nfsV4IDDomain?: VfsV4IDDomain | null;

  /**
   * MultiAD Status for the account
   */
  multiAdStatus?: MultiAdStatus;

  /**
   * LDAP Configuration for the account.
   */
  ldapConfiguration?: LdapConfigurationPatch;
}

/**
 * LDAP configuration
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
@removed(Versions.v2025_09_01)
model LdapConfiguration {
  /**
   * Name of the LDAP configuration domain
   */
  @maxLength(255)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9.-]{0,253}[a-zA-Z0-9]$")
  domain?: string;

  /**
   * List of LDAP server IP addresses (IPv4 only) for the LDAP domain.
   */
  ldapServers?: ipV4Address[];

  /**
   * Specifies whether or not the LDAP traffic needs to be secured via TLS.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  ldapOverTLS?: boolean;

  /**
   * When LDAP over SSL/TLS is enabled, the LDAP client is required to have base64 encoded ldap servers CA certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @maxLength(10240)
  @minLength(1)
  @secret
  serverCACertificate?: string;

  /**
   * The CN host name used while generating the certificate, LDAP Over TLS requires the CN host name to create DNS host entry.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @maxLength(255)
  certificateCNHost?: string | null;
}

/**
 * LDAP configuration for PATCH operations (no default values)
 */
@added(Versions.v2025_12_15_preview)
model LdapConfigurationPatch {
  /**
   * Name of the LDAP configuration domain
   */
  @maxLength(255)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9.-]{0,253}[a-zA-Z0-9]$")
  domain?: string;

  /**
   * List of LDAP server IP addresses (IPv4 only) for the LDAP domain.
   */
  ldapServers?: ipV4Address[];

  /**
   * Specifies whether or not the LDAP traffic needs to be secured via TLS.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  ldapOverTLS?: boolean;

  /**
   * When LDAP over SSL/TLS is enabled, the LDAP client is required to have base64 encoded ldap servers CA certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @maxLength(10240)
  @minLength(1)
  @secret
  serverCACertificate?: string;

  /**
   * The CN host name used while generating the certificate, LDAP Over TLS requires the CN host name to create DNS host entry.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @maxLength(255)
  certificateCNHost?: string | null;
}

@maxLength(255)
@pattern("^[a-zA-Z0-9][a-zA-Z0-9.-]{0,253}[a-zA-Z0-9]$")
scalar VfsV4IDDomain extends string;

/**
 * Active Directory
 */
model ActiveDirectory {
  /**
   * Id of the Active Directory
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  activeDirectoryId?: string | null;

  /**
   * A domain user account with permission to create machine accounts
   */
  username?: string;

  /**
   * Plain text password of Active Directory domain administrator, value is masked in the response
   */
  @secret
  @maxLength(64)
  password?: string;

  /**
   * Name of the Active Directory domain
   */
  domain?: string;

  /**
   * Comma separated list of DNS server IP addresses (IPv4 only) for the Active Directory domain
   */
  dns?: ipV4Address;

  /**
   * Status of the Active Directory
   */
  @visibility(Lifecycle.Read)
  status?: ActiveDirectoryStatus;

  /**
   * Any details in regards to the Status of the Active Directory
   */
  @visibility(Lifecycle.Read)
  statusDetails?: string;

  /**
   * NetBIOS name of the SMB server. This name will be registered as a computer account in the AD and used to mount volumes
   */
  smbServerName?: string;

  /**
   * The Organizational Unit (OU) within the Windows Active Directory
   */
  organizationalUnit?: string = "CN=Computers";

  /**
   * The Active Directory site the service will limit Domain Controller discovery to
   */
  site?: string;

  /**
   * Users to be added to the Built-in Backup Operator active directory group. A list of unique usernames without domain specifier
   */
  backupOperators?: UserName[];

  /**
   * Users to be added to the Built-in Administrators active directory group. A list of unique usernames without domain specifier
   */
  administrators?: UserName[];

  /**
   * kdc server IP address for the active directory machine. This optional parameter is used only while creating kerberos volume.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @pattern("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
  kdcIP?: string;

  /**
   * Name of the active directory machine. This optional parameter is used only while creating kerberos volume
   */
  @maxLength(64)
  @minLength(1)
  adName?: string;

  /**
   * When LDAP over SSL/TLS is enabled, the LDAP client is required to have base64 encoded Active Directory Certificate Service's self-signed root CA certificate, this optional parameter is used only for dual protocol with LDAP user-mapping volumes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @maxLength(10240)
  @minLength(1)
  @secret
  serverRootCACertificate?: string;

  /**
   * If enabled, AES encryption will be enabled for SMB communication.
   */
  aesEncryption?: boolean;

  /**
   * Specifies whether or not the LDAP traffic needs to be signed.
   */
  ldapSigning?: boolean;

  /**
   * Domain Users in the Active directory to be given SeSecurityPrivilege privilege (Needed for SMB Continuously available shares for SQL). A list of unique usernames without domain specifier
   */
  securityOperators?: UserName[];

  /**
   * Specifies whether or not the LDAP traffic needs to be secured via TLS.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  ldapOverTLS?: boolean;

  /**
   *  If enabled, NFS client local users can also (in addition to LDAP users) access the NFS volumes.
   */
  allowLocalNfsUsersWithLdap?: boolean;

  /**
   * If enabled, Traffic between the SMB server to Domain Controller (DC) will be encrypted.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  encryptDCConnections?: boolean;

  /**
   * LDAP Search scope options
   */
  ldapSearchScope?: LdapSearchScopeOpt;

  /**
   * Comma separated list of IPv4 addresses of preferred servers for LDAP client. At most two comma separated IPv4 addresses can be passed.
   */
  @maxLength(32)
  @pattern("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)((, ?)(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))?)?$")
  preferredServersForLdapClient?: string;
}

/**
 * LDAP search scope
 */
model LdapSearchScopeOpt {
  /**
   * This specifies the user DN, which overrides the base DN for user lookups.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @maxLength(255)
  userDN?: string;

  /**
   * This specifies the group DN, which overrides the base DN for group lookups.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @maxLength(255)
  groupDN?: string;

  /**
   * This specifies the custom LDAP search filter to be used when looking up group membership from LDAP server.
   */
  @maxLength(255)
  groupMembershipFilter?: string;
}

/**
 * Encryption settings
 */
model AccountEncryption {
  /**
   * The encryption keySource (provider). Possible values (case-insensitive):  Microsoft.NetApp, Microsoft.KeyVault
   */
  keySource?: KeySource = KeySource.`Microsoft.NetApp`;

  /**
   * Properties provided by KeVault. Applicable if keySource is 'Microsoft.KeyVault'.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * Identity used to authenticate to KeyVault. Applicable if keySource is 'Microsoft.KeyVault'.
   */
  identity?: EncryptionIdentity;
}

/**
 * Properties of key vault.
 */
model KeyVaultProperties {
  /**
   * UUID v4 used to identify the Azure Key Vault configuration
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  keyVaultId?: string;

  /**
   * The Uri of KeyVault.
   */
  keyVaultUri: url;

  /**
   * The name of KeyVault key.
   */
  keyName: string;

  /**
   * The resource ID of KeyVault.
   */
  keyVaultResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * Status of the KeyVault connection.
   */
  @visibility(Lifecycle.Read)
  status?: KeyVaultStatus;
}

/**
 * Identity used to authenticate with key vault.
 */
model EncryptionIdentity {
  /**
   * The principal ID (object ID) of the identity used to authenticate with key vault. Read-only.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The ARM resource identifier of the user assigned identity used to authenticate with key vault. Applicable if identity.type has 'UserAssigned'. It should match key of identity.userAssignedIdentities.
   */
  userAssignedIdentity?: string;

  /**
   * ClientId of the multi-tenant Entra ID Application. Used to access cross-tenant keyvaults.
   */
  federatedClientId?: string;
}

/**
 * Entra ID Patch configuration for the account.
 */
@added(Versions.v2025_12_15_preview)
model EntraIdConfigPatch {
  /**
   * ApplicationId of the app created by customer to provide authentication and required API permissions for Microsoft Graph endpoint.
   */
  @minLength(36)
  @maxLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  applicationId?: string;

  /**
   * Domain of the Active directory synced to Entra ID for hybrid identities.
   */
  @maxLength(255)
  @pattern("^(?=.*[a-zA-Z])(?!.*\\.\\.)(?!.*-\\.)(?!.*\\.-)[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?)+$")
  domain?: string;

  /**
   * Using ServerNamePrefix, FQDN (Fully Qualified Domain Name) will be generated for SMB share, using this FQDN, SMB Share will be mounted on Entra Joined VM.
   */
  @minLength(1)
  @maxLength(10)
  @pattern("^[A-Za-z0-9](?:[A-Za-z0-9-]{0,8}[A-Za-z0-9])?$")
  serverNamePrefix?: string;

  /**
   * Using AKV config, certificate will be fetched, which will contain private key & public certificate, that correspond to the public certificate which is uploaded on the application created by customer. This will be used further for authentication.
   */
  entraIdAkvConfig?: EntraIdAkvConfigPatch;
}

/**
 * Using AKV config, certificate will be fetched, which will contain private key & public certificate, that correspond to the public certificate which is uploaded on the application created by customer. This will be used further for authentication.
 */
@added(Versions.v2025_12_15_preview)
model EntraIdAkvConfigPatch {
  /**
   * The Azure Key Vault URI where the Entra ID credentials are stored.
   */
  azureKeyVaultUri?: url;

  /**
   * The name of the certificate in Azure Key Vault.
   */
  @minLength(1)
  @maxLength(127)
  certificateName?: string;

  /**
   * The ARM resource identifier of the user assigned identity used to authenticate with key vault.
   */
  userAssignedIdentity?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/**
 * NetApp account patch resource
 */
model NetAppAccountPatch {
  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * NetApp Account properties
   */
  @typeChangedFrom(Versions.v2025_12_15_preview, AccountProperties)
  properties?: AccountPropertiesPatch;

  /**
   * The identity used for the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

/**
 * Change key vault request
 */
model ChangeKeyVault {
  /**
   * The URI of the key vault/managed HSM that should be used for encryption.
   */
  keyVaultUri: url;

  /**
   * The name of the key that should be used for encryption.
   */
  keyName: string;

  /**
   * Azure resource ID of the key vault/managed HSM that should be used for encryption.
   */
  keyVaultResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * Pairs of virtual network ID and private endpoint ID. Every virtual network that has volumes encrypted with customer-managed keys needs its own key vault private endpoint.
   */
  @identifiers(#["virtualNetworkId"])
  keyVaultPrivateEndpoints: KeyVaultPrivateEndpoint[];
}

/**
 * Status of the KeyVault connection.
 */
@clientName("NetAppKeyVaultStatus", "csharp")
union KeyVaultStatus {
  string,

  /**
   * KeyVault connection created but not in use
   */
  Created: "Created",

  /**
   * KeyVault connection in use by SMB Volume
   */
  InUse: "InUse",

  /**
   * KeyVault connection Deleted
   */
  Deleted: "Deleted",

  /**
   * Error with the KeyVault connection
   */
  Error: "Error",

  /**
   * KeyVault connection Updating
   */
  Updating: "Updating",
}

/**
 * MultiAD Status for the account
 */
union MultiAdStatus {
  string,

  /**
   * Account is MultiAD disabled, Means its a SharedAD or SingleAD account.
   */
  Disabled: "Disabled",

  /**
   * Account is MultiAD enabled
   */
  Enabled: "Enabled",
}

@armResourceOperations
interface NetAppAccounts {
  /**
   * Get the NetApp account
   */
  get is ArmResourceRead<NetAppAccount>;

  /**
   * Create or update the specified NetApp account within the resource group
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NetAppAccount>;

  /**
   * Patch the specified NetApp account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetAppAccount,
    PatchModel = NetAppAccountPatch,
    Response = ArmResponse<NetAppAccount> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetAppAccount> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: NetAppAccount;
    })
  >;

  /**
   * Delete the specified NetApp account
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetAppAccount>;

  /**
   * List and describe all NetApp accounts in the resource group.
   */
  list is ArmResourceListByParent<
    NetAppAccount,
    Response = ArmResponse<NetAppAccountList>
  >;

  /**
   * List and describe all NetApp accounts in the subscription.
   */
  listBySubscription is ArmListBySubscription<
    NetAppAccount,
    Response = ArmResponse<NetAppAccountList>
  >;

  /**
   * Renew identity credentials that are used to authenticate to key vault, for customer-managed key encryption. If encryption.identity.principalId does not match identity.principalId, running this operation will fix it.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  renewCredentials is ArmResourceActionAsync<
    NetAppAccount,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Transitions all volumes in a VNet to a different encryption key source (Microsoft-managed key or Azure Key Vault). Operation fails if targeted volumes share encryption sibling set with volumes from another account.
   */
  @action("transitiontocmk")
  transitionToCmk is ArmResourceActionAsyncBase<
    NetAppAccount,
    EncryptionTransitionRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetAppAccount>,
    OptionalRequestBody = true
  >;

  /**
   * Contains data from encryption.keyVaultProperties as well as information about which private endpoint is used by each encryption sibling set. Response from this endpoint can be modified and used as request body for POST request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @action("getKeyVaultStatus")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  getChangeKeyVaultInformation is ArmResourceActionAsync<
    NetAppAccount,
    void,
    ArmResponse<GetKeyVaultStatusResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = GetKeyVaultStatusResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Affects existing volumes that are encrypted with Key Vault/Managed HSM, and new volumes. Supports HSM to Key Vault, Key Vault to HSM, HSM to HSM and Key Vault to Key Vault.
   */
  changeKeyVault is ArmResourceActionAsyncBase<
    NetAppAccount,
    ChangeKeyVault,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetAppAccount>,
    OptionalRequestBody = true
  >;

  /**
   * List all volume groups for given account
   */
  @list
  @get
  @action("volumeGroups")
  listByNetAppAccount is ArmResourceActionSync<
    NetAppAccount,
    void,
    ArmResponse<VolumeGroupList>
  >;

  /**
   * Migrate the backups under a NetApp account to backup vault
   */
  migrateBackups is ArmResourceActionAsyncBase<
    NetAppAccount,
    BackupsMigrationRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetAppAccount>
  >;
}

@@doc(NetAppAccount.name, "The name of the NetApp account");
@@doc(NetAppAccount.properties, "NetApp Account properties");
@@doc(NetAppAccounts.createOrUpdate::parameters.resource,
  "NetApp Account object supplied in the body of the operation."
);
@@doc(NetAppAccounts.update::parameters.properties,
  "NetApp Account object supplied in the body of the operation."
);
@@doc(NetAppAccounts.transitionToCmk::parameters.body,
  "The required parameters to perform encryption transition."
);
@@doc(NetAppAccounts.changeKeyVault::parameters.body,
  "The required parameters to perform encryption migration."
);
@@doc(NetAppAccounts.migrateBackups::parameters.body,
  "Migrate backups under an account payload supplied in the body of the operation."
);
