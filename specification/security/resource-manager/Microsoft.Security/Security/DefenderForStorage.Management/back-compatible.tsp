import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CloudError.error);

@@clientLocation(DefenderForStorageSettings.get, "DefenderForStorage");
@@clientLocation(DefenderForStorageSettings.create, "DefenderForStorage");
@@clientName(DefenderForStorageSettings.create::parameters.resource,
  "defenderForStorageSetting"
);
@@clientLocation(DefenderForStorageSettings.list, "DefenderForStorage");
@@clientLocation(DefenderForStorageSettings.startMalwareScan,
  "DefenderForStorage"
);
@@clientLocation(DefenderForStorageSettings.cancelMalwareScan,
  "DefenderForStorage"
);
@@clientLocation(DefenderForStorageSettings.getMalwareScan,
  "DefenderForStorage"
);
