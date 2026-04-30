import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HDInsight;

@@clientName(Role.autoscale, "autoscaleConfiguration");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

@@clientName(Extensions.enableMonitoring::parameters.body, "parameters");
@@clientName(Extensions.enableAzureMonitor::parameters.body, "parameters");
@@clientName(Extensions.enableAzureMonitorAgent::parameters.body, "parameters");

@@clientName(VirtualMachines.restartHosts::parameters.body, "hosts");

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
@@clientName(Extensions.create::parameters.resource, "parameters");
@@visibility(ScriptActionExecutionHistoryList.value, Lifecycle.Read);
@@clientName(Configurations.update::parameters.resource, "parameters");
@@doc(Extensions.enableMonitoring::parameters.body,
  "The Operations Management Suite (OMS) workspace parameters."
);
@@doc(Extensions.enableAzureMonitor::parameters.body,
  "The Log Analytics workspace parameters."
);
@@doc(Extensions.enableAzureMonitorAgent::parameters.body,
  "The Log Analytics workspace parameters."
);
@@doc(Extensions.create::parameters.resource,
  "The cluster extensions create request."
);

@@doc(Configurations.update::parameters.resource,
  "The cluster configurations."
);
@@doc(VirtualMachines.restartHosts::parameters.body,
  "The list of hosts to restart"
);
