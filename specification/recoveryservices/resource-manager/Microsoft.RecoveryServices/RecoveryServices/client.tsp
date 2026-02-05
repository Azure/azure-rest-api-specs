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
@@clientName(DNSZone, "DnsZone", "csharp");
@@clientName(DNSZoneResponse, "DnsZoneResult", "csharp");
@@alternateType(CmkKekIdentity.userAssignedIdentity,
  armResourceIdentifier,
  "csharp"
);
@@clientName(CapabilitiesResponse, "CapabilitiesResult", "csharp");
@@alternateType(VaultExtendedInfoResource.etag, eTag, "csharp");
@@clientName(MonitoringSettings, "VaultMonitoringSettings", "csharp");

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
@@alternateType(PrivateEndpoint.id, armResourceIdentifier, "csharp");
@@clientName(UpgradeDetails.lastUpdatedTimeUtc, "LastUpdatedOn", "csharp");
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
@@clientName(Vaults.list, "GetReplicationUsages", "csharp");
@@clientName(Vaults.listByVaults, "GetUsagesByVaults", "csharp");
@@clientName(Vaults.create, "CreateVaultCertificate", "csharp");
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
@@scope(DeletedVaults.getOperationStatus, "!csharp");
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
@@clientName(DeletedVault, "RecoveryServicesDeletedVault", "csharp");
@@clientName(DeletedVaultUndeleteInput, "DeletedVaultRestoreInput", "csharp");
@@clientName(DeletedVaultUndeleteInputProperties,
  "DeletedVaultRestoreInputProperties",
  "csharp"
);
@@clientName(DeletedVaults.undelete, "restoreDeletedVault", "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(PatchVault.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(Vault.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);

@@clientName(Microsoft.RecoveryServices, "RecoveryServicesClient", "python");

// Java SDK backward compatibility fixes
@@clientName(BCDRSecurityLevel, "BcdrSecurityLevel", "java");
@@clientName(DNSZone, "DnsZone", "java");
@@clientName(DNSZoneResponse, "DnsZoneResponse", "java");
@@clientName(ResourceCertificateAndAcsDetails.globalAcsHostName,
  "globalAcsHostname",
  "java"
);

/**
 * Patch Resource information, as returned by the resource provider.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For csharp backward compatibility"
model PatchVaultWithEtag
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Properties of the vault.
   */
  properties?: VaultProperties;

  /**
   * Identifies the unique system identifier for each Azure resource.
   */
  sku?: Sku;

  /**
   * Identity for the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Optional ETag.
   */
  etag?: eTag;
}

@@alternateType(PatchVault, PatchVaultWithEtag, "csharp");

/**
 * Information to be stored in Vault properties as an element of privateEndpointConnections List.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For csharp backward compatibility"
model PrivateEndpointConnectionVaultPropertiesReplacement
  extends Azure.ResourceManager.CommonTypes.Resource {
  ...OmitProperties<
    PrivateEndpointConnectionVaultProperties,
    "id" | "name" | "type"
  >;
}
@@alternateType(PrivateEndpointConnectionVaultProperties,
  PrivateEndpointConnectionVaultPropertiesReplacement,
  "csharp"
);
@@clientName(PrivateEndpointConnectionVaultPropertiesReplacement,
  "RecoveryServicesPrivateEndpointConnectionVaultProperties",
  "csharp"
);

/**
 * Certificate corresponding to a vault that can be used by clients to register themselves with the vault.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For csharp backward compatibility"
model VaultCertificateResponseReplacement
  extends Azure.ResourceManager.CommonTypes.Resource {
  ...OmitProperties<VaultCertificateResponse, "id" | "name" | "type">;
}
@@alternateType(VaultCertificateResponse,
  VaultCertificateResponseReplacement,
  "csharp"
);
@@clientName(VaultCertificateResponseReplacement,
  "VaultCertificateResult",
  "csharp"
);
