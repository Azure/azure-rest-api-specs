import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.KeyVault;
using Azure.Core;

#suppress "@azure-tools/typespec-client-generator-core/client-option" "https://github.com/Azure/typespec-azure/issues/4090"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "https://github.com/Azure/typespec-azure/issues/4090"
@@clientOption(Vault,
  "resource-rbac-roles",
  #{
    KeyVaultAdministrator: "00482a5a-887f-4fb3-b363-3b7fe8e74483",
    KeyVaultCertificateUser: "db79e9a7-68ee-4b58-9aeb-b90e7c24fcba",
    KeyVaultCertificatesOfficer: "a4417e6f-fecd-4de8-b567-7b0420556985",
    KeyVaultContributor: "f25e0fa2-a7c8-4377-a976-54943a77a395",
    KeyVaultCryptoOfficer: "14b46e9e-c2b7-41b4-b07b-48a6ebf60603",
    KeyVaultCryptoServiceEncryptionUser: "e147488a-f6f5-4113-8e2d-b22465e65bf6",
    KeyVaultCryptoServiceReleaseUser: "08bbd89e-9f13-488c-ac41-acfcb10c90ab",
    KeyVaultCryptoUser: "12338af0-0e69-4776-bea7-57ae8d297424",
    KeyVaultDataAccessAdministrator: "8b54135c-b56d-4d72-a534-26097cfdc8d8",
    KeyVaultReader: "21090545-7ca7-4776-b22c-e363652d74d2",
    KeyVaultSecretsOfficer: "b86a8fe4-44ce-4948-aee5-eccb2c155cd7",
    KeyVaultSecretsUser: "4633458b-17de-408a-b874-0445c86b69e6",
    ManagedHsmContributor: "18500a29-7fe2-46b2-a342-b16a415e101d",
  },
  "csharp"
);

@@scope(Keys.get, "!csharp");
@@scope(Keys.createIfNotExist, "!csharp");
@@scope(Keys.list, "!csharp");
@@scope(KeyOperationGroup.getVersion, "!csharp");
@@scope(KeyOperationGroup.listVersions, "!csharp");
@@scope(ManagedHsmKeys.get, "!csharp");
@@scope(ManagedHsmKeys.createIfNotExist, "!csharp");
@@scope(ManagedHsmKeys.list, "!csharp");
@@scope(ManagedHsmKeyOperationGroup.getVersion, "!csharp");
@@scope(ManagedHsmKeyOperationGroup.listVersions, "!csharp");
@@scope(Operations.list, "!csharp");
@@scope(VaultsOperationGroup.list, "!csharp");

@@clientName(Vaults.listByVault, "GetPrivateLinkResources", "csharp");
@@clientName(ManagedHsms.listByMHSMResource,
  "GetMHSMPrivateLinkResourcesByManagedHsmResource",
  "csharp"
);
@@clientName(ManagedHsms.listByResource, "GetRegions", "csharp");

@@clientName(CheckMhsmNameAvailabilityResult,
  "ManagedHsmNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckMhsmNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(CheckMhsmNameAvailabilityParameters,
  "ManagedHsmNameAvailabilityContent",
  "csharp"
);
@@clientName(ActivationStatus,
  "ManagedHSMSecurityDomainActivationStatus",
  "csharp"
);
@@clientName(Attributes, "SecretBaseAttributes", "csharp");
@@clientName(GeoReplicationRegionProvisioningState,
  "ManagedHsmGeoReplicatedRegionProvisioningState",
  "csharp"
);
@@clientName(Secret, "KeyVaultSecret", "csharp");
@@clientName(MhsmPrivateEndpointConnectionItem,
  "ManagedHsmPrivateEndpointConnectionItemData",
  "csharp"
);
@@clientName(MhsmPrivateLinkResource,
  "ManagedHsmPrivateLinkResourceData",
  "csharp"
);
@@usage(MhsmPrivateLinkResource, Usage.input | Usage.output, "csharp");

@@clientName(MhsmPrivateEndpointConnection,
  "ManagedHsmPrivateEndpointConnection",
  "csharp"
);

@@clientName(PublicNetworkAccess, "ManagedHsmPublicNetworkAccess", "csharp");
@@clientName(ManagedHsmProperties.networkAcls, "NetworkRuleSet", "csharp");
@@clientName(MhsmipRule, "ManagedHsmIPRule", "csharp");
@@clientName(DeletedVaultProperties, "DeletedKeyVaultProperties", "csharp");
@@clientName(DeletedVault, "DeletedKeyVault", "csharp");
@@clientName(MhsmipRule.value, "AddressRange", "csharp");
@@clientName(PrivateLinkResource, "KeyVaultPrivateLinkResourceData", "csharp");
@@clientName(AccessPolicyEntry, "KeyVaultAccessPolicy", "csharp");
@@clientName(NetworkRuleSet, "KeyVaultNetworkRuleSet", "csharp");
@@clientName(VaultsOperationGroup.checkNameAvailability,
  "CheckKeyVaultNameAvailability",
  "csharp"
);
@@clientName(ManagedHsmsOperationGroup.checkMhsmNameAvailability,
  "CheckManagedHsmNameAvailability",
  "csharp"
);
@@clientName(VaultCheckNameAvailabilityParameters,
  "KeyVaultNameAvailabilityContent",
  "csharp"
);
@@clientName(VaultCheckNameAvailabilityParameters.type,
  "ResourceType",
  "csharp"
);
@@alternateType(VaultCheckNameAvailabilityParameters.type,
  armResourceType,
  "csharp"
);
@@clientName(VaultAccessPolicyProperties,
  "KeyVaultAccessPolicyProperties",
  "csharp"
);
@@clientName(PrivateEndpointConnectionItem,
  "KeyVaultPrivateEndpointConnectionItemData",
  "csharp"
);
@@clientName(VaultPatchProperties, "KeyVaultPatchProperties", "csharp");
@@clientName(VaultAccessPolicyParameters,
  "KeyVaultAccessPolicyParameters",
  "csharp"
);
@@clientName(VaultPatchProperties.networkAcls, "NetworkRuleSet", "csharp");
@@clientName(VaultProperties, "KeyVaultProperties", "csharp");
@@clientName(VaultProperties.networkAcls, "NetworkRuleSet", "csharp");
@@clientName(Vault, "KeyVault", "csharp");
@@clientName(Vaults.createOrUpdate::parameters.resource, "content", "csharp");
@@clientName(Vaults.update::parameters.properties, "patch", "csharp");
@@clientName(VirtualNetworkRule, "KeyVaultVirtualNetworkRule", "csharp");
@@clientName(Permissions, "IdentityAccessPermissions", "csharp");
@@clientName(IPRule, "KeyVaultIPRule", "csharp");
@@clientName(KeyPermissions, "IdentityAccessKeyPermission", "csharp");
@@clientName(SecretPermissions, "IdentityAccessSecretPermission", "csharp");
@@clientName(StoragePermissions, "IdentityAccessStoragePermission", "csharp");
@@clientName(StoragePermissions.deletesas, "DeleteSas", "csharp");
@@clientName(StoragePermissions.getsas, "GetSas", "csharp");
@@clientName(StoragePermissions.listsas, "ListSas", "csharp");
@@clientName(StoragePermissions.regeneratekey, "RegenerateKey", "csharp");
@@clientName(StoragePermissions.setsas, "SetSas", "csharp");
@@clientName(CertificatePermissions,
  "IdentityAccessCertificatePermission",
  "csharp"
);
@@clientName(CertificatePermissions.deleteissuers, "DeleteIssuers", "csharp");
@@clientName(CertificatePermissions.getissuers, "GetIssuers", "csharp");
@@clientName(CertificatePermissions.listissuers, "ListIssuers", "csharp");
@@clientName(CertificatePermissions.managecontacts, "ManageContacts", "csharp");
@@clientName(CertificatePermissions.manageissuers, "ManageIssuers", "csharp");
@@clientName(CertificatePermissions.setissuers, "SetIssuers", "csharp");
@@clientName(IPRule.value, "AddressRange", "csharp");
@@clientName(CheckNameAvailabilityResult,
  "KeyVaultNameAvailabilityResult",
  "csharp"
);

@@clientName(MhsmPrivateEndpointConnection,
  "ManagedHsmPrivateEndpointConnection",
  "csharp"
);
@@clientName(MhsmGeoReplicatedRegion,
  "ManagedHsmGeoReplicatedRegion",
  "csharp"
);
@@clientName(MhsmRegionsListResult, "ManagedHsmRegionsListResult", "csharp");
@@clientName(MhsmPrivateLinkResourceListResult,
  "ManagedHsmPrivateLinkResourceListResult",
  "csharp"
);
@@clientName(MhsmNetworkRuleSet, "ManagedHsmNetworkRuleSet", "csharp");
@@clientName(MhsmNetworkRuleSet.ipRules, "IPRules", "csharp");
@@clientName(NetworkRuleSet.ipRules, "IPRules", "csharp");
@@alternateType(VaultProperties.tenantId, uuid, "csharp");
@@alternateType(VaultProperties.vaultUri, url, "csharp");
@@clientName(MhsmPrivateEndpoint, "ManagedHsmPrivateEndpoint", "csharp");
@@clientName(MhsmVirtualNetworkRule, "ManagedHsmVirtualNetworkRule", "csharp");
@@alternateType(MhsmVirtualNetworkRule.id, armResourceIdentifier, "csharp");
@@clientName(MhsmVirtualNetworkRule.id, "SubnetId", "csharp");
@@clientName(SecretCreateOrUpdateParameters,
  "KeyVaultSecretCreateOrUpdateContent",
  "csharp"
);
@@clientName(MhsmPrivateLinkServiceConnectionState,
  "ManagedHsmPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(ProvisioningState, "ManagedHsmProvisioningState", "csharp");
@@clientName(MhsmServiceTagRule, "ManagedHsmServiceTagRule", "csharp");

@@clientName(MhsmPrivateEndpointConnectionProperties,
  "ManagedHsmPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(VaultProvisioningState, "KeyVaultProvisioningState", "csharp");
@@alternateType(PrivateEndpointConnection.location, azureLocation, "csharp");
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@alternateType(MhsmPrivateEndpointConnectionItem.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ManagedHsmProperties.hsmUri, url, "csharp");
@@alternateType(ManagedHsmProperties.tenantId, uuid, "csharp");
@@alternateType(SecretProperties.secretUri, url, "csharp");
@@alternateType(DeletedVaultProperties.vaultId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(DeletedVaultProperties.location, azureLocation, "csharp");
@@alternateType(DeletedManagedHsmProperties.mhsmId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(DeletedManagedHsmProperties.mhsmId, "managedHsmId", "csharp");
@@alternateType(DeletedManagedHsmProperties.location, azureLocation, "csharp");
@@alternateType(VaultAccessPolicyParameters.location, azureLocation, "csharp");
@@alternateType(Secret.location, azureLocation, "csharp");
@@clientName(Secrets.createOrUpdate::parameters.resource, "content", "csharp");
@@clientName(Secrets.update::parameters.properties, "patch", "csharp");
@@alternateType(Key.location, azureLocation, "csharp");
@@alternateType(ManagedHsm.location, azureLocation, "csharp");
@@alternateType(MhsmPrivateEndpointConnection.location,
  azureLocation,
  "csharp"
);
@@alternateType(PrivateLinkResource.location, azureLocation, "csharp");
@@alternateType(MhsmNetworkRuleSet.bypass,
  ManagedHsmNetworkRuleBypassOption,
  "csharp"
);
@@alternateType(NetworkRuleSet.bypass,
  KeyVaultNetworkRuleBypassOption,
  "csharp"
);
@@alternateType(MhsmNetworkRuleSet.defaultAction,
  ManagedHsmNetworkRuleAction,
  "csharp"
);
@@alternateType(NetworkRuleSet.defaultAction,
  KeyVaultNetworkRuleAction,
  "csharp"
);
@@alternateType(MhsmPrivateEndpointConnectionProperties.provisioningState,
  ManagedHsmPrivateEndpointConnectionProvisioningState,
  "csharp"
);
@@alternateType(MhsmPrivateLinkServiceConnectionState.status,
  ManagedHsmPrivateEndpointServiceConnectionStatus,
  "csharp"
);
@@alternateType(MhsmPrivateLinkServiceConnectionState.actionsRequired,
  ManagedHsmActionsRequiredMessage,
  "csharp"
);
@@alternateType(PrivateLinkServiceConnectionState.actionsRequired,
  KeyVaultActionsRequiredMessage,
  "csharp"
);
// these enums are used in csharp customization only.
/**
 * The vault's create mode to indicate whether the vault need to be recovered or not.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeyVaultCreateMode {
  /** Default. */
  default,

  /** Recover. */
  recover,
}
/**
 * The vault's create mode to indicate whether the vault need to be recovered or not.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeyVaultPatchMode {
  /** Default. */
  default,

  /** Recover. */
  recover,
}
/**
 * The create mode to indicate whether the resource is being created or is being recovered from a deleted resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ManagedHsmCreateMode {
  /** Default. */
  default,

  /** Recover. */
  recover,
}

@@alternateType(VaultProperties.createMode, KeyVaultCreateMode, "csharp");
@@alternateType(ManagedHsmProperties.createMode,
  ManagedHsmCreateMode,
  "csharp"
);
@@alternateType(VaultPatchProperties.createMode, KeyVaultPatchMode, "csharp");
@@alternateType(CheckMhsmNameAvailabilityResult.reason,
  ManagedHsmNameUnavailableReason,
  "csharp"
);
@@alternateType(CheckNameAvailabilityResult.reason,
  KeyVaultNameUnavailableReason,
  "csharp"
);
@@alternateType(Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation.location,
  azureLocation,
  "csharp"
);
@@alternateType(VaultCreateOrUpdateParameters.location,
  azureLocation,
  "csharp"
);
@@clientName(ManagedHsmsOperationGroup.listDeleted,
  "GetDeletedManagedHsms",
  "csharp"
);
@@clientName(VaultsOperationGroup.listDeleted, "GetDeletedKeyVaults", "csharp");
@@clientName(PrivateEndpointConnection,
  "KeyVaultPrivateEndpointConnection",
  "csharp"
);
@@clientName(VaultCreateOrUpdateParameters,
  "KeyVaultCreateOrUpdateContent",
  "csharp"
);
@@alternateType(MhsmPrivateEndpoint.id, armResourceIdentifier, "csharp");
@@alternateType(PrivateEndpoint.id, armResourceIdentifier, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResource for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Vault,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResource for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ManagedHsm,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResource for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(MhsmPrivateEndpointConnection,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

@@clientName(ManagedHsms.listByResource, "GetMHSMRegionsByResource", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the operation back to pageable for backward compatibility"
@@markAsPageable(ManagedHsms.listByMHSMResource, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the operation back to pageable for backward compatibility"
@@markAsPageable(Vaults.listByVault, "csharp");

// Java-specific client configurations
@@clientName(IPRule, "IpRule", "java");
@@usage(Vault, Usage.input, "java");
@@clientName(ManagedHSMSecurityDomainProperties,
  "ManagedHsmSecurityDomainProperties",
  "java"
);

@@clientLocation(ManagedHsms.listByResource, "MhsmRegions", "java");
@@clientLocation(ManagedHsms.listByMHSMResource,
  "MhsmPrivateLinkResources",
  "java"
);
@@clientName(ManagedHsms.listByMHSMResource, "listByMhsmResource", "java");

// Mitigate Java breaking change of enum "Reason" now being expandable.
/**
 * The reason that a vault name could not be used. The Reason element is only returned if NameAvailable is false.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Avoid breaking changes for Java"
enum NameAvailabilityReason {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AccountNameInvalid: "AccountNameInvalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlreadyExists: "AlreadyExists",
}

@@clientName(NameAvailabilityReason, "Reason", "java");

@@clientName(Reason, "NameAvailabilityReason", "java");

@@alternateType(CheckNameAvailabilityResult.reason,
  NameAvailabilityReason,
  "java"
);
@@alternateType(CheckMhsmNameAvailabilityResult.reason,
  NameAvailabilityReason,
  "java"
);

@@clientName(Microsoft.KeyVault, "KeyVaultManagementClient", "javascript");
@@clientName(Microsoft.KeyVault, "KeyVaultManagementClient", "python");

// temporary until https://github.com/Azure/typespec-rust/issues/907 is fixed
@@clientInitialization(Microsoft.KeyVault,
  {
    initializedBy: InitializedBy.customizeCode,
  },
  "rust"
);
