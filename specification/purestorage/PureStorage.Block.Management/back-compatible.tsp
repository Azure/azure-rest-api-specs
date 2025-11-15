import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./LiftrBase.Storage/main.tsp";

using PureStorage.Block;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvsStorageContainer.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvsStorageContainerVolume.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvsVm.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LiftrBase.Storage.Reservation.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvsVmVolume.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StoragePool.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
