import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageCache;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AmlFilesystemUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AutoExportJobProperties.status);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AutoExportJobUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ImportJobProperties.status);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ImportJobUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AutoImportJobProperties.status);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AutoImportJobUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpansionJobProperties.status);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApiOperation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AscOperation.properties);

@@clientLocation(AmlFilesystems.get, "amlFilesystems");
@@clientLocation(AmlFilesystems.createOrUpdate, "amlFilesystems");
@@clientName(AmlFilesystems.createOrUpdate::parameters.resource,
  "amlFilesystem"
);
@@clientLocation(AmlFilesystems.update, "amlFilesystems");
@@clientName(AmlFilesystems.update::parameters.properties, "amlFilesystem");
@@clientLocation(AmlFilesystems.delete, "amlFilesystems");
@@clientLocation(AmlFilesystems.listByResourceGroup, "amlFilesystems");
@@clientLocation(AmlFilesystems.list, "amlFilesystems");
@@clientLocation(AmlFilesystems.archive, "amlFilesystems");
@@clientName(AmlFilesystems.archive::parameters.body, "archiveInfo");
@@clientLocation(AmlFilesystems.cancelArchive, "amlFilesystems");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AmlFilesystem.properties);

@@clientLocation(AutoExportJobs.get, "autoExportJobs");
@@clientLocation(AutoExportJobs.createOrUpdate, "autoExportJobs");
@@clientName(AutoExportJobs.createOrUpdate::parameters.resource,
  "autoExportJob"
);
@@clientLocation(AutoExportJobs.update, "autoExportJobs");
@@clientName(AutoExportJobs.update::parameters.properties, "autoExportJob");
@@clientLocation(AutoExportJobs.delete, "autoExportJobs");
@@clientLocation(AutoExportJobs.listByAmlFilesystem, "autoExportJobs");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AutoExportJob.properties);

@@clientLocation(ImportJobs.get, "importJobs");
@@clientLocation(ImportJobs.createOrUpdate, "importJobs");
@@clientName(ImportJobs.createOrUpdate::parameters.resource, "importJob");
@@clientLocation(ImportJobs.update, "importJobs");
@@clientName(ImportJobs.update::parameters.properties, "importJob");
@@clientLocation(ImportJobs.delete, "importJobs");
@@clientLocation(ImportJobs.listByAmlFilesystem, "importJobs");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ImportJob.properties);

@@clientLocation(AutoImportJobs.get, "autoImportJobs");
@@clientLocation(AutoImportJobs.createOrUpdate, "autoImportJobs");
@@clientName(AutoImportJobs.createOrUpdate::parameters.resource,
  "autoImportJob"
);
@@clientLocation(AutoImportJobs.update, "autoImportJobs");
@@clientName(AutoImportJobs.update::parameters.properties, "autoImportJob");
@@clientLocation(AutoImportJobs.delete, "autoImportJobs");
@@clientLocation(AutoImportJobs.listByAmlFilesystem, "autoImportJobs");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AutoImportJob.properties);

@@clientLocation(ExpansionJobs.get, "expansionJobs");
@@clientLocation(ExpansionJobs.createOrUpdate, "expansionJobs");
@@clientName(ExpansionJobs.createOrUpdate::parameters.resource, "expansionJob");
@@clientLocation(ExpansionJobs.update, "expansionJobs");
@@clientName(ExpansionJobs.update::parameters.properties, "expansionJob");
@@clientLocation(ExpansionJobs.delete, "expansionJobs");
@@clientLocation(ExpansionJobs.listByAmlFilesystem, "expansionJobs");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpansionJob.properties);

@@clientName(Caches.createOrUpdate::parameters.resource, "cache");
@@clientName(Caches.update::parameters.properties, "cache");
@@clientName(Caches.startPrimingJob::parameters.body, "primingjob");
@@clientName(Caches.stopPrimingJob::parameters.body, "primingJobId");
@@clientName(Caches.pausePrimingJob::parameters.body, "primingJobId");
@@clientName(Caches.resumePrimingJob::parameters.body, "primingJobId");
@@clientName(Caches.spaceAllocation::parameters.body, "spaceAllocation");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Cache.properties);

@@clientName(StorageTargets.createOrUpdate::parameters.resource,
  "storagetarget"
);
@@clientLocation(StorageTargets.flush, "StorageTarget");
@@clientLocation(StorageTargets.suspend, "StorageTarget");
@@clientLocation(StorageTargets.resume, "StorageTarget");
@@clientLocation(StorageTargets.invalidate, "StorageTarget");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(StorageTarget.properties);

@@clientLocation(checkAmlFSSubnets, "Management", "go");
@@clientName(checkAmlFSSubnets, "checkAmlFSSubnets");
@@clientLocation(getRequiredAmlFSSubnetsSize, "Management", "go");
@@clientName(getRequiredAmlFSSubnetsSize, "getRequiredAmlFSSubnetsSize");

@@clientLocation(SkusOperationGroup.list, "Skus");

@@clientLocation(UsageModelsOperationGroup.list, "UsageModels");

@@clientLocation(AscOperationsOperationGroup.get, "AscOperations");

@@clientLocation(AscUsagesOperationGroup.list, "AscUsages");
@@clientName(checkAmlFSSubnets::parameters.body, "amlFilesystemSubnetInfo");
@@clientName(getRequiredAmlFSSubnetsSize::parameters.body,
  "requiredAMLFilesystemSubnetsSizeInfo"
);

@@clientName(ProvisioningStateType.Canceled, "Cancelled", "go");
