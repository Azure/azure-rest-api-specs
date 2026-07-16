import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.Synapse;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AvailableRpOperation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlPoolPatchInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlPoolOperation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SensitivityLabelUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RecommendedSensitivityLabelUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlPoolVulnerabilityAssessmentScansExport.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkspacePatchInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KustoPoolUpdate.properties);

@@clientName(
  FollowerDatabaseDefinition.clusterResourceId,
  "kustoPoolResourceId"
);

@@clientName(
  AttachedDatabaseConfigurationProperties.clusterResourceId,
  "kustoPoolResourceId"
);

@@clientName(Resource, "SynapseResource");
@@clientName(
  ResourceProvisioningState,
  "SynapseResourceProvisioningState"
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KustoPoolPrivateLinkResources.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedIntegrationRuntime.typeProperties);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedIntegrationRuntime.managedVirtualNetwork);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CmdkeySetup.typeProperties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EnvironmentVariableSetup.typeProperties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ComponentSetup.typeProperties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SelfHostedIntegrationRuntime.typeProperties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedIntegrationRuntimeStatus.typeProperties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SelfHostedIntegrationRuntimeStatus.typeProperties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReadWriteDatabase.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReadOnlyFollowingDatabase.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventHubDataConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IotHubDataConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventGridDataConnection.properties);

@@clientName(
  AzureADOnlyAuthentications.create::parameters.resource,
  "AzureADOnlyAuthenticationInfo"
);
@@clientName(
  AzureADOnlyAuthenticationProperties.azureADOnlyAuthentication,
  "IsAadOnlyAuthenticationEnabled"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureADOnlyAuthentication.properties);

@@clientName(
  IpFirewallRuleInfos.createOrUpdate::parameters.resource,
  "ipFirewallRuleInfo"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IpFirewallRuleInfo.properties);

@@clientName(Keys.createOrUpdate::parameters.resource, "keyProperties");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Key.properties);

@@clientName(PrivateEndpointConnections.create::parameters.resource, "request");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(
  PrivateLinkHubs.createOrUpdate::parameters.resource,
  "privateLinkHubInfo"
);
@@clientName(
  PrivateLinkHubs.update::parameters.properties,
  "privateLinkHubPatchInfo"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkHub.properties);

@@clientName(SqlPools.create::parameters.resource, "sqlPoolInfo");
@@clientName(SqlPools.update::parameters.properties, "sqlPoolInfo");
@@clientName(
  SqlPools.sqlPoolRestorePointsCreate::parameters.body,
  "parameters"
);
@@clientName(
  SqlPools.sqlPoolSensitivityLabelsUpdate::parameters.body,
  "parameters"
);
@@clientName(
  SqlPools.sqlPoolRecommendedSensitivityLabelsUpdate::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlPool.properties);

@@clientName(
  GeoBackupPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GeoBackupPolicy.properties);

@@clientName(
  SqlPoolDataWarehouseUserActivities,
  "DataWarehouseUserActivities"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DataWarehouseUserActivities.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RestorePoint.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReplicationLink.properties);

@@clientName(SqlPoolMaintenanceWindows, "MaintenanceWindows");
@@clientName(
  SqlPoolMaintenanceWindows.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MaintenanceWindows.properties);

@@clientName(
  SqlPoolMaintenanceWindowOptions,
  "MaintenanceWindowOptions"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MaintenanceWindowOptions.properties);

@@clientName(
  TransparentDataEncryptions.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TransparentDataEncryption.properties);

@@clientName(
  SqlPoolBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlPoolBlobAuditingPolicy.properties);

@@clientName(
  SensitivityLabels.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SensitivityLabel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlPoolColumn.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlPoolConnectionPolicy.properties);

@@clientName(
  SqlPoolVulnerabilityAssessments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlPoolVulnerabilityAssessment.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VulnerabilityAssessmentScanRecord.properties);

@@clientName(
  SqlPoolSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlPoolSecurityAlertPolicy.properties);

@@clientName(
  SqlPoolVulnerabilityAssessmentRuleBaselines.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlPoolVulnerabilityAssessmentRuleBaseline.properties);

@@clientName(
  ExtendedSqlPoolBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExtendedSqlPoolBlobAuditingPolicy.properties);

@@clientName(
  DataMaskingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DataMaskingPolicy.properties);

@@clientName(
  DataMaskingRules.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DataMaskingRuleProperties.id, "RuleId");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DataMaskingRule.properties);

@@clientName(WorkloadGroups.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkloadGroup.properties);

@@clientName(
  WorkloadClassifiers.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkloadClassifier.properties);

@@clientName(
  ServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerBlobAuditingPolicy.properties);

@@clientName(
  ExtendedServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExtendedServerBlobAuditingPolicy.properties);

@@clientName(
  ServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerSecurityAlertPolicy.properties);

@@clientName(
  ServerVulnerabilityAssessments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerVulnerabilityAssessment.properties);

@@clientName(
  EncryptionProtectors.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EncryptionProtector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RecoverableSqlPool.properties);

@@clientName(
  WorkspaceManagedSqlServerDedicatedSQLMinimalTlsSettings,
  "DedicatedSQLminimalTlsSettings"
);
@@clientName(
  WorkspaceManagedSqlServerDedicatedSQLMinimalTlsSettings.update::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DedicatedSQLminimalTlsSettings.properties);

@@clientName(Workspaces.createOrUpdate::parameters.resource, "workspaceInfo");
@@clientName(Workspaces.update::parameters.properties, "workspacePatchInfo");
@@clientName(Workspaces.replaceAll::parameters.body, "request");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Workspace.properties);

@@clientName(
  WorkspaceAadAdminInfos.createOrUpdate::parameters.resource,
  "aadAdminInfo"
);
@@clientName(
  WorkspaceSqlAadAdmins.createOrUpdate::parameters.resource,
  "aadAdminInfo"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkspaceAadAdminInfo.properties);

@@clientName(
  ManagedIdentitySqlControlSettingsModels.createOrUpdate::parameters.resource,
  "managedIdentitySqlControlSettings"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedIdentitySqlControlSettingsModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RestorableDroppedSqlPool.properties);

@@clientName(
  BigDataPoolResourceInfos.createOrUpdate::parameters.resource,
  "bigDataPoolInfo"
);
@@clientName(
  BigDataPoolResourceInfos.update::parameters.properties,
  "bigDataPoolPatchInfo"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BigDataPoolResourceInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LibraryResource.properties);
@@clientName(LibraryInfo.name, "NamePropertiesName");

@@clientName(
  IntegrationRuntimeResources.create::parameters.resource,
  "integrationRuntime"
);
@@clientName(
  IntegrationRuntimeResources.update::parameters.properties,
  "updateIntegrationRuntimeRequest"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeNodesUpdate::parameters.body,
  "updateIntegrationRuntimeNodeRequest"
);
@@clientName(
  IntegrationRuntimeResources.regenerate::parameters.body,
  "regenerateKeyParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SparkConfigurationResource.properties);

@@clientName(KustoPools.createOrUpdate::parameters.resource, "parameters");
@@clientName(KustoPools.update::parameters.properties, "parameters");
@@clientName(
  KustoPools.addLanguageExtensions::parameters.body,
  "languageExtensionsToAdd"
);
@@clientName(
  KustoPools.removeLanguageExtensions::parameters.body,
  "languageExtensionsToRemove"
);
@@clientName(
  KustoPools.detachFollowerDatabases::parameters.body,
  "followerDatabaseToRemove"
);
@@clientName(KustoPools.checkNameAvailability::parameters.body, "resourceName");
@@clientName(
  KustoPools.kustoPoolPrincipalAssignmentsCheckNameAvailability::parameters.body,
  "principalAssignmentName"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KustoPool.properties);

@@clientName(
  AttachedDatabaseConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AttachedDatabaseConfiguration.properties);

@@clientName(Databases.createOrUpdate::parameters.resource, "parameters");
@@clientName(Databases.update::parameters.properties, "parameters");
@@clientName(
  Databases.checkNameAvailability::parameters.body,
  "dataConnectionName"
);
@@clientName(Databases.dataConnectionValidation::parameters.body, "parameters");
@@clientName(
  Databases.kustoPoolDatabasePrincipalAssignmentsCheckNameAvailability::parameters.body,
  "principalAssignmentName"
);

@@clientName(DataConnections.createOrUpdate::parameters.resource, "parameters");
@@clientName(DataConnections.update::parameters.properties, "parameters");

@@clientName(
  ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterPrincipalAssignment.properties);

@@clientName(
  DatabasePrincipalAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DatabasePrincipalAssignment.properties);
