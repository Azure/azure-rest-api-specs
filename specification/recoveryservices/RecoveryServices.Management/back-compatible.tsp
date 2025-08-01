import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(Vaults.createOrUpdate::parameters.resource, "vault");
@@clientName(Vaults.update::parameters.properties, "vault");
@@clientName(Vaults.create::parameters.properties, "certificateRequest");

@@clientName(VaultExtendedInfoResources.createOrUpdate::parameters.resource,
  "resourceResourceExtendedInfoDetails",
  "!python"
);
@@clientName(VaultExtendedInfoResources.createOrUpdate::parameters.resource,
  "resourceExtendedInfoDetails",
  "python"
);
@@clientName(VaultExtendedInfoResources.update::parameters.properties,
  "resourceResourceExtendedInfoDetails",
  "!python"
);
@@clientName(VaultExtendedInfoResources.update::parameters.properties,
  "resourceExtendedInfoDetails",
  "python"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VaultExtendedInfoResource.properties);
@@clientName(RecoveryServicesOperationGroup.capabilities::parameters.body,
  "input"
);

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// PrivateLinkResourceOperationGroup operations
@@clientLocation(PrivateLinkResourceOperationGroup.get,
  "PrivateLinkResources",
  "!csharp"
);
@@clientLocation(PrivateLinkResourceOperationGroup.list,
  "PrivateLinkResources",
  "!csharp"
);

// RecoveryServicesOperationGroup operations
@@clientLocation(RecoveryServicesOperationGroup.checkNameAvailability,
  "RecoveryServices",
  "!csharp"
);
@@clientLocation(RecoveryServicesOperationGroup.capabilities,
  "RecoveryServices",
  "!csharp"
);
@@alternateType(RecoveryServicesOperationGroup.capabilities::parameters.location,
  azureLocation,
  "csharp"
);

// Vaults operations
@@clientLocation(Vaults.create, "VaultCertificates");
@@clientLocation(Vaults.registeredIdentitiesDelete, "RegisteredIdentities");
@@clientName(Vaults.registeredIdentitiesDelete, "Delete");
@@clientLocation(Vaults.list, "ReplicationUsages");
@@clientLocation(Vaults.listByVaults, "Usages");

// GetOperationResult operations
@@clientLocation(GetOperationResult.listByResourceGroup, Vaults);

// VaultExtendedInfoResources operations
@@clientLocation(VaultExtendedInfoResources.get,
  "VaultExtendedInfo",
  "!csharp"
);
@@clientLocation(VaultExtendedInfoResources.createOrUpdate,
  "VaultExtendedInfo",
  "!csharp"
);
@@clientLocation(VaultExtendedInfoResources.update,
  "VaultExtendedInfo",
  "!csharp"
);

//SDK Validation
@@clientName(PrivateLinkResource,
  "RecoveryServicesPrivateLinkResource",
  "csharp"
);
@@clientName(VaultExtendedInfoResource,
  "RecoveryServicesVaultExtendedInfo",
  "csharp"
);
@@clientName(Vault, "RecoveryServicesVault", "csharp");
@@clientName(UsagesUnit, "VaultUsageUnit", "csharp");
@@clientName(NameInfo, "VaultUsageNameInfo", "csharp");
@@clientName(VaultPropertiesMoveDetails.completionTimeUtc,
  "CompletedOn",
  "csharp"
);
@@clientName(VaultPropertiesMoveDetails.startTimeUtc, "StartOn", "csharp");
@@alternateType(VaultPropertiesMoveDetails.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VaultPropertiesMoveDetails.targetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CmkKeyVaultProperties.keyUri, url, "csharp");
@@usage(VaultPropertiesRedundancySettings, Usage.output, "csharp");
@@clientName(ResourceCertificateDetails.validFrom, "ValidStartOn", "csharp");
@@clientName(ResourceCertificateDetails.validTo, "ValidEndOn", "csharp");
@@alternateType(ResourceCertificateAndAadDetails.aadTenantId, uuid, "csharp");
@@alternateType(ResourceCertificateAndAadDetails.serviceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ResourceCertificateDetails.thumbprint, unknown, "csharp");
@@alternateType(ResourceCapabilitiesBase.type, armResourceType, "csharp");
@@clientName(ResourceCapabilitiesBase.type,
  "ResourceCapabilitiesBaseType",
  "csharp"
);
@@clientName(JobsSummary, "ReplicationJobSummary", "csharp");
@@clientName(MonitoringSummary, "VaultMonitoringSummary ", "csharp");
@@clientName(VaultProperties, "RecoveryServicesVaultProperties", "csharp");
@@alternateType(Vault.etag, eTag, "csharp");
@@clientName(PrivateEndpointConnectionStatus,
  "RecoveryServicesPrivateEndpointConnectionStatus",
  "csharp"
);
@@clientName(ProvisioningState,
  "RecoveryServicesPrivateEndpointConnectionProvisioningState",
  "csharp"
);
@@clientName(DNSZoneResponse, "DnsZoneResult", "csharp");
@@alternateType(CmkKekIdentity.userAssignedIdentity,
  armResourceIdentifier,
  "csharp"
);
@@clientName(CapabilitiesResponse, "CapabilitiesResult", "csharp");
@@alternateType(VaultExtendedInfoResource.etag, eTag, "csharp");
@@clientName(MonitoringSettings, "VaultMonitoringSettings", "csharp");
@@clientName(PrivateEndpointConnectionVaultProperties,
  "RecoveryServicesPrivateEndpointConnectionVaultProperties",
  "csharp"
);
@@alternateType(PrivateEndpointConnectionVaultProperties.location,
  azureLocation,
  "csharp"
);
@@clientName(PublicNetworkAccess, "VaultPublicNetworkAccess", "csharp");
@@clientName(SecuritySettings, "RecoveryServicesSecuritySettings", "csharp");
@@clientName(UpgradeDetails, "VaultUpgradeDetails ", "csharp");
@@clientName(UpgradeDetails.endTimeUtc, "EndOn", "csharp");
@@clientName(UpgradeDetails.startTimeUtc, "StartOn", "csharp");
@@alternateType(UpgradeDetails.previousResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(UpgradeDetails.upgradedResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(UpgradeDetails.lastUpdatedTimeUtc, "LastUpdatedOn", "csharp");
@@clientName(VaultCertificateResponse, "VaultCertificateResult", "csharp");
@@clientName(TriggerType, "VaultUpgradeTriggerType", "csharp");
@@clientName(SoftDeleteSettings,
  "RecoveryServicesSoftDeleteSettings",
  "csharp"
);
@@clientName(AuthType, "RecoveryServicesAuthType", "csharp");
@@clientName(SoftDeleteState, "RecoveryServicesSoftDeleteState", "csharp");
@@clientName(PatchVault, "RecoveryServicesVaultPatch", "csharp");
@@alternateType(PatchVault.etag, eTag, "csharp");
@@clientName(CheckNameAvailabilityResult,
  "RecoveryServicesNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(CertificateRequest,
  "RecoveryServicesCertificateContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityParameters,
  "RecoveryServicesNameAvailabilityContent",
  "csharp"
);
@@clientName(AlertsState, "RecoveryServicesAlertsState", "csharp");
@@alternateType(CheckNameAvailabilityParameters.type,
  armResourceType,
  "csharp"
);
@@clientName(CheckNameAvailabilityParameters.type, "ResourceType", "csharp");
@@clientName(Vaults.registeredIdentitiesDelete,
  "DeleteRegisteredIdentity",
  "csharp"
);
@@clientName(RecoveryServicesOperationGroup.checkNameAvailability,
  "CheckRecoveryServicesNameAvailability",
  "csharp"
);
@@clientName(RecoveryServicesOperationGroup.capabilities,
  "GetRecoveryServiceCapabilities",
  "csharp"
);
@@usage(CapabilitiesResponse, Usage.input, "csharp");
@@usage(DNSZoneResponse, Usage.input, "csharp");
@@clientName(CapabilitiesResponseProperties,
  "CapabilitiesResultProperties",
  "csharp"
);
@@clientName(AuthType.ACS, "Acs", "csharp");
@@clientName(AuthType.AAD, "Aad", "csharp");
