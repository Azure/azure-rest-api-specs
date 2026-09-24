import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./LiftrBase.Storage/main.tsp";

using Azure.ClientGenerator.Core;
using PureStorage.Block;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  AvsStorageContainer.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  AvsStorageContainerVolume.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  AvsVm.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  LiftrBase.Storage.Reservation.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  AvsVmVolume.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  StoragePool.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);

@@clientName(StoragePools.enableAvsConnection::parameters.body, "properties");
@@doc(
  StoragePools.enableAvsConnection::parameters.body,
  "Storage pool EnableAvsConnection properties"
);

@@clientName(StoragePools.finalizeAvsConnection::parameters.body, "properties");
@@doc(
  StoragePools.finalizeAvsConnection::parameters.body,
  "Storage pool FinalizeAvsConnection properties"
);
