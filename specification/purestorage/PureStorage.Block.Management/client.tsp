import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using PureStorage.Block;

@@clientName(PureStorage.Block, "PureStorageBlockMgmtClient", "python");
@@clientName(PureStorage.Block, "PureStorageBlockMgmtClient", "java");

// Client-specific naming overrides
@@clientName(HealthResponse, "StoragePoolHealthInfo");
@@clientName(ServiceInitializationData, "ServiceInitializationInfo");

// Rename sddcResourceId field to avsClusterResourceId in all models
@@clientName(AzureVmwareService.sddcResourceId, "clusterResourceId");
@@clientName(ServiceInitializationHandle.sddcResourceId, "clusterResourceId");
@@clientName(AvsStatus.sddcResourceId, "clusterResourceId");
@@clientName(StoragePoolEnableAvsConnectionPost.sddcResourceId,
  "clusterResourceId"
);

// CSharp
@@alternateType(ServiceInitializationHandle.sddcResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(StoragePoolEnableAvsConnectionPost.sddcResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(StoragePool, "PureStoragePool", "csharp");
@@clientName(StoragePoolProperties, "PureStoragePoolProperties", "csharp");
@@alternateType(StoragePoolProperties.reservationResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(LiftrBase.Storage.Reservation, "PureStorageReservation", "csharp");
@@clientName(LiftrBase.Storage.ReservationProperties,
  "PureStorageReservationProperties",
  "csharp"
);
@@clientName(AvsStorageContainer, "PureStorageAvsStorageContainer", "csharp");
@@clientName(AvsStorageContainerProperties,
  "PureStorageAvsStorageContainerProperties",
  "csharp"
);
@@clientName(AvsStorageContainerVolume,
  "PureStorageAvsStorageContainerVolume",
  "csharp"
);
@@clientName(VolumeProperties, "PureStorageVolumeProperties", "csharp");
@@alternateType(VolumeProperties.storagePoolResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AvsVm, "PureStorageAvsVm", "csharp");
@@clientName(AvsVmProperties, "PureStorageAvsVmProperties", "csharp");
@@alternateType(AvsVmProperties.storagePoolResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AvsVmProperties.createdTimestamp, "CreatedOn", "csharp");
@@alternateType(AvsVmProperties.createdTimestamp, utcDateTime, "csharp");
@@clientName(AvsVmVolume, "PureStorageAvsVmVolume", "csharp");
@@clientName(LiftrBase.Address, "PureStorageAddressDetails", "csharp");
@@clientName(Alert, "PureStorageHealthAlert", "csharp");
@@clientName(AlertLevel, "PureStorageHealthAlertLevel", "csharp");
@@clientName(AvsConnection, "PureStorageAvsConnection", "csharp");
@@clientName(AvsConnection.serviceInitializationCompleted,
  "IsServiceInitializationCompleted",
  "csharp"
);
@@clientName(AvsDiskDetails, "PureStorageAvsDiskDetails", "csharp");
@@alternateType(AvsDiskDetails.avsVmResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AvsDiskDetails.avsStorageContainerResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AvsStatus, "PureStorageAvsStatus", "csharp");
@@clientName(AvsStatus.avsEnabled, "IsAvsEnabled", "csharp");
@@alternateType(AvsStatus.sddcResourceId, armResourceIdentifier, "csharp");
@@clientName(AvsVmDetails, "PureStorageAvsVmDetails", "csharp");
@@clientName(AzureVmwareService, "PureStorageAvs", "csharp");
@@clientName(AzureVmwareService.avsEnabled, "IsAvsEnabled", "csharp");
@@alternateType(AzureVmwareService.sddcResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(BandwidthUsage, "PureStorageBandwidthUsage", "csharp");
@@clientName(BillingUsageProperty, "PureStorageBillingUsageProperty", "csharp");
@@clientName(UsageSeverity, "PureStorageBillingUsageSeverity", "csharp");
@@clientName(HealthDetails, "PureStorageHealthDetails", "csharp");
@@clientName(LiftrBase.CompanyDetails, "PureStorageCompanyDetails", "csharp");
@@clientName(IopsUsage, "PureStorageIopsUsage", "csharp");
@@clientName(LimitDetails, "PureStorageResourceLimitDetails", "csharp");
@@clientName(LiftrBase.MarketplaceDetails,
  "PureStorageMarketplaceDetails",
  "csharp"
);
@@clientName(LiftrBase.MarketplaceSubscriptionStatus,
  "PureStorageMarketplaceSubscriptionStatus",
  "csharp"
);
@@clientName(LiftrBase.OfferDetails, "PureStorageOfferDetails", "csharp");
@@clientName(LiftrBase.ProvisioningState,
  "PureStorageProvisioningState",
  "csharp"
);
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "PureStorageResourceProvisioningState",
  "csharp"
); // TODO: this will be removed after the tsp get fixed
@@clientName(RangeLimits, "PropertyValueRangeLimits", "csharp");
@@clientName(SoftDeletion, "PureStorageSoftDeletionState", "csharp");
@@clientName(SoftDeletion.destroyed, "IsDestroyed", "csharp");
@@clientName(SoftDeletion.eradicationTimestamp, "EradicatedOn", "csharp");
@@alternateType(SoftDeletion.eradicationTimestamp, utcDateTime, "csharp");
@@clientName(Space, "PureStorageSpaceUsage", "csharp");
@@clientName(StoragePoolEnableAvsConnectionPost,
  "StoragePoolEnableAvsConnectionContent",
  "csharp"
);
@@clientName(StoragePoolFinalizeAvsConnectionPost,
  "StoragePoolFinalizeAvsConnectionContent",
  "csharp"
);
@@clientName(LiftrBase.UserDetails, "PureStorageUserDetails", "csharp");
@@clientName(VmType, "PureStorageAvsVmType", "csharp");
@@clientName(VnetInjection, "PureStoragePoolVnetInjection", "csharp");
@@alternateType(VnetInjection.subnetId, armResourceIdentifier, "csharp");
@@alternateType(VnetInjection.vnetId, armResourceIdentifier, "csharp");
@@clientName(VolumeContainerType,
  "PureStorageAvsVmVolumeContainerType",
  "csharp"
);
@@clientName(VolumeType, "PureStorageAvsVmVolumeType", "csharp");
@@clientName(ServiceInitializationData.vSphereIp, "vSphereIP", "csharp");
