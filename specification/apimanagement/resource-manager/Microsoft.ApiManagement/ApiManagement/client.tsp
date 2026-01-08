import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ApiManagement;
using Http;

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
@@clientName(ConnectivityCheckRequestProtocolConfigurationHttpConfiguration,
  "ConnectivityCheckRequestProtocolConfigurationHTTPConfiguration",
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DeletedServicesContractsPurge(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  subscriptionId: Azure.Core.uuid,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  serviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  location: Azure.Core.azureLocation,
): void;

@@override(DeletedServiceContracts.purge,
  DeletedServicesContractsPurge,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DeletedServicesContractsGetByName(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  subscriptionId: Azure.Core.uuid,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  serviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  location: Azure.Core.azureLocation,
): void;

@@override(DeletedServiceContracts.getByName,
  DeletedServicesContractsGetByName,
  "python"
);
