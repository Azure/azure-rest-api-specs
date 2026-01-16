import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.Web;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AppServiceEnvironmentPatchResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PushSettings.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ResourceMetricDefinition.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Microsoft.Web.Usage.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AppServicePlanPatchResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(HybridConnectionKey.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CertificatePatchResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DiagnosticAnalysis.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DiagnosticDetectorResponse.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Snapshot.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(KubeEnvironmentPatchResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ApplicationStackResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FunctionAppStack.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WebAppStack.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Recommendation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BillingMeter.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CustomHostnameSites.properties);

@@clientName(IdentifierProperties.id, "value");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(GeoRegion.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AseRegion.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PremierAddOnOffer.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VnetParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VnetValidationFailureDetails.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VnetValidationTestFailure.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ValidateRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSitesWorkflowPreviewRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSitesWorkflowPreview.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RemotePrivateEndpointConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteUserProvidedFunctionApp.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSitePatchResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteUserARMResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StringDictionary.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DatabaseConnectionPatchRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteFunctionOverviewARMResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteZipDeploymentARMResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteUserInvitationRequestResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteUserInvitationResponseResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteCustomDomainRequestPropertiesARMResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteResetPropertiesARMResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SitePatchResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CustomHostnameAnalysisResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BackupRequest.properties);

@@clientName(BackupItemProperties.id, "BackupId");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RestoreRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteAuthSettings.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AzureStoragePropertyDictionaryResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ConnectionStringDictionary.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteConfigurationSnapshotInfo.properties);

@@clientName(ContinuousWebJobProperties.detailed_status, "detailedStatus");
@@clientName(ContinuousWebJobProperties.log_url, "logUrl");
@@clientName(ContinuousWebJobProperties.run_command, "runCommand");
@@clientName(ContinuousWebJobProperties.extra_info_url, "extraInfoUrl");
@@clientName(ContinuousWebJobProperties.web_job_type, "webJobType");
@@clientName(ContinuousWebJobProperties.using_sdk, "usingSdk");

@@clientName(DeploymentProperties.author_email, "authorEmail");
@@clientName(DeploymentProperties.start_time, "startTime");
@@clientName(DeploymentProperties.end_time, "endTime");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MSDeploy.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MSDeployLog.properties);

@@clientName(FunctionEnvelopeProperties.function_app_id, "functionAppId");
@@clientName(FunctionEnvelopeProperties.script_root_path_href,
  "scriptRootPathHref"
);
@@clientName(FunctionEnvelopeProperties.script_href, "scriptHref");
@@clientName(FunctionEnvelopeProperties.config_href, "configHref");
@@clientName(FunctionEnvelopeProperties.test_data_href, "testDataHref");
@@clientName(FunctionEnvelopeProperties.secrets_file_href, "secretsFileHref");
@@clientName(FunctionEnvelopeProperties.test_data, "testData");
@@clientName(FunctionEnvelopeProperties.invoke_url_template,
  "invokeUrlTemplate"
);

@@clientName(FunctionSecrets.trigger_url, "triggerUrl");

@@clientName(ProcessInfoProperties.deployment_name, "deploymentName");
@@clientName(ProcessInfoProperties.is_profile_running, "isProfileRunning");
@@clientName(ProcessInfoProperties.is_iis_profile_running,
  "isIisProfileRunning"
);
@@clientName(ProcessInfoProperties.iis_profile_timeout_in_seconds,
  "iisProfileTimeoutInSeconds"
);
@@clientName(ProcessInfoProperties.open_file_handles, "openFileHandles");
@@clientName(ProcessInfoProperties.file_name, "fileName");
@@clientName(ProcessInfoProperties.command_line, "commandLine");
@@clientName(ProcessInfoProperties.user_name, "userName");
@@clientName(ProcessInfoProperties.handle_count, "handleCount");
@@clientName(ProcessInfoProperties.module_count, "moduleCount");
@@clientName(ProcessInfoProperties.thread_count, "threadCount");
@@clientName(ProcessInfoProperties.start_time, "startTime");
@@clientName(ProcessInfoProperties.total_cpu_time, "totalCpuTime");
@@clientName(ProcessInfoProperties.user_cpu_time, "userCpuTime");
@@clientName(ProcessInfoProperties.privileged_cpu_time, "privilegedCpuTime");
@@clientName(ProcessInfoProperties.working_set, "workingSet");
@@clientName(ProcessInfoProperties.peak_working_set, "peakWorkingSet");
@@clientName(ProcessInfoProperties.private_memory, "privateMemory");
@@clientName(ProcessInfoProperties.virtual_memory, "virtualMemory");
@@clientName(ProcessInfoProperties.peak_virtual_memory, "peakVirtualMemory");
@@clientName(ProcessInfoProperties.paged_system_memory, "pagedSystemMemory");
@@clientName(ProcessInfoProperties.non_paged_system_memory,
  "nonPagedSystemMemory"
);
@@clientName(ProcessInfoProperties.paged_memory, "pagedMemory");
@@clientName(ProcessInfoProperties.peak_paged_memory, "peakPagedMemory");
@@clientName(ProcessInfoProperties.time_stamp, "timeStamp");
@@clientName(ProcessInfoProperties.environment_variables,
  "environmentVariables"
);
@@clientName(ProcessInfoProperties.is_scm_site, "isScmSite");
@@clientName(ProcessInfoProperties.is_webjob, "isWebjob");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProcessThreadInfo.properties);

@@clientName(ProcessThreadInfoProperties.start_address, "startAddress");
@@clientName(ProcessThreadInfoProperties.current_priority, "currentPriority");
@@clientName(ProcessThreadInfoProperties.priority_level, "priorityLevel");
@@clientName(ProcessThreadInfoProperties.base_priority, "basePriority");
@@clientName(ProcessThreadInfoProperties.start_time, "startTime");
@@clientName(ProcessThreadInfoProperties.total_processor_time,
  "totalProcessorTime"
);
@@clientName(ProcessThreadInfoProperties.user_processor_time,
  "userProcessorTime"
);
@@clientName(ProcessThreadInfoProperties.wait_reason, "waitReason");

@@clientName(ProcessModuleInfoProperties.base_address, "baseAddress");
@@clientName(ProcessModuleInfoProperties.file_name, "fileName");
@@clientName(ProcessModuleInfoProperties.file_path, "filePath");
@@clientName(ProcessModuleInfoProperties.module_memory_size,
  "moduleMemorySize"
);
@@clientName(ProcessModuleInfoProperties.file_version, "fileVersion");
@@clientName(ProcessModuleInfoProperties.file_description, "fileDescription");
@@clientName(ProcessModuleInfoProperties.product_version, "productVersion");
@@clientName(ProcessModuleInfoProperties.is_debug, "isDebug");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageMigrationOptions.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageMigrationResponse.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MigrateMySqlRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SitePhpErrorLogFlag.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PremierAddOnPatchResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DeletedAppRestoreRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SnapshotRestoreRequest.properties);

@@clientName(SiteExtensionInfoProperties.extension_id, "extensionId");
@@clientName(SiteExtensionInfoProperties.extension_type, "extensionType");
@@clientName(SiteExtensionInfoProperties.extension_url, "extensionUrl");
@@clientName(SiteExtensionInfoProperties.project_url, "projectUrl");
@@clientName(SiteExtensionInfoProperties.icon_url, "iconUrl");
@@clientName(SiteExtensionInfoProperties.license_url, "licenseUrl");
@@clientName(SiteExtensionInfoProperties.feed_url, "feedUrl");
@@clientName(SiteExtensionInfoProperties.installer_command_line_params,
  "installerCommandLineParams"
);
@@clientName(SiteExtensionInfoProperties.published_date_time,
  "publishedDateTime"
);
@@clientName(SiteExtensionInfoProperties.download_count, "downloadCount");
@@clientName(SiteExtensionInfoProperties.local_is_latest_version,
  "localIsLatestVersion"
);
@@clientName(SiteExtensionInfoProperties.local_path, "localPath");
@@clientName(SiteExtensionInfoProperties.installed_date_time,
  "installedDateTime"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SlotDifference.properties);

@@clientName(TriggeredWebJobProperties.latest_run, "latestRun");
@@clientName(TriggeredWebJobProperties.history_url, "historyUrl");
@@clientName(TriggeredWebJobProperties.scheduler_logs_url, "schedulerLogsUrl");
@@clientName(TriggeredWebJobProperties.run_command, "runCommand");
@@clientName(TriggeredWebJobProperties.extra_info_url, "extraInfoUrl");
@@clientName(TriggeredWebJobProperties.web_job_type, "webJobType");
@@clientName(TriggeredWebJobProperties.using_sdk, "usingSdk");

@@clientName(TriggeredJobRun.web_job_id, "webJobId");
@@clientName(TriggeredJobRun.web_job_name, "webJobName");
@@clientName(TriggeredJobRun.start_time, "startTime");
@@clientName(TriggeredJobRun.end_time, "endTime");
@@clientName(TriggeredJobRun.output_url, "outputUrl");
@@clientName(TriggeredJobRun.error_url, "errorUrl");
@@clientName(TriggeredJobRun.job_name, "jobName");

@@clientName(WebJobProperties.run_command, "runCommand");
@@clientName(WebJobProperties.extra_info_url, "extraInfoUrl");
@@clientName(WebJobProperties.web_job_type, "webJobType");
@@clientName(WebJobProperties.using_sdk, "usingSdk");

@@clientName(WorkflowTriggerListCallbackUrlQueries.`api-version`, "apiVersion");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Workflow.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateLinkConnectionApprovalRequestResource.properties);

@@clientLocation(AppServiceEnvironmentResources.get, AppServiceEnvironments);
@@clientLocation(AppServiceEnvironmentResources.createOrUpdate,
  AppServiceEnvironments
);
@@clientName(AppServiceEnvironmentResources.createOrUpdate::parameters.resource,
  "hostingEnvironmentEnvelope"
);
@@clientLocation(AppServiceEnvironmentResources.update, AppServiceEnvironments);
@@clientName(AppServiceEnvironmentResources.update::parameters.properties,
  "hostingEnvironmentEnvelope"
);
@@clientLocation(AppServiceEnvironmentResources.delete, AppServiceEnvironments);
@@clientLocation(AppServiceEnvironmentResources.listByResourceGroup,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.list, AppServiceEnvironments);
@@clientLocation(AppServiceEnvironmentResources.listCapacities,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.changeVnet,
  AppServiceEnvironments
);
@@clientName(AppServiceEnvironmentResources.changeVnet::parameters.body,
  "vnetInfo"
);
@@clientLocation(AppServiceEnvironmentResources.listDiagnostics,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.getDiagnosticsItem,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.getInboundNetworkDependenciesEndpoints,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.testUpgradeAvailableNotification,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.upgrade,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.listOperations,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.getOutboundNetworkDependenciesEndpoints,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.getPrivateLinkResources,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.reboot, AppServiceEnvironments);
@@clientLocation(AppServiceEnvironmentResources.resume, AppServiceEnvironments);
@@clientLocation(AppServiceEnvironmentResources.listAppServicePlans,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.listWebApps,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.suspend,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.listUsages,
  AppServiceEnvironments
);
@@clientLocation(AppServiceEnvironmentResources.listHistoryForHostingEnvironment,
  Recommendations
);
@@clientLocation(AppServiceEnvironmentResources.listRecommendedRulesForHostingEnvironment,
  Recommendations
);
@@clientLocation(AppServiceEnvironmentResources.disableAllForHostingEnvironment,
  Recommendations
);
@@clientLocation(AppServiceEnvironmentResources.resetAllFiltersForHostingEnvironment,
  Recommendations
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AppServiceEnvironmentResource.properties);

@@clientLocation(CustomDnsSuffixConfigurations.getAseCustomDnsSuffixConfiguration,
  AppServiceEnvironments
);
@@clientLocation(CustomDnsSuffixConfigurations.updateAseCustomDnsSuffixConfiguration,
  AppServiceEnvironments
);
@@clientName(CustomDnsSuffixConfigurations.updateAseCustomDnsSuffixConfiguration::parameters.resource,
  "customDnsSuffixConfiguration"
);
@@clientLocation(CustomDnsSuffixConfigurations.deleteAseCustomDnsSuffixConfiguration,
  AppServiceEnvironments
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CustomDnsSuffixConfiguration.properties);

@@clientLocation(AseV3NetworkingConfigurations.getAseV3NetworkingConfiguration,
  AppServiceEnvironments
);
@@clientLocation(AseV3NetworkingConfigurations.updateAseNetworkingConfiguration,
  AppServiceEnvironments
);
@@clientName(AseV3NetworkingConfigurations.updateAseNetworkingConfiguration::parameters.resource,
  "aseNetworkingConfiguration"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AseV3NetworkingConfiguration.properties);

@@clientLocation(AddressResponses.getVipInfo, AppServiceEnvironments);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AddressResponse.properties);

@@clientLocation(Sites.get, WebApps);
@@clientLocation(Sites.createOrUpdate, WebApps);
@@clientName(Sites.createOrUpdate::parameters.resource, "siteEnvelope");
@@clientLocation(Sites.update, WebApps);
@@clientName(Sites.update::parameters.properties, "siteEnvelope");
@@clientLocation(Sites.delete, WebApps);
@@clientLocation(Sites.list, WebApps);
@@clientLocation(Sites.listHistoryForWebApp, Recommendations);
@@clientLocation(Sites.listRecommendedRulesForWebApp, Recommendations);
@@clientLocation(Sites.disableAllForWebApp, Recommendations);
@@clientLocation(Sites.resetAllFiltersForWebApp, Recommendations);
@@clientLocation(Sites.analyzeCustomHostname, WebApps);
@@clientLocation(Sites.applySlotConfigToProduction, WebApps);
@@clientName(Sites.applySlotConfigToProduction::parameters.body,
  "slotSwapEntity"
);
@@clientLocation(Sites.backup, WebApps);
@@clientName(Sites.backup::parameters.body, "request");
@@clientLocation(Sites.updateApplicationSettings, WebApps);
@@clientName(Sites.updateApplicationSettings::parameters.body, "appSettings");
@@clientLocation(Sites.listApplicationSettings, WebApps);
@@clientLocation(Sites.updateAuthSettings, WebApps);
@@clientName(Sites.updateAuthSettings::parameters.body, "siteAuthSettings");
@@clientLocation(Sites.getAuthSettings, WebApps);
@@clientLocation(Sites.updateAzureStorageAccounts, WebApps);
@@clientName(Sites.updateAzureStorageAccounts::parameters.body,
  "azureStorageAccounts"
);
@@clientLocation(Sites.listAzureStorageAccounts, WebApps);
@@clientLocation(Sites.updateBackupConfiguration, WebApps);
@@clientName(Sites.updateBackupConfiguration::parameters.body, "request");
@@clientLocation(Sites.deleteBackupConfiguration, WebApps);
@@clientLocation(Sites.getBackupConfiguration, WebApps);
@@clientLocation(Sites.updateConnectionStrings, WebApps);
@@clientName(Sites.updateConnectionStrings::parameters.body,
  "connectionStrings"
);
@@clientLocation(Sites.listConnectionStrings, WebApps);
@@clientLocation(Sites.updateMetadata, WebApps);
@@clientName(Sites.updateMetadata::parameters.body, "metadata");
@@clientLocation(Sites.listMetadata, WebApps);
@@clientLocation(Sites.listPublishingCredentials, WebApps);
@@clientLocation(Sites.updateSitePushSettings, WebApps);
@@clientName(Sites.updateSitePushSettings::parameters.body, "pushSettings");
@@clientLocation(Sites.listSitePushSettings, WebApps);
@@clientLocation(Sites.getWebSiteContainerLogs, WebApps);
@@clientLocation(Sites.getContainerLogsZip, WebApps);
@@clientLocation(Sites.discoverBackup, WebApps);
@@clientName(Sites.discoverBackup::parameters.body, "request");
@@clientLocation(Sites.getOneDeployStatus, WebApps);
@@clientLocation(Sites.createOneDeployOperation, WebApps);
@@clientLocation(Sites.getFunctionsAdminToken, WebApps);
@@clientLocation(Sites.listHostKeys, WebApps);
@@clientLocation(Sites.listSyncStatus, WebApps);
@@clientLocation(Sites.syncFunctions, WebApps);
@@clientLocation(Sites.createOrUpdateHostSecret, WebApps);
@@clientName(Sites.createOrUpdateHostSecret::parameters.body, "key");
@@clientLocation(Sites.deleteHostSecret, WebApps);
@@clientLocation(Sites.listHybridConnections, WebApps);
@@clientLocation(Sites.listRelayServiceConnections, WebApps);
@@clientLocation(Sites.isCloneable, WebApps);
@@clientLocation(Sites.listSiteBackups, WebApps);
@@clientLocation(Sites.listSyncFunctionTriggers, WebApps);
@@clientLocation(Sites.updateMachineKey, WebApps);
@@clientLocation(Sites.migrateStorage, WebApps);
@@clientName(Sites.migrateStorage::parameters.body, "migrationOptions");
@@clientLocation(Sites.migrateMySql, WebApps);
@@clientName(Sites.migrateMySql::parameters.body, "migrationRequestEnvelope");
@@clientLocation(Sites.getNetworkTraceOperation, WebApps);
@@clientLocation(Sites.startWebSiteNetworkTrace, WebApps);
@@clientLocation(Sites.startWebSiteNetworkTraceOperation, WebApps);
@@clientLocation(Sites.stopWebSiteNetworkTrace, WebApps);
@@clientLocation(Sites.getNetworkTraces, WebApps);
@@clientLocation(Sites.getNetworkTraceOperationV2, WebApps);
@@clientLocation(Sites.getNetworkTracesV2, WebApps);
@@clientLocation(Sites.generateNewSitePublishingPassword, WebApps);
@@clientLocation(Sites.listPerfMonCounters, WebApps);
@@clientLocation(Sites.getSitePhpErrorLogFlag, WebApps);
@@clientLocation(Sites.listPremierAddOns, WebApps);
@@clientLocation(Sites.getPrivateLinkResources, WebApps);
@@clientLocation(Sites.listPublishingProfileXmlWithSecrets, WebApps);
@@clientName(Sites.listPublishingProfileXmlWithSecrets::parameters.body,
  "publishingProfileOptions"
);
@@clientLocation(Sites.resetProductionSlotConfig, WebApps);
@@clientLocation(Sites.restart, WebApps);
@@clientLocation(Sites.restoreFromBackupBlob, WebApps);
@@clientName(Sites.restoreFromBackupBlob::parameters.body, "request");
@@clientLocation(Sites.restoreFromDeletedApp, WebApps);
@@clientName(Sites.restoreFromDeletedApp::parameters.body, "restoreRequest");
@@clientLocation(Sites.restoreSnapshot, WebApps);
@@clientName(Sites.restoreSnapshot::parameters.body, "restoreRequest");
@@clientLocation(Sites.listSlotDifferencesFromProduction, WebApps);
@@clientName(Sites.listSlotDifferencesFromProduction::parameters.body,
  "slotSwapEntity"
);
@@clientLocation(Sites.swapSlotWithProduction, WebApps);
@@clientName(Sites.swapSlotWithProduction::parameters.body, "slotSwapEntity");
@@clientLocation(Sites.listSnapshots, WebApps);
@@clientLocation(Sites.listSnapshotsFromDRSecondary, WebApps);
@@clientLocation(Sites.start, WebApps);
@@clientLocation(Sites.startNetworkTrace, WebApps);
@@clientLocation(Sites.stop, WebApps);
@@clientLocation(Sites.stopNetworkTrace, WebApps);
@@clientLocation(Sites.syncRepository, WebApps);
@@clientLocation(Sites.syncFunctionTriggers, WebApps);
@@clientLocation(Sites.listUsages, WebApps);
@@clientLocation(Sites.deployWorkflowArtifacts, WebApps);
@@clientName(Sites.deployWorkflowArtifacts::parameters.body,
  "workflowArtifacts"
);
@@clientLocation(Sites.listWorkflowsConnections, WebApps);
@@clientLocation(Sites.regenerateAccessKey, "Workflows");
@@clientName(Sites.regenerateAccessKey::parameters.body, "keyType");
@@clientLocation(Sites.validate, "Workflows");
@@clientName(Sites.validate::parameters.body, "validate");

@@clientName(WebApps.createOrUpdateSlot::parameters.resource, "siteEnvelope");
@@clientName(WebApps.updateSlot::parameters.properties, "siteEnvelope");
@@clientName(WebApps.applySlotConfigurationSlot::parameters.body,
  "slotSwapEntity"
);
@@clientName(WebApps.backupSlot::parameters.body, "request");
@@clientName(WebApps.updateApplicationSettingsSlot::parameters.body,
  "appSettings"
);
@@clientName(WebApps.updateAuthSettingsSlot::parameters.body,
  "siteAuthSettings"
);
@@clientName(WebApps.updateAzureStorageAccountsSlot::parameters.body,
  "azureStorageAccounts"
);
@@clientName(WebApps.updateBackupConfigurationSlot::parameters.body, "request");
@@clientName(WebApps.updateConnectionStringsSlot::parameters.body,
  "connectionStrings"
);
@@clientName(WebApps.updateMetadataSlot::parameters.body, "metadata");
@@clientName(WebApps.updateSitePushSettingsSlot::parameters.body,
  "pushSettings"
);
@@clientName(WebApps.discoverBackupSlot::parameters.body, "request");
@@clientName(WebApps.createOrUpdateHostSecretSlot::parameters.body, "key");
@@clientName(WebApps.listPublishingProfileXmlWithSecretsSlot::parameters.body,
  "publishingProfileOptions"
);
@@clientName(WebApps.restoreFromBackupBlobSlot::parameters.body, "request");
@@clientName(WebApps.restoreFromDeletedAppSlot::parameters.body,
  "restoreRequest"
);
@@clientName(WebApps.restoreSnapshotSlot::parameters.body, "restoreRequest");
@@clientName(WebApps.listSlotDifferencesSlot::parameters.body,
  "slotSwapEntity"
);
@@clientName(WebApps.swapSlotSlot::parameters.body, "slotSwapEntity");
@@clientName(WebApps.deployWorkflowArtifactsSlot::parameters.body,
  "workflowArtifacts"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Site.properties);

@@clientLocation(WorkerPoolResources.getMultiRolePool, AppServiceEnvironments);
@@clientLocation(WorkerPoolResources.createOrUpdateMultiRolePool,
  AppServiceEnvironments
);
@@clientName(WorkerPoolResources.createOrUpdateMultiRolePool::parameters.resource,
  "multiRolePoolEnvelope"
);
@@clientLocation(WorkerPoolResources.updateMultiRolePool,
  AppServiceEnvironments
);
@@clientName(WorkerPoolResources.updateMultiRolePool::parameters.properties,
  "multiRolePoolEnvelope"
);
@@clientLocation(WorkerPoolResources.listMultiRolePools,
  AppServiceEnvironments
);
@@clientLocation(WorkerPoolResources.listMultiRolePoolInstanceMetricDefinitions,
  AppServiceEnvironments
);
@@clientLocation(WorkerPoolResources.listMultiRoleMetricDefinitions,
  AppServiceEnvironments
);
@@clientLocation(WorkerPoolResources.listMultiRolePoolSkus,
  AppServiceEnvironments
);
@@clientLocation(WorkerPoolResources.listMultiRoleUsages,
  AppServiceEnvironments
);
@@clientName(AppServiceEnvironments.createOrUpdateWorkerPool::parameters.resource,
  "workerPoolEnvelope"
);
@@clientName(AppServiceEnvironments.updateWorkerPool::parameters.properties,
  "workerPoolEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkerPoolResource.properties);

@@clientLocation(RemotePrivateEndpointConnectionARMResources.getPrivateEndpointConnection,
  AppServiceEnvironments
);
@@clientLocation(RemotePrivateEndpointConnectionARMResources.approveOrRejectPrivateEndpointConnection,
  AppServiceEnvironments
);
@@clientName(RemotePrivateEndpointConnectionARMResources.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "privateEndpointWrapper"
);
@@clientLocation(RemotePrivateEndpointConnectionARMResources.deletePrivateEndpointConnection,
  AppServiceEnvironments
);
@@clientLocation(RemotePrivateEndpointConnectionARMResources.getPrivateEndpointConnectionList,
  AppServiceEnvironments
);
@@clientName(StaticSites.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "privateEndpointWrapper"
);
@@clientLocation(RemotePrivateEndpointConnectionARMResourceOperationGroup.getPrivateEndpointConnection,
  WebApps
);
@@clientLocation(RemotePrivateEndpointConnectionARMResourceOperationGroup.approveOrRejectPrivateEndpointConnection,
  WebApps
);
@@clientName(RemotePrivateEndpointConnectionARMResourceOperationGroup.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "privateEndpointWrapper"
);
@@clientLocation(RemotePrivateEndpointConnectionARMResourceOperationGroup.deletePrivateEndpointConnection,
  WebApps
);
@@clientLocation(RemotePrivateEndpointConnectionARMResourceOperationGroup.getPrivateEndpointConnectionList,
  WebApps
);
@@clientLocation(PrivateEndpointConnectionSlotOperationGroup.getPrivateEndpointConnectionSlot,
  WebApps
);
@@clientLocation(PrivateEndpointConnectionSlotOperationGroup.approveOrRejectPrivateEndpointConnectionSlot,
  WebApps
);
@@clientName(PrivateEndpointConnectionSlotOperationGroup.approveOrRejectPrivateEndpointConnectionSlot::parameters.resource,
  "privateEndpointWrapper"
);
@@clientLocation(PrivateEndpointConnectionSlotOperationGroup.deletePrivateEndpointConnectionSlot,
  WebApps
);
@@clientLocation(PrivateEndpointConnectionSlotOperationGroup.getPrivateEndpointConnectionListSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RemotePrivateEndpointConnectionARMResource.properties);

@@clientName(AppServicePlans.createOrUpdate::parameters.resource,
  "appServicePlan"
);
@@clientName(AppServicePlans.update::parameters.properties, "appServicePlan");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AppServicePlan.properties);

@@clientLocation(HybridConnections.getHybridConnection, AppServicePlans);
@@clientLocation(HybridConnections.deleteHybridConnection, AppServicePlans);
@@clientLocation(HybridConnections.listHybridConnectionKeys, AppServicePlans);
@@clientLocation(HybridConnections.listWebAppsByHybridConnection,
  AppServicePlans
);
@@clientLocation(HybridConnectionOperationGroup.getHybridConnection, WebApps);
@@clientLocation(HybridConnectionOperationGroup.createOrUpdateHybridConnection,
  WebApps
);
@@clientName(HybridConnectionOperationGroup.createOrUpdateHybridConnection::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(HybridConnectionOperationGroup.updateHybridConnection,
  WebApps
);
@@clientName(HybridConnectionOperationGroup.updateHybridConnection::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(HybridConnectionOperationGroup.deleteHybridConnection,
  WebApps
);
@@clientLocation(HybridConnectionSlotOperationGroup.getHybridConnectionSlot,
  WebApps
);
@@clientLocation(HybridConnectionSlotOperationGroup.createOrUpdateHybridConnectionSlot,
  WebApps
);
@@clientName(HybridConnectionSlotOperationGroup.createOrUpdateHybridConnectionSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(HybridConnectionSlotOperationGroup.updateHybridConnectionSlot,
  WebApps
);
@@clientName(HybridConnectionSlotOperationGroup.updateHybridConnectionSlot::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(HybridConnectionSlotOperationGroup.deleteHybridConnectionSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(HybridConnection.properties);

@@clientLocation(HybridConnectionLimitsOperationGroup.getHybridConnectionPlanLimit,
  AppServicePlans
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(HybridConnectionLimits.properties);

@@clientLocation(VnetInfoResources.getVnetFromServerFarm, AppServicePlans);
@@clientLocation(VnetInfoResources.listVnets, AppServicePlans);
@@clientLocation(VnetInfoResourceOperationGroup.getVnetConnectionSlot, WebApps);
@@clientLocation(VnetInfoResourceOperationGroup.createOrUpdateVnetConnectionSlot,
  WebApps
);
@@clientName(VnetInfoResourceOperationGroup.createOrUpdateVnetConnectionSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(VnetInfoResourceOperationGroup.updateVnetConnectionSlot,
  WebApps
);
@@clientName(VnetInfoResourceOperationGroup.updateVnetConnectionSlot::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(VnetInfoResourceOperationGroup.deleteVnetConnectionSlot,
  WebApps
);
@@clientLocation(VnetInfoResourceOperationGroup.listVnetConnectionsSlot,
  WebApps
);
@@clientLocation(VnetConnectionOperationGroup.getVnetConnection, WebApps);
@@clientLocation(VnetConnectionOperationGroup.createOrUpdateVnetConnection,
  WebApps
);
@@clientName(VnetConnectionOperationGroup.createOrUpdateVnetConnection::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(VnetConnectionOperationGroup.updateVnetConnection, WebApps);
@@clientName(VnetConnectionOperationGroup.updateVnetConnection::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(VnetConnectionOperationGroup.deleteVnetConnection, WebApps);
@@clientLocation(VnetConnectionOperationGroup.listVnetConnections, WebApps);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VnetInfoResource.properties);

@@clientLocation(VnetRoutes.getRouteForVnet, AppServicePlans);
@@clientLocation(VnetRoutes.createOrUpdateVnetRoute, AppServicePlans);
@@clientName(VnetRoutes.createOrUpdateVnetRoute::parameters.resource, "route");
@@clientLocation(VnetRoutes.updateVnetRoute, AppServicePlans);
@@clientName(VnetRoutes.updateVnetRoute::parameters.properties, "route");
@@clientLocation(VnetRoutes.deleteVnetRoute, AppServicePlans);
@@clientLocation(VnetRoutes.listRoutesForVnet, AppServicePlans);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VnetRoute.properties);

@@clientLocation(VnetGateways.getVnetGateway, AppServicePlans);
@@clientLocation(VnetGateways.updateVnetGateway, AppServicePlans);
@@clientName(VnetGateways.updateVnetGateway::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(VnetGatewayOperationGroup.getVnetConnectionGatewaySlot,
  WebApps
);
@@clientLocation(VnetGatewayOperationGroup.createOrUpdateVnetConnectionGatewaySlot,
  WebApps
);
@@clientName(VnetGatewayOperationGroup.createOrUpdateVnetConnectionGatewaySlot::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(VnetGatewayOperationGroup.updateVnetConnectionGatewaySlot,
  WebApps
);
@@clientName(VnetGatewayOperationGroup.updateVnetConnectionGatewaySlot::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(VnetConnectionGatewayOperationGroup.getVnetConnectionGateway,
  WebApps
);
@@clientLocation(VnetConnectionGatewayOperationGroup.createOrUpdateVnetConnectionGateway,
  WebApps
);
@@clientName(VnetConnectionGatewayOperationGroup.createOrUpdateVnetConnectionGateway::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(VnetConnectionGatewayOperationGroup.updateVnetConnectionGateway,
  WebApps
);
@@clientName(VnetConnectionGatewayOperationGroup.updateVnetConnectionGateway::parameters.properties,
  "connectionEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VnetGateway.properties);

@@clientName(Certificates.createOrUpdate::parameters.resource,
  "certificateEnvelope"
);
@@clientName(Certificates.update::parameters.properties, "certificateEnvelope");
@@clientName(SiteCertificates.createOrUpdate::parameters.resource,
  "certificateEnvelope"
);
@@clientName(SiteCertificates.update::parameters.properties,
  "certificateEnvelope"
);
@@clientLocation(CertificateOperationGroup.getSlot, SiteCertificates);
@@clientLocation(CertificateOperationGroup.createOrUpdateSlot,
  SiteCertificates
);
@@clientName(CertificateOperationGroup.createOrUpdateSlot::parameters.resource,
  "certificateEnvelope"
);
@@clientLocation(CertificateOperationGroup.updateSlot, SiteCertificates);
@@clientName(CertificateOperationGroup.updateSlot::parameters.properties,
  "certificateEnvelope"
);
@@clientLocation(CertificateOperationGroup.deleteSlot, SiteCertificates);
@@clientLocation(CertificateOperationGroup.listSlot, SiteCertificates);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Certificate.properties);

@@clientLocation(DeletedSites.getDeletedWebAppByLocation, "DeletedWebApps");
@@clientLocation(DeletedSites.listByLocation, "DeletedWebApps");
@@clientLocation(Global.list, "DeletedWebApps");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DeletedSite.properties);

@@clientLocation(DetectorResponses.getHostingEnvironmentDetectorResponse,
  Diagnostics
);
@@clientLocation(DetectorResponses.listHostingEnvironmentDetectorResponses,
  Diagnostics
);
@@clientLocation(DetectorResponseOperationGroup.getSiteDetectorResponseSlot,
  Diagnostics
);
@@clientLocation(DetectorResponseOperationGroup.listSiteDetectorResponsesSlot,
  Diagnostics
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DetectorResponse.properties);

@@clientLocation(DiagnosticCategories.getSiteDiagnosticCategory, Diagnostics);
@@clientLocation(DiagnosticCategories.listSiteDiagnosticCategories,
  Diagnostics
);
@@clientLocation(DiagnosticCategoryOperationGroup.getSiteDiagnosticCategorySlot,
  Diagnostics
);
@@clientLocation(DiagnosticCategoryOperationGroup.listSiteDiagnosticCategoriesSlot,
  Diagnostics
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DiagnosticCategory.properties);

@@clientLocation(AnalysisDefinitions.getSiteAnalysis, Diagnostics);
@@clientLocation(AnalysisDefinitions.listSiteAnalyses, Diagnostics);
@@clientLocation(AnalysisDefinitions.executeSiteAnalysis, Diagnostics);
@@clientLocation(AnalysisDefinitionOperationGroup.getSiteAnalysisSlot,
  Diagnostics
);
@@clientLocation(AnalysisDefinitionOperationGroup.listSiteAnalysesSlot,
  Diagnostics
);
@@clientLocation(AnalysisDefinitionOperationGroup.executeSiteAnalysisSlot,
  Diagnostics
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AnalysisDefinition.properties);

@@clientLocation(DetectorDefinitionResources.getSiteDetector, Diagnostics);
@@clientLocation(DetectorDefinitionResources.listSiteDetectors, Diagnostics);
@@clientLocation(DetectorDefinitionResources.executeSiteDetector, Diagnostics);
@@clientLocation(DetectorDefinitionResourceOperationGroup.getSiteDetectorSlot,
  Diagnostics
);
@@clientLocation(DetectorDefinitionResourceOperationGroup.listSiteDetectorsSlot,
  Diagnostics
);
@@clientLocation(DetectorDefinitionResourceOperationGroup.executeSiteDetectorSlot,
  Diagnostics
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DetectorDefinitionResource.properties);

@@clientName(KubeEnvironments.createOrUpdate::parameters.resource,
  "kubeEnvironmentEnvelope"
);
@@clientName(KubeEnvironments.update::parameters.properties,
  "kubeEnvironmentEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(KubeEnvironment.properties);

@@clientLocation(RecommendationRules.getRuleDetailsByHostingEnvironment,
  Recommendations
);
@@clientLocation(RecommendationRules.disableRecommendationForHostingEnvironment,
  Recommendations
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RecommendationRule.properties);

@@clientLocation(ResourceHealthMetadataOperationGroup.getBySite,
  "ResourceHealthMetadata"
);
@@clientLocation(ResourceHealthMetadataOperationGroup.listBySite,
  "ResourceHealthMetadata"
);
@@clientLocation(BySiteSlotOperationGroup.getBySiteSlot,
  "ResourceHealthMetadata"
);
@@clientLocation(BySiteSlotOperationGroup.listBySiteSlot,
  "ResourceHealthMetadata"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ResourceHealthMetadata.properties);

@@clientLocation(Users.getPublishingUser, Microsoft.Web);
@@clientLocation(Users.updatePublishingUser, Microsoft.Web);
@@clientName(Users.updatePublishingUser::parameters.resource, "userDetails");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(User.properties);

@@clientLocation(SourceControls.getSourceControl, Microsoft.Web);
@@clientLocation(SourceControls.updateSourceControl, Microsoft.Web);
@@clientName(SourceControls.updateSourceControl::parameters.resource,
  "requestMessage"
);
@@clientLocation(SourceControls.listSourceControls, Microsoft.Web);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SourceControl.properties);

@@clientLocation(Identifiers.getDomainOwnershipIdentifier, WebApps);
@@clientLocation(Identifiers.createOrUpdateDomainOwnershipIdentifier, WebApps);
@@clientName(Identifiers.createOrUpdateDomainOwnershipIdentifier::parameters.resource,
  "domainOwnershipIdentifier"
);
@@clientLocation(Identifiers.updateDomainOwnershipIdentifier, WebApps);
@@clientName(Identifiers.updateDomainOwnershipIdentifier::parameters.properties,
  "domainOwnershipIdentifier"
);
@@clientLocation(Identifiers.deleteDomainOwnershipIdentifier, WebApps);
@@clientLocation(Identifiers.listDomainOwnershipIdentifiers, WebApps);
@@clientLocation(IdentifierOperationGroup.getDomainOwnershipIdentifierSlot,
  WebApps
);
@@clientLocation(IdentifierOperationGroup.createOrUpdateDomainOwnershipIdentifierSlot,
  WebApps
);
@@clientName(IdentifierOperationGroup.createOrUpdateDomainOwnershipIdentifierSlot::parameters.resource,
  "domainOwnershipIdentifier"
);
@@clientLocation(IdentifierOperationGroup.updateDomainOwnershipIdentifierSlot,
  WebApps
);
@@clientName(IdentifierOperationGroup.updateDomainOwnershipIdentifierSlot::parameters.properties,
  "domainOwnershipIdentifier"
);
@@clientLocation(IdentifierOperationGroup.deleteDomainOwnershipIdentifierSlot,
  WebApps
);
@@clientLocation(IdentifierOperationGroup.listDomainOwnershipIdentifiersSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Identifier.properties);

@@clientLocation(StaticSiteARMResources.getStaticSite, StaticSites);
@@clientLocation(StaticSiteARMResources.createOrUpdateStaticSite, StaticSites);
@@clientName(StaticSiteARMResources.createOrUpdateStaticSite::parameters.resource,
  "staticSiteEnvelope"
);
@@clientLocation(StaticSiteARMResources.updateStaticSite, StaticSites);
@@clientName(StaticSiteARMResources.updateStaticSite::parameters.properties,
  "staticSiteEnvelope"
);
@@clientLocation(StaticSiteARMResources.deleteStaticSite, StaticSites);
@@clientLocation(StaticSiteARMResources.getStaticSitesByResourceGroup,
  StaticSites
);
@@clientLocation(StaticSiteARMResources.list, StaticSites);
@@clientLocation(StaticSiteARMResources.listStaticSiteUsers, StaticSites);
@@clientLocation(StaticSiteARMResources.deleteStaticSiteUser, StaticSites);
@@clientLocation(StaticSiteARMResources.updateStaticSiteUser, StaticSites);

@@clientLocation(StaticSiteARMResources.createOrUpdateStaticSiteAppSettings,
  StaticSites
);
@@clientName(StaticSiteARMResources.createOrUpdateStaticSiteAppSettings::parameters.body,
  "appSettings"
);
@@clientLocation(StaticSiteARMResources.createOrUpdateStaticSiteFunctionAppSettings,
  StaticSites
);
@@clientName(StaticSiteARMResources.createOrUpdateStaticSiteFunctionAppSettings::parameters.body,
  "appSettings"
);
@@clientLocation(StaticSiteARMResources.createUserRolesInvitationLink,
  StaticSites
);
@@clientName(StaticSiteARMResources.createUserRolesInvitationLink::parameters.body,
  "staticSiteUserRolesInvitationEnvelope"
);
@@clientLocation(StaticSiteARMResources.detachStaticSite, StaticSites);
@@clientLocation(StaticSiteARMResources.listStaticSiteFunctions, StaticSites);
@@clientLocation(StaticSiteARMResources.listStaticSiteAppSettings, StaticSites);
@@clientLocation(StaticSiteARMResources.listStaticSiteConfiguredRoles,
  StaticSites
);
@@clientLocation(StaticSiteARMResources.listStaticSiteFunctionAppSettings,
  StaticSites
);
@@clientLocation(StaticSiteARMResources.listStaticSiteSecrets, StaticSites);
@@clientLocation(StaticSiteARMResources.getPrivateLinkResources, StaticSites);
@@clientLocation(StaticSiteARMResources.resetStaticSiteApiKey, StaticSites);
@@clientName(StaticSiteARMResources.resetStaticSiteApiKey::parameters.body,
  "resetPropertiesEnvelope"
);
@@clientLocation(StaticSiteARMResources.getDatabaseConnectionsWithDetails,
  StaticSites
);
@@clientLocation(StaticSiteARMResources.createZipDeploymentForStaticSite,
  StaticSites
);
@@clientName(StaticSiteARMResources.createZipDeploymentForStaticSite::parameters.body,
  "staticSiteZipDeploymentEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteARMResource.properties);

@@clientLocation(StaticSiteBuildARMResources.getStaticSiteBuild, StaticSites);
@@clientLocation(StaticSiteBuildARMResources.deleteStaticSiteBuild,
  StaticSites
);
@@clientLocation(StaticSiteBuildARMResources.getStaticSiteBuilds, StaticSites);
@@clientLocation(StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildAppSettings,
  StaticSites
);
@@clientName(StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildAppSettings::parameters.body,
  "appSettings"
);
@@clientLocation(StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildFunctionAppSettings,
  StaticSites
);
@@clientName(StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildFunctionAppSettings::parameters.body,
  "appSettings"
);
@@clientLocation(StaticSiteBuildARMResources.listStaticSiteBuildFunctions,
  StaticSites
);
@@clientLocation(StaticSiteBuildARMResources.listStaticSiteBuildAppSettings,
  StaticSites
);
@@clientLocation(StaticSiteBuildARMResources.listStaticSiteBuildFunctionAppSettings,
  StaticSites
);
@@clientLocation(StaticSiteBuildARMResources.getBuildDatabaseConnectionsWithDetails,
  StaticSites
);
@@clientLocation(StaticSiteBuildARMResources.createZipDeploymentForStaticSiteBuild,
  StaticSites
);
@@clientName(StaticSiteBuildARMResources.createZipDeploymentForStaticSiteBuild::parameters.body,
  "staticSiteZipDeploymentEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteBuildARMResource.properties);

@@clientLocation(DatabaseConnections.getBuildDatabaseConnection, StaticSites);
@@clientLocation(DatabaseConnections.createOrUpdateBuildDatabaseConnection,
  StaticSites
);
@@clientName(DatabaseConnections.createOrUpdateBuildDatabaseConnection::parameters.resource,
  "databaseConnectionRequestEnvelope"
);
@@clientLocation(DatabaseConnections.updateBuildDatabaseConnection,
  StaticSites
);
@@clientName(DatabaseConnections.updateBuildDatabaseConnection::parameters.properties,
  "databaseConnectionRequestEnvelope"
);
@@clientLocation(DatabaseConnections.deleteBuildDatabaseConnection,
  StaticSites
);
@@clientLocation(DatabaseConnections.getBuildDatabaseConnections, StaticSites);
@@clientLocation(DatabaseConnections.getBuildDatabaseConnectionWithDetails,
  StaticSites
);
@@clientLocation(DatabaseConnectionOperationGroup.getDatabaseConnection,
  StaticSites
);
@@clientLocation(DatabaseConnectionOperationGroup.createOrUpdateDatabaseConnection,
  StaticSites
);
@@clientName(DatabaseConnectionOperationGroup.createOrUpdateDatabaseConnection::parameters.resource,
  "databaseConnectionRequestEnvelope"
);
@@clientLocation(DatabaseConnectionOperationGroup.updateDatabaseConnection,
  StaticSites
);
@@clientName(DatabaseConnectionOperationGroup.updateDatabaseConnection::parameters.properties,
  "databaseConnectionRequestEnvelope"
);
@@clientLocation(DatabaseConnectionOperationGroup.deleteDatabaseConnection,
  StaticSites
);
@@clientLocation(DatabaseConnectionOperationGroup.getDatabaseConnections,
  StaticSites
);
@@clientLocation(DatabaseConnectionOperationGroup.getDatabaseConnectionWithDetails,
  StaticSites
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DatabaseConnection.properties);

@@clientLocation(StaticSiteUserProvidedFunctionAppARMResources.getUserProvidedFunctionAppForStaticSiteBuild,
  StaticSites
);
@@clientLocation(StaticSiteUserProvidedFunctionAppARMResources.registerUserProvidedFunctionAppWithStaticSiteBuild,
  StaticSites
);
@@clientName(StaticSiteUserProvidedFunctionAppARMResources.registerUserProvidedFunctionAppWithStaticSiteBuild::parameters.resource,
  "staticSiteUserProvidedFunctionEnvelope"
);
@@clientLocation(StaticSiteUserProvidedFunctionAppARMResources.detachUserProvidedFunctionAppFromStaticSiteBuild,
  StaticSites
);
@@clientLocation(StaticSiteUserProvidedFunctionAppARMResources.getUserProvidedFunctionAppsForStaticSiteBuild,
  StaticSites
);
@@clientLocation(StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.getUserProvidedFunctionAppForStaticSite,
  StaticSites
);
@@clientLocation(StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.registerUserProvidedFunctionAppWithStaticSite,
  StaticSites
);
@@clientName(StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.registerUserProvidedFunctionAppWithStaticSite::parameters.resource,
  "staticSiteUserProvidedFunctionEnvelope"
);
@@clientLocation(StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.detachUserProvidedFunctionAppFromStaticSite,
  StaticSites
);
@@clientLocation(StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.getUserProvidedFunctionAppsForStaticSite,
  StaticSites
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteUserProvidedFunctionAppARMResource.properties);

@@clientLocation(StaticSiteBasicAuthPropertiesARMResources.getBasicAuth,
  StaticSites
);
@@clientLocation(StaticSiteBasicAuthPropertiesARMResources.createOrUpdateBasicAuth,
  StaticSites
);
@@clientName(StaticSiteBasicAuthPropertiesARMResources.createOrUpdateBasicAuth::parameters.resource,
  "basicAuthEnvelope"
);
@@clientLocation(StaticSiteBasicAuthPropertiesARMResources.listBasicAuth,
  StaticSites
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteBasicAuthPropertiesARMResource.properties);

@@clientLocation(StaticSiteCustomDomainOverviewARMResources.getStaticSiteCustomDomain,
  StaticSites
);
@@clientLocation(StaticSiteCustomDomainOverviewARMResources.createOrUpdateStaticSiteCustomDomain,
  StaticSites
);
@@clientName(StaticSiteCustomDomainOverviewARMResources.createOrUpdateStaticSiteCustomDomain::parameters.resource,
  "staticSiteCustomDomainRequestPropertiesEnvelope"
);
@@clientLocation(StaticSiteCustomDomainOverviewARMResources.deleteStaticSiteCustomDomain,
  StaticSites
);
@@clientLocation(StaticSiteCustomDomainOverviewARMResources.listStaticSiteCustomDomains,
  StaticSites
);
@@clientLocation(StaticSiteCustomDomainOverviewARMResources.validateCustomDomainCanBeAddedToStaticSite,
  StaticSites
);
@@clientName(StaticSiteCustomDomainOverviewARMResources.validateCustomDomainCanBeAddedToStaticSite::parameters.body,
  "staticSiteCustomDomainRequestPropertiesEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteCustomDomainOverviewARMResource.properties);

@@clientLocation(StaticSiteLinkedBackendARMResources.getLinkedBackend,
  StaticSites
);
@@clientLocation(StaticSiteLinkedBackendARMResources.linkBackend, StaticSites);
@@clientName(StaticSiteLinkedBackendARMResources.linkBackend::parameters.resource,
  "staticSiteLinkedBackendEnvelope"
);
@@clientLocation(StaticSiteLinkedBackendARMResources.unlinkBackend,
  StaticSites
);
@@clientLocation(StaticSiteLinkedBackendARMResources.getLinkedBackends,
  StaticSites
);
@@clientLocation(StaticSiteLinkedBackendARMResources.validateBackend,
  StaticSites
);
@@clientName(StaticSiteLinkedBackendARMResources.validateBackend::parameters.body,
  "staticSiteLinkedBackendEnvelope"
);
@@clientLocation(StaticSiteLinkedBackendARMResourceOperationGroup.getLinkedBackendForBuild,
  StaticSites
);
@@clientLocation(StaticSiteLinkedBackendARMResourceOperationGroup.linkBackendToBuild,
  StaticSites
);
@@clientName(StaticSiteLinkedBackendARMResourceOperationGroup.linkBackendToBuild::parameters.resource,
  "staticSiteLinkedBackendEnvelope"
);
@@clientLocation(StaticSiteLinkedBackendARMResourceOperationGroup.unlinkBackendFromBuild,
  StaticSites
);
@@clientLocation(StaticSiteLinkedBackendARMResourceOperationGroup.getLinkedBackendsForBuild,
  StaticSites
);
@@clientLocation(StaticSiteLinkedBackendARMResourceOperationGroup.validateBackendForBuild,
  StaticSites
);
@@clientName(StaticSiteLinkedBackendARMResourceOperationGroup.validateBackendForBuild::parameters.body,
  "staticSiteLinkedBackendEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteLinkedBackendARMResource.properties);

@@clientLocation(BackupItems.getBackupStatus, WebApps);
@@clientLocation(BackupItems.deleteBackup, WebApps);
@@clientLocation(BackupItems.listBackups, WebApps);
@@clientLocation(BackupItems.listBackupStatusSecrets, WebApps);
@@clientName(BackupItems.listBackupStatusSecrets::parameters.body, "request");
@@clientLocation(BackupItems.restore, WebApps);
@@clientName(BackupItems.restore::parameters.body, "request");
@@clientLocation(BackupItemOperationGroup.getBackupStatusSlot, WebApps);
@@clientLocation(BackupItemOperationGroup.deleteBackupSlot, WebApps);
@@clientLocation(BackupItemOperationGroup.listBackupsSlot, WebApps);
@@clientLocation(BackupItemOperationGroup.listBackupStatusSecretsSlot, WebApps);
@@clientName(BackupItemOperationGroup.listBackupStatusSecretsSlot::parameters.body,
  "request"
);
@@clientLocation(BackupItemOperationGroup.restoreSlot, WebApps);
@@clientName(BackupItemOperationGroup.restoreSlot::parameters.body, "request");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BackupItem.properties);

@@clientLocation(CsmPublishingCredentialsPoliciesEntities.getFtpAllowed,
  WebApps
);
@@clientLocation(CsmPublishingCredentialsPoliciesEntities.updateFtpAllowed,
  WebApps
);
@@clientName(CsmPublishingCredentialsPoliciesEntities.updateFtpAllowed::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);
@@clientLocation(CsmPublishingCredentialsPoliciesEntities.listBasicPublishingCredentialsPolicies,
  WebApps
);
@@clientLocation(CsmPublishingCredentialsPoliciesEntityOperationGroup.getScmAllowed,
  WebApps
);
@@clientLocation(CsmPublishingCredentialsPoliciesEntityOperationGroup.updateScmAllowed,
  WebApps
);
@@clientName(CsmPublishingCredentialsPoliciesEntityOperationGroup.updateScmAllowed::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);
@@clientLocation(CsmPublishingCredentialsPoliciesEntityFtpAllowedSlot.getFtpAllowedSlot,
  WebApps
);
@@clientLocation(CsmPublishingCredentialsPoliciesEntityFtpAllowedSlot.updateFtpAllowedSlot,
  WebApps
);
@@clientName(CsmPublishingCredentialsPoliciesEntityFtpAllowedSlot.updateFtpAllowedSlot::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);
@@clientLocation(CsmPublishingCredentialsPoliciesEntityFtpAllowedSlot.listBasicPublishingCredentialsPoliciesSlot,
  WebApps
);
@@clientLocation(CsmPublishingCredentialsPoliciesEntityScmAllowedSlot.getScmAllowedSlot,
  WebApps
);
@@clientLocation(CsmPublishingCredentialsPoliciesEntityScmAllowedSlot.updateScmAllowedSlot,
  WebApps
);
@@clientName(CsmPublishingCredentialsPoliciesEntityScmAllowedSlot.updateScmAllowedSlot::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CsmPublishingCredentialsPoliciesEntity.properties);

@@clientLocation(SiteConfigResources.getConfiguration, WebApps);
@@clientLocation(SiteConfigResources.createOrUpdateConfiguration, WebApps);
@@clientName(SiteConfigResources.createOrUpdateConfiguration::parameters.resource,
  "siteConfig"
);
@@clientLocation(SiteConfigResources.updateConfiguration, WebApps);
@@clientName(SiteConfigResources.updateConfiguration::parameters.properties,
  "siteConfig"
);
@@clientLocation(SiteConfigResources.listConfigurationSnapshotInfo, WebApps);
@@clientLocation(SiteConfigResourceOperationGroup.getConfigurationSnapshot,
  WebApps
);
@@clientLocation(SiteConfigResourceOperationGroup.listConfigurations, WebApps);
@@clientLocation(SiteConfigResourceOperationGroup.recoverSiteConfigurationSnapshot,
  WebApps
);
@@clientLocation(SiteConfigSlotResourceOperationGroup.getConfigurationSlot,
  WebApps
);
@@clientLocation(SiteConfigSlotResourceOperationGroup.createOrUpdateConfigurationSlot,
  WebApps
);
@@clientName(SiteConfigSlotResourceOperationGroup.createOrUpdateConfigurationSlot::parameters.resource,
  "siteConfig"
);
@@clientLocation(SiteConfigSlotResourceOperationGroup.updateConfigurationSlot,
  WebApps
);
@@clientName(SiteConfigSlotResourceOperationGroup.updateConfigurationSlot::parameters.properties,
  "siteConfig"
);
@@clientLocation(SiteConfigSlotResourceOperationGroup.listConfigurationSnapshotInfoSlot,
  WebApps
);
@@clientLocation(SiteConfigSnapshotSlotResourceOperationGroup.getConfigurationSnapshotSlot,
  WebApps
);
@@clientLocation(SiteConfigSnapshotSlotResourceOperationGroup.listConfigurationsSlot,
  WebApps
);
@@clientLocation(SiteConfigSnapshotSlotResourceOperationGroup.recoverSiteConfigurationSnapshotSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteConfigResource.properties);

@@clientLocation(SiteAuthSettingsV2s.getAuthSettingsV2WithoutSecrets, WebApps);
@@clientLocation(SiteAuthSettingsV2s.updateAuthSettingsV2, WebApps);
@@clientName(SiteAuthSettingsV2s.updateAuthSettingsV2::parameters.resource,
  "siteAuthSettingsV2"
);
@@clientLocation(SiteAuthSettingsV2s.getAuthSettingsV2, WebApps);
@@clientLocation(SiteAuthSettingsV2OperationGroup.getAuthSettingsV2WithoutSecretsSlot,
  WebApps
);
@@clientLocation(SiteAuthSettingsV2OperationGroup.updateAuthSettingsV2Slot,
  WebApps
);
@@clientName(SiteAuthSettingsV2OperationGroup.updateAuthSettingsV2Slot::parameters.resource,
  "siteAuthSettingsV2"
);
@@clientLocation(SiteAuthSettingsV2OperationGroup.getAuthSettingsV2Slot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteAuthSettingsV2.properties);

@@clientLocation(AppSettingKeyVaultReference.getAppSettingKeyVaultReference,
  WebApps
);
@@clientLocation(AppSettingKeyVaultReference.getAppSettingsKeyVaultReferences,
  WebApps
);
@@clientLocation(SiteConnectionStringKeyVaultReference.getSiteConnectionStringKeyVaultReference,
  WebApps
);
@@clientLocation(SiteConnectionStringKeyVaultReference.getSiteConnectionStringKeyVaultReferences,
  WebApps
);
@@clientLocation(AppSettingKeyVaultReferenceSlot.getAppSettingKeyVaultReferenceSlot,
  WebApps
);
@@clientLocation(AppSettingKeyVaultReferenceSlot.getAppSettingsKeyVaultReferencesSlot,
  WebApps
);
@@clientLocation(SiteConnectionStringKeyVaultReferenceSlot.getSiteConnectionStringKeyVaultReferenceSlot,
  WebApps
);
@@clientLocation(SiteConnectionStringKeyVaultReferenceSlot.getSiteConnectionStringKeyVaultReferencesSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ApiKVReference.properties);

@@clientLocation(SiteLogsConfigs.getDiagnosticLogsConfiguration, WebApps);
@@clientLocation(SiteLogsConfigs.updateDiagnosticLogsConfig, WebApps);
@@clientName(SiteLogsConfigs.updateDiagnosticLogsConfig::parameters.resource,
  "siteLogsConfig"
);
@@clientLocation(SiteLogsConfigOperationGroup.getDiagnosticLogsConfigurationSlot,
  WebApps
);
@@clientLocation(SiteLogsConfigOperationGroup.updateDiagnosticLogsConfigSlot,
  WebApps
);
@@clientName(SiteLogsConfigOperationGroup.updateDiagnosticLogsConfigSlot::parameters.resource,
  "siteLogsConfig"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteLogsConfig.properties);

@@clientLocation(SlotConfigNamesResources.listSlotConfigurationNames, WebApps);
@@clientLocation(SlotConfigNamesResources.updateSlotConfigurationNames,
  WebApps
);
@@clientName(SlotConfigNamesResources.updateSlotConfigurationNames::parameters.resource,
  "slotConfigNames"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SlotConfigNamesResource.properties);

@@clientLocation(ContinuousWebJobs.getContinuousWebJob, WebApps);
@@clientLocation(ContinuousWebJobs.deleteContinuousWebJob, WebApps);
@@clientLocation(ContinuousWebJobs.listContinuousWebJobs, WebApps);
@@clientLocation(ContinuousWebJobs.startContinuousWebJob, WebApps);
@@clientLocation(ContinuousWebJobs.stopContinuousWebJob, WebApps);
@@clientLocation(ContinuousWebJobOperationGroup.getContinuousWebJobSlot,
  WebApps
);
@@clientLocation(ContinuousWebJobOperationGroup.deleteContinuousWebJobSlot,
  WebApps
);
@@clientLocation(ContinuousWebJobOperationGroup.listContinuousWebJobsSlot,
  WebApps
);
@@clientLocation(ContinuousWebJobOperationGroup.startContinuousWebJobSlot,
  WebApps
);
@@clientLocation(ContinuousWebJobOperationGroup.stopContinuousWebJobSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ContinuousWebJob.properties);

@@clientLocation(CsmDeploymentStatuses.getProductionSiteDeploymentStatus,
  WebApps
);
@@clientLocation(CsmDeploymentStatuses.listProductionSiteDeploymentStatuses,
  WebApps
);
@@clientLocation(CsmDeploymentStatusOperationGroup.getSlotSiteDeploymentStatusSlot,
  WebApps
);
@@clientLocation(CsmDeploymentStatusOperationGroup.listSlotSiteDeploymentStatusesSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CsmDeploymentStatus.properties);

@@clientLocation(Deployments.getDeployment, WebApps);
@@clientLocation(Deployments.createDeployment, WebApps);
@@clientName(Deployments.createDeployment::parameters.resource, "deployment");
@@clientLocation(Deployments.deleteDeployment, WebApps);
@@clientLocation(Deployments.listDeployments, WebApps);
@@clientLocation(Deployments.listDeploymentLog, WebApps);
@@clientLocation(DeploymentOperationGroup.getDeploymentSlot, WebApps);
@@clientLocation(DeploymentOperationGroup.createDeploymentSlot, WebApps);
@@clientName(DeploymentOperationGroup.createDeploymentSlot::parameters.resource,
  "deployment"
);
@@clientLocation(DeploymentOperationGroup.deleteDeploymentSlot, WebApps);
@@clientLocation(DeploymentOperationGroup.listDeploymentsSlot, WebApps);
@@clientLocation(DeploymentOperationGroup.listDeploymentLogSlot, WebApps);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Deployment.properties);

@@clientLocation(MSDeployStatuses.getMSDeployStatus, WebApps);
@@clientLocation(MSDeployStatuses.createMSDeployOperation, WebApps);
@@clientName(MSDeployStatuses.createMSDeployOperation::parameters.resource,
  "MSDeploy"
);
@@clientLocation(MSDeployStatuses.getMSDeployLog, WebApps);
@@clientLocation(MSDeployStatusOperationGroup.getInstanceMsDeployStatus,
  WebApps
);
@@clientLocation(MSDeployStatusOperationGroup.createInstanceMSDeployOperation,
  WebApps
);
@@clientName(MSDeployStatusOperationGroup.createInstanceMSDeployOperation::parameters.resource,
  "MSDeploy"
);
@@clientLocation(MSDeployStatusOperationGroup.getInstanceMSDeployLog, WebApps);
@@clientLocation(MSDeployStatusSlotOperationGroup.getMSDeployStatusSlot,
  WebApps
);
@@clientLocation(MSDeployStatusSlotOperationGroup.createMSDeployOperationSlot,
  WebApps
);
@@clientName(MSDeployStatusSlotOperationGroup.createMSDeployOperationSlot::parameters.resource,
  "MSDeploy"
);
@@clientLocation(MSDeployStatusSlotOperationGroup.getMSDeployLogSlot, WebApps);
@@clientLocation(InstanceMSDeployStatusOperationGroup.getInstanceMsDeployStatusSlot,
  WebApps
);
@@clientLocation(InstanceMSDeployStatusOperationGroup.createInstanceMSDeployOperationSlot,
  WebApps
);
@@clientName(InstanceMSDeployStatusOperationGroup.createInstanceMSDeployOperationSlot::parameters.resource,
  "MSDeploy"
);
@@clientLocation(InstanceMSDeployStatusOperationGroup.getInstanceMSDeployLogSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MSDeployStatus.properties);

@@clientLocation(FunctionEnvelopes.getFunction, WebApps);
@@clientLocation(FunctionEnvelopes.createFunction, WebApps);
@@clientName(FunctionEnvelopes.createFunction::parameters.resource,
  "function_envelope"
);
@@clientLocation(FunctionEnvelopes.deleteFunction, WebApps);
@@clientLocation(FunctionEnvelopes.listFunctions, WebApps);
@@clientLocation(FunctionEnvelopes.createOrUpdateFunctionSecret, WebApps);
@@clientLocation(FunctionEnvelopes.deleteFunctionSecret, WebApps);
@@clientLocation(FunctionEnvelopes.listFunctionKeys, WebApps);
@@clientLocation(FunctionEnvelopes.listFunctionSecrets, WebApps);
@@clientLocation(FunctionEnvelopeOperationGroup.getInstanceFunctionSlot,
  WebApps
);
@@clientLocation(FunctionEnvelopeOperationGroup.createInstanceFunctionSlot,
  WebApps
);
@@clientName(FunctionEnvelopeOperationGroup.createInstanceFunctionSlot::parameters.resource,
  "function_envelope"
);
@@clientLocation(FunctionEnvelopeOperationGroup.deleteInstanceFunctionSlot,
  WebApps
);
@@clientLocation(FunctionEnvelopeOperationGroup.listInstanceFunctionsSlot,
  WebApps
);
@@clientLocation(FunctionEnvelopeOperationGroup.createOrUpdateFunctionSecretSlot,
  WebApps
);

@@clientLocation(FunctionEnvelopeOperationGroup.deleteFunctionSecretSlot,
  WebApps
);
@@clientLocation(FunctionEnvelopeOperationGroup.listFunctionKeysSlot, WebApps);
@@clientLocation(FunctionEnvelopeOperationGroup.listFunctionSecretsSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FunctionEnvelope.properties);

@@clientLocation(HostNameBindings.getHostNameBinding, WebApps);
@@clientLocation(HostNameBindings.createOrUpdateHostNameBinding, WebApps);
@@clientName(HostNameBindings.createOrUpdateHostNameBinding::parameters.resource,
  "hostNameBinding"
);
@@clientLocation(HostNameBindings.deleteHostNameBinding, WebApps);
@@clientLocation(HostNameBindings.listHostNameBindings, WebApps);
@@clientLocation(HostNameBindingOperationGroup.getHostNameBindingSlot, WebApps);
@@clientLocation(HostNameBindingOperationGroup.createOrUpdateHostNameBindingSlot,
  WebApps
);
@@clientName(HostNameBindingOperationGroup.createOrUpdateHostNameBindingSlot::parameters.resource,
  "hostNameBinding"
);
@@clientLocation(HostNameBindingOperationGroup.deleteHostNameBindingSlot,
  WebApps
);
@@clientLocation(HostNameBindingOperationGroup.listHostNameBindingsSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(HostNameBinding.properties);

@@clientLocation(RelayServiceConnectionEntities.getRelayServiceConnection,
  WebApps
);
@@clientLocation(RelayServiceConnectionEntities.createOrUpdateRelayServiceConnection,
  WebApps
);
@@clientName(RelayServiceConnectionEntities.createOrUpdateRelayServiceConnection::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(RelayServiceConnectionEntities.updateRelayServiceConnection,
  WebApps
);
@@clientName(RelayServiceConnectionEntities.updateRelayServiceConnection::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(RelayServiceConnectionEntities.deleteRelayServiceConnection,
  WebApps
);
@@clientLocation(RelayServiceConnectionEntityOperationGroup.getRelayServiceConnectionSlot,
  WebApps
);
@@clientLocation(RelayServiceConnectionEntityOperationGroup.createOrUpdateRelayServiceConnectionSlot,
  WebApps
);
@@clientName(RelayServiceConnectionEntityOperationGroup.createOrUpdateRelayServiceConnectionSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(RelayServiceConnectionEntityOperationGroup.updateRelayServiceConnectionSlot,
  WebApps
);
@@clientName(RelayServiceConnectionEntityOperationGroup.updateRelayServiceConnectionSlot::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(RelayServiceConnectionEntityOperationGroup.deleteRelayServiceConnectionSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RelayServiceConnectionEntity.properties);

@@clientLocation(WebSiteInstanceStatuses.getInstanceInfo, WebApps);
@@clientLocation(WebSiteInstanceStatuses.listInstanceIdentifiers, WebApps);
@@clientLocation(WebSiteInstanceStatusOperationGroup.getInstanceInfoSlot,
  WebApps
);
@@clientLocation(WebSiteInstanceStatusOperationGroup.listInstanceIdentifiersSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WebSiteInstanceStatus.properties);

@@clientLocation(ProcessInfos.getInstanceProcess, WebApps);
@@clientLocation(ProcessInfos.deleteInstanceProcess, WebApps);
@@clientLocation(ProcessInfos.listInstanceProcesses, WebApps);
@@clientLocation(ProcessInfos.getInstanceProcessDump, WebApps);
@@clientLocation(ProcessInfos.listInstanceProcessThreads, WebApps);
@@clientLocation(ProcessInfoOperationGroup.getProcess, WebApps);
@@clientLocation(ProcessInfoOperationGroup.deleteProcess, WebApps);
@@clientLocation(ProcessInfoOperationGroup.listProcesses, WebApps);
@@clientLocation(ProcessInfoOperationGroup.getProcessDump, WebApps);
@@clientLocation(ProcessInfoOperationGroup.listProcessThreads, WebApps);
@@clientLocation(InstanceProcessSlotOperationGroup.getInstanceProcessSlot,
  WebApps
);
@@clientLocation(InstanceProcessSlotOperationGroup.deleteInstanceProcessSlot,
  WebApps
);
@@clientLocation(InstanceProcessSlotOperationGroup.listInstanceProcessesSlot,
  WebApps
);
@@clientLocation(InstanceProcessSlotOperationGroup.getInstanceProcessDumpSlot,
  WebApps
);
@@clientLocation(InstanceProcessSlotOperationGroup.listInstanceProcessThreadsSlot,
  WebApps
);
@@clientLocation(ProcessSlotOperationGroup.getProcessSlot, WebApps);
@@clientLocation(ProcessSlotOperationGroup.deleteProcessSlot, WebApps);
@@clientLocation(ProcessSlotOperationGroup.listProcessesSlot, WebApps);
@@clientLocation(ProcessSlotOperationGroup.getProcessDumpSlot, WebApps);
@@clientLocation(ProcessSlotOperationGroup.listProcessThreadsSlot, WebApps);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProcessInfo.properties);

@@clientLocation(ProcessModuleInfos.getInstanceProcessModule, WebApps);
@@clientLocation(ProcessModuleInfos.listInstanceProcessModules, WebApps);
@@clientLocation(ProcessModuleInfoOperationGroup.getProcessModule, WebApps);
@@clientLocation(ProcessModuleInfoOperationGroup.listProcessModules, WebApps);
@@clientLocation(InstanceProcessModuleSlotOperationGroup.getInstanceProcessModuleSlot,
  WebApps
);
@@clientLocation(InstanceProcessModuleSlotOperationGroup.listInstanceProcessModulesSlot,
  WebApps
);
@@clientLocation(ProcessModuleSlotOperationGroup.getProcessModuleSlot, WebApps);
@@clientLocation(ProcessModuleSlotOperationGroup.listProcessModulesSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProcessModuleInfo.properties);

@@clientLocation(MigrateMySqlStatuses.getMigrateMySqlStatus, WebApps);
@@clientLocation(MigrateMySqlStatusOperationGroup.getMigrateMySqlStatusSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MigrateMySqlStatus.properties);

@@clientLocation(SwiftVirtualNetworks.getSwiftVirtualNetworkConnection,
  WebApps
);
@@clientLocation(SwiftVirtualNetworks.createOrUpdateSwiftVirtualNetworkConnectionWithCheck,
  WebApps
);
@@clientName(SwiftVirtualNetworks.createOrUpdateSwiftVirtualNetworkConnectionWithCheck::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(SwiftVirtualNetworks.updateSwiftVirtualNetworkConnectionWithCheck,
  WebApps
);
@@clientName(SwiftVirtualNetworks.updateSwiftVirtualNetworkConnectionWithCheck::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(SwiftVirtualNetworks.deleteSwiftVirtualNetwork, WebApps);
@@clientLocation(SwiftVirtualNetworkOperationGroup.getSwiftVirtualNetworkConnectionSlot,
  WebApps
);
@@clientLocation(SwiftVirtualNetworkOperationGroup.createOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot,
  WebApps
);
@@clientName(SwiftVirtualNetworkOperationGroup.createOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(SwiftVirtualNetworkOperationGroup.updateSwiftVirtualNetworkConnectionWithCheckSlot,
  WebApps
);
@@clientName(SwiftVirtualNetworkOperationGroup.updateSwiftVirtualNetworkConnectionWithCheckSlot::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(SwiftVirtualNetworkOperationGroup.deleteSwiftVirtualNetworkSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SwiftVirtualNetwork.properties);

@@clientLocation(NetworkFeaturesOperationGroup.listNetworkFeatures, WebApps);
@@clientLocation(NetworkFeaturesSlotOperationGroup.listNetworkFeaturesSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NetworkFeatures.properties);

@@clientLocation(PremierAddOns.getPremierAddOn, WebApps);
@@clientLocation(PremierAddOns.addPremierAddOn, WebApps);
@@clientName(PremierAddOns.addPremierAddOn::parameters.resource,
  "premierAddOn"
);
@@clientLocation(PremierAddOns.updatePremierAddOn, WebApps);
@@clientName(PremierAddOns.updatePremierAddOn::parameters.properties,
  "premierAddOn"
);
@@clientLocation(PremierAddOns.deletePremierAddOn, WebApps);
@@clientLocation(PremierAddOnOperationGroup.getPremierAddOnSlot, WebApps);
@@clientLocation(PremierAddOnOperationGroup.addPremierAddOnSlot, WebApps);
@@clientName(PremierAddOnOperationGroup.addPremierAddOnSlot::parameters.resource,
  "premierAddOn"
);
@@clientLocation(PremierAddOnOperationGroup.updatePremierAddOnSlot, WebApps);
@@clientName(PremierAddOnOperationGroup.updatePremierAddOnSlot::parameters.properties,
  "premierAddOn"
);
@@clientLocation(PremierAddOnOperationGroup.deletePremierAddOnSlot, WebApps);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PremierAddOn.properties);

@@clientLocation(PrivateAccesses.getPrivateAccess, WebApps);
@@clientLocation(PrivateAccesses.putPrivateAccessVnet, WebApps);
@@clientName(PrivateAccesses.putPrivateAccessVnet::parameters.resource,
  "access"
);
@@clientLocation(PrivateAccessOperationGroup.getPrivateAccessSlot, WebApps);
@@clientLocation(PrivateAccessOperationGroup.putPrivateAccessVnetSlot, WebApps);
@@clientName(PrivateAccessOperationGroup.putPrivateAccessVnetSlot::parameters.resource,
  "access"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateAccess.properties);

@@clientLocation(PublicCertificates.getPublicCertificate, WebApps);
@@clientLocation(PublicCertificates.createOrUpdatePublicCertificate, WebApps);
@@clientName(PublicCertificates.createOrUpdatePublicCertificate::parameters.resource,
  "publicCertificate"
);
@@clientLocation(PublicCertificates.deletePublicCertificate, WebApps);
@@clientLocation(PublicCertificates.listPublicCertificates, WebApps);
@@clientLocation(PublicCertificateOperationGroup.getPublicCertificateSlot,
  WebApps
);
@@clientLocation(PublicCertificateOperationGroup.createOrUpdatePublicCertificateSlot,
  WebApps
);
@@clientName(PublicCertificateOperationGroup.createOrUpdatePublicCertificateSlot::parameters.resource,
  "publicCertificate"
);
@@clientLocation(PublicCertificateOperationGroup.deletePublicCertificateSlot,
  WebApps
);
@@clientLocation(PublicCertificateOperationGroup.listPublicCertificatesSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PublicCertificate.properties);

@@clientLocation(SiteContainers.getSiteContainer, WebApps);
@@clientLocation(SiteContainers.createOrUpdateSiteContainer, WebApps);
@@clientName(SiteContainers.createOrUpdateSiteContainer::parameters.resource,
  "request"
);
@@clientLocation(SiteContainers.deleteSiteContainer, WebApps);
@@clientLocation(SiteContainers.listSiteContainers, WebApps);
@@clientLocation(SiteContainerOperationGroup.getSiteContainerSlot, WebApps);
@@clientLocation(SiteContainerOperationGroup.createOrUpdateSiteContainerSlot,
  WebApps
);
@@clientName(SiteContainerOperationGroup.createOrUpdateSiteContainerSlot::parameters.resource,
  "request"
);
@@clientLocation(SiteContainerOperationGroup.deleteSiteContainerSlot, WebApps);
@@clientLocation(SiteContainerOperationGroup.listSiteContainersSlot, WebApps);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteContainer.properties);

@@clientLocation(SiteExtensionInfos.getSiteExtension, WebApps);
@@clientLocation(SiteExtensionInfos.installSiteExtension, WebApps);
@@clientLocation(SiteExtensionInfos.deleteSiteExtension, WebApps);
@@clientLocation(SiteExtensionInfos.listSiteExtensions, WebApps);
@@clientLocation(SiteExtensionInfoOperationGroup.getSiteExtensionSlot, WebApps);
@@clientLocation(SiteExtensionInfoOperationGroup.installSiteExtensionSlot,
  WebApps
);
@@clientLocation(SiteExtensionInfoOperationGroup.deleteSiteExtensionSlot,
  WebApps
);
@@clientLocation(SiteExtensionInfoOperationGroup.listSiteExtensionsSlot,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteExtensionInfo.properties);

@@clientLocation(SiteSourceControls.getSourceControlSlot, WebApps);
@@clientLocation(SiteSourceControls.createOrUpdateSourceControlSlot, WebApps);
@@clientName(SiteSourceControls.createOrUpdateSourceControlSlot::parameters.resource,
  "siteSourceControl"
);
@@clientLocation(SiteSourceControls.updateSourceControlSlot, WebApps);
@@clientName(SiteSourceControls.updateSourceControlSlot::parameters.properties,
  "siteSourceControl"
);
@@clientLocation(SiteSourceControls.deleteSourceControlSlot, WebApps);
@@clientLocation(SiteSourceControlOperationGroup.getSourceControl, WebApps);
@@clientLocation(SiteSourceControlOperationGroup.createOrUpdateSourceControl,
  WebApps
);
@@clientName(SiteSourceControlOperationGroup.createOrUpdateSourceControl::parameters.resource,
  "siteSourceControl"
);
@@clientLocation(SiteSourceControlOperationGroup.updateSourceControl, WebApps);
@@clientName(SiteSourceControlOperationGroup.updateSourceControl::parameters.properties,
  "siteSourceControl"
);
@@clientLocation(SiteSourceControlOperationGroup.deleteSourceControl, WebApps);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteSourceControl.properties);

@@clientLocation(TriggeredWebJobs.getTriggeredWebJobSlot, WebApps);
@@clientLocation(TriggeredWebJobs.deleteTriggeredWebJobSlot, WebApps);
@@clientLocation(TriggeredWebJobs.listTriggeredWebJobsSlot, WebApps);
@@clientLocation(TriggeredWebJobs.runTriggeredWebJobSlot, WebApps);
@@clientLocation(TriggeredWebJobOperationGroup.getTriggeredWebJob, WebApps);
@@clientLocation(TriggeredWebJobOperationGroup.deleteTriggeredWebJob, WebApps);
@@clientLocation(TriggeredWebJobOperationGroup.listTriggeredWebJobs, WebApps);
@@clientLocation(TriggeredWebJobOperationGroup.runTriggeredWebJob, WebApps);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(TriggeredWebJob.properties);

@@clientLocation(TriggeredJobHistories.getTriggeredWebJobHistorySlot, WebApps);
@@clientLocation(TriggeredJobHistories.listTriggeredWebJobHistorySlot, WebApps);
@@clientLocation(TriggeredJobHistoryOperationGroup.getTriggeredWebJobHistory,
  WebApps
);
@@clientLocation(TriggeredJobHistoryOperationGroup.listTriggeredWebJobHistory,
  WebApps
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(TriggeredJobHistory.properties);

@@clientLocation(WebJobs.getWebJobSlot, WebApps);
@@clientLocation(WebJobs.listWebJobsSlot, WebApps);
@@clientLocation(WebJobOperationGroup.getWebJob, WebApps);
@@clientLocation(WebJobOperationGroup.listWebJobs, WebApps);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WebJob.properties);

@@clientLocation(WorkflowEnvelopes.getInstanceWorkflowSlot, WebApps);
@@clientLocation(WorkflowEnvelopes.listInstanceWorkflowsSlot, WebApps);
@@clientLocation(WorkflowEnvelopeOperationGroup.getWorkflow, WebApps);
@@clientLocation(WorkflowEnvelopeOperationGroup.listWorkflows, WebApps);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowRun.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowRunAction.properties);

@@clientLocation(WorkflowRunActionRepetitionDefinitions.get,
  "WorkflowRunActionRepetitions"
);
@@clientLocation(WorkflowRunActionRepetitionDefinitions.list,
  "WorkflowRunActionRepetitions"
);
@@clientLocation(WorkflowRunActionRepetitionDefinitions.listExpressionTraces,
  "WorkflowRunActionRepetitions"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowRunActionRepetitionDefinition.properties);

@@clientLocation(RequestHistories.get,
  "WorkflowRunActionRepetitionsRequestHistories"
);
@@clientLocation(RequestHistories.list,
  "WorkflowRunActionRepetitionsRequestHistories"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowTrigger.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowTriggerHistory.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowVersion.properties);

@@clientLocation(GlobalOperationGroup.getSubscriptionOperationWithAsyncResponse,
  Global
);

@@clientLocation(ProviderOperationGroup.getAvailableStacks, "Provider");
@@clientLocation(ProviderOperationGroup.getFunctionAppStacks, "Provider");
@@clientLocation(ProviderOperationGroup.getFunctionAppStacksForLocation,
  "Provider"
);
@@clientLocation(ProviderOperationGroup.getWebAppStacksForLocation, "Provider");
@@clientLocation(ProviderOperationGroup.getWebAppStacks, "Provider");
@@clientLocation(ProviderOperationGroup.getAvailableStacksOnPrem, "Provider");

@@clientLocation(RecommendationsOperationGroup.list, Recommendations);
@@clientLocation(RecommendationsOperationGroup.resetAllFilters,
  Recommendations
);
@@clientLocation(RecommendationsOperationGroup.disableRecommendationForSubscription,
  Recommendations
);

@@clientLocation(ResourceHealthMetadataNonResourceOperationGroup.list,
  "ResourceHealthMetadata"
);
@@clientLocation(ResourceHealthMetadataNonResourceOperationGroup.listByResourceGroup,
  "ResourceHealthMetadata"
);

@@clientLocation(GetUsagesInLocationOperationGroup.list, "GetUsagesInLocation");
@@clientName(GetUsagesInLocationOperationGroup.list, "list");

@@clientLocation(StaticSitesOperationGroup.previewWorkflow, StaticSites);

@@clientLocation(Operations.list, "Provider");
@@clientName(Operations.list, "ListOperations");
@@clientName(checkNameAvailability::parameters.body, "request");
@@clientName(listSiteIdentifiersAssignedToHostName::parameters.body,
  "nameIdentifier"
);
@@clientName(regionalCheckNameAvailability::parameters.body, "request");
@@clientName(verifyHostingEnvironmentVnet::parameters.body, "parameters");
@@clientName(StaticSitesOperationGroup.previewWorkflow::parameters.body,
  "staticSitesWorkflowPreviewRequest"
);
@@clientName(FunctionEnvelopeOperationGroup.createOrUpdateFunctionSecretSlot::parameters.resource,
  "key"
);
@@summary(Operations.list,
  "Gets all available operations for the Microsoft.Web resource provider. Also exposes resource metric definitions"
);
@@doc(Operations.list,
  "Description for Gets all available operations for the Microsoft.Web resource provider. Also exposes resource metric definitions"
);
@@clientName(FunctionEnvelopes.createOrUpdateFunctionSecret::parameters.body,
  "key"
);
@@clientName(StaticSiteARMResources.updateStaticSiteUser::parameters.body,
  "staticSiteUserEnvelope"
);

@@clientLocation(checkNameAvailability, "WebSiteManagement", "go");
@@clientLocation(Users.getPublishingUser, "WebSiteManagement", "go");
@@clientLocation(SourceControls.getSourceControl, "WebSiteManagement", "go");
@@clientLocation(getSubscriptionDeploymentLocations, "WebSiteManagement", "go");
@@clientLocation(listAseRegions, "WebSiteManagement", "go");
@@clientLocation(listBillingMeters, "WebSiteManagement", "go");
@@clientLocation(listCustomHostNameSites, "WebSiteManagement", "go");
@@clientLocation(listGeoRegions, "WebSiteManagement", "go");
@@clientLocation(listPremierAddOnOffers, "WebSiteManagement", "go");
@@clientLocation(listSkus, "WebSiteManagement", "go");
@@clientLocation(listSiteIdentifiersAssignedToHostName,
  "WebSiteManagement",
  "go"
);
@@clientLocation(SourceControls.listSourceControls, "WebSiteManagement", "go");
@@clientLocation(move, "WebSiteManagement", "go");
@@clientLocation(regionalCheckNameAvailability, "WebSiteManagement", "go");
@@clientLocation(Users.updatePublishingUser, "WebSiteManagement", "go");
@@clientLocation(SourceControls.updateSourceControl, "WebSiteManagement", "go");
@@clientLocation(validate, "WebSiteManagement", "go");
@@clientLocation(validateMove, "WebSiteManagement", "go");
@@clientLocation(verifyHostingEnvironmentVnet, "WebSiteManagement", "go");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(checkNameAvailability::parameters.body);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(regionalCheckNameAvailability::parameters.body);

@@clientLocation(Users.getPublishingUser, Microsoft.Web, "python");
@@clientLocation(Users.updatePublishingUser, Microsoft.Web, "python");
@@clientLocation(SourceControls.getSourceControl, Microsoft.Web, "python");
@@clientLocation(SourceControls.listSourceControls, Microsoft.Web, "python");
@@clientLocation(SourceControls.updateSourceControl, Microsoft.Web, "python");
