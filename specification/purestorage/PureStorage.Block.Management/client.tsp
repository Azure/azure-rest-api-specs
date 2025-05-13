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
@@clientName(StoragePool, "PureStoragePool", "csharp");
@@clientName(StoragePoolProperties, "PureStoragePoolProperties", "csharp");
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
@@clientName(AvsVm, "PureStorageAvsVm", "csharp");
@@clientName(AvsVmProperties, "PureStorageAvsVmProperties", "csharp");
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
