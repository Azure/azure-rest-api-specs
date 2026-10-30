import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace IntegrationRuntimes;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IntegrationRuntimeStatusResponse.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedIntegrationRuntime.typeProperties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedIntegrationRuntime.managedVirtualNetwork);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CmdkeySetup.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EnvironmentVariableSetup.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ComponentSetup.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SelfHostedIntegrationRuntime.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedIntegrationRuntimeStatus.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SelfHostedIntegrationRuntimeStatus.typeProperties);

@@clientLocation(IntegrationRuntimeResources.get, "IntegrationRuntimes");
@@clientLocation(IntegrationRuntimeResources.create, "IntegrationRuntimes");
@@clientName(
  IntegrationRuntimeResources.create::parameters.resource,
  "integrationRuntime"
);
@@clientLocation(IntegrationRuntimeResources.update, "IntegrationRuntimes");
@@clientName(
  IntegrationRuntimeResources.update::parameters.properties,
  "updateIntegrationRuntimeRequest"
);
@@clientLocation(IntegrationRuntimeResources.delete, "IntegrationRuntimes");
@@clientLocation(
  IntegrationRuntimeResources.listByWorkspace,
  "IntegrationRuntimes"
);
@@clientLocation(IntegrationRuntimeResources.upgrade, "IntegrationRuntimes");
@@clientLocation(IntegrationRuntimeResources.start, "IntegrationRuntimes");
@@clientLocation(IntegrationRuntimeResources.stop, "IntegrationRuntimes");
@@clientLocation(
  IntegrationRuntimeResources.listOutboundNetworkDependenciesEndpoints,
  "IntegrationRuntimes"
);
@@clientLocation(
  IntegrationRuntimeResources.enableInteractiveQuery,
  "IntegrationRuntimes"
);
@@clientLocation(
  IntegrationRuntimeResources.disableInteractiveQuery,
  "IntegrationRuntimes"
);
@@clientLocation(
  IntegrationRuntimeResources.integrationRuntimeNodeIpAddressGet,
  "IntegrationRuntimeNodeIpAddress"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeNodeIpAddressGet,
  "Get"
);
@@clientLocation(
  IntegrationRuntimeResources.list,
  "IntegrationRuntimeObjectMetadata"
);
@@clientName(
  IntegrationRuntimeResources.list::parameters.body,
  "getMetadataRequest"
);
@@clientLocation(
  IntegrationRuntimeResources.refresh,
  "IntegrationRuntimeObjectMetadata"
);
@@clientLocation(
  IntegrationRuntimeResources.integrationRuntimeNodesGet,
  "IntegrationRuntimeNodes"
);
@@clientName(IntegrationRuntimeResources.integrationRuntimeNodesGet, "Get");
@@clientLocation(
  IntegrationRuntimeResources.integrationRuntimeNodesUpdate,
  "IntegrationRuntimeNodes"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeNodesUpdate,
  "Update"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeNodesUpdate::parameters.body,
  "updateIntegrationRuntimeNodeRequest"
);
@@clientLocation(
  IntegrationRuntimeResources.integrationRuntimeNodesDelete,
  "IntegrationRuntimeNodes"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeNodesDelete,
  "Delete"
);
@@clientLocation(
  IntegrationRuntimeResources.sync,
  "IntegrationRuntimeCredentials"
);
@@clientLocation(
  IntegrationRuntimeResources.integrationRuntimeConnectionInfosGet,
  "IntegrationRuntimeConnectionInfos"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeConnectionInfosGet,
  "Get"
);
@@clientLocation(
  IntegrationRuntimeResources.regenerate,
  "IntegrationRuntimeAuthKeys"
);
@@clientName(
  IntegrationRuntimeResources.regenerate::parameters.body,
  "regenerateKeyParameters"
);
@@clientLocation(
  IntegrationRuntimeResources.integrationRuntimeAuthKeysList,
  "IntegrationRuntimeAuthKeys"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeAuthKeysList,
  "List"
);
@@clientLocation(
  IntegrationRuntimeResources.integrationRuntimeMonitoringDataList,
  "IntegrationRuntimeMonitoringData"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeMonitoringDataList,
  "List"
);
@@clientLocation(
  IntegrationRuntimeResources.integrationRuntimeStatusGet,
  "IntegrationRuntimeStatus"
);
@@clientName(IntegrationRuntimeResources.integrationRuntimeStatusGet, "Get");
@@clientLocation(IntegrationRuntimeResources.integrationRuntimeStart, "Get");
@@clientLocation(IntegrationRuntimeResources.integrationRuntimeStop, "Get");
@@clientLocation(
  IntegrationRuntimeResources.integrationRuntimeEnableInteractivequery,
  "Get"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IntegrationRuntimeResource.properties);
