import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.StorageCache;

@@clientName(Microsoft.StorageCache,
  "StorageCacheManagementClient",
  "javascript,python"
);

@@clientLocation(AmlFilesystems.get, "AmlFilesystems", "python");
@@clientLocation(AmlFilesystems.createOrUpdate, "AmlFilesystems", "python");
@@clientLocation(AmlFilesystems.update, "AmlFilesystems", "python");
@@clientLocation(AmlFilesystems.delete, "AmlFilesystems", "python");
@@clientLocation(AmlFilesystems.listByResourceGroup,
  "AmlFilesystems",
  "python"
);
@@clientLocation(AmlFilesystems.list, "AmlFilesystems", "python");
@@clientLocation(AmlFilesystems.archive, "AmlFilesystems", "python");
@@clientLocation(AmlFilesystems.cancelArchive, "AmlFilesystems", "python");
@@clientLocation(AutoExportJobs.get, "AutoExportJobs", "python");
@@clientLocation(AutoExportJobs.createOrUpdate, "AutoExportJobs", "python");
@@clientLocation(AutoExportJobs.update, "AutoExportJobs", "python");
@@clientLocation(AutoExportJobs.delete, "AutoExportJobs", "python");
@@clientLocation(AutoExportJobs.listByAmlFilesystem,
  "AutoExportJobs",
  "python"
);
@@clientLocation(ImportJobs.get, "ImportJobs", "python");
@@clientLocation(ImportJobs.createOrUpdate, "ImportJobs", "python");
@@clientLocation(ImportJobs.update, "ImportJobs", "python");
@@clientLocation(ImportJobs.delete, "ImportJobs", "python");
@@clientLocation(ImportJobs.listByAmlFilesystem, "ImportJobs", "python");
@@clientLocation(AutoImportJobs.get, "AutoImportJobs", "python");
@@clientLocation(AutoImportJobs.createOrUpdate, "AutoImportJobs", "python");
@@clientLocation(AutoImportJobs.update, "AutoImportJobs", "python");
@@clientLocation(AutoImportJobs.delete, "AutoImportJobs", "python");
@@clientLocation(AutoImportJobs.listByAmlFilesystem,
  "AutoImportJobs",
  "python"
);
@@clientLocation(ExpansionJobs.get, "ExpansionJobs", "python");
@@clientLocation(ExpansionJobs.createOrUpdate, "ExpansionJobs", "python");
@@clientLocation(ExpansionJobs.update, "ExpansionJobs", "python");
@@clientLocation(ExpansionJobs.delete, "ExpansionJobs", "python");
@@clientLocation(ExpansionJobs.listByAmlFilesystem, "ExpansionJobs", "python");

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
