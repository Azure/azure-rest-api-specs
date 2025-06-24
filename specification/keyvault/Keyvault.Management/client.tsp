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
//@@clientName(Reason, "NameUnavailableReason", "csharp");
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
//@@clientName(ActionsRequired, "ManagedHsmActionsRequiredMessage", "csharp");
//@@clientName(NetworkRuleAction, "ManagedHsmNetworkRuleAction", "csharp");
//@@clientName(NetworkRuleBypassOptions, "ManagedHsmNetworkRuleBypassOption","csharp");
@@clientName(PublicNetworkAccess, "ManagedHsmPublicNetworkAccess", "csharp");
//@@clientName(CreateMode, "ManagedHsmCreateMode", "csharp");
@@clientName(ManagedHsmProperties.networkAcls, "NetworkRuleSet", "csharp");
@@clientName(MhsmipRule, "ManagedHsmIPRule", "csharp");
@@clientName(DeletedVaultProperties, "DeletedKeyVaultProperties", "csharp");
@@clientName(DeletedVault, "DeletedKeyVault", "csharp");
@@clientName(MhsmipRule.value, "AddressRange");
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
@@clientName(Trigger, "KeyRotationTrigger", "csharp");
@@clientName(Action, "KeyRotationAction", "csharp");
@@clientName(Key, "KeyVaultKey", "csharp");
//@@clientName(Key.properties.kty,"keyType","csharp");
@@clientName(KeyAttributes.enabled, "keyType", "csharp");
@@clientName(ManagedHsmKeyAttributes.enabled, "isEnabled", "csharp");
@@clientName(ManagedHsmKeyAttributes.exportable, "canExported", "csharp");
@@clientName(ManagedHsmKeyProperties.kty, "keyType", "csharp");
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
//@@clientName(MhsmVirtualNetworkRule, "ManagedHsmVirtualNetworkRule", "csharp");
@@clientName(MhsmPrivateLinkServiceConnectionState,
  "ManagedHsmPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(ProvisioningState, "ManagedHsmProvisioningState", "csharp");
//@@clientName(PrivateEndpointConnectionProvisioningState,"ManagedHsmPrivateEndpointConnectionProvisioningState","csharp");
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
