import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.ClientGenerator.Core;

namespace Microsoft.RecoveryServices;

@@clientLocation(getOperationStatus, Operations, "go");
@@clientLocation(getOperationResult, Operations, "go");
@@clientName(getOperationStatus, "OperationStatusGet", "go");
//dotnet SDK Validation
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
@@scope(Operations.list, "!csharp");
@@scope(getOperationStatus, "!csharp");
@@scope(getOperationResult, "!csharp");
@@clientName(BCDRSecurityLevel, "BcdrSecurityLevel", "csharp");
@@clientName(AssociatedIdentity,
  "RecoveryServicesAssociatedIdentity",
  "csharp"
);
@@clientName(AzureMonitorAlertSettings,
  "RecoveryServicesAzureMonitorAlertSettings",
  "csharp"
);
@@clientName(ClassicAlertSettings,
  "RecoveryServicesClassicAlertSettings",
  "csharp"
);
@@clientName(EnhancedSecurityState,
  "RecoveryServicesEnhancedSecurityState",
  "csharp"
);
@@clientName(IdentityType, "RecoveryServicesIdentityType", "csharp");
@@clientName(State, "RecoveryServicesSourceScanState", "csharp");
