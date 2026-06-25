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
@@flattenProperty(
  StaticSiteCustomDomainRequestPropertiesARMResource.properties
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
@@clientName(
  FunctionEnvelopeProperties.script_root_path_href,
  "scriptRootPathHref"
);
@@clientName(FunctionEnvelopeProperties.script_href, "scriptHref");
@@clientName(FunctionEnvelopeProperties.config_href, "configHref");
@@clientName(FunctionEnvelopeProperties.test_data_href, "testDataHref");
@@clientName(FunctionEnvelopeProperties.secrets_file_href, "secretsFileHref");
@@clientName(FunctionEnvelopeProperties.test_data, "testData");
@@clientName(
  FunctionEnvelopeProperties.invoke_url_template,
  "invokeUrlTemplate"
);

@@clientName(FunctionSecrets.trigger_url, "triggerUrl");

@@clientName(ProcessInfoProperties.deployment_name, "deploymentName");
@@clientName(ProcessInfoProperties.is_profile_running, "isProfileRunning");
@@clientName(
  ProcessInfoProperties.is_iis_profile_running,
  "isIisProfileRunning"
);
@@clientName(
  ProcessInfoProperties.iis_profile_timeout_in_seconds,
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
@@clientName(
  ProcessInfoProperties.non_paged_system_memory,
  "nonPagedSystemMemory"
);
@@clientName(ProcessInfoProperties.paged_memory, "pagedMemory");
@@clientName(ProcessInfoProperties.peak_paged_memory, "peakPagedMemory");
@@clientName(ProcessInfoProperties.time_stamp, "timeStamp");
@@clientName(
  ProcessInfoProperties.environment_variables,
  "environmentVariables"
);
@@clientName(ProcessInfoProperties.is_scm_site, "isScmSite");
@@clientName(ProcessInfoProperties.is_webjob, "isWebjob");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProcessThreadInfo.properties, "!csharp");

@@clientName(ProcessThreadInfoProperties.start_address, "startAddress");
@@clientName(ProcessThreadInfoProperties.current_priority, "currentPriority");
@@clientName(ProcessThreadInfoProperties.priority_level, "priorityLevel");
@@clientName(ProcessThreadInfoProperties.base_priority, "basePriority");
@@clientName(ProcessThreadInfoProperties.start_time, "startTime");
@@clientName(
  ProcessThreadInfoProperties.total_processor_time,
  "totalProcessorTime"
);
@@clientName(
  ProcessThreadInfoProperties.user_processor_time,
  "userProcessorTime"
);
@@clientName(ProcessThreadInfoProperties.wait_reason, "waitReason");

@@clientName(ProcessModuleInfoProperties.base_address, "baseAddress");
@@clientName(ProcessModuleInfoProperties.file_name, "fileName");
@@clientName(ProcessModuleInfoProperties.file_path, "filePath");
@@clientName(
  ProcessModuleInfoProperties.module_memory_size,
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
@@clientName(
  SiteExtensionInfoProperties.installer_command_line_params,
  "installerCommandLineParams"
);
@@clientName(
  SiteExtensionInfoProperties.published_date_time,
  "publishedDateTime"
);
@@clientName(SiteExtensionInfoProperties.download_count, "downloadCount");
@@clientName(
  SiteExtensionInfoProperties.local_is_latest_version,
  "localIsLatestVersion"
);
@@clientName(SiteExtensionInfoProperties.local_path, "localPath");
@@clientName(
  SiteExtensionInfoProperties.installed_date_time,
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

@@clientLocation(
  AppServiceEnvironmentResources.get,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.createOrUpdate,
  AppServiceEnvironments,
  "!csharp"
);
@@clientName(
  AppServiceEnvironmentResources.createOrUpdate::parameters.resource,
  "hostingEnvironmentEnvelope"
);
@@clientLocation(
  AppServiceEnvironmentResources.update,
  AppServiceEnvironments,
  "!csharp"
);
@@clientName(
  AppServiceEnvironmentResources.update::parameters.properties,
  "hostingEnvironmentEnvelope"
);
@@clientLocation(
  AppServiceEnvironmentResources.delete,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.listByResourceGroup,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.list,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.listCapacities,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.changeVnet,
  AppServiceEnvironments,
  "!csharp"
);
@@clientName(
  AppServiceEnvironmentResources.changeVnet::parameters.body,
  "vnetInfo"
);
@@clientLocation(
  AppServiceEnvironmentResources.listDiagnostics,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.getDiagnosticsItem,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.getInboundNetworkDependenciesEndpoints,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.testUpgradeAvailableNotification,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.upgrade,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.listOperations,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.getOutboundNetworkDependenciesEndpoints,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.getPrivateLinkResources,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.reboot,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.resume,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.listAppServicePlans,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.listWebApps,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.suspend,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentResources.listUsages,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentRecommendations.listHistoryForHostingEnvironment,
  Recommendations,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentRecommendations.listRecommendedRulesForHostingEnvironment,
  Recommendations,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentRecommendations.disableAllForHostingEnvironment,
  Recommendations,
  "!csharp"
);
@@clientLocation(
  AppServiceEnvironmentRecommendations.resetAllFiltersForHostingEnvironment,
  Recommendations,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AppServiceEnvironmentResource.properties);

@@clientLocation(
  CustomDnsSuffixConfigurations.getAseCustomDnsSuffixConfiguration,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  CustomDnsSuffixConfigurations.updateAseCustomDnsSuffixConfiguration,
  AppServiceEnvironments,
  "!csharp"
);
@@clientName(
  CustomDnsSuffixConfigurations.updateAseCustomDnsSuffixConfiguration::parameters.resource,
  "customDnsSuffixConfiguration"
);
@@clientLocation(
  CustomDnsSuffixConfigurations.deleteAseCustomDnsSuffixConfiguration,
  AppServiceEnvironments,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CustomDnsSuffixConfiguration.properties);

@@clientLocation(
  AseV3NetworkingConfigurations.getAseV3NetworkingConfiguration,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  AseV3NetworkingConfigurations.updateAseNetworkingConfiguration,
  AppServiceEnvironments,
  "!csharp"
);
@@clientName(
  AseV3NetworkingConfigurations.updateAseNetworkingConfiguration::parameters.resource,
  "aseNetworkingConfiguration"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AseV3NetworkingConfiguration.properties);

@@clientLocation(
  AddressResponses.getVipInfo,
  AppServiceEnvironments,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AddressResponse.properties);

@@clientLocation(Sites.get, WebApps, "!csharp");
@@clientLocation(Sites.createOrUpdate, WebApps, "!csharp");
@@clientName(Sites.createOrUpdate::parameters.resource, "siteEnvelope");
@@clientLocation(Sites.update, WebApps, "!csharp");
@@clientName(Sites.update::parameters.properties, "siteEnvelope");
@@clientLocation(Sites.delete, WebApps, "!csharp");
@@clientLocation(Sites.list, WebApps, "!csharp");
@@clientLocation(
  SiteRecommendations.listHistoryForWebApp,
  Recommendations,
  "!csharp"
);
@@clientLocation(
  SiteRecommendations.listRecommendedRulesForWebApp,
  Recommendations,
  "!csharp"
);
@@clientLocation(
  SiteRecommendations.disableAllForWebApp,
  Recommendations,
  "!csharp"
);
@@clientLocation(
  SiteRecommendations.resetAllFiltersForWebApp,
  Recommendations,
  "!csharp"
);
@@clientLocation(Sites.analyzeCustomHostname, WebApps, "!csharp");
@@clientLocation(Sites.applySlotConfigToProduction, WebApps, "!csharp");
@@clientName(
  Sites.applySlotConfigToProduction::parameters.body,
  "slotSwapEntity"
);
@@clientLocation(Sites.backup, WebApps, "!csharp");
@@clientName(Sites.backup::parameters.body, "request");
@@clientLocation(Sites.updateApplicationSettings, WebApps, "!csharp");
@@clientName(Sites.updateApplicationSettings::parameters.body, "appSettings");
@@clientLocation(Sites.listApplicationSettings, WebApps, "!csharp");
@@clientLocation(Sites.updateAuthSettings, WebApps, "!csharp");
@@clientName(Sites.updateAuthSettings::parameters.body, "siteAuthSettings");
@@clientLocation(Sites.getAuthSettings, WebApps, "!csharp");
@@clientLocation(Sites.updateAzureStorageAccounts, WebApps, "!csharp");
@@clientName(
  Sites.updateAzureStorageAccounts::parameters.body,
  "azureStorageAccounts"
);
@@clientLocation(Sites.listAzureStorageAccounts, WebApps, "!csharp");
@@clientLocation(Sites.updateBackupConfiguration, WebApps, "!csharp");
@@clientName(Sites.updateBackupConfiguration::parameters.body, "request");
@@clientLocation(Sites.deleteBackupConfiguration, WebApps, "!csharp");
@@clientLocation(Sites.getBackupConfiguration, WebApps, "!csharp");
@@clientLocation(Sites.updateConnectionStrings, WebApps, "!csharp");
@@clientName(
  Sites.updateConnectionStrings::parameters.body,
  "connectionStrings"
);
@@clientLocation(Sites.listConnectionStrings, WebApps, "!csharp");
@@clientLocation(Sites.updateMetadata, WebApps, "!csharp");
@@clientName(Sites.updateMetadata::parameters.body, "metadata");
@@clientLocation(Sites.listMetadata, WebApps, "!csharp");
@@clientLocation(Sites.listPublishingCredentials, WebApps, "!csharp");
@@clientLocation(Sites.updateSitePushSettings, WebApps, "!csharp");
@@clientName(Sites.updateSitePushSettings::parameters.body, "pushSettings");
@@clientLocation(Sites.listSitePushSettings, WebApps, "!csharp");
@@clientLocation(Sites.getWebSiteContainerLogs, WebApps, "!csharp");
@@clientLocation(Sites.getContainerLogsZip, WebApps, "!csharp");
@@clientLocation(Sites.discoverBackup, WebApps, "!csharp");
@@clientName(Sites.discoverBackup::parameters.body, "request");
@@clientLocation(Sites.getOneDeployStatus, WebApps, "!csharp");
@@clientLocation(Sites.createOneDeployOperation, WebApps, "!csharp");
@@clientLocation(Sites.getFunctionsAdminToken, WebApps, "!csharp");
@@clientLocation(Sites.listHostKeys, WebApps, "!csharp");
@@clientLocation(Sites.listSyncStatus, WebApps, "!csharp");
@@clientLocation(Sites.syncFunctions, WebApps, "!csharp");
@@clientLocation(Sites.createOrUpdateHostSecret, WebApps, "!csharp");
@@clientName(Sites.createOrUpdateHostSecret::parameters.body, "key");
@@clientLocation(Sites.deleteHostSecret, WebApps, "!csharp");
@@clientLocation(Sites.listHybridConnections, WebApps, "!csharp");
@@clientLocation(Sites.listRelayServiceConnections, WebApps, "!csharp");
@@clientLocation(Sites.isCloneable, WebApps, "!csharp");
@@clientLocation(Sites.listSiteBackups, WebApps, "!csharp");
@@clientLocation(Sites.listSyncFunctionTriggers, WebApps, "!csharp");
@@clientLocation(Sites.updateMachineKey, WebApps, "!csharp");
@@clientLocation(Sites.migrateStorage, WebApps, "!csharp");
@@clientName(Sites.migrateStorage::parameters.body, "migrationOptions");
@@clientLocation(Sites.migrateMySql, WebApps, "!csharp");
@@clientName(Sites.migrateMySql::parameters.body, "migrationRequestEnvelope");
@@clientLocation(Sites.getNetworkTraceOperation, WebApps, "!csharp");
@@clientLocation(Sites.startWebSiteNetworkTrace, WebApps, "!csharp");
@@clientLocation(Sites.startWebSiteNetworkTraceOperation, WebApps, "!csharp");
@@clientLocation(Sites.stopWebSiteNetworkTrace, WebApps, "!csharp");
@@clientLocation(Sites.getNetworkTraces, WebApps, "!csharp");
@@clientLocation(Sites.getNetworkTraceOperationV2, WebApps, "!csharp");
@@clientLocation(Sites.getNetworkTracesV2, WebApps, "!csharp");
@@clientLocation(Sites.generateNewSitePublishingPassword, WebApps, "!csharp");
@@clientLocation(Sites.listPerfMonCounters, WebApps, "!csharp");
@@clientLocation(Sites.getSitePhpErrorLogFlag, WebApps, "!csharp");
@@clientLocation(Sites.listPremierAddOns, WebApps, "!csharp");
@@clientLocation(Sites.getPrivateLinkResources, WebApps, "!csharp");
@@clientLocation(Sites.listPublishingProfileXmlWithSecrets, WebApps, "!csharp");
@@clientName(
  Sites.listPublishingProfileXmlWithSecrets::parameters.body,
  "publishingProfileOptions"
);
@@clientLocation(Sites.resetProductionSlotConfig, WebApps, "!csharp");
@@clientLocation(Sites.restart, WebApps, "!csharp");
@@clientLocation(Sites.restoreFromBackupBlob, WebApps, "!csharp");
@@clientName(Sites.restoreFromBackupBlob::parameters.body, "request");
@@clientLocation(Sites.restoreFromDeletedApp, WebApps, "!csharp");
@@clientName(Sites.restoreFromDeletedApp::parameters.body, "restoreRequest");
@@clientLocation(Sites.restoreSnapshot, WebApps, "!csharp");
@@clientName(Sites.restoreSnapshot::parameters.body, "restoreRequest");
@@clientLocation(Sites.listSlotDifferencesFromProduction, WebApps, "!csharp");
@@clientName(
  Sites.listSlotDifferencesFromProduction::parameters.body,
  "slotSwapEntity"
);
@@clientLocation(Sites.swapSlotWithProduction, WebApps, "!csharp");
@@clientName(Sites.swapSlotWithProduction::parameters.body, "slotSwapEntity");
@@clientLocation(Sites.listSnapshots, WebApps, "!csharp");
@@clientLocation(Sites.listSnapshotsFromDRSecondary, WebApps, "!csharp");
@@clientLocation(Sites.start, WebApps, "!csharp");
@@clientLocation(Sites.startNetworkTrace, WebApps, "!csharp");
@@clientLocation(Sites.stop, WebApps, "!csharp");
@@clientLocation(Sites.stopNetworkTrace, WebApps, "!csharp");
@@clientLocation(Sites.syncRepository, WebApps, "!csharp");
@@clientLocation(Sites.syncFunctionTriggers, WebApps, "!csharp");
@@clientLocation(Sites.listUsages, WebApps, "!csharp");
@@clientLocation(Sites.deployWorkflowArtifacts, WebApps, "!csharp");
@@clientName(
  Sites.deployWorkflowArtifacts::parameters.body,
  "workflowArtifacts"
);
@@clientLocation(Sites.listWorkflowsConnections, WebApps, "!csharp");
@@clientLocation(SiteWorkflows.regenerateAccessKey, "Workflows", "!csharp");
@@clientName(SiteWorkflows.regenerateAccessKey::parameters.body, "keyType");
@@clientLocation(SiteWorkflows.validate, "Workflows", "!csharp");
@@clientName(SiteWorkflows.validate::parameters.body, "validate");

@@clientName(WebApps.createOrUpdateSlot::parameters.resource, "siteEnvelope");
@@clientName(WebApps.updateSlot::parameters.properties, "siteEnvelope");
@@clientName(
  WebApps.applySlotConfigurationSlot::parameters.body,
  "slotSwapEntity"
);
@@clientName(WebApps.backupSlot::parameters.body, "request");
@@clientName(
  WebApps.updateApplicationSettingsSlot::parameters.body,
  "appSettings"
);
@@clientName(
  WebApps.updateAuthSettingsSlot::parameters.body,
  "siteAuthSettings"
);
@@clientName(
  WebApps.updateAzureStorageAccountsSlot::parameters.body,
  "azureStorageAccounts"
);
@@clientName(WebApps.updateBackupConfigurationSlot::parameters.body, "request");
@@clientName(
  WebApps.updateConnectionStringsSlot::parameters.body,
  "connectionStrings"
);
@@clientName(WebApps.updateMetadataSlot::parameters.body, "metadata");
@@clientName(
  WebApps.updateSitePushSettingsSlot::parameters.body,
  "pushSettings"
);
@@clientName(WebApps.discoverBackupSlot::parameters.body, "request");
@@clientName(WebApps.createOrUpdateHostSecretSlot::parameters.body, "key");
@@clientName(
  WebApps.listPublishingProfileXmlWithSecretsSlot::parameters.body,
  "publishingProfileOptions"
);
@@clientName(WebApps.restoreFromBackupBlobSlot::parameters.body, "request");
@@clientName(
  WebApps.restoreFromDeletedAppSlot::parameters.body,
  "restoreRequest"
);
@@clientName(WebApps.restoreSnapshotSlot::parameters.body, "restoreRequest");
@@clientName(
  WebApps.listSlotDifferencesSlot::parameters.body,
  "slotSwapEntity"
);
@@clientName(WebApps.swapSlotSlot::parameters.body, "slotSwapEntity");
@@clientName(
  WebApps.deployWorkflowArtifactsSlot::parameters.body,
  "workflowArtifacts"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Site.properties);

@@clientLocation(
  WorkerPoolResources.getMultiRolePool,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  WorkerPoolResources.createOrUpdateMultiRolePool,
  AppServiceEnvironments,
  "!csharp"
);
@@clientName(
  WorkerPoolResources.createOrUpdateMultiRolePool::parameters.resource,
  "multiRolePoolEnvelope"
);
@@clientLocation(
  WorkerPoolResources.updateMultiRolePool,
  AppServiceEnvironments,
  "!csharp"
);
@@clientName(
  WorkerPoolResources.updateMultiRolePool::parameters.properties,
  "multiRolePoolEnvelope"
);
@@clientLocation(
  WorkerPoolResources.listMultiRolePools,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  WorkerPoolResources.listMultiRolePoolInstanceMetricDefinitions,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  WorkerPoolResources.listMultiRoleMetricDefinitions,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  WorkerPoolResources.listMultiRolePoolSkus,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  WorkerPoolResources.listMultiRoleUsages,
  AppServiceEnvironments,
  "!csharp"
);
@@clientName(
  AppServiceEnvironments.createOrUpdateWorkerPool::parameters.resource,
  "workerPoolEnvelope"
);
@@clientName(
  AppServiceEnvironments.updateWorkerPool::parameters.properties,
  "workerPoolEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkerPoolResource.properties);

@@clientLocation(
  RemotePrivateEndpointConnectionARMResources.getPrivateEndpointConnection,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  RemotePrivateEndpointConnectionARMResources.approveOrRejectPrivateEndpointConnection,
  AppServiceEnvironments,
  "!csharp"
);
@@clientName(
  RemotePrivateEndpointConnectionARMResources.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "privateEndpointWrapper"
);
@@clientLocation(
  RemotePrivateEndpointConnectionARMResources.deletePrivateEndpointConnection,
  AppServiceEnvironments,
  "!csharp"
);
@@clientLocation(
  RemotePrivateEndpointConnectionARMResources.getPrivateEndpointConnectionList,
  AppServiceEnvironments,
  "!csharp"
);
@@clientName(
  StaticSites.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "privateEndpointWrapper"
);
@@clientLocation(
  RemotePrivateEndpointConnectionARMResourceOperationGroup.getPrivateEndpointConnection,
  WebApps,
  "!csharp"
);
@@clientLocation(
  RemotePrivateEndpointConnectionARMResourceOperationGroup.approveOrRejectPrivateEndpointConnection,
  WebApps,
  "!csharp"
);
@@clientName(
  RemotePrivateEndpointConnectionARMResourceOperationGroup.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "privateEndpointWrapper"
);
@@clientLocation(
  RemotePrivateEndpointConnectionARMResourceOperationGroup.deletePrivateEndpointConnection,
  WebApps,
  "!csharp"
);
@@clientLocation(
  RemotePrivateEndpointConnectionARMResourceOperationGroup.getPrivateEndpointConnectionList,
  WebApps,
  "!csharp"
);
@@clientLocation(
  PrivateEndpointConnectionSlotOperationGroup.getPrivateEndpointConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  PrivateEndpointConnectionSlotOperationGroup.approveOrRejectPrivateEndpointConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  PrivateEndpointConnectionSlotOperationGroup.approveOrRejectPrivateEndpointConnectionSlot::parameters.resource,
  "privateEndpointWrapper"
);
@@clientLocation(
  PrivateEndpointConnectionSlotOperationGroup.deletePrivateEndpointConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  PrivateEndpointConnectionSlotOperationGroup.getPrivateEndpointConnectionListSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RemotePrivateEndpointConnectionARMResource.properties);

@@clientName(
  AppServicePlans.createOrUpdate::parameters.resource,
  "appServicePlan"
);
@@clientName(AppServicePlans.update::parameters.properties, "appServicePlan");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AppServicePlan.properties);

@@clientLocation(
  HybridConnections.getHybridConnection,
  AppServicePlans,
  "!csharp"
);
@@clientLocation(
  HybridConnections.deleteHybridConnection,
  AppServicePlans,
  "!csharp"
);
@@clientLocation(
  HybridConnections.listHybridConnectionKeys,
  AppServicePlans,
  "!csharp"
);
@@clientLocation(
  HybridConnections.listWebAppsByHybridConnection,
  AppServicePlans,
  "!csharp"
);
@@clientLocation(
  HybridConnectionOperationGroup.getHybridConnection,
  WebApps,
  "!csharp"
);
@@clientLocation(
  HybridConnectionOperationGroup.createOrUpdateHybridConnection,
  WebApps,
  "!csharp"
);
@@clientName(
  HybridConnectionOperationGroup.createOrUpdateHybridConnection::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(
  HybridConnectionOperationGroup.updateHybridConnection,
  WebApps,
  "!csharp"
);
@@clientName(
  HybridConnectionOperationGroup.updateHybridConnection::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(
  HybridConnectionOperationGroup.deleteHybridConnection,
  WebApps,
  "!csharp"
);
@@clientLocation(
  HybridConnectionSlotOperationGroup.getHybridConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  HybridConnectionSlotOperationGroup.createOrUpdateHybridConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  HybridConnectionSlotOperationGroup.createOrUpdateHybridConnectionSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(
  HybridConnectionSlotOperationGroup.updateHybridConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  HybridConnectionSlotOperationGroup.updateHybridConnectionSlot::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(
  HybridConnectionSlotOperationGroup.deleteHybridConnectionSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(HybridConnection.properties);

@@clientLocation(
  HybridConnectionLimitsOperationGroup.getHybridConnectionPlanLimit,
  AppServicePlans,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(HybridConnectionLimits.properties);

@@clientLocation(
  VnetInfoResources.getVnetFromServerFarm,
  AppServicePlans,
  "!csharp"
);
@@clientLocation(VnetInfoResources.listVnets, AppServicePlans, "!csharp");
@@clientLocation(
  VnetInfoResourceOperationGroup.getVnetConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  VnetInfoResourceOperationGroup.createOrUpdateVnetConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  VnetInfoResourceOperationGroup.createOrUpdateVnetConnectionSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(
  VnetInfoResourceOperationGroup.updateVnetConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  VnetInfoResourceOperationGroup.updateVnetConnectionSlot::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(
  VnetInfoResourceOperationGroup.deleteVnetConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  VnetInfoResourceOperationGroup.listVnetConnectionsSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  VnetConnectionOperationGroup.getVnetConnection,
  WebApps,
  "!csharp"
);
@@clientLocation(
  VnetConnectionOperationGroup.createOrUpdateVnetConnection,
  WebApps,
  "!csharp"
);
@@clientName(
  VnetConnectionOperationGroup.createOrUpdateVnetConnection::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(
  VnetConnectionOperationGroup.updateVnetConnection,
  WebApps,
  "!csharp"
);
@@clientName(
  VnetConnectionOperationGroup.updateVnetConnection::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(
  VnetConnectionOperationGroup.deleteVnetConnection,
  WebApps,
  "!csharp"
);
@@clientLocation(
  VnetConnectionOperationGroup.listVnetConnections,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VnetInfoResource.properties);

@@clientLocation(VnetRoutes.getRouteForVnet, AppServicePlans, "!csharp");
@@clientLocation(
  VnetRoutes.createOrUpdateVnetRoute,
  AppServicePlans,
  "!csharp"
);
@@clientName(VnetRoutes.createOrUpdateVnetRoute::parameters.resource, "route");
@@clientLocation(VnetRoutes.updateVnetRoute, AppServicePlans, "!csharp");
@@clientName(VnetRoutes.updateVnetRoute::parameters.properties, "route");
@@clientLocation(VnetRoutes.deleteVnetRoute, AppServicePlans, "!csharp");
@@clientLocation(VnetRoutes.listRoutesForVnet, AppServicePlans, "!csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VnetRoute.properties);

@@clientLocation(VnetGateways.getVnetGateway, AppServicePlans, "!csharp");
@@clientLocation(VnetGateways.updateVnetGateway, AppServicePlans, "!csharp");
@@clientName(
  VnetGateways.updateVnetGateway::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(
  VnetGatewayOperationGroup.getVnetConnectionGatewaySlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  VnetGatewayOperationGroup.createOrUpdateVnetConnectionGatewaySlot,
  WebApps,
  "!csharp"
);
@@clientName(
  VnetGatewayOperationGroup.createOrUpdateVnetConnectionGatewaySlot::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(
  VnetGatewayOperationGroup.updateVnetConnectionGatewaySlot,
  WebApps,
  "!csharp"
);
@@clientName(
  VnetGatewayOperationGroup.updateVnetConnectionGatewaySlot::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(
  VnetConnectionGatewayOperationGroup.getVnetConnectionGateway,
  WebApps,
  "!csharp"
);
@@clientLocation(
  VnetConnectionGatewayOperationGroup.createOrUpdateVnetConnectionGateway,
  WebApps,
  "!csharp"
);
@@clientName(
  VnetConnectionGatewayOperationGroup.createOrUpdateVnetConnectionGateway::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(
  VnetConnectionGatewayOperationGroup.updateVnetConnectionGateway,
  WebApps,
  "!csharp"
);
@@clientName(
  VnetConnectionGatewayOperationGroup.updateVnetConnectionGateway::parameters.properties,
  "connectionEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VnetGateway.properties);

@@clientName(
  Certificates.createOrUpdate::parameters.resource,
  "certificateEnvelope"
);
@@clientName(Certificates.update::parameters.properties, "certificateEnvelope");
@@clientName(
  SiteCertificates.createOrUpdate::parameters.resource,
  "certificateEnvelope"
);
@@clientName(
  SiteCertificates.update::parameters.properties,
  "certificateEnvelope"
);
@@clientLocation(
  CertificateOperationGroup.getSlot,
  SiteCertificates,
  "!csharp"
);
@@clientLocation(
  CertificateOperationGroup.createOrUpdateSlot,
  SiteCertificates,
  "!csharp"
);
@@clientName(
  CertificateOperationGroup.createOrUpdateSlot::parameters.resource,
  "certificateEnvelope"
);
@@clientLocation(
  CertificateOperationGroup.updateSlot,
  SiteCertificates,
  "!csharp"
);
@@clientName(
  CertificateOperationGroup.updateSlot::parameters.properties,
  "certificateEnvelope"
);
@@clientLocation(
  CertificateOperationGroup.deleteSlot,
  SiteCertificates,
  "!csharp"
);
@@clientLocation(
  CertificateOperationGroup.listSlot,
  SiteCertificates,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Certificate.properties);

@@clientLocation(
  DeletedSites.getDeletedWebAppByLocation,
  "DeletedWebApps",
  "!csharp"
);
@@clientLocation(DeletedSites.listByLocation, "DeletedWebApps", "!csharp");
@@clientLocation(GlobalDeletedWebApps.list, "DeletedWebApps", "!csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DeletedSite.properties);

@@clientLocation(
  DetectorResponses.getHostingEnvironmentDetectorResponse,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  DetectorResponses.listHostingEnvironmentDetectorResponses,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  DetectorResponseOperationGroup.getSiteDetectorResponseSlot,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  DetectorResponseOperationGroup.listSiteDetectorResponsesSlot,
  Diagnostics,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DetectorResponse.properties);

@@clientLocation(
  DiagnosticCategories.getSiteDiagnosticCategory,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  DiagnosticCategories.listSiteDiagnosticCategories,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  DiagnosticCategoryOperationGroup.getSiteDiagnosticCategorySlot,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  DiagnosticCategoryOperationGroup.listSiteDiagnosticCategoriesSlot,
  Diagnostics,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DiagnosticCategory.properties);

@@clientLocation(AnalysisDefinitions.getSiteAnalysis, Diagnostics, "!csharp");
@@clientLocation(AnalysisDefinitions.listSiteAnalyses, Diagnostics, "!csharp");
@@clientLocation(
  AnalysisDefinitions.executeSiteAnalysis,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  AnalysisDefinitionOperationGroup.getSiteAnalysisSlot,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  AnalysisDefinitionOperationGroup.listSiteAnalysesSlot,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  AnalysisDefinitionOperationGroup.executeSiteAnalysisSlot,
  Diagnostics,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AnalysisDefinition.properties);

@@clientLocation(
  DetectorDefinitionResources.getSiteDetector,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  DetectorDefinitionResources.listSiteDetectors,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  DetectorDefinitionResources.executeSiteDetector,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  DetectorDefinitionResourceOperationGroup.getSiteDetectorSlot,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  DetectorDefinitionResourceOperationGroup.listSiteDetectorsSlot,
  Diagnostics,
  "!csharp"
);
@@clientLocation(
  DetectorDefinitionResourceOperationGroup.executeSiteDetectorSlot,
  Diagnostics,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DetectorDefinitionResource.properties);

@@clientName(
  KubeEnvironments.createOrUpdate::parameters.resource,
  "kubeEnvironmentEnvelope"
);
@@clientName(
  KubeEnvironments.update::parameters.properties,
  "kubeEnvironmentEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(KubeEnvironment.properties);

@@clientLocation(
  RecommendationRules.getRuleDetailsByHostingEnvironment,
  Recommendations,
  "!csharp"
);
@@clientLocation(
  RecommendationRules.disableRecommendationForHostingEnvironment,
  Recommendations,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RecommendationRule.properties);

@@clientLocation(
  ResourceHealthMetadataOperationGroup.getBySite,
  "ResourceHealthMetadata",
  "!csharp"
);
@@clientLocation(
  ResourceHealthMetadataOperationGroup.listBySite,
  "ResourceHealthMetadata",
  "!csharp"
);
@@clientLocation(
  BySiteSlotOperationGroup.getBySiteSlot,
  "ResourceHealthMetadata",
  "!csharp"
);
@@clientLocation(
  BySiteSlotOperationGroup.listBySiteSlot,
  "ResourceHealthMetadata",
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ResourceHealthMetadata.properties);

@@clientLocation(Users.getPublishingUser, Microsoft.Web, "!csharp");
@@clientLocation(Users.updatePublishingUser, Microsoft.Web, "!csharp");
@@clientName(Users.updatePublishingUser::parameters.resource, "userDetails");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(User.properties);

@@clientLocation(SourceControls.getSourceControl, Microsoft.Web, "!csharp");
@@clientLocation(SourceControls.updateSourceControl, Microsoft.Web, "!csharp");
@@clientName(
  SourceControls.updateSourceControl::parameters.resource,
  "requestMessage"
);
@@clientLocation(SourceControls.listSourceControls, Microsoft.Web, "!csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SourceControl.properties);

@@clientLocation(Identifiers.getDomainOwnershipIdentifier, WebApps, "!csharp");
@@clientLocation(
  Identifiers.createOrUpdateDomainOwnershipIdentifier,
  WebApps,
  "!csharp"
);
@@clientName(
  Identifiers.createOrUpdateDomainOwnershipIdentifier::parameters.resource,
  "domainOwnershipIdentifier"
);
@@clientLocation(
  Identifiers.updateDomainOwnershipIdentifier,
  WebApps,
  "!csharp"
);
@@clientName(
  Identifiers.updateDomainOwnershipIdentifier::parameters.properties,
  "domainOwnershipIdentifier"
);
@@clientLocation(
  Identifiers.deleteDomainOwnershipIdentifier,
  WebApps,
  "!csharp"
);
@@clientLocation(
  Identifiers.listDomainOwnershipIdentifiers,
  WebApps,
  "!csharp"
);
@@clientLocation(
  IdentifierOperationGroup.getDomainOwnershipIdentifierSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  IdentifierOperationGroup.createOrUpdateDomainOwnershipIdentifierSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  IdentifierOperationGroup.createOrUpdateDomainOwnershipIdentifierSlot::parameters.resource,
  "domainOwnershipIdentifier"
);
@@clientLocation(
  IdentifierOperationGroup.updateDomainOwnershipIdentifierSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  IdentifierOperationGroup.updateDomainOwnershipIdentifierSlot::parameters.properties,
  "domainOwnershipIdentifier"
);
@@clientLocation(
  IdentifierOperationGroup.deleteDomainOwnershipIdentifierSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  IdentifierOperationGroup.listDomainOwnershipIdentifiersSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Identifier.properties);

@@clientLocation(StaticSiteARMResources.getStaticSite, StaticSites, "!csharp");
@@clientLocation(
  StaticSiteARMResources.createOrUpdateStaticSite,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteARMResources.createOrUpdateStaticSite::parameters.resource,
  "staticSiteEnvelope"
);
@@clientLocation(
  StaticSiteARMResources.updateStaticSite,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteARMResources.updateStaticSite::parameters.properties,
  "staticSiteEnvelope"
);
@@clientLocation(
  StaticSiteARMResources.deleteStaticSite,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteARMResources.getStaticSitesByResourceGroup,
  StaticSites,
  "!csharp"
);
@@clientLocation(StaticSiteARMResources.list, StaticSites, "!csharp");
@@clientLocation(
  StaticSiteARMResources.listStaticSiteUsers,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteARMResources.deleteStaticSiteUser,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteARMResources.updateStaticSiteUser,
  StaticSites,
  "!csharp"
);

@@clientLocation(
  StaticSiteARMResources.createOrUpdateStaticSiteAppSettings,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteARMResources.createOrUpdateStaticSiteAppSettings::parameters.body,
  "appSettings"
);
@@clientLocation(
  StaticSiteARMResources.createOrUpdateStaticSiteFunctionAppSettings,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteARMResources.createOrUpdateStaticSiteFunctionAppSettings::parameters.body,
  "appSettings"
);
@@clientLocation(
  StaticSiteARMResources.createUserRolesInvitationLink,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteARMResources.createUserRolesInvitationLink::parameters.body,
  "staticSiteUserRolesInvitationEnvelope"
);
@@clientLocation(
  StaticSiteARMResources.detachStaticSite,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteARMResources.listStaticSiteFunctions,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteARMResources.listStaticSiteAppSettings,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteARMResources.listStaticSiteConfiguredRoles,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteARMResources.listStaticSiteFunctionAppSettings,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteARMResources.listStaticSiteSecrets,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteARMResources.getPrivateLinkResources,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteARMResources.resetStaticSiteApiKey,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteARMResources.resetStaticSiteApiKey::parameters.body,
  "resetPropertiesEnvelope"
);
@@clientLocation(
  StaticSiteARMResources.getDatabaseConnectionsWithDetails,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteARMResources.createZipDeploymentForStaticSite,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteARMResources.createZipDeploymentForStaticSite::parameters.body,
  "staticSiteZipDeploymentEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteARMResource.properties);

@@clientLocation(
  StaticSiteBuildARMResources.getStaticSiteBuild,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteBuildARMResources.deleteStaticSiteBuild,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteBuildARMResources.getStaticSiteBuilds,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildAppSettings,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildAppSettings::parameters.body,
  "appSettings"
);
@@clientLocation(
  StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildFunctionAppSettings,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildFunctionAppSettings::parameters.body,
  "appSettings"
);
@@clientLocation(
  StaticSiteBuildARMResources.listStaticSiteBuildFunctions,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteBuildARMResources.listStaticSiteBuildAppSettings,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteBuildARMResources.listStaticSiteBuildFunctionAppSettings,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteBuildARMResources.getBuildDatabaseConnectionsWithDetails,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteBuildARMResources.createZipDeploymentForStaticSiteBuild,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteBuildARMResources.createZipDeploymentForStaticSiteBuild::parameters.body,
  "staticSiteZipDeploymentEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteBuildARMResource.properties);

@@clientLocation(
  DatabaseConnections.getBuildDatabaseConnection,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  DatabaseConnections.createOrUpdateBuildDatabaseConnection,
  StaticSites,
  "!csharp"
);
@@clientName(
  DatabaseConnections.createOrUpdateBuildDatabaseConnection::parameters.resource,
  "databaseConnectionRequestEnvelope"
);
@@clientLocation(
  DatabaseConnections.updateBuildDatabaseConnection,
  StaticSites,
  "!csharp"
);
@@clientName(
  DatabaseConnections.updateBuildDatabaseConnection::parameters.properties,
  "databaseConnectionRequestEnvelope"
);
@@clientLocation(
  DatabaseConnections.deleteBuildDatabaseConnection,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  DatabaseConnections.getBuildDatabaseConnections,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  DatabaseConnections.getBuildDatabaseConnectionWithDetails,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  DatabaseConnectionOperationGroup.getDatabaseConnection,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  DatabaseConnectionOperationGroup.createOrUpdateDatabaseConnection,
  StaticSites,
  "!csharp"
);
@@clientName(
  DatabaseConnectionOperationGroup.createOrUpdateDatabaseConnection::parameters.resource,
  "databaseConnectionRequestEnvelope"
);
@@clientLocation(
  DatabaseConnectionOperationGroup.updateDatabaseConnection,
  StaticSites,
  "!csharp"
);
@@clientName(
  DatabaseConnectionOperationGroup.updateDatabaseConnection::parameters.properties,
  "databaseConnectionRequestEnvelope"
);
@@clientLocation(
  DatabaseConnectionOperationGroup.deleteDatabaseConnection,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  DatabaseConnectionOperationGroup.getDatabaseConnections,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  DatabaseConnectionOperationGroup.getDatabaseConnectionWithDetails,
  StaticSites,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DatabaseConnection.properties);

@@clientLocation(
  StaticSiteUserProvidedFunctionAppARMResources.getUserProvidedFunctionAppForStaticSiteBuild,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteUserProvidedFunctionAppARMResources.registerUserProvidedFunctionAppWithStaticSiteBuild,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteUserProvidedFunctionAppARMResources.registerUserProvidedFunctionAppWithStaticSiteBuild::parameters.resource,
  "staticSiteUserProvidedFunctionEnvelope"
);
@@clientLocation(
  StaticSiteUserProvidedFunctionAppARMResources.detachUserProvidedFunctionAppFromStaticSiteBuild,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteUserProvidedFunctionAppARMResources.getUserProvidedFunctionAppsForStaticSiteBuild,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.getUserProvidedFunctionAppForStaticSite,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.registerUserProvidedFunctionAppWithStaticSite,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.registerUserProvidedFunctionAppWithStaticSite::parameters.resource,
  "staticSiteUserProvidedFunctionEnvelope"
);
@@clientLocation(
  StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.detachUserProvidedFunctionAppFromStaticSite,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.getUserProvidedFunctionAppsForStaticSite,
  StaticSites,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteUserProvidedFunctionAppARMResource.properties);

@@clientLocation(
  StaticSiteBasicAuthPropertiesARMResources.getBasicAuth,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteBasicAuthPropertiesARMResources.createOrUpdateBasicAuth,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteBasicAuthPropertiesARMResources.createOrUpdateBasicAuth::parameters.resource,
  "basicAuthEnvelope"
);
@@clientLocation(
  StaticSiteBasicAuthPropertiesARMResources.listBasicAuth,
  StaticSites,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteBasicAuthPropertiesARMResource.properties);

@@clientLocation(
  StaticSiteCustomDomainOverviewARMResources.getStaticSiteCustomDomain,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteCustomDomainOverviewARMResources.createOrUpdateStaticSiteCustomDomain,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteCustomDomainOverviewARMResources.createOrUpdateStaticSiteCustomDomain::parameters.resource,
  "staticSiteCustomDomainRequestPropertiesEnvelope"
);
@@clientLocation(
  StaticSiteCustomDomainOverviewARMResources.deleteStaticSiteCustomDomain,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteCustomDomainOverviewARMResources.listStaticSiteCustomDomains,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteCustomDomainOverviewARMResources.validateCustomDomainCanBeAddedToStaticSite,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteCustomDomainOverviewARMResources.validateCustomDomainCanBeAddedToStaticSite::parameters.body,
  "staticSiteCustomDomainRequestPropertiesEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteCustomDomainOverviewARMResource.properties);

@@clientLocation(
  StaticSiteLinkedBackendARMResources.getLinkedBackend,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteLinkedBackendARMResources.linkBackend,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteLinkedBackendARMResources.linkBackend::parameters.resource,
  "staticSiteLinkedBackendEnvelope"
);
@@clientLocation(
  StaticSiteLinkedBackendARMResources.unlinkBackend,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteLinkedBackendARMResources.getLinkedBackends,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteLinkedBackendARMResources.validateBackend,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteLinkedBackendARMResources.validateBackend::parameters.body,
  "staticSiteLinkedBackendEnvelope"
);
@@clientLocation(
  StaticSiteLinkedBackendARMResourceOperationGroup.getLinkedBackendForBuild,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteLinkedBackendARMResourceOperationGroup.linkBackendToBuild,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteLinkedBackendARMResourceOperationGroup.linkBackendToBuild::parameters.resource,
  "staticSiteLinkedBackendEnvelope"
);
@@clientLocation(
  StaticSiteLinkedBackendARMResourceOperationGroup.unlinkBackendFromBuild,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteLinkedBackendARMResourceOperationGroup.getLinkedBackendsForBuild,
  StaticSites,
  "!csharp"
);
@@clientLocation(
  StaticSiteLinkedBackendARMResourceOperationGroup.validateBackendForBuild,
  StaticSites,
  "!csharp"
);
@@clientName(
  StaticSiteLinkedBackendARMResourceOperationGroup.validateBackendForBuild::parameters.body,
  "staticSiteLinkedBackendEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StaticSiteLinkedBackendARMResource.properties);

@@clientLocation(BackupItems.getBackupStatus, WebApps, "!csharp");
@@clientLocation(BackupItems.deleteBackup, WebApps, "!csharp");
@@clientLocation(BackupItems.listBackups, WebApps, "!csharp");
@@clientLocation(BackupItems.listBackupStatusSecrets, WebApps, "!csharp");
@@clientName(BackupItems.listBackupStatusSecrets::parameters.body, "request");
@@clientLocation(BackupItems.restore, WebApps, "!csharp");
@@clientName(BackupItems.restore::parameters.body, "request");
@@clientLocation(
  BackupItemOperationGroup.getBackupStatusSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(BackupItemOperationGroup.deleteBackupSlot, WebApps, "!csharp");
@@clientLocation(BackupItemOperationGroup.listBackupsSlot, WebApps, "!csharp");
@@clientLocation(
  BackupItemOperationGroup.listBackupStatusSecretsSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  BackupItemOperationGroup.listBackupStatusSecretsSlot::parameters.body,
  "request"
);
@@clientLocation(BackupItemOperationGroup.restoreSlot, WebApps, "!csharp");
@@clientName(BackupItemOperationGroup.restoreSlot::parameters.body, "request");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BackupItem.properties);

@@clientLocation(
  CsmPublishingCredentialsPoliciesEntities.getFtpAllowed,
  WebApps,
  "!csharp"
);
@@clientLocation(
  CsmPublishingCredentialsPoliciesEntities.updateFtpAllowed,
  WebApps,
  "!csharp"
);
@@clientName(
  CsmPublishingCredentialsPoliciesEntities.updateFtpAllowed::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);
@@clientLocation(
  CsmPublishingCredentialsPoliciesEntities.listBasicPublishingCredentialsPolicies,
  WebApps,
  "!csharp"
);
@@clientLocation(
  CsmPublishingCredentialsPoliciesEntityOperationGroup.getScmAllowed,
  WebApps,
  "!csharp"
);
@@clientLocation(
  CsmPublishingCredentialsPoliciesEntityOperationGroup.updateScmAllowed,
  WebApps,
  "!csharp"
);
@@clientName(
  CsmPublishingCredentialsPoliciesEntityOperationGroup.updateScmAllowed::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);
@@clientLocation(
  CsmPublishingCredentialsPoliciesEntityFtpAllowedSlot.getFtpAllowedSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  CsmPublishingCredentialsPoliciesEntityFtpAllowedSlot.updateFtpAllowedSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  CsmPublishingCredentialsPoliciesEntityFtpAllowedSlot.updateFtpAllowedSlot::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);
@@clientLocation(
  CsmPublishingCredentialsPoliciesEntityFtpAllowedSlot.listBasicPublishingCredentialsPoliciesSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  CsmPublishingCredentialsPoliciesEntityScmAllowedSlot.getScmAllowedSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  CsmPublishingCredentialsPoliciesEntityScmAllowedSlot.updateScmAllowedSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  CsmPublishingCredentialsPoliciesEntityScmAllowedSlot.updateScmAllowedSlot::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CsmPublishingCredentialsPoliciesEntity.properties);

@@clientLocation(SiteConfigResources.getConfiguration, WebApps, "!csharp");
@@clientLocation(
  SiteConfigResources.createOrUpdateConfiguration,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteConfigResources.createOrUpdateConfiguration::parameters.resource,
  "siteConfig"
);
@@clientLocation(SiteConfigResources.updateConfiguration, WebApps, "!csharp");
@@clientName(
  SiteConfigResources.updateConfiguration::parameters.properties,
  "siteConfig"
);
@@clientLocation(
  SiteConfigResources.listConfigurationSnapshotInfo,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConfigResourceOperationGroup.getConfigurationSnapshot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConfigResourceOperationGroup.listConfigurations,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConfigResourceOperationGroup.recoverSiteConfigurationSnapshot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConfigSlotResourceOperationGroup.getConfigurationSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConfigSlotResourceOperationGroup.createOrUpdateConfigurationSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteConfigSlotResourceOperationGroup.createOrUpdateConfigurationSlot::parameters.resource,
  "siteConfig"
);
@@clientLocation(
  SiteConfigSlotResourceOperationGroup.updateConfigurationSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteConfigSlotResourceOperationGroup.updateConfigurationSlot::parameters.properties,
  "siteConfig"
);
@@clientLocation(
  SiteConfigSlotResourceOperationGroup.listConfigurationSnapshotInfoSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConfigSnapshotSlotResourceOperationGroup.getConfigurationSnapshotSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConfigSnapshotSlotResourceOperationGroup.listConfigurationsSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConfigSnapshotSlotResourceOperationGroup.recoverSiteConfigurationSnapshotSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteConfigResource.properties);

@@clientLocation(
  SiteAuthSettingsV2s.getAuthSettingsV2WithoutSecrets,
  WebApps,
  "!csharp"
);
@@clientLocation(SiteAuthSettingsV2s.updateAuthSettingsV2, WebApps, "!csharp");
@@clientName(
  SiteAuthSettingsV2s.updateAuthSettingsV2::parameters.resource,
  "siteAuthSettingsV2"
);
@@clientLocation(SiteAuthSettingsV2s.getAuthSettingsV2, WebApps, "!csharp");
@@clientLocation(
  SiteAuthSettingsV2OperationGroup.getAuthSettingsV2WithoutSecretsSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteAuthSettingsV2OperationGroup.updateAuthSettingsV2Slot,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteAuthSettingsV2OperationGroup.updateAuthSettingsV2Slot::parameters.resource,
  "siteAuthSettingsV2"
);
@@clientLocation(
  SiteAuthSettingsV2OperationGroup.getAuthSettingsV2Slot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteAuthSettingsV2.properties);

@@clientLocation(
  AppSettingKeyVaultReference.getAppSettingKeyVaultReference,
  WebApps,
  "!csharp"
);
@@clientLocation(
  AppSettingKeyVaultReference.getAppSettingsKeyVaultReferences,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConnectionStringKeyVaultReference.getSiteConnectionStringKeyVaultReference,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConnectionStringKeyVaultReference.getSiteConnectionStringKeyVaultReferences,
  WebApps,
  "!csharp"
);
@@clientLocation(
  AppSettingKeyVaultReferenceSlot.getAppSettingKeyVaultReferenceSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  AppSettingKeyVaultReferenceSlot.getAppSettingsKeyVaultReferencesSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConnectionStringKeyVaultReferenceSlot.getSiteConnectionStringKeyVaultReferenceSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteConnectionStringKeyVaultReferenceSlot.getSiteConnectionStringKeyVaultReferencesSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ApiKVReference.properties);

@@clientLocation(
  SiteLogsConfigs.getDiagnosticLogsConfiguration,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteLogsConfigs.updateDiagnosticLogsConfig,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteLogsConfigs.updateDiagnosticLogsConfig::parameters.resource,
  "siteLogsConfig"
);
@@clientLocation(
  SiteLogsConfigOperationGroup.getDiagnosticLogsConfigurationSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteLogsConfigOperationGroup.updateDiagnosticLogsConfigSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteLogsConfigOperationGroup.updateDiagnosticLogsConfigSlot::parameters.resource,
  "siteLogsConfig"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteLogsConfig.properties);

@@clientLocation(
  SlotConfigNamesResources.listSlotConfigurationNames,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SlotConfigNamesResources.updateSlotConfigurationNames,
  WebApps,
  "!csharp"
);
@@clientName(
  SlotConfigNamesResources.updateSlotConfigurationNames::parameters.resource,
  "slotConfigNames"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SlotConfigNamesResource.properties);

@@clientLocation(ContinuousWebJobs.getContinuousWebJob, WebApps, "!csharp");
@@clientLocation(ContinuousWebJobs.deleteContinuousWebJob, WebApps, "!csharp");
@@clientLocation(ContinuousWebJobs.listContinuousWebJobs, WebApps, "!csharp");
@@clientLocation(ContinuousWebJobs.startContinuousWebJob, WebApps, "!csharp");
@@clientLocation(ContinuousWebJobs.stopContinuousWebJob, WebApps, "!csharp");
@@clientLocation(
  ContinuousWebJobOperationGroup.getContinuousWebJobSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ContinuousWebJobOperationGroup.deleteContinuousWebJobSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ContinuousWebJobOperationGroup.listContinuousWebJobsSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ContinuousWebJobOperationGroup.startContinuousWebJobSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ContinuousWebJobOperationGroup.stopContinuousWebJobSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ContinuousWebJob.properties);

@@clientLocation(
  CsmDeploymentStatuses.getProductionSiteDeploymentStatus,
  WebApps,
  "!csharp"
);
@@clientLocation(
  CsmDeploymentStatuses.listProductionSiteDeploymentStatuses,
  WebApps,
  "!csharp"
);
@@clientLocation(
  CsmDeploymentStatusOperationGroup.getSlotSiteDeploymentStatusSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  CsmDeploymentStatusOperationGroup.listSlotSiteDeploymentStatusesSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CsmDeploymentStatus.properties);

@@clientLocation(Deployments.getDeployment, WebApps, "!csharp");
@@clientLocation(Deployments.createDeployment, WebApps, "!csharp");
@@clientName(Deployments.createDeployment::parameters.resource, "deployment");
@@clientLocation(Deployments.deleteDeployment, WebApps, "!csharp");
@@clientLocation(Deployments.listDeployments, WebApps, "!csharp");
@@clientLocation(Deployments.listDeploymentLog, WebApps, "!csharp");
@@clientLocation(
  DeploymentOperationGroup.getDeploymentSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  DeploymentOperationGroup.createDeploymentSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  DeploymentOperationGroup.createDeploymentSlot::parameters.resource,
  "deployment"
);
@@clientLocation(
  DeploymentOperationGroup.deleteDeploymentSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  DeploymentOperationGroup.listDeploymentsSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  DeploymentOperationGroup.listDeploymentLogSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Deployment.properties);

@@clientLocation(MSDeployStatuses.getMSDeployStatus, WebApps, "!csharp");
@@clientLocation(MSDeployStatuses.createMSDeployOperation, WebApps, "!csharp");
@@clientName(
  MSDeployStatuses.createMSDeployOperation::parameters.resource,
  "MSDeploy"
);
@@clientLocation(MSDeployStatuses.getMSDeployLog, WebApps, "!csharp");
@@clientLocation(
  MSDeployStatusOperationGroup.getInstanceMsDeployStatus,
  WebApps,
  "!csharp"
);
@@clientLocation(
  MSDeployStatusOperationGroup.createInstanceMSDeployOperation,
  WebApps,
  "!csharp"
);
@@clientName(
  MSDeployStatusOperationGroup.createInstanceMSDeployOperation::parameters.resource,
  "MSDeploy"
);
@@clientLocation(
  MSDeployStatusOperationGroup.getInstanceMSDeployLog,
  WebApps,
  "!csharp"
);
@@clientLocation(
  MSDeployStatusSlotOperationGroup.getMSDeployStatusSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  MSDeployStatusSlotOperationGroup.createMSDeployOperationSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  MSDeployStatusSlotOperationGroup.createMSDeployOperationSlot::parameters.resource,
  "MSDeploy"
);
@@clientLocation(
  MSDeployStatusSlotOperationGroup.getMSDeployLogSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  InstanceMSDeployStatusOperationGroup.getInstanceMsDeployStatusSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  InstanceMSDeployStatusOperationGroup.createInstanceMSDeployOperationSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  InstanceMSDeployStatusOperationGroup.createInstanceMSDeployOperationSlot::parameters.resource,
  "MSDeploy"
);
@@clientLocation(
  InstanceMSDeployStatusOperationGroup.getInstanceMSDeployLogSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MSDeployStatus.properties);

@@clientLocation(FunctionEnvelopes.getFunction, WebApps, "!csharp");
@@clientLocation(FunctionEnvelopes.createFunction, WebApps, "!csharp");
@@clientName(
  FunctionEnvelopes.createFunction::parameters.resource,
  "function_envelope"
);
@@clientLocation(FunctionEnvelopes.deleteFunction, WebApps, "!csharp");
@@clientLocation(FunctionEnvelopes.listFunctions, WebApps, "!csharp");
@@clientLocation(
  FunctionEnvelopes.createOrUpdateFunctionSecret,
  WebApps,
  "!csharp"
);
@@clientLocation(FunctionEnvelopes.deleteFunctionSecret, WebApps, "!csharp");
@@clientLocation(FunctionEnvelopes.listFunctionKeys, WebApps, "!csharp");
@@clientLocation(FunctionEnvelopes.listFunctionSecrets, WebApps, "!csharp");
@@clientLocation(
  FunctionEnvelopeOperationGroup.getInstanceFunctionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  FunctionEnvelopeOperationGroup.createInstanceFunctionSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  FunctionEnvelopeOperationGroup.createInstanceFunctionSlot::parameters.resource,
  "function_envelope"
);
@@clientLocation(
  FunctionEnvelopeOperationGroup.deleteInstanceFunctionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  FunctionEnvelopeOperationGroup.listInstanceFunctionsSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  FunctionEnvelopeOperationGroup.createOrUpdateFunctionSecretSlot,
  WebApps,
  "!csharp"
);

@@clientLocation(
  FunctionEnvelopeOperationGroup.deleteFunctionSecretSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  FunctionEnvelopeOperationGroup.listFunctionKeysSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  FunctionEnvelopeOperationGroup.listFunctionSecretsSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FunctionEnvelope.properties);

@@clientLocation(HostNameBindings.getHostNameBinding, WebApps, "!csharp");
@@clientLocation(
  HostNameBindings.createOrUpdateHostNameBinding,
  WebApps,
  "!csharp"
);
@@clientName(
  HostNameBindings.createOrUpdateHostNameBinding::parameters.resource,
  "hostNameBinding"
);
@@clientLocation(HostNameBindings.deleteHostNameBinding, WebApps, "!csharp");
@@clientLocation(HostNameBindings.listHostNameBindings, WebApps, "!csharp");
@@clientLocation(
  HostNameBindingOperationGroup.getHostNameBindingSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  HostNameBindingOperationGroup.createOrUpdateHostNameBindingSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  HostNameBindingOperationGroup.createOrUpdateHostNameBindingSlot::parameters.resource,
  "hostNameBinding"
);
@@clientLocation(
  HostNameBindingOperationGroup.deleteHostNameBindingSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  HostNameBindingOperationGroup.listHostNameBindingsSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(HostNameBinding.properties);

@@clientLocation(
  RelayServiceConnectionEntities.getRelayServiceConnection,
  WebApps,
  "!csharp"
);
@@clientLocation(
  RelayServiceConnectionEntities.createOrUpdateRelayServiceConnection,
  WebApps,
  "!csharp"
);
@@clientName(
  RelayServiceConnectionEntities.createOrUpdateRelayServiceConnection::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(
  RelayServiceConnectionEntities.updateRelayServiceConnection,
  WebApps,
  "!csharp"
);
@@clientName(
  RelayServiceConnectionEntities.updateRelayServiceConnection::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(
  RelayServiceConnectionEntities.deleteRelayServiceConnection,
  WebApps,
  "!csharp"
);
@@clientLocation(
  RelayServiceConnectionEntityOperationGroup.getRelayServiceConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  RelayServiceConnectionEntityOperationGroup.createOrUpdateRelayServiceConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  RelayServiceConnectionEntityOperationGroup.createOrUpdateRelayServiceConnectionSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(
  RelayServiceConnectionEntityOperationGroup.updateRelayServiceConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  RelayServiceConnectionEntityOperationGroup.updateRelayServiceConnectionSlot::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(
  RelayServiceConnectionEntityOperationGroup.deleteRelayServiceConnectionSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RelayServiceConnectionEntity.properties);

@@clientLocation(WebSiteInstanceStatuses.getInstanceInfo, WebApps, "!csharp");
@@clientLocation(
  WebSiteInstanceStatuses.listInstanceIdentifiers,
  WebApps,
  "!csharp"
);
@@clientLocation(
  WebSiteInstanceStatusOperationGroup.getInstanceInfoSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  WebSiteInstanceStatusOperationGroup.listInstanceIdentifiersSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WebSiteInstanceStatus.properties);

@@clientLocation(ProcessInfos.getInstanceProcess, WebApps, "!csharp");
@@clientLocation(ProcessInfos.deleteInstanceProcess, WebApps, "!csharp");
@@clientLocation(ProcessInfos.listInstanceProcesses, WebApps, "!csharp");
@@clientLocation(ProcessInfos.getInstanceProcessDump, WebApps, "!csharp");
@@clientLocation(ProcessInfos.listInstanceProcessThreads, WebApps, "!csharp");
@@clientLocation(ProcessInfoOperationGroup.getProcess, WebApps, "!csharp");
@@clientLocation(ProcessInfoOperationGroup.deleteProcess, WebApps, "!csharp");
@@clientLocation(ProcessInfoOperationGroup.listProcesses, WebApps, "!csharp");
@@clientLocation(ProcessInfoOperationGroup.getProcessDump, WebApps, "!csharp");
@@clientLocation(
  ProcessInfoOperationGroup.listProcessThreads,
  WebApps,
  "!csharp"
);
@@clientLocation(
  InstanceProcessSlotOperationGroup.getInstanceProcessSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  InstanceProcessSlotOperationGroup.deleteInstanceProcessSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  InstanceProcessSlotOperationGroup.listInstanceProcessesSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  InstanceProcessSlotOperationGroup.getInstanceProcessDumpSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  InstanceProcessSlotOperationGroup.listInstanceProcessThreadsSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(ProcessSlotOperationGroup.getProcessSlot, WebApps, "!csharp");
@@clientLocation(
  ProcessSlotOperationGroup.deleteProcessSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ProcessSlotOperationGroup.listProcessesSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ProcessSlotOperationGroup.getProcessDumpSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ProcessSlotOperationGroup.listProcessThreadsSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProcessInfo.properties);

@@clientLocation(
  ProcessModuleInfos.getInstanceProcessModule,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ProcessModuleInfos.listInstanceProcessModules,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ProcessModuleInfoOperationGroup.getProcessModule,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ProcessModuleInfoOperationGroup.listProcessModules,
  WebApps,
  "!csharp"
);
@@clientLocation(
  InstanceProcessModuleSlotOperationGroup.getInstanceProcessModuleSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  InstanceProcessModuleSlotOperationGroup.listInstanceProcessModulesSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ProcessModuleSlotOperationGroup.getProcessModuleSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  ProcessModuleSlotOperationGroup.listProcessModulesSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProcessModuleInfo.properties);

@@clientLocation(
  MigrateMySqlStatuses.getMigrateMySqlStatus,
  WebApps,
  "!csharp"
);
@@clientLocation(
  MigrateMySqlStatusOperationGroup.getMigrateMySqlStatusSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MigrateMySqlStatus.properties);

@@clientLocation(
  SwiftVirtualNetworks.getSwiftVirtualNetworkConnection,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SwiftVirtualNetworks.createOrUpdateSwiftVirtualNetworkConnectionWithCheck,
  WebApps,
  "!csharp"
);
@@clientName(
  SwiftVirtualNetworks.createOrUpdateSwiftVirtualNetworkConnectionWithCheck::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(
  SwiftVirtualNetworks.updateSwiftVirtualNetworkConnectionWithCheck,
  WebApps,
  "!csharp"
);
@@clientName(
  SwiftVirtualNetworks.updateSwiftVirtualNetworkConnectionWithCheck::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(
  SwiftVirtualNetworks.deleteSwiftVirtualNetwork,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SwiftVirtualNetworkOperationGroup.getSwiftVirtualNetworkConnectionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SwiftVirtualNetworkOperationGroup.createOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  SwiftVirtualNetworkOperationGroup.createOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientLocation(
  SwiftVirtualNetworkOperationGroup.updateSwiftVirtualNetworkConnectionWithCheckSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  SwiftVirtualNetworkOperationGroup.updateSwiftVirtualNetworkConnectionWithCheckSlot::parameters.properties,
  "connectionEnvelope"
);
@@clientLocation(
  SwiftVirtualNetworkOperationGroup.deleteSwiftVirtualNetworkSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SwiftVirtualNetwork.properties);

@@clientLocation(
  NetworkFeaturesOperationGroup.listNetworkFeatures,
  WebApps,
  "!csharp"
);
@@clientLocation(
  NetworkFeaturesSlotOperationGroup.listNetworkFeaturesSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NetworkFeatures.properties);

@@clientLocation(PremierAddOns.getPremierAddOn, WebApps, "!csharp");
@@clientLocation(PremierAddOns.addPremierAddOn, WebApps, "!csharp");
@@clientName(
  PremierAddOns.addPremierAddOn::parameters.resource,
  "premierAddOn"
);
@@clientLocation(PremierAddOns.updatePremierAddOn, WebApps, "!csharp");
@@clientName(
  PremierAddOns.updatePremierAddOn::parameters.properties,
  "premierAddOn"
);
@@clientLocation(PremierAddOns.deletePremierAddOn, WebApps, "!csharp");
@@clientLocation(
  PremierAddOnOperationGroup.getPremierAddOnSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  PremierAddOnOperationGroup.addPremierAddOnSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  PremierAddOnOperationGroup.addPremierAddOnSlot::parameters.resource,
  "premierAddOn"
);
@@clientLocation(
  PremierAddOnOperationGroup.updatePremierAddOnSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  PremierAddOnOperationGroup.updatePremierAddOnSlot::parameters.properties,
  "premierAddOn"
);
@@clientLocation(
  PremierAddOnOperationGroup.deletePremierAddOnSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PremierAddOn.properties);

@@clientLocation(PrivateAccesses.getPrivateAccess, WebApps, "!csharp");
@@clientLocation(PrivateAccesses.putPrivateAccessVnet, WebApps, "!csharp");
@@clientName(
  PrivateAccesses.putPrivateAccessVnet::parameters.resource,
  "access"
);
@@clientLocation(
  PrivateAccessOperationGroup.getPrivateAccessSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  PrivateAccessOperationGroup.putPrivateAccessVnetSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  PrivateAccessOperationGroup.putPrivateAccessVnetSlot::parameters.resource,
  "access"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateAccess.properties);

@@clientLocation(PublicCertificates.getPublicCertificate, WebApps, "!csharp");
@@clientLocation(
  PublicCertificates.createOrUpdatePublicCertificate,
  WebApps,
  "!csharp"
);
@@clientName(
  PublicCertificates.createOrUpdatePublicCertificate::parameters.resource,
  "publicCertificate"
);
@@clientLocation(
  PublicCertificates.deletePublicCertificate,
  WebApps,
  "!csharp"
);
@@clientLocation(PublicCertificates.listPublicCertificates, WebApps, "!csharp");
@@clientLocation(
  PublicCertificateOperationGroup.getPublicCertificateSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  PublicCertificateOperationGroup.createOrUpdatePublicCertificateSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  PublicCertificateOperationGroup.createOrUpdatePublicCertificateSlot::parameters.resource,
  "publicCertificate"
);
@@clientLocation(
  PublicCertificateOperationGroup.deletePublicCertificateSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  PublicCertificateOperationGroup.listPublicCertificatesSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PublicCertificate.properties);

@@clientLocation(SiteContainers.getSiteContainer, WebApps, "!csharp");
@@clientLocation(
  SiteContainers.createOrUpdateSiteContainer,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteContainers.createOrUpdateSiteContainer::parameters.resource,
  "request"
);
@@clientLocation(SiteContainers.deleteSiteContainer, WebApps, "!csharp");
@@clientLocation(SiteContainers.listSiteContainers, WebApps, "!csharp");
@@clientLocation(
  SiteContainerOperationGroup.getSiteContainerSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteContainerOperationGroup.createOrUpdateSiteContainerSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteContainerOperationGroup.createOrUpdateSiteContainerSlot::parameters.resource,
  "request"
);
@@clientLocation(
  SiteContainerOperationGroup.deleteSiteContainerSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteContainerOperationGroup.listSiteContainersSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteContainer.properties);

@@clientLocation(SiteExtensionInfos.getSiteExtension, WebApps, "!csharp");
@@clientLocation(SiteExtensionInfos.installSiteExtension, WebApps, "!csharp");
@@clientLocation(SiteExtensionInfos.deleteSiteExtension, WebApps, "!csharp");
@@clientLocation(SiteExtensionInfos.listSiteExtensions, WebApps, "!csharp");
@@clientLocation(
  SiteExtensionInfoOperationGroup.getSiteExtensionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteExtensionInfoOperationGroup.installSiteExtensionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteExtensionInfoOperationGroup.deleteSiteExtensionSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteExtensionInfoOperationGroup.listSiteExtensionsSlot,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteExtensionInfo.properties);

@@clientLocation(SiteSourceControls.getSourceControlSlot, WebApps, "!csharp");
@@clientLocation(
  SiteSourceControls.createOrUpdateSourceControlSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteSourceControls.createOrUpdateSourceControlSlot::parameters.resource,
  "siteSourceControl"
);
@@clientLocation(
  SiteSourceControls.updateSourceControlSlot,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteSourceControls.updateSourceControlSlot::parameters.properties,
  "siteSourceControl"
);
@@clientLocation(
  SiteSourceControls.deleteSourceControlSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteSourceControlOperationGroup.getSourceControl,
  WebApps,
  "!csharp"
);
@@clientLocation(
  SiteSourceControlOperationGroup.createOrUpdateSourceControl,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteSourceControlOperationGroup.createOrUpdateSourceControl::parameters.resource,
  "siteSourceControl"
);
@@clientLocation(
  SiteSourceControlOperationGroup.updateSourceControl,
  WebApps,
  "!csharp"
);
@@clientName(
  SiteSourceControlOperationGroup.updateSourceControl::parameters.properties,
  "siteSourceControl"
);
@@clientLocation(
  SiteSourceControlOperationGroup.deleteSourceControl,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteSourceControl.properties);

@@clientLocation(TriggeredWebJobs.getTriggeredWebJobSlot, WebApps, "!csharp");
@@clientLocation(
  TriggeredWebJobs.deleteTriggeredWebJobSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(TriggeredWebJobs.listTriggeredWebJobsSlot, WebApps, "!csharp");
@@clientLocation(TriggeredWebJobs.runTriggeredWebJobSlot, WebApps, "!csharp");
@@clientLocation(
  TriggeredWebJobOperationGroup.getTriggeredWebJob,
  WebApps,
  "!csharp"
);
@@clientLocation(
  TriggeredWebJobOperationGroup.deleteTriggeredWebJob,
  WebApps,
  "!csharp"
);
@@clientLocation(
  TriggeredWebJobOperationGroup.listTriggeredWebJobs,
  WebApps,
  "!csharp"
);
@@clientLocation(
  TriggeredWebJobOperationGroup.runTriggeredWebJob,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(TriggeredWebJob.properties);

@@clientLocation(
  TriggeredJobHistories.getTriggeredWebJobHistorySlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  TriggeredJobHistories.listTriggeredWebJobHistorySlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  TriggeredJobHistoryOperationGroup.getTriggeredWebJobHistory,
  WebApps,
  "!csharp"
);
@@clientLocation(
  TriggeredJobHistoryOperationGroup.listTriggeredWebJobHistory,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(TriggeredJobHistory.properties);

@@clientLocation(WebJobs.getWebJobSlot, WebApps, "!csharp");
@@clientLocation(WebJobs.listWebJobsSlot, WebApps, "!csharp");
@@clientLocation(WebJobOperationGroup.getWebJob, WebApps, "!csharp");
@@clientLocation(WebJobOperationGroup.listWebJobs, WebApps, "!csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WebJob.properties);

@@clientLocation(WorkflowEnvelopes.getInstanceWorkflowSlot, WebApps, "!csharp");
@@clientLocation(
  WorkflowEnvelopes.listInstanceWorkflowsSlot,
  WebApps,
  "!csharp"
);
@@clientLocation(
  WorkflowEnvelopeOperationGroup.getWorkflow,
  WebApps,
  "!csharp"
);
@@clientLocation(
  WorkflowEnvelopeOperationGroup.listWorkflows,
  WebApps,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowRun.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowRunAction.properties);

@@clientLocation(
  WorkflowRunActionRepetitionDefinitions.get,
  "WorkflowRunActionRepetitions",
  "!csharp"
);
@@clientLocation(
  WorkflowRunActionRepetitionDefinitions.list,
  "WorkflowRunActionRepetitions",
  "!csharp"
);
@@clientLocation(
  WorkflowRunActionRepetitionDefinitions.listExpressionTraces,
  "WorkflowRunActionRepetitions",
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowRunActionRepetitionDefinition.properties);

@@clientLocation(
  RequestHistories.get,
  "WorkflowRunActionRepetitionsRequestHistories",
  "!csharp"
);
@@clientLocation(
  RequestHistories.list,
  "WorkflowRunActionRepetitionsRequestHistories",
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowTrigger.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowTriggerHistory.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WorkflowVersion.properties);

@@clientLocation(
  GlobalOperationGroup.getSubscriptionOperationWithAsyncResponse,
  Global,
  "!csharp"
);

@@clientLocation(
  ProviderOperationGroup.getAvailableStacks,
  "Provider",
  "!csharp"
);
@@clientLocation(
  ProviderOperationGroup.getFunctionAppStacks,
  "Provider",
  "!csharp"
);
@@clientLocation(
  ProviderOperationGroup.getFunctionAppStacksForLocation,
  "Provider",
  "!csharp"
);
@@clientLocation(
  ProviderOperationGroup.getWebAppStacksForLocation,
  "Provider",
  "!csharp"
);
@@clientLocation(ProviderOperationGroup.getWebAppStacks, "Provider", "!csharp");
@@clientLocation(
  ProviderOperationGroup.getAvailableStacksOnPrem,
  "Provider",
  "!csharp"
);

@@clientLocation(
  RecommendationsOperationGroup.list,
  Recommendations,
  "!csharp"
);
@@clientLocation(
  RecommendationsOperationGroup.resetAllFilters,
  Recommendations,
  "!csharp"
);
@@clientLocation(
  RecommendationsOperationGroup.disableRecommendationForSubscription,
  Recommendations,
  "!csharp"
);

@@clientLocation(
  ResourceHealthMetadataNonResourceOperationGroup.list,
  "ResourceHealthMetadata",
  "!csharp"
);
@@clientLocation(
  ResourceHealthMetadataNonResourceOperationGroup.listByResourceGroup,
  "ResourceHealthMetadata",
  "!csharp"
);

@@clientLocation(
  GetUsagesInLocationOperationGroup.list,
  "GetUsagesInLocation",
  "!csharp"
);
@@clientName(GetUsagesInLocationOperationGroup.list, "list");

@@clientLocation(
  StaticSitesOperationGroup.previewWorkflow,
  StaticSites,
  "!csharp"
);

@@clientLocation(Operations.list, "Provider", "!csharp");
@@clientName(Operations.list, "ListOperations");
@@clientName(checkNameAvailability::parameters.body, "request");
@@clientName(
  listSiteIdentifiersAssignedToHostName::parameters.body,
  "nameIdentifier"
);
@@clientName(regionalCheckNameAvailability::parameters.body, "request");
@@clientName(verifyHostingEnvironmentVnet::parameters.body, "parameters");
@@clientName(
  StaticSitesOperationGroup.previewWorkflow::parameters.body,
  "staticSitesWorkflowPreviewRequest"
);
@@clientName(
  FunctionEnvelopeOperationGroup.createOrUpdateFunctionSecretSlot::parameters.resource,
  "key"
);
@@summary(
  Operations.list,
  "Gets all available operations for the Microsoft.Web resource provider. Also exposes resource metric definitions"
);
@@doc(
  Operations.list,
  "Description for Gets all available operations for the Microsoft.Web resource provider. Also exposes resource metric definitions"
);
@@clientName(
  FunctionEnvelopes.createOrUpdateFunctionSecret::parameters.body,
  "key"
);
@@clientName(
  StaticSiteARMResources.updateStaticSiteUser::parameters.body,
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
@@clientLocation(
  listSiteIdentifiersAssignedToHostName,
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

// Java client naming: fix HostName -> Hostname casing
@@clientName(HostNameBinding, "HostnameBinding", "java");
@@clientName(HostNameBindingCollection, "HostnameBindingCollection", "java");
@@clientName(HostNameBindingProperties, "HostnameBindingProperties", "java");
@@clientName(HostNameSslState, "HostnameSslState", "java");
@@clientName(
  CustomHostNameDnsRecordType,
  "CustomHostnameDnsRecordType",
  "java"
);
@@clientName(HostNameType, "HostnameType", "java");
@@clientName(
  HostNameBindingProperties.customHostNameDnsRecordType,
  "customHostnameDnsRecordType",
  "java"
);
@@clientName(HostNameBindingProperties.hostNameType, "hostnameType", "java");
@@clientName(HostNameBindingProperties.virtualIP, "virtualIp", "java");
@@clientName(RampUpRule.actionHostName, "actionHostname", "java");

// Java client naming: fix property casing in HostNameSslState
@@clientName(HostNameSslState.virtualIP, "virtualIp", "java");

// Java client naming: fix TimeStamp -> Timestamp casing
@@clientName(ContainerInfo.currentTimeStamp, "currentTimestamp", "java");
@@clientName(ContainerInfo.previousTimeStamp, "previousTimestamp", "java");

// Java client naming: fix ARM -> Arm casing
@@clientName(
  RemotePrivateEndpointConnectionARMResource,
  "RemotePrivateEndpointConnectionArmResource",
  "java"
);
@@clientName(
  RemotePrivateEndpointConnectionARMResourceProperties,
  "RemotePrivateEndpointConnectionArmResourceProperties",
  "java"
);
@@clientName(StaticSiteARMResource, "StaticSiteArmResource", "java");
@@clientName(
  StaticSiteResetPropertiesARMResource,
  "StaticSiteResetPropertiesArmResource",
  "java"
);
@@clientName(
  StaticSiteResetPropertiesARMResourceProperties,
  "StaticSiteResetPropertiesArmResourceProperties",
  "java"
);
@@clientName(
  StaticSiteBasicAuthPropertiesARMResource,
  "StaticSiteBasicAuthPropertiesArmResource",
  "java"
);
@@clientName(
  StaticSiteBasicAuthPropertiesARMResourceProperties,
  "StaticSiteBasicAuthPropertiesArmResourceProperties",
  "java"
);
@@clientName(StaticSiteBuildARMResource, "StaticSiteBuildArmResource", "java");
@@clientName(
  StaticSiteBuildARMResourceProperties,
  "StaticSiteBuildArmResourceProperties",
  "java"
);
@@clientName(
  StaticSiteCustomDomainOverviewARMResource,
  "StaticSiteCustomDomainOverviewArmResource",
  "java"
);
@@clientName(
  StaticSiteCustomDomainOverviewARMResourceProperties,
  "StaticSiteCustomDomainOverviewArmResourceProperties",
  "java"
);
@@clientName(
  StaticSiteCustomDomainRequestPropertiesARMResource,
  "StaticSiteCustomDomainRequestPropertiesArmResource",
  "java"
);
@@clientName(
  StaticSiteCustomDomainRequestPropertiesARMResourceProperties,
  "StaticSiteCustomDomainRequestPropertiesArmResourceProperties",
  "java"
);
@@clientName(
  StaticSiteFunctionOverviewARMResource,
  "StaticSiteFunctionOverviewArmResource",
  "java"
);
@@clientName(
  StaticSiteFunctionOverviewARMResourceProperties,
  "StaticSiteFunctionOverviewArmResourceProperties",
  "java"
);
@@clientName(
  StaticSiteLinkedBackendARMResource,
  "StaticSiteLinkedBackendArmResource",
  "java"
);
@@clientName(
  StaticSiteLinkedBackendARMResourceProperties,
  "StaticSiteLinkedBackendArmResourceProperties",
  "java"
);
@@clientName(StaticSiteUserARMResource, "StaticSiteUserArmResource", "java");
@@clientName(
  StaticSiteUserARMResourceProperties,
  "StaticSiteUserArmResourceProperties",
  "java"
);
@@clientName(
  StaticSiteUserProvidedFunctionAppARMResource,
  "StaticSiteUserProvidedFunctionAppArmResource",
  "java"
);
@@clientName(
  StaticSiteUserProvidedFunctionAppARMResourceProperties,
  "StaticSiteUserProvidedFunctionAppArmResourceProperties",
  "java"
);
@@clientName(
  StaticSiteZipDeploymentARMResource,
  "StaticSiteZipDeploymentArmResource",
  "java"
);

// Java client naming: fix IP -> Ip and MetaData -> Metadata casing
@@clientName(IPMode, "IpMode", "java");
@@clientName(VirtualIPMapping, "VirtualIpMapping", "java");
@@clientName(VirtualIPMapping.virtualIP, "virtualIp", "java");
@@clientName(ResponseMetaData, "ResponseMetadata", "java");
@@clientName(AnalysisData.detectorMetaData, "detectorMetadata", "java");
@@clientName(DetectorAbnormalTimePeriod.metaData, "metadata", "java");

// Java client naming: fix aksResourceID -> aksResourceId casing
@@clientName(KubeEnvironmentProperties.aksResourceID, "aksResourceId", "java");
@@clientName(
  KubeEnvironmentPatchResourceProperties.aksResourceID,
  "aksResourceId",
  "java"
);
@@clientName(
  ContainerAppsConfiguration.platformReservedDnsIP,
  "platformReservedDnsIp",
  "java"
);
@@clientName(
  SiteConfig.acrUserManagedIdentityID,
  "acrUserManagedIdentityId",
  "java"
);

// Java client naming: fix WWW -> Www casing
@@clientName(
  AzureActiveDirectoryLogin.disableWWWAuthenticate,
  "disableWwwAuthenticate",
  "java"
);

// Java client naming: fix property casing in SiteProperties
@@clientName(SiteProperties.defaultHostName, "defaultHostname", "java");
@@clientName(SiteProperties.hostNameSslStates, "hostnameSslStates", "java");

// Java client naming: fix property casing in SitePatchResourceProperties
@@clientName(
  SitePatchResourceProperties.defaultHostName,
  "defaultHostname",
  "java"
);
@@clientName(
  SitePatchResourceProperties.hostNameSslStates,
  "hostnameSslStates",
  "java"
);

// Java client naming: fix HostNameBinding operation casing
@@clientName(HostNameBindings.getHostNameBinding, "getHostnameBinding", "java");
@@clientName(
  HostNameBindings.createOrUpdateHostNameBinding,
  "createOrUpdateHostnameBinding",
  "java"
);
@@clientName(
  HostNameBindings.deleteHostNameBinding,
  "deleteHostnameBinding",
  "java"
);
@@clientName(
  HostNameBindings.listHostNameBindings,
  "listHostnameBindings",
  "java"
);
@@clientName(
  HostNameBindingOperationGroup.getHostNameBindingSlot,
  "getHostnameBindingSlot",
  "java"
);
@@clientName(
  HostNameBindingOperationGroup.createOrUpdateHostNameBindingSlot,
  "createOrUpdateHostnameBindingSlot",
  "java"
);
@@clientName(
  HostNameBindingOperationGroup.deleteHostNameBindingSlot,
  "deleteHostnameBindingSlot",
  "java"
);
@@clientName(
  HostNameBindingOperationGroup.listHostNameBindingsSlot,
  "listHostnameBindingsSlot",
  "java"
);
@@clientName(listCustomHostNameSites, "listCustomHostnameSites", "java");

// Java client naming: fix swapSlotSlot -> swapSlot
@@clientName(WebApps.swapSlotSlot, "swapSlot", "java");

// Java client location: move ResourceProvider-level operations to ResourceProviders client
@@clientLocation(checkNameAvailability, "ResourceProviders", "java");
@@clientLocation(
  getSubscriptionDeploymentLocations,
  "ResourceProviders",
  "java"
);
@@clientLocation(listAseRegions, "ResourceProviders", "java");
@@clientLocation(listBillingMeters, "ResourceProviders", "java");
@@clientLocation(listCustomHostNameSites, "ResourceProviders", "java");
@@clientLocation(listGeoRegions, "ResourceProviders", "java");
@@clientLocation(listPremierAddOnOffers, "ResourceProviders", "java");
@@clientLocation(listSkus, "ResourceProviders", "java");
@@clientLocation(
  listSiteIdentifiersAssignedToHostName,
  "ResourceProviders",
  "java"
);
@@clientLocation(move, "ResourceProviders", "java");
@@clientLocation(regionalCheckNameAvailability, "ResourceProviders", "java");
@@clientLocation(validate, "ResourceProviders", "java");
@@clientLocation(validateMove, "ResourceProviders", "java");
@@clientLocation(verifyHostingEnvironmentVnet, "ResourceProviders", "java");
@@clientLocation(Users.getPublishingUser, "ResourceProviders", "java");
@@clientLocation(Users.updatePublishingUser, "ResourceProviders", "java");
@@clientLocation(SourceControls.getSourceControl, "ResourceProviders", "java");
@@clientLocation(
  SourceControls.updateSourceControl,
  "ResourceProviders",
  "java"
);
@@clientLocation(
  SourceControls.listSourceControls,
  "ResourceProviders",
  "java"
);

@@alternateType(CloningInfo.correlationId, Azure.Core.uuid, "java");
@@alternateType(SiteProperties.inProgressOperationId, Azure.Core.uuid, "java");
@@alternateType(
  SitePatchResourceProperties.inProgressOperationId,
  Azure.Core.uuid,
  "java"
);
@@alternateType(Operation.geoMasterOperationId, Azure.Core.uuid, "java");
@@alternateType(
  RecommendationProperties.recommendationId,
  Azure.Core.uuid,
  "java"
);
@@alternateType(
  RecommendationRuleProperties.recommendationId,
  Azure.Core.uuid,
  "java"
);
