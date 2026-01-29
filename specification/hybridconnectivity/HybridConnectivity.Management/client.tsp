import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
namespace Microsoft.HybridConnectivity;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ServiceConfigurationResourcePatch.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EndpointAccessResource.relay
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(IngressGatewayResource.relay
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(IngressGatewayResource.ingress
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(IngressProfileProperties.aadProfile
);

@@clientName(EndpointResources.createOrUpdate::parameters.resource,
  "EndpointResource"
);
@@clientName(EndpointResources.listManagedProxyDetails::parameters.body,
  "ManagedProxyRequest"
);
@@clientName(ServiceConfigurationResources.update::parameters.properties,
  "ServiceConfigurationResource"
);
@@clientName(EndpointResources.update::parameters.properties,
  "EndpointResource"
);
@@clientName(ServiceConfigurationResources.createOrupdate::parameters.resource,
  "ServiceConfigurationResource"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ServiceConfigurationResource.properties
);

@@clientName(EndpointResource, "HybridConnectivityEndpoint", "csharp");
@@clientName(ServiceConfigurationResource,
  "HybridConnectivityServiceConfiguration",
  "csharp"
);
@@clientName(IngressGatewayResource, "IngressGatewayAsset", "csharp");
@@clientName(EndpointAccessResource, "TargetResourceEndpointAccess", "csharp");
@@clientName(EndpointProperties,
  "HybridConnectivityEndpointProperties",
  "csharp"
);
@@clientName(ManagedProxyResource, "ManagedProxyAsset", "csharp");
@@clientName(ProvisioningState,
  "HybridConnectivityProvisioningState",
  "csharp"
);
@@clientName(ServiceName, "HybridConnectivityServiceName", "csharp");
@@clientName(Type, "HybridConnectivityEndpointType", "csharp");
@@clientName(EndpointProperties.type, "endpointType", "csharp");

@@clientName(ServiceConfigurationResources, "ServiceConfigurations", "go");
@@clientName(EndpointResources, "Endpoints", "go");

@@clientName(Microsoft.HybridConnectivity,
  "HybridConnectivityMgmtClient",
  "python"
);
@@clientName(ServiceConfigurationResources, "ServiceConfigurations", "python");
@@clientName(EndpointResources, "Endpoints", "python");

@@clientName(Microsoft.HybridConnectivity,
  "HybridConnectivityMgmtClient",
  "java"
);
@@clientName(ServiceConfigurationResources, "ServiceConfigurations", "java");
@@clientName(EndpointResources, "Endpoints", "java");
@@clientName(AADProfileProperties, "AadProfileProperties", "java");

@@clientName(Microsoft.HybridConnectivity,
  "HybridConnectivityManagementAPI",
  "javascript"
);
@@clientName(ServiceConfigurationResources,
  "ServiceConfigurations",
  "javascript"
);
@@clientName(EndpointResources, "Endpoints", "javascript");

@@clientName(Microsoft.HybridConnectivity,
  "HybridConnectivityMgmtClient",
  "python"
);
@@alternateType(AADProfileProperties.serverId, uuid, "csharp");
@@alternateType(AADProfileProperties.tenantId, uuid, "csharp");
@@clientName(InventoryResource, "PublicCloudInventory", "csharp");
@@clientName(SolutionConfiguration,
  "PublicCloudConnectorSolutionConfiguration",
  "csharp"
);
@@clientName(SolutionTypeResource,
  "PublicCloudConnectorSolutionType",
  "csharp"
);
@@clientName(HostType, "PublicCloudHostType", "csharp");
@@clientName(GenerateAwsTemplateRequest,
  "GenerateAwsTemplateContent",
  "csharp"
);
@@alternateType(GenerateAwsTemplateRequest.connectorId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ListCredentialsRequest, "ListCredentialsContent", "csharp");
@@clientName(ListIngressGatewayCredentialsRequest,
  "ListIngressGatewayCredentialsContent",
  "csharp"
);
@@clientName(ManagedProxyRequest, "ManagedProxyContent", "csharp");
@@clientName(HostType.AWS, "Aws", "csharp");
@@clientName(InventoryProperties, "PublicCloudInventoryProperties", "csharp");
@@alternateType(InventoryProperties.azureResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(SolutionConfigurationProperties,
  "PublicCloudConnectorSolutionConfigurationProperties",
  "csharp"
);
@@clientName(SolutionConfigurationProperties.lastSyncTime,
  "LastSyncedOn",
  "csharp"
);
@@clientName(SolutionConfigurationStatus,
  "PublicCloudConnectorSolutionConfigurationStatus",
  "csharp"
);
@@clientName(SolutionSettings,
  "PublicCloudConnectorSolutionSettings",
  "csharp"
);
@@clientName(SolutionTypeSettings,
  "PublicCloudConnectorSolutionTypeSettings",
  "csharp"
);
@@clientName(SolutionTypeProperties,
  "PublicCloudConnectorSolutionTypeProperties",
  "csharp"
);
@@clientName(SolutionTypeSettingsProperties,
  "PublicCloudConnectorSolutionTypeSettingsProperties",
  "csharp"
);
@@clientName(Azure.ResourceManager.Foundations.OperationStatusResult,
  "HybridConnectivityOperationStatus",
  "csharp"
);
@@alternateType(Azure.ResourceManager.Foundations.OperationStatusResult.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "PublicCloudResourceProvisioningState",
  "csharp"
);
@@clientName(GenerateAwsTemplateResponse,
  "GenerateAwsTemplateResult",
  "csharp"
);

@@clientName(GenerateAwsTemplate.post, "PostGenerateAwsTemplate", "csharp");
@@clientName(TrackedResourceUpdate,
  "HybridConnectivityTrackedResourcePatch",
  "csharp"
);
