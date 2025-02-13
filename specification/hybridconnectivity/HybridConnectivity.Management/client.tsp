import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
namespace Microsoft.HybridConnectivity;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceConfigurationResourcePatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EndpointAccessResource.relay);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IngressGatewayResource.relay);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IngressGatewayResource.ingress);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IngressProfileProperties.aadProfile);

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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceConfigurationResource.properties);

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

@@clientName(Microsoft.HybridConnectivity,
  "HybridConnectivityManagementAPI",
  "javascript"
);
@@clientName(ServiceConfigurationResources,
  "ServiceConfigurations",
  "javascript"
);
@@clientName(EndpointResources, "Endpoints", "javascript");

@@clientName(Microsoft.HybridConnectivity, "HybridConnectivityMgmt", "python");
@@alternateType(AADProfileProperties.serverId, uuid, "csharp");
@@alternateType(AADProfileProperties.tenantId, uuid, "csharp");
