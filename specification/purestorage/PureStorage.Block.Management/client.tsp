import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace PureStorage.Block.Client {
  // Client-specific naming overrides
  @@clientName(PureStorage.Block.HealthResponse, "StoragePoolHealthInfo");
  @@clientName(PureStorage.Block.ServiceInitializationData,
    "ServiceInitializationInfo"
  );

  // Rename sddcResourceId field to avsClusterResourceId in all models
  @@clientName(PureStorage.Block.AzureVmwareService.sddcResourceId,
    "clusterResourceId"
  );
  @@clientName(PureStorage.Block.ServiceInitializationHandle.sddcResourceId,
    "clusterResourceId"
  );
  @@clientName(PureStorage.Block.AvsStatus.sddcResourceId, "clusterResourceId");
  @@clientName(PureStorage.Block.StoragePoolEnableAvsConnectionPost.sddcResourceId,
    "clusterResourceId"
  );
  @@clientName(PureStorage.Block, "PureStorageBlockMgmtClient", "python");
  @@clientName(PureStorage.Block, "PureStorageBlockMgmtClient", "java");
}
