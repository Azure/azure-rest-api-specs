import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Automation;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

// C# compatibility renames
@@usage(AutomationAccount, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(Certificate, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(Connection, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  ConnectionCreateOrUpdateParameters,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  ConnectionCreateOrUpdateProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  ConnectionTypeAssociationProperty,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  ConnectionTypeCreateOrUpdateParameters,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(Credential, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  CredentialCreateOrUpdateParameters,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  CredentialCreateOrUpdateProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(DscConfiguration, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  DscConfigurationAssociationProperty,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  DscConfigurationCreateOrUpdateParameters,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  DscConfigurationCreateOrUpdateProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(DscNode, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(DscNodeConfiguration, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  DscNodeConfigurationCreateOrUpdateParameters,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  DscNodeConfigurationCreateOrUpdateParametersProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(HybridRunbookWorker, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  HybridRunbookWorkerCreateParameters,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  HybridRunbookWorkerCreateOrUpdateParameters,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  HybridRunbookWorkerGroup,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(Job, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(JobCollectionItem, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(Module, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  PrivateEndpointConnection,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(PrivateLinkResource, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(Runbook, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  RunbookCreateOrUpdateParameters,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  RunbookCreateOrUpdateProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(Schedule, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(SourceControl, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(Variable, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(Webhook, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@access(ConnectionTypeAssociationProperty, Access.public, "csharp");
@@access(DscConfigurationAssociationProperty, Access.public, "csharp");
@@clientName(FieldDefinition.type, "FieldDefinitionType", "csharp");
@@clientName(DscNodeProperties.ip, "IP", "csharp");
@@clientName(
  PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(
  AutomationAccounts.regenerateKey,
  "RegenerateKeyAgentRegistrationInformation",
  "csharp"
);
@@clientName(Module, "AutomationModule", "csharp");
@@clientName(Modules, "AutomationAccountModule", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Restore old C# AutomationAccountModule resource and collection names."
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Restore old C# AutomationAccountModule resource and collection names."
@@clientOption(
  Modules.get,
  "resource-name",
  "AutomationAccountModule",
  "csharp"
);
@@clientName(Python2Package, "AutomationAccountPython2Package", "csharp");
@@clientName(Package, "AutomationPackage", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Use an Automation-scoped C# resource name for the Package child resource."
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Use an Automation-scoped C# resource name for the Package child resource."
@@clientOption(Packages.get, "resource-name", "AutomationPackage", "csharp");
@@clientName(Certificate, "AutomationCertificate", "csharp");
@@clientName(Connection, "AutomationConnection", "csharp");
@@clientName(ConnectionType, "AutomationConnectionType", "csharp");
@@clientName(Credential, "AutomationCredential", "csharp");
@@clientName(Job, "AutomationJob", "csharp");
@@clientName(JobSchedule, "AutomationJobSchedule", "csharp");
@@clientName(
  PrivateEndpointConnection,
  "AutomationPrivateEndpointConnection",
  "csharp"
);
@@clientName(Runbook, "AutomationRunbook", "csharp");
@@clientName(Schedule, "AutomationSchedule", "csharp");
@@clientName(SourceControl, "AutomationSourceControl", "csharp");
@@clientName(Variable, "AutomationVariable", "csharp");
@@clientName(Watcher, "AutomationWatcher", "csharp");
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Watcher,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  DeletedAutomationAccount,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  SourceControlSyncJob,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);
@@clientName(Webhook, "AutomationWebhook", "csharp");
@@access(ModuleProvisioningState, Access.internal, "csharp");
@@clientName(
  ModuleProvisioningState,
  "ModuleProvisioningStateGenerated",
  "csharp"
);
@@clientName(
  updateConfiguration,
  "SoftwareUpdateConfigurationSpecificProperties",
  "csharp"
);
@@clientName(
  SUCScheduleProperties,
  "SoftwareUpdateConfigurationScheduleProperties",
  "csharp"
);
@@clientName(
  taskProperties,
  "SoftwareUpdateConfigurationTaskProperties",
  "csharp"
);
@@clientName(TagSettingsProperties, "QueryTagSettingsProperties", "csharp");
@@clientName(AutomationErrorResponse, "AutomationResponseError", "csharp");
@@clientName(ScheduleFrequency, "AutomationScheduleFrequency", "csharp");
@@clientName(SkuNameEnum, "AutomationSkuName", "csharp");
@@clientName(UsageCounterName, "AutomationUsageCounterName", "csharp");
@@clientName(
  AutomationAccountProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(
  AutomationAccountProperties.publicNetworkAccess,
  "IsPublicNetworkAccessAllowed",
  "csharp"
);
@@clientName(
  DscConfigurationProperties.provisioningState,
  "ProvisioningState",
  "csharp"
);
@@clientName(
  DscConfigurationParameter,
  "DscConfigurationParameterDefinition",
  "csharp"
);
@@clientName(ContentSource, "AutomationContentSource", "csharp");
@@clientName(EncryptionProperties, "AutomationEncryptionProperties", "csharp");
@@clientName(GroupTypeEnum, "HybridWorkerGroup", "csharp");
@@clientName(HybridRunbookWorkerProperties.ip, "IP", "csharp");
@@clientName(WorkerType, "HybridWorkerType", "csharp");
@@clientName(HttpStatusCode, "AutomationHttpStatusCode", "csharp");
@@clientName(SourceType, "SourceControlSourceType", "csharp");
@@clientName(TokenType, "SourceControlTokenType", "csharp");
@@clientName(ProvisioningState, "SourceControlProvisioningState", "csharp");
@@clientName(SyncType, "SourceControlSyncType", "csharp");
@@clientName(StreamType, "SourceControlStreamType", "csharp");
@@clientName(CountType, "AutomationCountType", "csharp");
@@clientName(NodeCount, "DscNodeCount", "csharp");
@@clientName(NodeCountProperties, "DscNodeCountProperties", "csharp");
@@clientName(NodeCounts, "DscNodeCountListResult", "csharp");
@@clientName(NodeCountProperties.count, "NameCount", "csharp");
@@clientName(LinuxUpdateClasses, "LinuxUpdateClassification", "csharp");
@@clientName(WindowsUpdateClasses, "WindowsUpdateClassification", "csharp");
@@clientName(
  OperatingSystemType,
  "SoftwareUpdateConfigurationOperatingSystemType",
  "csharp"
);
@@clientName(
  WindowsProperties,
  "WindowsUpdateConfigurationProperties",
  "csharp"
);
@@clientName(LinuxProperties, "LinuxUpdateConfigurationProperties", "csharp");
@@clientName(
  TargetProperties,
  "SoftwareUpdateConfigurationTargetProperties",
  "csharp"
);
@@clientName(AdvancedSchedule, "AutomationAdvancedSchedule", "csharp");
@@clientName(
  AdvancedScheduleMonthlyOccurrence,
  "AutomationAdvancedScheduleMonthlyOccurrence",
  "csharp"
);
@@clientName(KeyVaultProperties, "AutomationKeyVaultProperties", "csharp");
@@clientName(JobStatus, "AutomationJobStatus", "csharp");
@@clientName(FieldDefinition, "AutomationConnectionFieldDefinition", "csharp");
@@clientName(ContentHash, "AutomationContentHash", "csharp");
@@clientName(ContentLink, "AutomationContentLink", "csharp");
@@clientName(RunbookTypeEnum, "AutomationRunbookType", "csharp");
@@clientName(RunbookParameter, "RunbookParameterDefinition", "csharp");
@@clientName(RunbookDraft, "AutomationRunbookDraft", "csharp");
@@clientName(TagOperators, "QueryTagOperator", "csharp");
@@clientName(ScheduleDay, "AutomationDayOfWeek", "csharp");
@@clientName(
  DscConfigurationAssociationProperty.name,
  "ConfigurationName",
  "csharp"
);
@@clientName(
  DscNodeConfigurationAssociationProperty.name,
  "NamePropertiesNodeConfigurationName",
  "csharp"
);
@@clientName(
  DeletedAutomationAccountProperties.location,
  "LocationPropertiesLocation",
  "csharp"
);
@@clientName(CertificateProperties.thumbprint, "ThumbprintString", "csharp");
@@clientName(
  CertificateCreateOrUpdateParameters,
  "AutomationCertificateCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  CertificateCreateOrUpdateProperties.thumbprint,
  "ThumbprintString",
  "csharp"
);
@@clientName(
  AutomationAccounts.nodeCountInformationGet,
  "GetAllNodeCountInformation",
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  AutomationAccounts.nodeCountInformationGet,
  "csharp"
);
@@clientName(
  AutomationAccounts.softwareUpdateConfigurationsList,
  "GetSoftwareUpdateConfigurations",
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  AutomationAccounts.softwareUpdateConfigurationsList,
  "csharp"
);
@@clientName(
  AutomationAccounts.agentRegistrationInformationGet,
  "GetAgentRegistrationInformation",
  "csharp"
);
@@clientName(
  AutomationAccounts.usagesListByAutomationAccount,
  "GetUsages",
  "csharp"
);
@@clientName(
  AutomationAccounts.keysListByAutomationAccount,
  "GetAutomationAccountKeys",
  "csharp"
);
@@pageItems(KeyListResult.keys);
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  AutomationAccounts.keysListByAutomationAccount,
  "csharp"
);
@@clientName(
  AutomationAccounts.jobListByAutomationAccount,
  "GetAutomationJobs",
  "csharp"
);
@@access(AutomationAccounts.jobListByAutomationAccount, Access.internal, "csharp");
@@clientName(
  AutomationAccounts.linkedWorkspaceGet,
  "GetLinkedWorkspace",
  "csharp"
);
@@clientName(AutomationAccounts.generateUri, "GenerateUriWebhook", "csharp");
@@clientName(
  AutomationAccounts.getById,
  "GetSoftwareUpdateConfigurationMachineRun",
  "csharp"
);
@@clientName(
  AutomationAccounts.softwareUpdateConfigurationMachineRunsList,
  "GetSoftwareUpdateConfigurationMachineRuns",
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  AutomationAccounts.softwareUpdateConfigurationMachineRunsList,
  "csharp"
);
@@clientName(
  AutomationAccounts.softwareUpdateConfigurationRunsGetById,
  "GetSoftwareUpdateConfigurationRun",
  "csharp"
);
@@clientName(
  AutomationAccounts.softwareUpdateConfigurationRunsList,
  "GetSoftwareUpdateConfigurationRuns",
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  AutomationAccounts.softwareUpdateConfigurationRunsList,
  "csharp"
);
@@clientName(
  AutomationAccounts.listByAutomationAccount,
  "GetStatistics",
  "csharp"
);
@@clientName(Runbooks.getContent, "GetContentRunbookDraft", "csharp");
@@clientName(Runbooks.replaceContent, "ReplaceContentRunbookDraft", "csharp");
@@clientName(Runbooks.runbookDraftGet, "GetRunbookDraft", "csharp");
@@clientName(Runbooks.undoEdit, "UndoEditRunbookDraft", "csharp");
@@clientName(Runbooks.create, "CreateTestJob", "csharp");
@@clientName(Runbooks.testJobGet, "GetTestJob", "csharp");
@@clientName(Runbooks.testJobStreamsGet, "GetTestJobStream", "csharp");
@@clientName(Runbooks.listByTestJob, "GetTestJobStreams", "csharp");
@@clientName(Runbooks.resume, "ResumeTestJob", "csharp");
@@clientName(Runbooks.stop, "StopTestJob", "csharp");
@@clientName(Runbooks.suspend, "SuspendTestJob", "csharp");
@@clientName(
  AgentRegistrationRegenerateKeyParameter,
  "AgentRegistrationRegenerateKeyContent",
  "csharp"
);
@@clientName(
  AutomationAccountCreateOrUpdateParameters,
  "AutomationAccountCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  ModuleCreateOrUpdateParameters,
  "AutomationAccountModuleCreateOrUpdateContent",
  "csharp"
);
@@clientName(ModuleUpdateParameters, "AutomationAccountModulePatch", "csharp");
@@clientName(
  PythonPackageCreateParameters,
  "AutomationPythonPackageCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  PythonPackageUpdateParameters,
  "AutomationPythonPackagePatch",
  "csharp"
);
@@clientName(Statistics, "AutomationAccountStatistics", "csharp");
@@clientName(
  StatisticsListResult,
  "AutomationAccountStatisticsListResult",
  "csharp"
);
@@clientName(Activity, "AutomationActivity", "csharp");
@@clientName(ActivityListResult, "AutomationActivityListResult", "csharp");
@@clientName(ActivityOutputType, "AutomationActivityOutputType", "csharp");
@@clientName(ActivityOutputType.type, "ActivityOutputType", "csharp");
@@clientName(
  ActivityParameter,
  "AutomationActivityParameterDefinition",
  "csharp"
);
@@clientName(ActivityParameterSet, "AutomationActivityParameterSet", "csharp");
@@clientName(
  ActivityParameterValidationSet,
  "AutomationActivityParameterValidationSet",
  "csharp"
);
@@clientName(
  ConnectionCreateOrUpdateParameters,
  "AutomationConnectionCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  ConnectionTypeCreateOrUpdateParameters,
  "AutomationConnectionTypeCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  CredentialCreateOrUpdateParameters,
  "AutomationCredentialCreateOrUpdateContent",
  "csharp"
);
@@clientName(JobCollectionItem, "AutomationJobCollectionItemData", "csharp");
@@clientName(
  JobCreateParameters,
  "AutomationJobCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  JobScheduleCreateParameters,
  "AutomationJobScheduleCreateOrUpdateContent",
  "csharp"
);
@@clientName(JobStream, "AutomationJobStream", "csharp");
@@clientName(JobStreamType, "AutomationJobStreamType", "csharp");
@@clientName(Jobs.jobStreamGet, "GetJobStream", "csharp");
@@clientName(Jobs.listByJob, "GetJobStreams", "csharp");
@@clientName(Key, "AutomationKey", "csharp");
@@clientName(AutomationKeyPermissions, "AutomationKeyPermission", "csharp");
@@clientName(KeyListResult, "AutomationKeyListResult", "csharp");
@@clientName(LinkedWorkspace, "AutomationLinkedWorkspace", "csharp");
@@clientName(ModuleErrorInfo, "AutomationModuleErrorInfo", "csharp");
@@clientName(TypeField, "AutomationModuleField", "csharp");
@@clientName(TypeFieldListResult, "AutomationModuleFieldListResult", "csharp");
@@clientName(
  RunbookCreateOrUpdateParameters,
  "AutomationRunbookCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  ScheduleCreateOrUpdateParameters,
  "AutomationScheduleCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  SourceControlCreateOrUpdateParameters,
  "AutomationSourceControlCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  VariableCreateOrUpdateParameters,
  "AutomationVariableCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  WebhookCreateOrUpdateParameters,
  "AutomationWebhookCreateOrUpdateContent",
  "csharp"
);
@@clientName(ContentSourceType, "AutomationContentSourceType", "csharp");
@@clientName(
  DscConfigurationCreateOrUpdateParameters,
  "DscConfigurationCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  DscNodeConfigurationCreateOrUpdateParameters,
  "DscNodeConfigurationCreateOrUpdateContent",
  "csharp"
);
@@clientName(TestJob, "RunbookTestJob", "csharp");
@@clientName(TestJobCreateParameters, "RunbookTestJobCreateContent", "csharp");
@@clientName(SourceControlSyncJobById, "SourceControlSyncJobResult", "csharp");
@@clientLocation(
  SourceControls.create,
  "SourceControlSyncJobOperations",
  "csharp"
);
@@clientLocation(
  SourceControls.sourceControlSyncJobGet,
  "SourceControlSyncJobOperations",
  "csharp"
);
@@clientLocation(
  SourceControls.sourceControlSyncJobListByAutomationAccount,
  "SourceControlSyncJobOperations",
  "csharp"
);
@@clientName(SourceControls.create, "CreateSourceControlSyncJob", "csharp");
@@clientName(
  SourceControls.sourceControlSyncJobGet,
  "GetSourceControlSyncJob",
  "csharp"
);
@@clientName(
  SourceControls.sourceControlSyncJobListByAutomationAccount,
  "GetSourceControlSyncJobs",
  "csharp"
);
@@clientName(
  SourceControls.sourceControlSyncJobStreamsGet,
  "GetSourceControlSyncJobStream",
  "csharp"
);
@@clientName(
  SourceControls.listBySyncJob,
  "GetSourceControlSyncJobStreams",
  "csharp"
);
@@clientName(
  SourceControlSyncJobStreamById,
  "SourceControlSyncJobStreamResult",
  "csharp"
);
@@clientName(
  SourceControlSyncJobStreamsListBySyncJob,
  "SourceControlSyncJobStreamListResult",
  "csharp"
);
@@clientName(
  SourceControlSyncJobCreateParameters,
  "SourceControlSyncJobCreateContent",
  "csharp"
);
@@clientName(
  PackageCreateOrUpdateParameters,
  "AutomationPackageCreateOrUpdateContent",
  "csharp"
);
@@clientName(PackageCreateOrUpdateParameters.allOf, "TrackedResource", "csharp");
@@clientName(PackageUpdateParameters, "AutomationPackagePatch", "csharp");
@@clientName(PackageUpdateParameters.allOf, "TrackedResource", "csharp");
@@clientName(PackageProperties.allOf, "ResourceSystemData", "csharp");
@@clientName(PackageErrorInfo, "AutomationPackageErrorInfo", "csharp");
@@clientName(
  PackageProvisioningState,
  "AutomationPackageProvisioningState",
  "csharp"
);
@@clientName(
  HybridRunbookWorkerMoveParameters,
  "HybridRunbookWorkerMoveContent",
  "csharp"
);
@@clientName(
  AutomationAccountUpdateProperties.publicNetworkAccess,
  "IsPublicNetworkAccessAllowed",
  "csharp"
);
@@clientName(
  AutomationAccountUpdateProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(
  AutomationAccountCreateOrUpdateProperties.publicNetworkAccess,
  "IsPublicNetworkAccessAllowed",
  "csharp"
);
@@clientName(
  AutomationAccountCreateOrUpdateProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(PackageProperties.default, "IsDefault", "csharp");
@@clientName(
  DscConfigurationProperties.logVerbose,
  "IsLogVerboseEnabled",
  "csharp"
);
@@clientName(
  DscConfigurationCreateOrUpdateProperties.logVerbose,
  "IsLogVerboseEnabled",
  "csharp"
);
@@clientName(
  DscConfigurationCreateOrUpdateProperties.logProgress,
  "IsLogProgressEnabled",
  "csharp"
);
@@clientName(
  DscNodeConfigurationProperties.incrementNodeConfigurationBuild,
  "IsIncrementNodeConfigurationBuildRequired",
  "csharp"
);
@@clientName(
  DscNodeConfigurationCreateOrUpdateParametersProperties.incrementNodeConfigurationBuild,
  "IsIncrementNodeConfigurationBuildRequired",
  "csharp"
);
@@clientName(DscNodeReport.type, "DscNodeReportType", "csharp");
@@clientName(DscNodes.getContent, "GetContentNodeReport", "csharp");
@@clientName(DscNodes.nodeReportsGet, "GetNodeReport", "csharp");
@@clientName(DscNodes.listByNode, "GetNodeReportsByNode", "csharp");
@@clientName(RunbookProperties.logVerbose, "IsLogVerboseEnabled", "csharp");
@@clientName(RunbookProperties.logProgress, "IsLogProgressEnabled", "csharp");
@@clientName(
  RunbookCreateOrUpdateProperties.logVerbose,
  "IsLogVerboseEnabled",
  "csharp"
);
@@clientName(
  RunbookCreateOrUpdateProperties.logProgress,
  "IsLogProgressEnabled",
  "csharp"
);
@@clientName(RunbookDraft.inEdit, "IsInEditMode", "csharp");
@@clientName(
  RunbookUpdateProperties.logVerbose,
  "IsLogVerboseEnabled",
  "csharp"
);
@@clientName(
  RunbookUpdateProperties.logProgress,
  "IsLogProgressEnabled",
  "csharp"
);
@@clientName(
  SourceControlCreateOrUpdateProperties.autoSync,
  "IsAutoSyncEnabled",
  "csharp"
);
@@clientName(
  SourceControlCreateOrUpdateProperties.publishRunbook,
  "IsAutoPublishRunbookEnabled",
  "csharp"
);
@@clientName(SourceControlProperties.autoSync, "IsAutoSyncEnabled", "csharp");
@@clientName(
  SourceControlProperties.publishRunbook,
  "IsAutoPublishRunbookEnabled",
  "csharp"
);
@@clientName(
  SourceControlUpdateProperties.autoSync,
  "IsAutoSyncEnabled",
  "csharp"
);
@@clientName(
  SourceControlUpdateProperties.publishRunbook,
  "IsAutoPublishRunbookEnabled",
  "csharp"
);
@@clientName(
  ActivityParameter.valueFromPipeline,
  "CanTakeValueFromPipeline",
  "csharp"
);
@@clientName(
  ActivityParameter.valueFromPipelineByPropertyName,
  "CanTakeValueFromPipelineByPropertyName",
  "csharp"
);
@@clientName(
  ActivityParameter.valueFromRemainingArguments,
  "CanTakeValueValueFromRemainingArguments",
  "csharp"
);
@@clientName(ActivityParameter.type, "ActivityParameterType", "csharp");
@@clientName(TypeField.type, "FieldType", "csharp");
@@clientName(ContentSource.type, "SourceType", "csharp");
@@clientName(RunbookParameter.type, "RunbookParameterType", "csharp");
@@clientName(
  DscConfigurationParameter.type,
  "DscConfigurationParameterType",
  "csharp"
);
@@clientName(CountType.nodeconfiguration, "NodeConfiguration", "csharp");
@@clientName(TokenType.Oauth, "OAuth", "csharp");
@@clientName(
  WindowsProperties.excludedKbNumbers,
  "ExcludedKBNumbers",
  "csharp"
);
@@clientName(
  WindowsProperties.includedKbNumbers,
  "IncludedKBNumbers",
  "csharp"
);
@@clientName(DscNodeProperties.lastSeen, "LastSeenOn", "csharp");
@@clientName(CertificateProperties.expiryTime, "ExpireOn", "csharp");
@@clientName(
  ScheduleProperties.startTimeOffsetMinutes,
  "StartInMinutes",
  "csharp"
);
@@clientName(ScheduleProperties.expiryTime, "ExpireOn", "csharp");
@@clientName(
  ScheduleProperties.expiryTimeOffsetMinutes,
  "ExpireInMinutes",
  "csharp"
);
@@clientName(ScheduleProperties.nextRun, "NextRunOn", "csharp");
@@clientName(
  ScheduleProperties.nextRunOffsetMinutes,
  "NextRunInMinutes",
  "csharp"
);
@@clientName(
  softwareUpdateConfigurationCollectionItemProperties.nextRun,
  "NextRunOn",
  "csharp"
);
@@clientName(
  SUCScheduleProperties.startTimeOffsetMinutes,
  "StartInMinutes",
  "csharp"
);
@@clientName(SUCScheduleProperties.expiryTime, "ExpireOn", "csharp");
@@clientName(
  SUCScheduleProperties.expiryTimeOffsetMinutes,
  "ExpireInMinutes",
  "csharp"
);
@@clientName(SUCScheduleProperties.nextRun, "NextRunOn", "csharp");
@@clientName(
  SUCScheduleProperties.nextRunOffsetMinutes,
  "NextRunInMinutes",
  "csharp"
);
@@clientName(WebhookProperties.expiryTime, "ExpireOn", "csharp");
@@clientName(WebhookCreateOrUpdateProperties.expiryTime, "ExpireOn", "csharp");
@@clientName(ScheduleCreateOrUpdateProperties.expiryTime, "ExpireOn", "csharp");
@@clientName(JobScheduleProperties.jobScheduleId, "JobScheduleId", "csharp");
@@clientName(
  updateConfigurationMachineRunProperties.targetComputer,
  "TargetComputerId",
  "csharp"
);
@@clientName(
  updateConfigurationMachineRunProperties.osType,
  "OSType",
  "csharp"
);
@@clientName(
  softwareUpdateConfigurationRunProperties.osType,
  "OSType",
  "csharp"
);

@@alternateType(
  AutomationAccountProperties.automationHybridServiceUrl,
  url,
  "csharp"
);
@@alternateType(WebhookCreateOrUpdateProperties.uri, url, "csharp");
@@alternateType(WebhookProperties.uri, url, "csharp");
@@alternateType(SourceControlCreateOrUpdateProperties.repoUrl, url, "csharp");
@@alternateType(SourceControlProperties.repoUrl, url, "csharp");
@@alternateType(AutomationAccount.etag, Azure.Core.eTag, "csharp");
@@alternateType(Module.etag, Azure.Core.eTag, "csharp");
@@alternateType(DscConfiguration.etag, Azure.Core.eTag, "csharp");
@@alternateType(DscNodeProperties.etag, Azure.Core.eTag, "csharp");
@@alternateType(Runbook.etag, Azure.Core.eTag, "csharp");
@@alternateType(Watcher.etag, Azure.Core.eTag, "csharp");
@@alternateType(JobSchedule.name, Azure.Core.uuid, "csharp");
@@alternateType(JobScheduleProperties.jobScheduleId, Azure.Core.uuid, "csharp");
@@alternateType(
  SoftwareUpdateConfigurationMachineRunIdParameter.softwareUpdateConfigurationMachineRunId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  SoftwareUpdateConfigurationRunIdParameter.softwareUpdateConfigurationRunId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  SourceControlSyncJobIdParameter.sourceControlSyncJobId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  PrivateEndpointProperty.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DeletedAutomationAccountProperties.automationAccountResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  HybridRunbookWorkerProperties.vmResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  HybridRunbookWorkerCreateOrUpdateParameters.vmResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  AutomationAccountCreateOrUpdateParameters.identity,
  Azure.ResourceManager.ManagedServiceIdentityProperty,
  "csharp"
);
@@alternateType(
  AutomationAccountUpdateParameters.identity,
  Azure.ResourceManager.ManagedServiceIdentityProperty,
  "csharp"
);
@@alternateType(JobProperties.jobId, Azure.Core.uuid, "csharp");
@@visibility(
  JobProperties.provisioningState,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(ModuleUpdateParameters.name, Lifecycle.Read, Lifecycle.Update);
@@visibility(ModuleUpdateParameters.location, Lifecycle.Read, Lifecycle.Update);
@@visibility(ActivityProperties.parameterSets, Lifecycle.Read);
@@visibility(ActivityProperties.outputTypes, Lifecycle.Read);
@@visibility(SourceControlSyncJobStreamByIdProperties.value, Lifecycle.Read);
@@visibility(
  ConnectionCreateOrUpdateProperties.description,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  ConnectionTypeCreateOrUpdateProperties.isGlobal,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  CredentialCreateOrUpdateProperties.description,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  DscConfigurationCreateOrUpdateProperties.description,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  DscConfigurationCreateOrUpdateProperties.logProgress,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  DscConfigurationCreateOrUpdateProperties.logVerbose,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  DscConfigurationCreateOrUpdateProperties.source,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  DscNodeConfigurationCreateOrUpdateParametersProperties.configuration,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  DscNodeConfigurationCreateOrUpdateParametersProperties.source,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  RunbookCreateOrUpdateProperties.description,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  RunbookCreateOrUpdateProperties.draft,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  RunbookCreateOrUpdateProperties.logActivityTrace,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  RunbookCreateOrUpdateProperties.logProgress,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  RunbookCreateOrUpdateProperties.logVerbose,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(
  RunbookCreateOrUpdateProperties.publishContentLink,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@alternateType(JobCollectionItemProperties.jobId, Azure.Core.uuid, "csharp");
@@alternateType(jobNavigation.id, Azure.Core.uuid, "csharp");
@@alternateType(
  softwareUpdateConfigurationRunTaskProperties.jobId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  updateConfigurationMachineRunProperties.targetComputer,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DeletedRunbook.location, Azure.Core.azureLocation, "csharp");
@@alternateType(
  updateConfigurationMachineRunProperties.configuredDuration,
  duration,
  "csharp"
);
@@alternateType(
  softwareUpdateConfigurationRunProperties.configuredDuration,
  duration,
  "csharp"
);
// Model renames
@@clientName(SUCScheduleProperties, "SucScheduleProperties", "java");
@@clientName(
  UserAssignedIdentitiesProperties,
  "IdentityUserAssignedIdentities",
  "java"
);

// Property renames
@@clientName(DscNodeReport.hostName, "hostname", "java");
@@clientName(CredentialProperties.userName, "username", "java");
@@clientName(CredentialCreateOrUpdateProperties.userName, "username", "java");
@@clientName(CredentialUpdateProperties.userName, "username", "java");

// Interface/client renames
@@clientLocation(
  AutomationAccounts.convertGraphRunbookContent,
  "ResourceProviders",
  "java"
);
@@alternateType(
  softwareUpdateConfigurationProperties.error,
  Azure.ResourceManager.CommonTypes.ErrorDetail,
  "java"
);
@@alternateType(
  updateConfigurationMachineRunProperties.error,
  Azure.ResourceManager.CommonTypes.ErrorDetail,
  "java"
);

@@clientName(
  Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ArmErrorResponse",
  "go"
);
@@clientLocation(AutomationAccounts.convertGraphRunbookContent, "Client", "go");

@@clientLocation(
  AutomationAccounts.convertGraphRunbookContent,
  Microsoft.Automation,
  "python,javascript"
);
@@clientLocation(
  deletedAutomationAccountsOperationGroup.listBySubscription,
  "DeletedAutomationAccounts",
  "python"
);
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  deletedAutomationAccountsOperationGroup.listBySubscription,
  "csharp"
);
@@clientName(
  deletedAutomationAccountsOperationGroup.listBySubscription,
  "GetDeletedAutomationAccountsBySubscription",
  "csharp"
);
@@clientName(Modules.activityGet, "GetActivity", "csharp");
@@clientName(Modules.listByModule, "GetActivities", "csharp");
@@clientName(Modules.listByType, "GetFieldsByType", "csharp");
@@clientName(
  AutomationAccounts.automation,
  "AutomationPrivateLinkResources",
  "csharp"
);

@@clientName(AutomationAccounts.automation, "listAutomation", "javascript");
@@clientName(
  UserAssignedIdentitiesProperties,
  "ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties",
  "javascript"
);

namespace Microsoft.Automation {
  using Azure.ResourceManager;

  /**
   * SDK-only compatibility fixed enum for the previous ModuleProvisioningState API.
   */
  enum ModuleProvisioningStateCompatibility {
    Created: "Created",
    Creating: "Creating",
    StartingImportModuleRunbook: "StartingImportModuleRunbook",
    RunningImportModuleRunbook: "RunningImportModuleRunbook",
    ContentRetrieved: "ContentRetrieved",
    ContentDownloaded: "ContentDownloaded",
    ContentValidated: "ContentValidated",
    ConnectionTypeImported: "ConnectionTypeImported",
    ContentStored: "ContentStored",
    ModuleDataStored: "ModuleDataStored",
    ActivitiesStored: "ActivitiesStored",
    ModuleImportRunbookComplete: "ModuleImportRunbookComplete",
    Succeeded: "Succeeded",
    Failed: "Failed",
    Cancelled: "Canceled",
    Updating: "Updating",
  }

  /**
   * SDK-only compatibility extensible enum for the previous DscConfigurationProvisioningState API.
   */
  union DscConfigurationProvisioningStateCompatibility {
    string,
    Succeeded: "Succeeded",
  }

  /**
   * SDK-only compatibility extensible enum for the previous RunbookProvisioningState API.
   */
  union RunbookProvisioningStateCompatibility {
    string,
    Succeeded: "Succeeded",
  }

  @@clientName(
    ModuleProvisioningStateCompatibility,
    "ModuleProvisioningState",
    "csharp"
  );
  @@alternateType(
    ModuleProvisioningState,
    ModuleProvisioningStateCompatibility,
    "csharp"
  );
  @@clientName(
    DscConfigurationProvisioningStateCompatibility,
    "DscConfigurationProvisioningState",
    "csharp"
  );
  @@alternateType(
    DscConfigurationProperties.provisioningState,
    DscConfigurationProvisioningStateCompatibility,
    "csharp"
  );
  @@clientName(
    RunbookProvisioningStateCompatibility,
    "RunbookProvisioningState",
    "csharp"
  );
  @@alternateType(
    RunbookProperties.provisioningState,
    RunbookProvisioningStateCompatibility,
    "csharp"
  );
}
