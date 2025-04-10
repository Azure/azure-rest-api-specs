import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CertificateRegistration;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServiceCertificateOrderPatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServiceCertificatePatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReissueCertificateOrderRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RenewCertificateOrderRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SiteSeal.html);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DomainPatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServiceEnvironmentPatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PushSettings.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResourceMetricDefinition.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Usage.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServicePlanPatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HybridConnectionKey.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CertificatePatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiagnosticAnalysis.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiagnosticDetectorResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Snapshot.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KubeEnvironmentPatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationStackResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FunctionAppStack.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WebAppStack.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Recommendation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BillingMeter.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomHostnameSites.properties);

@@clientName(IdentifierProperties.id, "value");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GeoRegion.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AseRegion.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PremierAddOnOffer.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VnetParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VnetValidationFailureDetails.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VnetValidationTestFailure.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ValidateRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSitesWorkflowPreviewRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSitesWorkflowPreview.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RemotePrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteUserProvidedFunctionApp.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSitePatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteUserARMResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StringDictionary.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DatabaseConnectionPatchRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteFunctionOverviewARMResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteZipDeploymentARMResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteUserInvitationRequestResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteUserInvitationResponseResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteCustomDomainRequestPropertiesARMResource.properties
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteResetPropertiesARMResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SitePatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomHostnameAnalysisResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackupRequest.properties);

@@clientName(BackupItemProperties.id, "backupId");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RestoreRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SiteAuthSettings.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureStoragePropertyDictionaryResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConnectionStringDictionary.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MSDeploy.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageMigrationOptions.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageMigrationResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MigrateMySqlRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SitePhpErrorLogFlag.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PremierAddOnPatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeletedAppRestoreRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Workflow.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkConnectionApprovalRequestResource.properties);

@@clientName(AppServiceCertificateOrders.createOrUpdate::parameters.resource,
  "certificateDistinguishedName"
);
@@clientName(AppServiceCertificateOrders.update::parameters.properties,
  "certificateDistinguishedName"
);
@@clientName(AppServiceCertificateOrders.reissue::parameters.body,
  "reissueCertificateOrderRequest"
);
@@clientName(AppServiceCertificateOrders.renew::parameters.body,
  "renewCertificateOrderRequest"
);
@@clientName(AppServiceCertificateOrders.resendRequestEmails::parameters.body,
  "nameIdentifier"
);
@@clientName(AppServiceCertificateOrders.retrieveSiteSeal::parameters.body,
  "siteSealRequest"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServiceCertificateOrder.properties);

@@clientName(AppServiceCertificateResources.createOrUpdateCertificate::parameters.resource,
  "keyVaultCertificate"
);
@@clientName(AppServiceCertificateResources.updateCertificate::parameters.properties,
  "keyVaultCertificate"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServiceCertificateResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DetectorResponse.properties);

@@clientName(Domains.createOrUpdate::parameters.resource, "domain");
@@clientName(Domains.update::parameters.properties, "domain");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Domain.properties);

@@clientName(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier::parameters.resource,
  "domainOwnershipIdentifier"
);
@@clientName(DomainOwnershipIdentifiers.updateOwnershipIdentifier::parameters.properties,
  "domainOwnershipIdentifier"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DomainOwnershipIdentifier.properties);

@@clientName(TopLevelDomains.listAgreements::parameters.body,
  "agreementOption"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TopLevelDomain.properties);

@@clientName(AppServiceEnvironmentResources.createOrUpdate::parameters.resource,
  "hostingEnvironmentEnvelope"
);
@@clientName(AppServiceEnvironmentResources.update::parameters.properties,
  "hostingEnvironmentEnvelope"
);
@@clientName(AppServiceEnvironmentResources.changeVnet::parameters.body,
  "vnetInfo"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServiceEnvironmentResource.properties);

@@clientName(CustomDnsSuffixConfigurations.updateAseCustomDnsSuffixConfiguration::parameters.resource,
  "customDnsSuffixConfiguration"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomDnsSuffixConfiguration.properties);

@@clientName(AseV3NetworkingConfigurations.updateAseNetworkingConfiguration::parameters.resource,
  "aseNetworkingConfiguration"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AseV3NetworkingConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AddressResponse.properties);

@@clientName(Sites.createOrUpdate::parameters.resource, "siteEnvelope");
@@clientName(Sites.update::parameters.properties, "siteEnvelope");
@@clientName(Sites.applySlotConfigToProduction::parameters.body,
  "slotSwapEntity"
);
@@clientName(Sites.backup::parameters.body, "request");
@@clientName(Sites.updateApplicationSettings::parameters.body, "appSettings");
@@clientName(Sites.updateAuthSettings::parameters.body, "siteAuthSettings");
@@clientName(Sites.updateAzureStorageAccounts::parameters.body,
  "azureStorageAccounts"
);
@@clientName(Sites.updateBackupConfiguration::parameters.body, "request");
@@clientName(Sites.updateConnectionStrings::parameters.body,
  "connectionStrings"
);
@@clientName(Sites.updateMetadata::parameters.body, "metadata");
@@clientName(Sites.updateSitePushSettings::parameters.body, "pushSettings");
@@clientName(Sites.discoverBackup::parameters.body, "request");
@@clientName(Sites.createOrUpdateHostSecret::parameters.body, "key");
@@clientName(Sites.migrateStorage::parameters.body, "migrationOptions");
@@clientName(Sites.migrateMySql::parameters.body, "migrationRequestEnvelope");
@@clientName(Sites.listPublishingProfileXmlWithSecrets::parameters.body,
  "publishingProfileOptions"
);
@@clientName(Sites.restoreFromBackupBlob::parameters.body, "request");
@@clientName(Sites.restoreFromDeletedApp::parameters.body, "restoreRequest");
@@clientName(Sites.restoreSnapshot::parameters.body, "restoreRequest");
@@clientName(Sites.listSlotDifferencesFromProduction::parameters.body,
  "slotSwapEntity"
);
@@clientName(Sites.swapSlotWithProduction::parameters.body, "slotSwapEntity");
@@clientName(Sites.regenerateAccessKey::parameters.body, "keyType");
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Site.properties);

@@clientName(WorkerPoolResources.createOrUpdateMultiRolePool::parameters.resource,
  "multiRolePoolEnvelope"
);
@@clientName(WorkerPoolResources.updateMultiRolePool::parameters.properties,
  "multiRolePoolEnvelope"
);
@@clientName(AppServiceEnvironments.createOrUpdateWorkerPool::parameters.resource,
  "workerPoolEnvelope"
);
@@clientName(AppServiceEnvironments.updateWorkerPool::parameters.properties,
  "workerPoolEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkerPoolResource.properties);

@@clientName(RemotePrivateEndpointConnectionARMResources.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "privateEndpointWrapper"
);
@@clientName(StaticSites.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "privateEndpointWrapper"
);
@@clientName(RemotePrivateEndpointConnectionARMResourceOperationGroup.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "privateEndpointWrapper"
);
@@clientName(RemotePrivateEndpointConnectionARMResourceOperationGroup.approveOrRejectPrivateEndpointConnectionSlot::parameters.resource,
  "privateEndpointWrapper"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RemotePrivateEndpointConnectionARMResource.properties);

@@clientName(AppServicePlans.createOrUpdate::parameters.resource,
  "appServicePlan"
);
@@clientName(AppServicePlans.update::parameters.properties, "appServicePlan");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServicePlan.properties);

@@clientName(HybridConnectionOperationGroup.createOrUpdateHybridConnection::parameters.resource,
  "connectionEnvelope"
);
@@clientName(HybridConnectionOperationGroup.updateHybridConnection::parameters.properties,
  "connectionEnvelope"
);
@@clientName(HybridConnectionOperationGroup.createOrUpdateHybridConnectionSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientName(HybridConnectionOperationGroup.updateHybridConnectionSlot::parameters.properties,
  "connectionEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HybridConnection.properties);

@@clientName(HybridConnectionLimitsOperationGroup, "HybridConnectionLimits");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HybridConnectionLimits.properties);

@@clientName(VnetInfoResourceOperationGroup.createOrUpdateVnetConnectionSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientName(VnetInfoResourceOperationGroup.updateVnetConnectionSlot::parameters.properties,
  "connectionEnvelope"
);
@@clientName(VnetInfoResourceOperationGroup.createOrUpdateVnetConnection::parameters.resource,
  "connectionEnvelope"
);
@@clientName(VnetInfoResourceOperationGroup.updateVnetConnection::parameters.properties,
  "connectionEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VnetInfoResource.properties);

@@clientName(VnetRoutes.createOrUpdateVnetRoute::parameters.resource, "route");
@@clientName(VnetRoutes.updateVnetRoute::parameters.properties, "route");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VnetRoute.properties);

@@clientName(VnetGateways.updateVnetGateway::parameters.resource,
  "connectionEnvelope"
);
@@clientName(VnetGatewayOperationGroup.createOrUpdateVnetConnectionGatewaySlot::parameters.resource,
  "connectionEnvelope"
);
@@clientName(VnetGatewayOperationGroup.updateVnetConnectionGatewaySlot::parameters.properties,
  "connectionEnvelope"
);
@@clientName(VnetGatewayOperationGroup.createOrUpdateVnetConnectionGateway::parameters.resource,
  "connectionEnvelope"
);
@@clientName(VnetGatewayOperationGroup.updateVnetConnectionGateway::parameters.properties,
  "connectionEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VnetGateway.properties);

@@clientName(Certificates.createOrUpdate::parameters.resource,
  "certificateEnvelope"
);
@@clientName(Certificates.update::parameters.properties, "certificateEnvelope");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Certificate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeletedSite.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiagnosticCategory.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AnalysisDefinition.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DetectorDefinitionResource.properties);

@@clientName(KubeEnvironments.createOrUpdate::parameters.resource,
  "kubeEnvironmentEnvelope"
);
@@clientName(KubeEnvironments.update::parameters.properties,
  "kubeEnvironmentEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KubeEnvironment.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RecommendationRule.properties);

@@clientName(ResourceHealthMetadataOperationGroup, "ResourceHealthMetadata");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResourceHealthMetadata.properties);

@@clientName(Users.updatePublishingUser::parameters.resource, "userDetails");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(User.properties);

@@clientName(SourceControls.updateSourceControl::parameters.resource,
  "requestMessage"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SourceControl.properties);

@@clientName(Identifiers.createOrUpdateDomainOwnershipIdentifier::parameters.resource,
  "domainOwnershipIdentifier"
);
@@clientName(Identifiers.updateDomainOwnershipIdentifier::parameters.properties,
  "domainOwnershipIdentifier"
);
@@clientName(IdentifierOperationGroup.createOrUpdateDomainOwnershipIdentifierSlot::parameters.resource,
  "domainOwnershipIdentifier"
);
@@clientName(IdentifierOperationGroup.updateDomainOwnershipIdentifierSlot::parameters.properties,
  "domainOwnershipIdentifier"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Identifier.properties);

@@clientName(StaticSiteARMResources.createOrUpdateStaticSite::parameters.resource,
  "staticSiteEnvelope"
);
@@clientName(StaticSiteARMResources.updateStaticSite::parameters.properties,
  "staticSiteEnvelope"
);
@@clientName(StaticSiteARMResources.updateStaticSiteUser::parameters.body,
  "staticSiteUserEnvelope"
);
@@clientName(StaticSiteARMResources.createOrUpdateStaticSiteAppSettings::parameters.body,
  "appSettings"
);
@@clientName(StaticSiteARMResources.createOrUpdateStaticSiteFunctionAppSettings::parameters.body,
  "appSettings"
);
@@clientName(StaticSiteARMResources.createUserRolesInvitationLink::parameters.body,
  "staticSiteUserRolesInvitationEnvelope"
);
@@clientName(StaticSiteARMResources.resetStaticSiteApiKey::parameters.body,
  "resetPropertiesEnvelope"
);
@@clientName(StaticSiteARMResources.createZipDeploymentForStaticSite::parameters.body,
  "staticSiteZipDeploymentEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteARMResource.properties);

@@clientName(StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildAppSettings::parameters.body,
  "appSettings"
);
@@clientName(StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildFunctionAppSettings::parameters.body,
  "appSettings"
);
@@clientName(StaticSiteBuildARMResources.createZipDeploymentForStaticSiteBuild::parameters.body,
  "staticSiteZipDeploymentEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteBuildARMResource.properties);

@@clientName(DatabaseConnections.createOrUpdateBuildDatabaseConnection::parameters.resource,
  "databaseConnectionRequestEnvelope"
);
@@clientName(DatabaseConnections.updateBuildDatabaseConnection::parameters.properties,
  "databaseConnectionRequestEnvelope"
);
@@clientName(DatabaseConnectionOperationGroup.createOrUpdateDatabaseConnection::parameters.resource,
  "databaseConnectionRequestEnvelope"
);
@@clientName(DatabaseConnectionOperationGroup.updateDatabaseConnection::parameters.properties,
  "databaseConnectionRequestEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DatabaseConnection.properties);

@@clientName(StaticSiteUserProvidedFunctionAppARMResources.registerUserProvidedFunctionAppWithStaticSiteBuild::parameters.resource,
  "staticSiteUserProvidedFunctionEnvelope"
);
@@clientName(StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.registerUserProvidedFunctionAppWithStaticSite::parameters.resource,
  "staticSiteUserProvidedFunctionEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteUserProvidedFunctionAppARMResource.properties);

@@clientName(StaticSiteBasicAuthPropertiesARMResources.createOrUpdateBasicAuth::parameters.resource,
  "basicAuthEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteBasicAuthPropertiesARMResource.properties);

@@clientName(StaticSiteCustomDomainOverviewARMResources.createOrUpdateStaticSiteCustomDomain::parameters.resource,
  "staticSiteCustomDomainRequestPropertiesEnvelope"
);
@@clientName(StaticSiteCustomDomainOverviewARMResources.validateCustomDomainCanBeAddedToStaticSite::parameters.body,
  "staticSiteCustomDomainRequestPropertiesEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteCustomDomainOverviewARMResource.properties);

@@clientName(StaticSiteLinkedBackendARMResources.linkBackend::parameters.resource,
  "staticSiteLinkedBackendEnvelope"
);
@@clientName(StaticSiteLinkedBackendARMResources.validateBackend::parameters.body,
  "staticSiteLinkedBackendEnvelope"
);
@@clientName(StaticSiteLinkedBackendARMResourceOperationGroup.linkBackendToBuild::parameters.resource,
  "staticSiteLinkedBackendEnvelope"
);
@@clientName(StaticSiteLinkedBackendARMResourceOperationGroup.validateBackendForBuild::parameters.body,
  "staticSiteLinkedBackendEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StaticSiteLinkedBackendARMResource.properties);

@@clientName(BackupItems.listBackupStatusSecrets::parameters.body, "request");
@@clientName(BackupItems.restore::parameters.body, "request");
@@clientName(BackupItemOperationGroup.listBackupStatusSecretsSlot::parameters.body,
  "request"
);
@@clientName(BackupItemOperationGroup.restoreSlot::parameters.body, "request");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackupItem.properties);

@@clientName(CsmPublishingCredentialsPoliciesEntities.updateFtpAllowed::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);
@@clientName(CsmPublishingCredentialsPoliciesEntityOperationGroup.updateScmAllowed::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);
@@clientName(CsmPublishingCredentialsPoliciesEntityOperationGroup.updateFtpAllowedSlot::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);
@@clientName(CsmPublishingCredentialsPoliciesEntityOperationGroup.updateScmAllowedSlot::parameters.resource,
  "csmPublishingAccessPoliciesEntity"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CsmPublishingCredentialsPoliciesEntity.properties);

@@clientName(SiteConfigResources.createOrUpdateConfiguration::parameters.resource,
  "siteConfig"
);
@@clientName(SiteConfigResources.updateConfiguration::parameters.properties,
  "siteConfig"
);
@@clientName(SiteConfigResourceOperationGroup.createOrUpdateConfigurationSlot::parameters.resource,
  "siteConfig"
);
@@clientName(SiteConfigResourceOperationGroup.updateConfigurationSlot::parameters.properties,
  "siteConfig"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SiteConfigResource.properties);

@@clientName(SiteAuthSettingsV2s.updateAuthSettingsV2::parameters.resource,
  "siteAuthSettingsV2"
);
@@clientName(SiteAuthSettingsV2OperationGroup.updateAuthSettingsV2Slot::parameters.resource,
  "siteAuthSettingsV2"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SiteAuthSettingsV2.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiKVReference.properties);

@@clientName(SiteLogsConfigs.updateDiagnosticLogsConfig::parameters.resource,
  "siteLogsConfig"
);
@@clientName(SiteLogsConfigOperationGroup.updateDiagnosticLogsConfigSlot::parameters.resource,
  "siteLogsConfig"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SiteLogsConfig.properties);

@@clientName(SlotConfigNamesResources.updateSlotConfigurationNames::parameters.resource,
  "slotConfigNames"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SlotConfigNamesResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ContinuousWebJob.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CsmDeploymentStatus.properties);

@@clientName(Deployments.createDeployment::parameters.resource, "deployment");
@@clientName(DeploymentOperationGroup.createDeploymentSlot::parameters.resource,
  "deployment"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Deployment.properties);

@@clientName(MSDeployStatuses.createMSDeployOperation::parameters.resource,
  "MSDeploy"
);
@@clientName(MSDeployStatusOperationGroup.createInstanceMSDeployOperation::parameters.resource,
  "MSDeploy"
);
@@clientName(MSDeployStatusOperationGroup.createMSDeployOperationSlot::parameters.resource,
  "MSDeploy"
);
@@clientName(MSDeployStatusOperationGroup.createInstanceMSDeployOperationSlot::parameters.resource,
  "MSDeploy"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MSDeployStatus.properties);

@@clientName(FunctionEnvelopes.createFunction::parameters.resource,
  "function_envelope"
);
@@clientName(FunctionEnvelopes.createOrUpdateFunctionSecret::parameters.body,
  "key"
);
@@clientName(FunctionEnvelopeOperationGroup.createInstanceFunctionSlot::parameters.resource,
  "function_envelope"
);
@@clientName(FunctionEnvelopeOperationGroup.createOrUpdateFunctionSecretSlot::parameters.body,
  "key"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FunctionEnvelope.properties);

@@clientName(HostNameBindings.createOrUpdateHostNameBinding::parameters.resource,
  "hostNameBinding"
);
@@clientName(HostNameBindingOperationGroup.createOrUpdateHostNameBindingSlot::parameters.resource,
  "hostNameBinding"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HostNameBinding.properties);

@@clientName(RelayServiceConnectionEntities.createOrUpdateRelayServiceConnection::parameters.resource,
  "connectionEnvelope"
);
@@clientName(RelayServiceConnectionEntities.updateRelayServiceConnection::parameters.properties,
  "connectionEnvelope"
);
@@clientName(RelayServiceConnectionEntityOperationGroup.createOrUpdateRelayServiceConnectionSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientName(RelayServiceConnectionEntityOperationGroup.updateRelayServiceConnectionSlot::parameters.properties,
  "connectionEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RelayServiceConnectionEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WebSiteInstanceStatus.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProcessInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProcessModuleInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MigrateMySqlStatus.properties);

@@clientName(SwiftVirtualNetworks.createOrUpdateSwiftVirtualNetworkConnectionWithCheck::parameters.resource,
  "connectionEnvelope"
);
@@clientName(SwiftVirtualNetworks.updateSwiftVirtualNetworkConnectionWithCheck::parameters.properties,
  "connectionEnvelope"
);
@@clientName(SwiftVirtualNetworkOperationGroup.createOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot::parameters.resource,
  "connectionEnvelope"
);
@@clientName(SwiftVirtualNetworkOperationGroup.updateSwiftVirtualNetworkConnectionWithCheckSlot::parameters.properties,
  "connectionEnvelope"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SwiftVirtualNetwork.properties);

@@clientName(NetworkFeaturesOperationGroup, "NetworkFeatures");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkFeatures.properties);

@@clientName(PremierAddOns.addPremierAddOn::parameters.resource,
  "premierAddOn"
);
@@clientName(PremierAddOns.updatePremierAddOn::parameters.properties,
  "premierAddOn"
);
@@clientName(PremierAddOnOperationGroup.addPremierAddOnSlot::parameters.resource,
  "premierAddOn"
);
@@clientName(PremierAddOnOperationGroup.updatePremierAddOnSlot::parameters.properties,
  "premierAddOn"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PremierAddOn.properties);

@@clientName(PrivateAccesses.putPrivateAccessVnet::parameters.resource,
  "access"
);
@@clientName(PrivateAccessOperationGroup.putPrivateAccessVnetSlot::parameters.resource,
  "access"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateAccess.properties);

@@clientName(PublicCertificates.createOrUpdatePublicCertificate::parameters.resource,
  "publicCertificate"
);
@@clientName(PublicCertificateOperationGroup.createOrUpdatePublicCertificateSlot::parameters.resource,
  "publicCertificate"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PublicCertificate.properties);

@@clientName(SiteContainers.createOrUpdateSiteContainer::parameters.resource,
  "request"
);
@@clientName(SiteContainerOperationGroup.createOrUpdateSiteContainerSlot::parameters.resource,
  "request"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SiteContainer.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SiteExtensionInfo.properties);

@@clientName(SiteSourceControls.createOrUpdateSourceControlSlot::parameters.resource,
  "siteSourceControl"
);
@@clientName(SiteSourceControls.updateSourceControlSlot::parameters.properties,
  "siteSourceControl"
);
@@clientName(SiteSourceControlOperationGroup.createOrUpdateSourceControl::parameters.resource,
  "siteSourceControl"
);
@@clientName(SiteSourceControlOperationGroup.updateSourceControl::parameters.properties,
  "siteSourceControl"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SiteSourceControl.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TriggeredWebJob.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TriggeredJobHistory.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WebJob.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowRun.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowRunAction.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowRunActionRepetitionDefinition.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowTrigger.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowTriggerHistory.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowVersion.properties);
