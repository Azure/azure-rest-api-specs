import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HDInsight;

@@clientName(Role.autoscale, "autoscaleConfiguration");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateLinkConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IPConfiguration.properties);

@@clientName(GatewaySettings.`restAuthCredential.isEnabled`,
  "isCredentialEnabled"
);
@@clientName(GatewaySettings.`restAuthCredential.username`, "userName");
@@clientName(GatewaySettings.`restAuthCredential.password`, "password");

@@clientName(UpdateGatewaySettingsParameters.`restAuthCredential.isEnabled`,
  "isCredentialEnabled"
);
@@clientName(UpdateGatewaySettingsParameters.`restAuthCredential.username`,
  "userName"
);
@@clientName(UpdateGatewaySettingsParameters.`restAuthCredential.password`,
  "password"
);

@@clientName(Applications.create::parameters.resource, "parameters");

@@clientName(Clusters.create::parameters.resource, "parameters");
@@clientName(Clusters.update::parameters.properties, "parameters");
@@clientName(Clusters.resize::parameters.body, "parameters");
@@clientName(Clusters.updateAutoScaleConfiguration::parameters.body,
  "parameters"
);
@@clientName(Clusters.rotateDiskEncryptionKey::parameters.body, "parameters");
@@clientName(Clusters.updateGatewaySettings::parameters.body, "parameters");
@@clientName(Clusters.updateIdentityCertificate::parameters.body, "parameters");
@@clientName(Clusters.executeScriptActions::parameters.body, "parameters");
@@clientLocation(Clusters.configurationsList, "Configurations");
@@clientName(Clusters.configurationsList, "List");
@@clientLocation(Clusters.configurationsUpdate, "Configurations");
@@clientName(Clusters.configurationsUpdate, "Update");
@@clientName(Clusters.configurationsUpdate::parameters.resource, "parameters");
@@clientLocation(Clusters.configurationsGet, "Configurations");
@@clientName(Clusters.configurationsGet, "Get");
@@clientLocation(Clusters.enableMonitoring, "Extensions");
@@clientName(Clusters.enableMonitoring::parameters.body, "parameters");
@@clientLocation(Clusters.getMonitoringStatus, "Extensions");
@@clientLocation(Clusters.disableMonitoring, "Extensions");
@@clientLocation(Clusters.enableAzureMonitor, "Extensions");
@@clientName(Clusters.enableAzureMonitor::parameters.body, "parameters");
@@clientLocation(Clusters.getAzureMonitorStatus, "Extensions");
@@clientLocation(Clusters.disableAzureMonitor, "Extensions");
@@clientLocation(Clusters.enableAzureMonitorAgent, "Extensions");
@@clientName(Clusters.enableAzureMonitorAgent::parameters.body, "parameters");
@@clientLocation(Clusters.getAzureMonitorAgentStatus, "Extensions");
@@clientLocation(Clusters.disableAzureMonitorAgent, "Extensions");
@@clientLocation(Clusters.extensionsCreate, "Extensions");
@@clientName(Clusters.extensionsCreate, "Create");
@@clientLocation(Clusters.extensionsGet, "Extensions");
@@clientName(Clusters.extensionsGet, "Get");
@@clientLocation(Clusters.extensionsDelete, "Extensions");
@@clientName(Clusters.extensionsDelete, "Delete");
@@clientLocation(Clusters.extensionsGetAzureAsyncOperationStatus, "Extensions");
@@clientName(Clusters.extensionsGetAzureAsyncOperationStatus,
  "GetAzureAsyncOperationStatus"
);
@@clientLocation(Clusters.scriptActionsDelete, "ScriptActions");
@@clientName(Clusters.scriptActionsDelete, "Delete");
@@clientLocation(Clusters.listByCluster, "ScriptActions");
@@clientLocation(Clusters.getExecutionDetail, "ScriptActions");
@@clientLocation(Clusters.getExecutionAsyncOperationStatus, "ScriptActions");
@@clientLocation(Clusters.scriptExecutionHistoryListByCluster,
  "ScriptExecutionHistory"
);
@@clientName(Clusters.scriptExecutionHistoryListByCluster, "ListByCluster");
@@clientLocation(Clusters.promote, "ScriptExecutionHistory");
@@clientLocation(Clusters.listHosts, "VirtualMachines");
@@clientLocation(Clusters.restartHosts, "VirtualMachines");
@@clientName(Clusters.restartHosts::parameters.body, "hosts");
@@clientLocation(Clusters.getAsyncOperationStatus, "VirtualMachines");

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateLinkResource.properties);

@@clientLocation(LocationsOperationGroup.getCapabilities, "Locations");
@@clientLocation(LocationsOperationGroup.listUsages, "Locations");
@@clientLocation(LocationsOperationGroup.listBillingSpecs, "Locations");
@@clientLocation(LocationsOperationGroup.getAzureAsyncOperationStatus,
  "Locations"
);
@@clientLocation(LocationsOperationGroup.checkNameAvailability, "Locations");
@@clientLocation(LocationsOperationGroup.validateClusterCreateRequest,
  "Locations"
);
@@doc(Operations.list,
  "Lists all of the available HDInsight REST API operations."
);
@@clientName(LocationsOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);
@@clientName(LocationsOperationGroup.validateClusterCreateRequest::parameters.body,
  "parameters"
);
@@clientName(Clusters.extensionsCreate::parameters.resource, "parameters");
@@visibility(ScriptActionExecutionHistoryList.value, Lifecycle.Read);
