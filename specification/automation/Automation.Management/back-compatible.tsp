import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Automation;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(softwareUpdateConfigurationCollectionItem.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DeletedAutomationAccount.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateLinkResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DscNodeProperties.nodeConfiguration);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DscNodeUpdateParametersProperties.nodeConfiguration);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AutomationAccountUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AutomationAccountCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DeletedRunbook.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CertificateCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CertificateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ConnectionCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ConnectionUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ConnectionTypeCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CredentialCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CredentialUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DscConfigurationCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DscConfigurationUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DscNodeConfigurationCreateOrUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HybridRunbookWorkerCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HybridRunbookWorkerGroupCreateOrUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(JobCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(JobCollectionItem.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(JobStream.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(JobScheduleCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Activity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ModuleCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ModuleUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PackageCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PackageUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PythonPackageCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RunbookCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RunbookUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RuntimeEnvironmentUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RuntimeEnvironmentProperties.runtime);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ScheduleCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ScheduleUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(softwareUpdateConfigurationMachineRun.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(softwareUpdateConfigurationRun.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SourceControlCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SourceControlUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SourceControlSyncJobCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SourceControlSyncJob.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SourceControlSyncJobById.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SourceControlSyncJobStream.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SourceControlSyncJobStreamById.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VariableCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VariableUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WatcherUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebhookCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebhookUpdateParameters.properties);

@@clientName(SoftwareUpdateConfigurations.create::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(softwareUpdateConfiguration.properties);

@@clientLocation(DscNodes.get, "DscNode");
@@clientLocation(DscNodes.update, "DscNode");
@@clientName(DscNodes.update::parameters.properties, "dscNodeUpdateParameters");
@@clientLocation(DscNodes.delete, "DscNode");
@@clientLocation(DscNodes.listByAutomationAccount, "DscNode");
@@clientLocation(DscNodes.listByNode, "NodeReports");
@@clientLocation(DscNodes.nodeReportsGet, "NodeReports");
@@clientName(DscNodes.nodeReportsGet, "Get");
@@clientLocation(DscNodes.getContent, "NodeReports");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DscNode.properties);

@@clientLocation(AutomationAccounts.get, "AutomationAccount");
@@clientLocation(AutomationAccounts.createOrUpdate, "AutomationAccount");
@@clientName(AutomationAccounts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(AutomationAccounts.update, "AutomationAccount");
@@clientName(AutomationAccounts.update::parameters.properties, "parameters");
@@clientLocation(AutomationAccounts.delete, "AutomationAccount");
@@clientLocation(AutomationAccounts.listByResourceGroup, "AutomationAccount");
@@clientLocation(AutomationAccounts.list, "AutomationAccount");
@@clientLocation(AutomationAccounts.nodeCountInformationGet,
  "NodeCountInformation"
);
@@clientName(AutomationAccounts.nodeCountInformationGet, "Get");
@@clientLocation(AutomationAccounts.softwareUpdateConfigurationsList,
  SoftwareUpdateConfigurations
);
@@clientName(AutomationAccounts.softwareUpdateConfigurationsList, "List");
@@clientLocation(AutomationAccounts.automation, "PrivateLinkResources");
@@clientLocation(AutomationAccounts.agentRegistrationInformationGet,
  "AgentRegistrationInformation"
);
@@clientName(AutomationAccounts.agentRegistrationInformationGet, "Get");
@@clientLocation(AutomationAccounts.regenerateKey,
  "AgentRegistrationInformation"
);
@@clientName(AutomationAccounts.regenerateKey::parameters.body, "parameters");
@@clientLocation(AutomationAccounts.listDeletedRunbooks, "AutomationAccount");
@@clientLocation(AutomationAccounts.listByAutomationAccount, "Statistics");
@@clientLocation(AutomationAccounts.usagesListByAutomationAccount, "Usages");
@@clientName(AutomationAccounts.usagesListByAutomationAccount,
  "ListByAutomationAccount"
);
@@clientLocation(AutomationAccounts.keysListByAutomationAccount, "Keys");
@@clientName(AutomationAccounts.keysListByAutomationAccount,
  "ListByAutomationAccount"
);
@@clientLocation(AutomationAccounts.jobListByAutomationAccount, "Job");
@@clientName(AutomationAccounts.jobListByAutomationAccount,
  "ListByAutomationAccount"
);
@@clientLocation(AutomationAccounts.linkedWorkspaceGet, "LinkedWorkspace");
@@clientName(AutomationAccounts.linkedWorkspaceGet, "Get");
@@clientLocation(AutomationAccounts.listFieldsByType, "ObjectDataTypes");
@@clientLocation(AutomationAccounts.convertGraphRunbookContent, "");
@@clientName(AutomationAccounts.convertGraphRunbookContent,
  "convertGraphRunbookContent"
);
@@clientName(AutomationAccounts.convertGraphRunbookContent::parameters.body,
  "parameters"
);
@@clientLocation(AutomationAccounts.getById,
  "SoftwareUpdateConfigurationMachineRuns"
);
@@clientLocation(AutomationAccounts.softwareUpdateConfigurationMachineRunsList,
  "SoftwareUpdateConfigurationMachineRuns"
);
@@clientName(AutomationAccounts.softwareUpdateConfigurationMachineRunsList,
  "List"
);
@@clientLocation(AutomationAccounts.softwareUpdateConfigurationRunsGetById,
  "SoftwareUpdateConfigurationRuns"
);
@@clientName(AutomationAccounts.softwareUpdateConfigurationRunsGetById,
  "GetById"
);
@@clientLocation(AutomationAccounts.softwareUpdateConfigurationRunsList,
  "SoftwareUpdateConfigurationRuns"
);
@@clientName(AutomationAccounts.softwareUpdateConfigurationRunsList, "List");
@@clientLocation(AutomationAccounts.generateUri, "Webhook");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AutomationAccount.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(Certificates.get, "Certificate");
@@clientLocation(Certificates.createOrUpdate, "Certificate");
@@clientName(Certificates.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Certificates.update, "Certificate");
@@clientName(Certificates.update::parameters.properties, "parameters");
@@clientLocation(Certificates.delete, "Certificate");
@@clientLocation(Certificates.listByAutomationAccount, "Certificate");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Certificate.properties);

@@clientLocation(Connections.get, "Connection");
@@clientLocation(Connections.createOrUpdate, "Connection");
@@clientName(Connections.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Connections.update, "Connection");
@@clientName(Connections.update::parameters.properties, "parameters");
@@clientLocation(Connections.delete, "Connection");
@@clientLocation(Connections.listByAutomationAccount, "Connection");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Connection.properties);

@@clientLocation(ConnectionTypes.get, "ConnectionType");
@@clientLocation(ConnectionTypes.createOrUpdate, "ConnectionType");
@@clientName(ConnectionTypes.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(ConnectionTypes.delete, "ConnectionType");
@@clientLocation(ConnectionTypes.listByAutomationAccount, "ConnectionType");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ConnectionType.properties);

@@clientLocation(Credentials.get, "Credential");
@@clientLocation(Credentials.createOrUpdate, "Credential");
@@clientName(Credentials.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Credentials.update, "Credential");
@@clientName(Credentials.update::parameters.properties, "parameters");
@@clientLocation(Credentials.delete, "Credential");
@@clientLocation(Credentials.listByAutomationAccount, "Credential");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Credential.properties);

@@clientLocation(DscConfigurations.get, "DscConfiguration");
@@clientLocation(DscConfigurations.createOrUpdate, "DscConfiguration");
@@clientName(DscConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DscConfigurations.update, "DscConfiguration");
@@clientName(DscConfigurations.update::parameters.properties, "parameters");
@@clientLocation(DscConfigurations.delete, "DscConfiguration");
@@clientLocation(DscConfigurations.listByAutomationAccount, "DscConfiguration");
@@clientLocation(DscConfigurations.getContent, "DscConfiguration");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DscConfiguration.properties);

@@clientLocation(DscNodeConfigurations.get, "DscNodeConfiguration");
@@clientLocation(DscNodeConfigurations.createOrUpdate, "DscNodeConfiguration");
@@clientName(DscNodeConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DscNodeConfigurations.delete, "DscNodeConfiguration");
@@clientLocation(DscNodeConfigurations.listByAutomationAccount,
  "DscNodeConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DscNodeConfiguration.properties);

@@clientName(HybridRunbookWorkers.create::parameters.resource,
  "HybridRunbookWorkerCreationParameters"
);
@@clientName(HybridRunbookWorkers.patch::parameters.properties,
  "HybridRunbookWorkerCreationParameters"
);
@@clientName(HybridRunbookWorkers.move::parameters.body,
  "HybridRunbookWorkerMoveParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HybridRunbookWorker.properties);

@@clientLocation(HybridRunbookWorkerGroups.get, "HybridRunbookWorkerGroup");
@@clientLocation(HybridRunbookWorkerGroups.create, "HybridRunbookWorkerGroup");
@@clientName(HybridRunbookWorkerGroups.create::parameters.resource,
  "HybridRunbookWorkerGroupCreationParameters"
);
@@clientLocation(HybridRunbookWorkerGroups.update, "HybridRunbookWorkerGroup");
@@clientName(HybridRunbookWorkerGroups.update::parameters.properties,
  "HybridRunbookWorkerGroupUpdationParameters"
);
@@clientLocation(HybridRunbookWorkerGroups.delete, "HybridRunbookWorkerGroup");
@@clientLocation(HybridRunbookWorkerGroups.listByAutomationAccount,
  "HybridRunbookWorkerGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HybridRunbookWorkerGroup.properties);

@@clientLocation(Jobs.get, "Job");
@@clientLocation(Jobs.create, "Job");
@@clientName(Jobs.create::parameters.resource, "parameters");
@@clientLocation(Jobs.getOutput, "Job");
@@clientLocation(Jobs.getRunbookContent, "Job");
@@clientLocation(Jobs.suspend, "Job");
@@clientLocation(Jobs.stop, "Job");
@@clientLocation(Jobs.resume, "Job");
@@clientLocation(Jobs.jobStreamGet, "JobStream");
@@clientName(Jobs.jobStreamGet, "Get");
@@clientLocation(Jobs.listByJob, "JobStream");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Job.properties);

@@clientLocation(JobSchedules.get, "JobSchedule");
@@clientLocation(JobSchedules.create, "JobSchedule");
@@clientName(JobSchedules.create::parameters.resource, "parameters");
@@clientLocation(JobSchedules.delete, "JobSchedule");
@@clientLocation(JobSchedules.listByAutomationAccount, "JobSchedule");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(JobSchedule.properties);

@@clientLocation(Modules.get, "Module");
@@clientLocation(Modules.createOrUpdate, "Module");
@@clientName(Modules.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Modules.update, "Module");
@@clientName(Modules.update::parameters.properties, "parameters");
@@clientLocation(Modules.delete, "Module");
@@clientLocation(Modules.listByAutomationAccount, "Module");
@@clientLocation(Modules.activityGet, "Activity");
@@clientName(Modules.activityGet, "Get");
@@clientLocation(Modules.listByModule, "Activity");
@@clientLocation(Modules.listFieldsByModuleAndType, "ObjectDataTypes");
@@clientLocation(Modules.listByType, "Fields");
@@clientName(Python2Package.createOrUpdate::parameters.resource, "parameters");
@@clientName(Python2Package.update::parameters.properties, "parameters");
@@clientName(Python3Package.createOrUpdate::parameters.resource, "parameters");
@@clientName(Python3Package.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Module.properties);

@@clientLocation(Packages.get, "Package");
@@clientLocation(Packages.createOrUpdate, "Package");
@@clientName(Packages.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Packages.update, "Package");
@@clientName(Packages.update::parameters.properties, "parameters");
@@clientLocation(Packages.delete, "Package");
@@clientLocation(Packages.listByRuntimeEnvironment, "Package");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Package.properties);

@@clientLocation(Runbooks.get, "Runbook");
@@clientLocation(Runbooks.createOrUpdate, "Runbook");
@@clientName(Runbooks.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Runbooks.update, "Runbook");
@@clientName(Runbooks.update::parameters.properties, "parameters");
@@clientLocation(Runbooks.delete, "Runbook");
@@clientLocation(Runbooks.listByAutomationAccount, "Runbook");
@@clientLocation(Runbooks.getContent, "RunbookDraft");
@@clientLocation(Runbooks.replaceContent, "RunbookDraft");
@@clientName(Runbooks.replaceContent::parameters.body, "runbookContent");
@@clientLocation(Runbooks.runbookDraftGet, "RunbookDraft");
@@clientName(Runbooks.runbookDraftGet, "Get");
@@clientLocation(Runbooks.undoEdit, "RunbookDraft");
@@clientLocation(Runbooks.publish, "Runbook");
@@clientLocation(Runbooks.runbookGetContent, "Runbook");
@@clientName(Runbooks.runbookGetContent, "GetContent");
@@clientLocation(Runbooks.testJobStreamsGet, "TestJobStreams");
@@clientName(Runbooks.testJobStreamsGet, "Get");
@@clientLocation(Runbooks.listByTestJob, "TestJobStreams");
@@clientLocation(Runbooks.create, "TestJob");
@@clientName(Runbooks.create::parameters.body, "parameters");
@@clientLocation(Runbooks.testJobGet, "TestJob");
@@clientName(Runbooks.testJobGet, "Get");
@@clientLocation(Runbooks.resume, "TestJob");
@@clientLocation(Runbooks.stop, "TestJob");
@@clientLocation(Runbooks.suspend, "TestJob");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Runbook.properties);

@@clientName(RuntimeEnvironments.create::parameters.resource, "parameters");
@@clientName(RuntimeEnvironments.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RuntimeEnvironment.properties);

@@clientLocation(Schedules.get, "Schedule");
@@clientLocation(Schedules.createOrUpdate, "Schedule");
@@clientName(Schedules.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Schedules.update, "Schedule");
@@clientName(Schedules.update::parameters.properties, "parameters");
@@clientLocation(Schedules.delete, "Schedule");
@@clientLocation(Schedules.listByAutomationAccount, "Schedule");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Schedule.properties);

@@clientLocation(SourceControls.get, "SourceControl");
@@clientLocation(SourceControls.createOrUpdate, "SourceControl");
@@clientName(SourceControls.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(SourceControls.update, "SourceControl");
@@clientName(SourceControls.update::parameters.properties, "parameters");
@@clientLocation(SourceControls.delete, "SourceControl");
@@clientLocation(SourceControls.listByAutomationAccount, "SourceControl");
@@clientLocation(SourceControls.create, "SourceControlSyncJob");
@@clientLocation(SourceControls.sourceControlSyncJobGet,
  "SourceControlSyncJob"
);
@@clientName(SourceControls.sourceControlSyncJobGet, "Get");
@@clientLocation(SourceControls.sourceControlSyncJobListByAutomationAccount,
  "SourceControlSyncJob"
);
@@clientName(SourceControls.sourceControlSyncJobListByAutomationAccount,
  "ListByAutomationAccount"
);
@@clientLocation(SourceControls.listBySyncJob, "SourceControlSyncJobStreams");
@@clientLocation(SourceControls.sourceControlSyncJobStreamsGet,
  "SourceControlSyncJobStreams"
);
@@clientName(SourceControls.sourceControlSyncJobStreamsGet, "Get");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SourceControl.properties);

@@clientLocation(Variables.get, "Variable");
@@clientLocation(Variables.createOrUpdate, "Variable");
@@clientName(Variables.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Variables.update, "Variable");
@@clientName(Variables.update::parameters.properties, "parameters");
@@clientLocation(Variables.delete, "Variable");
@@clientLocation(Variables.listByAutomationAccount, "Variable");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Variable.properties);

@@clientLocation(Watchers.get, "Watcher");
@@clientLocation(Watchers.createOrUpdate, "Watcher");
@@clientName(Watchers.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Watchers.update, "Watcher");
@@clientName(Watchers.update::parameters.properties, "parameters");
@@clientLocation(Watchers.delete, "Watcher");
@@clientLocation(Watchers.listByAutomationAccount, "Watcher");
@@clientLocation(Watchers.start, "Watcher");
@@clientLocation(Watchers.stop, "Watcher");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Watcher.properties);

@@clientLocation(Webhooks.get, "Webhook");
@@clientLocation(Webhooks.createOrUpdate, "Webhook");
@@clientName(Webhooks.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Webhooks.update, "Webhook");
@@clientName(Webhooks.update::parameters.properties, "parameters");
@@clientLocation(Webhooks.delete, "Webhook");
@@clientLocation(Webhooks.listByAutomationAccount, "Webhook");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Webhook.properties);

@@clientLocation(deletedAutomationAccountsOperationGroup.listBySubscription,
  "deletedAutomationAccounts"
);

@@visibility(Watcher.tags, Lifecycle.Read, Lifecycle.Create, Lifecycle.Update);
