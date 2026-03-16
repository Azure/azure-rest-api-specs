// Contains overrides to make the Autorest Swagger2.0 back compatible

using Microsoft.AzureLargeInstance;
using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureLargeInstance.properties,
  "autorest"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureLargeStorageInstance.properties,
  "autorest"
);

@@clientLocation(AzureLargeInstances.get, "AzureLargeInstance");
@@clientLocation(AzureLargeInstances.create, "AzureLargeInstance");
@@clientLocation(AzureLargeInstances.update, "AzureLargeInstance");
@@clientLocation(AzureLargeInstances.delete, "AzureLargeInstance");
@@clientLocation(AzureLargeInstances.listByResourceGroup, "AzureLargeInstance");
@@clientLocation(AzureLargeInstances.listBySubscription, "AzureLargeInstance");
@@clientLocation(AzureLargeInstances.start, "AzureLargeInstance");
@@clientLocation(AzureLargeInstances.restart, "AzureLargeInstance");
@@clientLocation(AzureLargeInstances.shutdown, "AzureLargeInstance");
@@clientLocation(AzureLargeStorageInstances.get, "AzureLargeStorageInstance");
@@clientLocation(AzureLargeStorageInstances.create,
  "AzureLargeStorageInstance"
);
@@clientLocation(AzureLargeStorageInstances.update,
  "AzureLargeStorageInstance"
);
@@clientLocation(AzureLargeStorageInstances.delete,
  "AzureLargeStorageInstance"
);
@@clientLocation(AzureLargeStorageInstances.listByResourceGroup,
  "AzureLargeStorageInstance"
);
@@clientLocation(AzureLargeStorageInstances.listBySubscription,
  "AzureLargeStorageInstance"
);
