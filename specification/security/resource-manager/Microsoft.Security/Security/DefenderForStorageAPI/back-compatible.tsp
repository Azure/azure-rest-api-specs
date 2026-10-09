import "@azure-tools/typespec-client-generator-core";
import "../Common/main.tsp";

using Azure.ClientGenerator.Core;
using DefenderForStorageAPI;
using Common;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the existing SDK flattening of CloudError.error while retaining the service's nested error response on the wire."
@@Legacy.flattenProperty(CloudError.error);

@@clientLocation(DefenderForStorageSettings.get, "DefenderForStorage");
@@clientLocation(DefenderForStorageSettings.create, "DefenderForStorage");
@@clientName(
  DefenderForStorageSettings.create::parameters.resource,
  "defenderForStorageSetting"
);
@@clientLocation(DefenderForStorageSettings.list, "DefenderForStorage");
@@clientLocation(
  DefenderForStorageSettings.startMalwareScan,
  "DefenderForStorage"
);
@@clientLocation(
  DefenderForStorageSettings.cancelMalwareScan,
  "DefenderForStorage"
);
@@clientLocation(
  DefenderForStorageSettings.getMalwareScan,
  "DefenderForStorage"
);
