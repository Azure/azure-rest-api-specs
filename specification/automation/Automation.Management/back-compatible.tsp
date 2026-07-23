import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Automation;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(softwareUpdateConfigurationCollectionItem.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DeletedAutomationAccount.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DscNodeProperties.nodeConfiguration);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DscNodeUpdateParametersProperties.nodeConfiguration);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AutomationAccountUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AutomationAccountCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DeletedRunbook.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CertificateCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CertificateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ConnectionCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ConnectionUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ConnectionTypeCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CredentialCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CredentialUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DscConfigurationCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DscConfigurationUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(
  DscNodeConfigurationCreateOrUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HybridRunbookWorkerCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(
  HybridRunbookWorkerGroupCreateOrUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JobCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JobCollectionItem.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JobStream.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JobScheduleCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Activity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ModuleCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ModuleUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PackageCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PackageUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PythonPackageCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RunbookCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RunbookUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RuntimeEnvironmentUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RuntimeEnvironmentProperties.runtime);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ScheduleCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ScheduleUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(softwareUpdateConfigurationMachineRun.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(softwareUpdateConfigurationRun.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SourceControlCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SourceControlUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SourceControlSyncJobCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SourceControlSyncJob.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SourceControlSyncJobById.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SourceControlSyncJobStream.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SourceControlSyncJobStreamById.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VariableCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VariableUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WatcherUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WebhookCreateOrUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WebhookUpdateParameters.properties);

@@clientName(
  SoftwareUpdateConfigurations.create::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(softwareUpdateConfiguration.properties);

@@clientLocation(DscNodes.get, "DscNode", "!javascript");
@@clientLocation(DscNodes.update, "DscNode", "!javascript");
@@clientName(DscNodes.update::parameters.properties, "dscNodeUpdateParameters");
@@clientLocation(DscNodes.delete, "DscNode", "!javascript");
@@clientLocation(DscNodes.listByAutomationAccount, "DscNode", "!javascript");
@@clientLocation(DscNodes.get, "DscNodeOperations", "javascript");
@@clientLocation(DscNodes.update, "DscNodeOperations", "javascript");
@@clientLocation(DscNodes.delete, "DscNodeOperations", "javascript");
@@clientLocation(
  DscNodes.listByAutomationAccount,
  "DscNodeOperations",
  "javascript"
);
@@clientLocation(DscNodes.listByNode, "NodeReports");
@@clientLocation(DscNodes.nodeReportsGet, "NodeReports");
@@clientName(DscNodes.nodeReportsGet, "Get");
@@clientLocation(DscNodes.getContent, "NodeReports");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DscNode.properties);

@@clientLocation(AutomationAccounts.get, "AutomationAccount", "!javascript");
@@clientLocation(
  AutomationAccounts.createOrUpdate,
  "AutomationAccount",
  "!javascript"
);
@@clientLocation(
  AutomationAccounts.get,
  "AutomationAccountOperations",
  "javascript"
);
@@clientLocation(
  AutomationAccounts.createOrUpdate,
  "AutomationAccountOperations",
  "javascript"
);
@@clientName(
  AutomationAccounts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(AutomationAccounts.update, "AutomationAccount", "!javascript");
@@clientName(AutomationAccounts.update::parameters.properties, "parameters");
@@clientLocation(AutomationAccounts.delete, "AutomationAccount", "!javascript");
@@clientLocation(
  AutomationAccounts.listByResourceGroup,
  "AutomationAccount",
  "!javascript"
);
@@clientLocation(AutomationAccounts.list, "AutomationAccount", "!javascript");
@@clientLocation(
  AutomationAccounts.update,
  "AutomationAccountOperations",
  "javascript"
);
@@clientLocation(
  AutomationAccounts.delete,
  "AutomationAccountOperations",
  "javascript"
);
@@clientLocation(
  AutomationAccounts.listByResourceGroup,
  "AutomationAccountOperations",
  "javascript"
);
@@clientLocation(
  AutomationAccounts.list,
  "AutomationAccountOperations",
  "javascript"
);
@@clientLocation(
  AutomationAccounts.nodeCountInformationGet,
  "NodeCountInformation"
);
@@clientName(AutomationAccounts.nodeCountInformationGet, "Get");
@@clientLocation(
  AutomationAccounts.softwareUpdateConfigurationsList,
  SoftwareUpdateConfigurations
);
@@clientName(AutomationAccounts.softwareUpdateConfigurationsList, "List");
@@clientLocation(AutomationAccounts.automation, "PrivateLinkResources");
@@clientLocation(
  AutomationAccounts.agentRegistrationInformationGet,
  "AgentRegistrationInformation"
);
@@clientName(AutomationAccounts.agentRegistrationInformationGet, "Get");
@@clientLocation(
  AutomationAccounts.regenerateKey,
  "AgentRegistrationInformation"
);
@@clientName(AutomationAccounts.regenerateKey::parameters.body, "parameters");
@@clientLocation(
  AutomationAccounts.listDeletedRunbooks,
  "AutomationAccount",
  "!javascript"
);
@@clientLocation(
  AutomationAccounts.listDeletedRunbooks,
  "AutomationAccountOperations",
  "javascript"
);
@@clientLocation(
  AutomationAccounts.listByAutomationAccount,
  "Statistics",
  "!javascript"
);
@@clientLocation(
  AutomationAccounts.listByAutomationAccount,
  "StatisticsOperations",
  "javascript"
);
@@clientLocation(AutomationAccounts.usagesListByAutomationAccount, "Usages");
@@clientName(
  AutomationAccounts.usagesListByAutomationAccount,
  "ListByAutomationAccount"
);
@@clientLocation(AutomationAccounts.keysListByAutomationAccount, "Keys");
@@clientName(
  AutomationAccounts.keysListByAutomationAccount,
  "ListByAutomationAccount"
);
@@clientLocation(
  AutomationAccounts.jobListByAutomationAccount,
  "Job",
  "!javascript"
);
@@clientLocation(
  AutomationAccounts.jobListByAutomationAccount,
  "JobOperations",
  "javascript"
);
@@clientName(
  AutomationAccounts.jobListByAutomationAccount,
  "ListByAutomationAccount"
);
@@clientLocation(
  AutomationAccounts.linkedWorkspaceGet,
  "LinkedWorkspace",
  "!javascript"
);
@@clientLocation(
  AutomationAccounts.linkedWorkspaceGet,
  "LinkedWorkspaceOperations",
  "javascript"
);
@@clientName(AutomationAccounts.linkedWorkspaceGet, "Get");
@@clientLocation(AutomationAccounts.listFieldsByType, "ObjectDataTypes");
@@clientLocation(AutomationAccounts.convertGraphRunbookContent, "");
@@clientName(
  AutomationAccounts.convertGraphRunbookContent,
  "convertGraphRunbookContent"
);
@@clientName(
  AutomationAccounts.convertGraphRunbookContent::parameters.body,
  "parameters"
);
@@clientLocation(
  AutomationAccounts.getById,
  "SoftwareUpdateConfigurationMachineRuns"
);
@@clientLocation(
  AutomationAccounts.softwareUpdateConfigurationMachineRunsList,
  "SoftwareUpdateConfigurationMachineRuns"
);
@@clientName(
  AutomationAccounts.softwareUpdateConfigurationMachineRunsList,
  "List"
);
@@clientLocation(
  AutomationAccounts.softwareUpdateConfigurationRunsGetById,
  "SoftwareUpdateConfigurationRuns"
);
@@clientName(
  AutomationAccounts.softwareUpdateConfigurationRunsGetById,
  "GetById"
);
@@clientLocation(
  AutomationAccounts.softwareUpdateConfigurationRunsList,
  "SoftwareUpdateConfigurationRuns"
);
@@clientName(AutomationAccounts.softwareUpdateConfigurationRunsList, "List");
@@clientLocation(AutomationAccounts.generateUri, "Webhook", "!javascript");
@@clientLocation(
  AutomationAccounts.generateUri,
  "WebhookOperations",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AutomationAccount.properties);

@@clientName(
  PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(Certificates.get, "Certificate", "!javascript");
@@clientLocation(Certificates.createOrUpdate, "Certificate", "!javascript");
@@clientName(Certificates.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Certificates.update, "Certificate", "!javascript");
@@clientName(Certificates.update::parameters.properties, "parameters");
@@clientLocation(Certificates.delete, "Certificate", "!javascript");
@@clientLocation(
  Certificates.listByAutomationAccount,
  "Certificate",
  "!javascript"
);
@@clientLocation(Certificates.get, "CertificateOperations", "javascript");
@@clientLocation(
  Certificates.createOrUpdate,
  "CertificateOperations",
  "javascript"
);
@@clientLocation(Certificates.update, "CertificateOperations", "javascript");
@@clientLocation(Certificates.delete, "CertificateOperations", "javascript");
@@clientLocation(
  Certificates.listByAutomationAccount,
  "CertificateOperations",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Certificate.properties);

@@clientLocation(Connections.get, "Connection", "!javascript");
@@clientLocation(Connections.createOrUpdate, "Connection", "!javascript");
@@clientName(Connections.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Connections.update, "Connection", "!javascript");
@@clientName(Connections.update::parameters.properties, "parameters");
@@clientLocation(Connections.delete, "Connection", "!javascript");
@@clientLocation(
  Connections.listByAutomationAccount,
  "Connection",
  "!javascript"
);
@@clientLocation(Connections.get, "ConnectionOperations", "javascript");
@@clientLocation(
  Connections.createOrUpdate,
  "ConnectionOperations",
  "javascript"
);
@@clientLocation(Connections.update, "ConnectionOperations", "javascript");
@@clientLocation(Connections.delete, "ConnectionOperations", "javascript");
@@clientLocation(
  Connections.listByAutomationAccount,
  "ConnectionOperations",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Connection.properties);

@@clientLocation(ConnectionTypes.get, "ConnectionType", "!javascript");
@@clientLocation(
  ConnectionTypes.createOrUpdate,
  "ConnectionType",
  "!javascript"
);
@@clientName(ConnectionTypes.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(ConnectionTypes.delete, "ConnectionType", "!javascript");
@@clientLocation(
  ConnectionTypes.listByAutomationAccount,
  "ConnectionType",
  "!javascript"
);
@@clientLocation(ConnectionTypes.get, "ConnectionTypeOperations", "javascript");
@@clientLocation(
  ConnectionTypes.createOrUpdate,
  "ConnectionTypeOperations",
  "javascript"
);
@@clientLocation(
  ConnectionTypes.delete,
  "ConnectionTypeOperations",
  "javascript"
);
@@clientLocation(
  ConnectionTypes.listByAutomationAccount,
  "ConnectionTypeOperations",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ConnectionType.properties);

@@clientLocation(Credentials.get, "Credential", "!javascript");
@@clientLocation(Credentials.createOrUpdate, "Credential", "!javascript");
@@clientName(Credentials.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Credentials.update, "Credential", "!javascript");
@@clientName(Credentials.update::parameters.properties, "parameters");
@@clientLocation(Credentials.delete, "Credential", "!javascript");
@@clientLocation(
  Credentials.listByAutomationAccount,
  "Credential",
  "!javascript"
);
@@clientLocation(Credentials.get, "CredentialOperations", "javascript");
@@clientLocation(
  Credentials.createOrUpdate,
  "CredentialOperations",
  "javascript"
);
@@clientLocation(Credentials.update, "CredentialOperations", "javascript");
@@clientLocation(Credentials.delete, "CredentialOperations", "javascript");
@@clientLocation(
  Credentials.listByAutomationAccount,
  "CredentialOperations",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Credential.properties);

@@clientLocation(DscConfigurations.get, "DscConfiguration", "!javascript");
@@clientLocation(
  DscConfigurations.createOrUpdate,
  "DscConfiguration",
  "!javascript"
);
@@clientName(
  DscConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DscConfigurations.update, "DscConfiguration", "!javascript");
@@clientName(DscConfigurations.update::parameters.properties, "parameters");
@@clientLocation(DscConfigurations.delete, "DscConfiguration", "!javascript");
@@clientLocation(
  DscConfigurations.listByAutomationAccount,
  "DscConfiguration",
  "!javascript"
);
@@clientLocation(
  DscConfigurations.getContent,
  "DscConfiguration",
  "!javascript"
);
@@clientLocation(
  DscConfigurations.get,
  "DscConfigurationOperations",
  "javascript"
);
@@clientLocation(
  DscConfigurations.createOrUpdate,
  "DscConfigurationOperations",
  "javascript"
);
@@clientLocation(
  DscConfigurations.update,
  "DscConfigurationOperations",
  "javascript"
);
@@clientLocation(
  DscConfigurations.delete,
  "DscConfigurationOperations",
  "javascript"
);
@@clientLocation(
  DscConfigurations.listByAutomationAccount,
  "DscConfigurationOperations",
  "javascript"
);
@@clientLocation(
  DscConfigurations.getContent,
  "DscConfigurationOperations",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DscConfiguration.properties);

@@clientLocation(
  DscNodeConfigurations.get,
  "DscNodeConfiguration",
  "!javascript"
);
@@clientLocation(
  DscNodeConfigurations.createOrUpdate,
  "DscNodeConfiguration",
  "!javascript"
);
@@clientName(
  DscNodeConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  DscNodeConfigurations.delete,
  "DscNodeConfiguration",
  "!javascript"
);
@@clientLocation(
  DscNodeConfigurations.listByAutomationAccount,
  "DscNodeConfiguration",
  "!javascript"
);
@@clientLocation(
  DscNodeConfigurations.get,
  "DscNodeConfigurationOperations",
  "javascript"
);
@@clientLocation(
  DscNodeConfigurations.createOrUpdate,
  "DscNodeConfigurationOperations",
  "javascript"
);
@@clientLocation(
  DscNodeConfigurations.delete,
  "DscNodeConfigurationOperations",
  "javascript"
);
@@clientLocation(
  DscNodeConfigurations.listByAutomationAccount,
  "DscNodeConfiguration",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DscNodeConfiguration.properties);

@@clientName(
  HybridRunbookWorkers.create::parameters.resource,
  "HybridRunbookWorkerCreationParameters"
);
@@clientName(
  HybridRunbookWorkers.patch::parameters.properties,
  "HybridRunbookWorkerCreationParameters"
);
@@clientName(
  HybridRunbookWorkers.move::parameters.body,
  "HybridRunbookWorkerMoveParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HybridRunbookWorker.properties);

@@clientLocation(
  HybridRunbookWorkerGroups.get,
  "HybridRunbookWorkerGroup",
  "!javascript"
);
@@clientLocation(
  HybridRunbookWorkerGroups.create,
  "HybridRunbookWorkerGroup",
  "!javascript"
);
@@clientName(
  HybridRunbookWorkerGroups.create::parameters.resource,
  "HybridRunbookWorkerGroupCreationParameters"
);
@@clientLocation(
  HybridRunbookWorkerGroups.update,
  "HybridRunbookWorkerGroup",
  "!javascript"
);
@@clientName(
  HybridRunbookWorkerGroups.update::parameters.properties,
  "HybridRunbookWorkerGroupUpdationParameters"
);
@@clientLocation(
  HybridRunbookWorkerGroups.delete,
  "HybridRunbookWorkerGroup",
  "!javascript"
);
@@clientLocation(
  HybridRunbookWorkerGroups.listByAutomationAccount,
  "HybridRunbookWorkerGroup",
  "!javascript"
);
@@clientLocation(
  HybridRunbookWorkerGroups.get,
  "HybridRunbookWorkerGroupOperations",
  "javascript"
);
@@clientLocation(
  HybridRunbookWorkerGroups.create,
  "HybridRunbookWorkerGroupOperations",
  "javascript"
);
@@clientLocation(
  HybridRunbookWorkerGroups.update,
  "HybridRunbookWorkerGroupOperations",
  "javascript"
);
@@clientLocation(
  HybridRunbookWorkerGroups.delete,
  "HybridRunbookWorkerGroupOperations",
  "javascript"
);
@@clientLocation(
  HybridRunbookWorkerGroups.listByAutomationAccount,
  "HybridRunbookWorkerGroupOperations",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HybridRunbookWorkerGroup.properties);

@@clientLocation(Jobs.get, "Job", "!javascript");
@@clientLocation(Jobs.create, "Job", "!javascript");
@@clientName(Jobs.create::parameters.resource, "parameters");
@@clientLocation(Jobs.getOutput, "Job", "!javascript");
@@clientLocation(Jobs.getRunbookContent, "Job", "!javascript");
@@clientLocation(Jobs.suspend, "Job", "!javascript");
@@clientLocation(Jobs.stop, "Job", "!javascript");
@@clientLocation(Jobs.resume, "Job", "!javascript");
@@clientLocation(Jobs.get, "JobOperations", "javascript");
@@clientLocation(Jobs.create, "JobOperations", "javascript");
@@clientLocation(Jobs.getOutput, "JobOperations", "javascript");
@@clientLocation(Jobs.getRunbookContent, "JobOperations", "javascript");
@@clientLocation(Jobs.suspend, "JobOperations", "javascript");
@@clientLocation(Jobs.stop, "JobOperations", "javascript");
@@clientLocation(Jobs.resume, "JobOperations", "javascript");
@@clientLocation(Jobs.jobStreamGet, "JobStream", "!javascript");
@@clientName(Jobs.jobStreamGet, "Get");
@@clientLocation(Jobs.listByJob, "JobStream", "!javascript");
@@clientLocation(Jobs.jobStreamGet, "JobStreamOperations", "javascript");
@@clientLocation(Jobs.listByJob, "JobStreamOperations", "javascript");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Job.properties);

@@clientLocation(JobSchedules.get, "JobSchedule", "!javascript");
@@clientLocation(JobSchedules.create, "JobSchedule", "!javascript");
@@clientName(JobSchedules.create::parameters.resource, "parameters");
@@clientLocation(JobSchedules.delete, "JobSchedule", "!javascript");
@@clientLocation(
  JobSchedules.listByAutomationAccount,
  "JobSchedule",
  "!javascript"
);
@@clientLocation(JobSchedules.get, "JobScheduleOperations", "javascript");
@@clientLocation(JobSchedules.create, "JobScheduleOperations", "javascript");
@@clientLocation(JobSchedules.delete, "JobScheduleOperations", "javascript");
@@clientLocation(
  JobSchedules.listByAutomationAccount,
  "JobScheduleOperations",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JobSchedule.properties);

@@clientLocation(Modules.get, "Module", "!javascript");
@@clientLocation(Modules.createOrUpdate, "Module", "!javascript");
@@clientName(Modules.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Modules.update, "Module", "!javascript");
@@clientName(Modules.update::parameters.properties, "parameters");
@@clientLocation(Modules.delete, "Module", "!javascript");
@@clientLocation(Modules.listByAutomationAccount, "Module", "!javascript");
@@clientLocation(Modules.get, "ModuleOperations", "javascript");
@@clientLocation(Modules.createOrUpdate, "ModuleOperations", "javascript");
@@clientLocation(Modules.update, "ModuleOperations", "javascript");
@@clientLocation(Modules.delete, "ModuleOperations", "javascript");
@@clientLocation(
  Modules.listByAutomationAccount,
  "ModuleOperations",
  "javascript"
);
@@clientLocation(Modules.activityGet, "Activity", "!javascript");
@@clientName(Modules.activityGet, "Get");
@@clientLocation(Modules.listByModule, "Activity", "!javascript");
@@clientLocation(Modules.activityGet, "ActivityOperations", "javascript");
@@clientLocation(Modules.listByModule, "ActivityOperations", "javascript");
@@clientLocation(Modules.listFieldsByModuleAndType, "ObjectDataTypes");
@@clientLocation(Modules.listByType, "Fields");
@@clientName(Python2Package.createOrUpdate::parameters.resource, "parameters");
@@clientName(Python2Package.update::parameters.properties, "parameters");
@@clientName(Python3Package.createOrUpdate::parameters.resource, "parameters");
@@clientName(Python3Package.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Module.properties);

@@clientLocation(Packages.get, "Package");
@@clientLocation(Packages.createOrUpdate, "Package");
@@clientName(Packages.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Packages.update, "Package");
@@clientName(Packages.update::parameters.properties, "parameters");
@@clientLocation(Packages.delete, "Package");
@@clientLocation(Packages.listByRuntimeEnvironment, "Package");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Package.properties);

@@clientLocation(Runbooks.get, "Runbook", "!javascript");
@@clientLocation(Runbooks.createOrUpdate, "Runbook", "!javascript");
@@clientName(Runbooks.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Runbooks.update, "Runbook", "!javascript");
@@clientName(Runbooks.update::parameters.properties, "parameters");
@@clientLocation(Runbooks.delete, "Runbook", "!javascript");
@@clientLocation(Runbooks.listByAutomationAccount, "Runbook", "!javascript");
@@clientLocation(Runbooks.get, "RunbookOperations", "javascript");
@@clientLocation(Runbooks.createOrUpdate, "RunbookOperations", "javascript");
@@clientLocation(Runbooks.update, "RunbookOperations", "javascript");
@@clientLocation(Runbooks.delete, "RunbookOperations", "javascript");
@@clientLocation(
  Runbooks.listByAutomationAccount,
  "RunbookOperations",
  "javascript"
);
@@clientLocation(Runbooks.getContent, "RunbookDraft", "!javascript");
@@clientLocation(Runbooks.replaceContent, "RunbookDraft", "!javascript");
@@clientLocation(Runbooks.runbookDraftGet, "RunbookDraft", "!javascript");
@@clientName(Runbooks.runbookDraftGet, "Get");
@@clientLocation(Runbooks.undoEdit, "RunbookDraft", "!javascript");
@@clientLocation(Runbooks.getContent, "RunbookDraftOperations", "javascript");
@@clientLocation(
  Runbooks.replaceContent,
  "RunbookDraftOperations",
  "javascript"
);
@@clientLocation(
  Runbooks.runbookDraftGet,
  "RunbookDraftOperations",
  "javascript"
);
@@clientLocation(Runbooks.undoEdit, "RunbookDraftOperations", "javascript");
@@clientLocation(Runbooks.publish, "Runbook");
@@clientLocation(Runbooks.runbookGetContent, "Runbook");
@@clientName(Runbooks.runbookGetContent, "GetContent");
@@clientLocation(Runbooks.testJobStreamsGet, "TestJobStreams");
@@clientName(Runbooks.testJobStreamsGet, "Get");
@@clientLocation(Runbooks.listByTestJob, "TestJobStreams");
@@clientLocation(Runbooks.create, "TestJob", "!javascript");
@@clientName(Runbooks.create::parameters.body, "parameters");
@@clientLocation(Runbooks.testJobGet, "TestJob", "!javascript");
@@clientName(Runbooks.testJobGet, "Get");
@@clientLocation(Runbooks.resume, "TestJob", "!javascript");
@@clientLocation(Runbooks.stop, "TestJob", "!javascript");
@@clientLocation(Runbooks.suspend, "TestJob", "!javascript");
@@clientLocation(Runbooks.create, "TestJobOperations", "javascript");
@@clientLocation(Runbooks.testJobGet, "TestJobOperations", "javascript");
@@clientLocation(Runbooks.resume, "TestJobOperations", "javascript");
@@clientLocation(Runbooks.stop, "TestJobOperations", "javascript");
@@clientLocation(Runbooks.suspend, "TestJobOperations", "javascript");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Runbook.properties);

@@clientName(RuntimeEnvironments.create::parameters.resource, "parameters");
@@clientName(RuntimeEnvironments.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RuntimeEnvironment.properties);

@@clientLocation(Schedules.get, "Schedule", "!javascript");
@@clientLocation(Schedules.createOrUpdate, "Schedule", "!javascript");
@@clientName(Schedules.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Schedules.update, "Schedule", "!javascript");
@@clientName(Schedules.update::parameters.properties, "parameters");
@@clientLocation(Schedules.delete, "Schedule", "!javascript");
@@clientLocation(Schedules.listByAutomationAccount, "Schedule", "!javascript");
@@clientLocation(Schedules.get, "ScheduleOperations", "javascript");
@@clientLocation(Schedules.createOrUpdate, "ScheduleOperations", "javascript");
@@clientLocation(Schedules.update, "ScheduleOperations", "javascript");
@@clientLocation(Schedules.delete, "ScheduleOperations", "javascript");
@@clientLocation(
  Schedules.listByAutomationAccount,
  "ScheduleOperations",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Schedule.properties);

@@clientLocation(SourceControls.get, "SourceControl", "!javascript");
@@clientLocation(SourceControls.createOrUpdate, "SourceControl", "!javascript");
@@clientName(SourceControls.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(SourceControls.update, "SourceControl", "!javascript");
@@clientName(SourceControls.update::parameters.properties, "parameters");
@@clientLocation(SourceControls.delete, "SourceControl", "!javascript");
@@clientLocation(
  SourceControls.listByAutomationAccount,
  "SourceControl",
  "!javascript"
);
@@clientLocation(SourceControls.get, "SourceControlOperations", "javascript");
@@clientLocation(
  SourceControls.createOrUpdate,
  "SourceControlOperations",
  "javascript"
);
@@clientLocation(
  SourceControls.update,
  "SourceControlOperations",
  "javascript"
);
@@clientLocation(
  SourceControls.delete,
  "SourceControlOperations",
  "javascript"
);
@@clientLocation(
  SourceControls.listByAutomationAccount,
  "SourceControlOperations",
  "javascript"
);
@@clientLocation(SourceControls.create, "SourceControlSyncJob", "!javascript");
@@clientLocation(
  SourceControls.sourceControlSyncJobGet,
  "SourceControlSyncJob",
  "!javascript"
);
@@clientName(SourceControls.sourceControlSyncJobGet, "Get");
@@clientLocation(
  SourceControls.sourceControlSyncJobListByAutomationAccount,
  "SourceControlSyncJob",
  "!javascript"
);
@@clientLocation(
  SourceControls.create,
  "SourceControlSyncJobOperations",
  "javascript"
);
@@clientLocation(
  SourceControls.sourceControlSyncJobGet,
  "SourceControlSyncJobOperations",
  "javascript"
);
@@clientLocation(
  SourceControls.sourceControlSyncJobListByAutomationAccount,
  "SourceControlSyncJobOperations",
  "javascript"
);
@@clientName(
  SourceControls.sourceControlSyncJobListByAutomationAccount,
  "ListByAutomationAccount"
);
@@clientLocation(SourceControls.listBySyncJob, "SourceControlSyncJobStreams");
@@clientLocation(
  SourceControls.sourceControlSyncJobStreamsGet,
  "SourceControlSyncJobStreams"
);
@@clientName(SourceControls.sourceControlSyncJobStreamsGet, "Get");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SourceControl.properties);

@@clientLocation(Variables.get, "Variable", "!javascript");
@@clientLocation(Variables.createOrUpdate, "Variable", "!javascript");
@@clientName(Variables.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Variables.update, "Variable", "!javascript");
@@clientName(Variables.update::parameters.properties, "parameters");
@@clientLocation(Variables.delete, "Variable", "!javascript");
@@clientLocation(Variables.listByAutomationAccount, "Variable", "!javascript");
@@clientLocation(Variables.get, "VariableOperations", "javascript");
@@clientLocation(Variables.createOrUpdate, "VariableOperations", "javascript");
@@clientLocation(Variables.update, "VariableOperations", "javascript");
@@clientLocation(Variables.delete, "VariableOperations", "javascript");
@@clientLocation(
  Variables.listByAutomationAccount,
  "VariableOperations",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Variable.properties);

@@clientLocation(Watchers.get, "Watcher", "!javascript");
@@clientLocation(Watchers.createOrUpdate, "Watcher", "!javascript");
@@clientName(Watchers.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Watchers.update, "Watcher", "!javascript");
@@clientName(Watchers.update::parameters.properties, "parameters");
@@clientLocation(Watchers.delete, "Watcher", "!javascript");
@@clientLocation(Watchers.listByAutomationAccount, "Watcher", "!javascript");
@@clientLocation(Watchers.start, "Watcher", "!javascript");
@@clientLocation(Watchers.stop, "Watcher", "!javascript");
@@clientLocation(Watchers.get, "WatcherOperations", "javascript");
@@clientLocation(Watchers.createOrUpdate, "WatcherOperations", "javascript");
@@clientLocation(Watchers.update, "WatcherOperations", "javascript");
@@clientLocation(Watchers.delete, "WatcherOperations", "javascript");
@@clientLocation(
  Watchers.listByAutomationAccount,
  "WatcherOperations",
  "javascript"
);
@@clientLocation(Watchers.start, "WatcherOperations", "javascript");
@@clientLocation(Watchers.stop, "WatcherOperations", "javascript");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Watcher.properties);

@@clientLocation(Webhooks.get, "Webhook", "!javascript");
@@clientLocation(Webhooks.createOrUpdate, "Webhook", "!javascript");
@@clientName(Webhooks.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Webhooks.update, "Webhook", "!javascript");
@@clientName(Webhooks.update::parameters.properties, "parameters");
@@clientLocation(Webhooks.delete, "Webhook", "!javascript");
@@clientLocation(Webhooks.listByAutomationAccount, "Webhook", "!javascript");
@@clientLocation(Webhooks.get, "WebhookOperations", "javascript");
@@clientLocation(Webhooks.createOrUpdate, "WebhookOperations", "javascript");
@@clientLocation(Webhooks.update, "WebhookOperations", "javascript");
@@clientLocation(Webhooks.delete, "WebhookOperations", "javascript");
@@clientLocation(
  Webhooks.listByAutomationAccount,
  "WebhookOperations",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Webhook.properties);

@@clientLocation(
  deletedAutomationAccountsOperationGroup.listBySubscription,
  "deletedAutomationAccounts"
);

@@visibility(Watcher.tags, Lifecycle.Read, Lifecycle.Create, Lifecycle.Update);
@@clientName(SourceControls.create::parameters.resource, "parameters");
