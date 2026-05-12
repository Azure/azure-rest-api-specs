import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.StorageCache;

@@clientName(Microsoft.StorageCache,
  "StorageCacheManagementClient",
  "javascript,python"
);

@@clientName(CacheUsernameDownloadSettings.userFileURI, "userFileUri", "java");
@@clientName(CacheUsernameDownloadSettings.caCertificateURI,
  "caCertificateUri",
  "java"
);
@@clientName(CacheUsernameDownloadSettings.groupFileURI,
  "groupFileUri",
  "java"
);
@@clientName(AmlFilesystemRootSquashSettings.squashUID, "squashUid", "java");
@@clientName(AmlFilesystemRootSquashSettings.squashGID, "squashGid", "java");
@@clientName(AmlFilesystemPropertiesMaintenanceWindow.timeOfDayUTC,
  "timeOfDayUtc",
  "java"
);
@@clientName(AmlFilesystemUpdatePropertiesMaintenanceWindow.timeOfDayUTC,
  "timeOfDayUtc",
  "java"
);
@@clientName(AutoExportJobPropertiesStatus.lastStartedTimeUTC,
  "lastStartedTimeUtc",
  "java"
);
@@clientName(AutoExportJobPropertiesStatus.lastCompletionTimeUTC,
  "lastCompletionTimeUtc",
  "java"
);
@@clientName(AutoExportJobPropertiesStatus.lastSuccessfulIterationCompletionTimeUTC,
  "lastSuccessfulIterationCompletionTimeUtc",
  "java"
);
@@clientName(AutoImportJobPropertiesStatus.lastStartedTimeUTC,
  "lastStartedTimeUtc",
  "java"
);
@@clientName(AutoImportJobPropertiesStatus.lastCompletionTimeUTC,
  "lastCompletionTimeUtc",
  "java"
);
@@clientName(NfsAccessRule.anonymousUID, "anonymousUid", "java");
@@clientName(NfsAccessRule.anonymousGID, "anonymousGid", "java");
@@clientName(getRequiredAmlFSSubnetsSize::parameters.body,
  "requiredAmlFilesystemSubnetsSizeInfo",
  "java"
);
