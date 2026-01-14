import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./LiftrBase.Storage/main.tsp";

using PureStorage.Block;

<<<<<<< HEAD
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
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvsStorageContainer.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvsStorageContainerVolume.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvsVm.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LiftrBase.Storage.Reservation.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvsVmVolume.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StoragePool.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
