import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ApiManagement;
using Http;
using Azure.ResourceManager;

// Java-specific compatibility customizations generated per TypeSpec migration guidance.
@@clientName(Microsoft.ApiManagement.PreferredIPVersion,
  "PreferredIpVersion",
  "java"
);
@@clientName(Microsoft.ApiManagement.TagTagResourceContractProperties,
  "TagResourceContractProperties",
  "java,python"
);
@@clientName(Microsoft.ApiManagement.ConnectivityCheckRequest.preferredIPVersion,
  "preferredIpVersion",
  "java"
);

@@clientName(Microsoft.ApiManagement.ApiManagementSkuCosts.meterID,
  "meterId",
  "java"
);
@@clientName(Microsoft.ApiManagement.KeyVaultLastAccessStatusContractProperties.timeStampUtc,
  "timestampUtc",
  "java"
);
@@clientName(Microsoft.ApiManagement.ApiManagementServiceBaseProperties.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.ApiManagementServiceBaseProperties.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.ApiManagementServiceBaseProperties.outboundPublicIPAddresses,
  "outboundPublicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.AdditionalLocation.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.AdditionalLocation.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.AdditionalLocation.outboundPublicIPAddresses,
  "outboundPublicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.HostnameConfiguration.hostName,
  "hostname",
  "java"
);

@@clientLocation(Microsoft.ApiManagement.ApiManagementWorkspaceLinksResources.get,
  "ApiManagementWorkspaceLinkOperations",
  "java"
);
@@clientLocation(Microsoft.ApiManagement.ApiManagementWorkspaceLinksResources.listByService,
  "ApiManagementWorkspaceLinks",
  "java"
);
@@clientLocation(Microsoft.ApiManagement.ApiManagementServiceResources.performConnectivityCheckAsync,
  "ResourceProviders",
  "java"
);

@@clientName(ExportFormat.Swagger, "SWAGGER_LINK", "java");
@@clientName(ExportFormat.Wadl, "WADL_LINK", "java");
@@clientName(ExportFormat.Wsdl, "WSDL_LINK", "java");
@@clientName(ExportFormat.Openapi, "OPENAPI_LINK", "java");
@@clientName(ExportFormat.OpenapiJson, "OPENAPI_JSON_LINK", "java");
@@clientName(ExportResultFormat.Swagger, "SWAGGER_LINK_JSON", "java");
@@clientName(ExportResultFormat.Wadl, "WADL_LINK_JSON", "java");
@@clientName(ExportResultFormat.Wsdl, "WSDL_LINK_XML", "java");
@@clientName(ExportResultFormat.OpenApi, "OPENAPI_LINK", "java");
@@clientName(SoapApiType.SoapToRest, "HTTP", "java");
@@clientName(SoapApiType.SoapPassThrough, "SOAP", "java");
@@clientName(SoapApiType.WebSocket, "WEBSOCKET", "java");
@@clientName(SoapApiType.GraphQL, "GRAPHQL", "java");
@@clientName(SoapApiType.gRPC, "GRPC", "java");

@@clientName(Microsoft.ApiManagement, "ApiManagementClient", "python");
@@clientName(HttpCorrelationProtocol.W3C, "W3_C", "python");
@@clientLocation(ApiManagementServiceResources.performConnectivityCheckAsync,
  Microsoft.ApiManagement,
  "python"
);

/**
 * override for DeletedServiceContracts.getByName
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replaceGetByName(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  location: Azure.Core.azureLocation,
): Azure.ResourceManager.ArmResponse<Microsoft.ApiManagement.DeletedServiceContract> | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(DeletedServiceContracts.getByName, replaceGetByName, "go,java");

/**
 * override for DeletedServiceContracts.purge
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replacePurge(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  location: Azure.Core.azureLocation,
): ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
  @bodyRoot
  _: DeletedServiceContract;
}) | ArmDeletedNoContentResponse;

@@override(DeletedServiceContracts.purge, replacePurge, "go,java");

@@clientName(TagTagResourceContractProperties,
  "TagResourceContractProperties",
  "go"
);
@@clientLocation(Microsoft.ApiManagement.ApiManagementServiceResources.performConnectivityCheckAsync,
  "Client",
  "go"
);
