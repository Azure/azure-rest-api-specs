import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KeyVault;
using Azure.Core;

@@clientName(CheckMhsmNameAvailabilityResult,
  "ManagedHsmNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckMhsmNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(CheckMhsmNameAvailabilityParameters,
  "MhsmNameAvailabilityParameters",
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

@@clientName(PublicNetworkAccess, "ManagedHsmPublicNetworkAccess", "csharp");
@@clientName(ManagedHsmProperties.networkAcls, "NetworkRuleSet", "csharp");
@@clientName(MhsmipRule, "ManagedHsmIPRule", "csharp");
@@clientName(DeletedVaultProperties, "DeletedKeyVaultProperties", "csharp");
@@clientName(DeletedVault, "DeletedKeyVault", "csharp");
@@clientName(MhsmipRule.value, "AddressRange", "csharp");
@@clientName(PrivateLinkResource, "KeyVaultPrivateLinkResourceData", "csharp");
@@clientName(AccessPolicyEntry, "KeyVaultAccessPolicy", "csharp");
@@clientName(NetworkRuleSet, "KeyVaultNetworkRuleSet", "csharp");
@@clientName(VaultCheckNameAvailabilityParameters,
  "KeyVaultNameAvailabilityContent",
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
@@clientName(VirtualNetworkRule, "KeyVaultVirtualNetworkRule", "csharp");
@@clientName(Permissions, "IdentityAccessPermissions", "csharp");
@@clientName(IPRule, "KeyVaultIPRule", "csharp");
@@clientName(KeyPermissions, "IdentityAccessKeyPermission", "csharp");
@@clientName(SecretPermissions, "IdentityAccessSecretPermission", "csharp");
@@clientName(StoragePermissions, "IdentityAccessStoragePermission", "csharp");
@@clientName(CertificatePermissions,
  "IdentityAccessCertificatePermission",
  "csharp"
);
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
@@alternateType(VaultProperties.tenantId, uuid, "csharp");
@@clientName(MhsmPrivateEndpoint, "ManagedHsmPrivateEndpoint", "csharp");
@@clientName(MhsmVirtualNetworkRule, "ManagedHsmVirtualNetworkRule", "csharp");
@@clientName(MhsmPrivateLinkServiceConnectionState,
  "ManagedHsmPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(ProvisioningState, "ManagedHsmProvisioningState", "csharp");

@@clientName(MhsmPrivateEndpointConnectionProperties,
  "ManagedHsmPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(VaultProvisioningState, "KeyVaultProvisioningState", "csharp");
@@alternateType(PrivateEndpointConnection.etag, eTag, "csharp");
@@alternateType(PrivateEndpointConnection.location, azureLocation, "csharp");
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@alternateType(MhsmPrivateEndpointConnection.etag, eTag, "csharp");
@@alternateType(MhsmPrivateEndpointConnectionItem.etag, eTag, "csharp");
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
@@alternateType(PrivateEndpointConnectionItem.etag, eTag, "csharp");
@@alternateType(Secret.location, azureLocation, "csharp");
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
@@clientName(Microsoft.KeyVault, "KeyVaultManagementClient", "javascript");
@@clientName(Microsoft.KeyVault, "KeyVaultManagementClient", "python");
