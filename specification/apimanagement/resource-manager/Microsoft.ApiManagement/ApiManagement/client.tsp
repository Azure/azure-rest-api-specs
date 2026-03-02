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

@@clientName(CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
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
@@clientName(CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "python,go"
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

/**
 * override for PolicyContracts.get
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op PolicyContractsGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  resourceGroupName: string,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  apiId: string,
  operationId: string,
  policyId: Microsoft.ApiManagement.PolicyIdName,

  /**
   * Policy Export Format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("format")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("xml")
  format?: PolicyExportFormat = PolicyExportFormat.xml,
): (ArmResponse<PolicyContract> & {
  /**
   * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
   */
  @header("ETag")
  etag: string;
}) | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(PolicyContracts.get, PolicyContractsGet, "javascript");

/**
 * override for GraphQLApiResolverPolicy.get
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op GraphQLApiResolverPolicyGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  resourceGroupName: string,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  apiId: string,
  resolverId: string,
  policyId: Microsoft.ApiManagement.PolicyIdName,

  /**
   * Policy Export Format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("format")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("xml")
  format?: PolicyExportFormat = PolicyExportFormat.xml,
): (ArmResponse<PolicyContract> & {
  /**
   * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
   */
  @header("ETag")
  etag: string;
}) | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(GraphQLApiResolverPolicy.get,
  GraphQLApiResolverPolicyGet,
  "javascript"
);

/**
 * override for ApiPolicy.get
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ApiPolicyGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  resourceGroupName: string,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  apiId: string,
  policyId: Microsoft.ApiManagement.PolicyIdName,

  /**
   * Policy Export Format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("format")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("xml")
  format?: PolicyExportFormat = PolicyExportFormat.xml,
): (ArmResponse<PolicyContract> & {
  /**
   * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
   */
  @header("ETag")
  etag: string;
}) | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(ApiPolicy.get, ApiPolicyGet, "javascript");

/**
 * override for Policy.get
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op PolicyGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  resourceGroupName: string,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  policyId: Microsoft.ApiManagement.PolicyIdName,

  /**
   * Policy Export Format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("format")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("xml")
  format?: PolicyExportFormat = PolicyExportFormat.xml,
): (ArmResponse<PolicyContract> & {
  /**
   * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
   */
  @header("ETag")
  etag: string;
}) | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(Policy.get, PolicyGet, "javascript");

/**
 * override for ProductPolicy.get
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ProductPolicyGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  resourceGroupName: string,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  productId: string,
  policyId: Microsoft.ApiManagement.PolicyIdName,

  /**
   * Policy Export Format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("format")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("xml")
  format?: PolicyExportFormat = PolicyExportFormat.xml,
): (ArmResponse<PolicyContract> & {
  /**
   * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
   */
  @header("ETag")
  etag: string;
}) | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(ProductPolicy.get, ProductPolicyGet, "javascript");

/**
 * override for WorkspacePolicy.get
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op WorkspacePolicyGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  resourceGroupName: string,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  workspaceId: string,
  policyId: Microsoft.ApiManagement.PolicyIdName,

  /**
   * Policy Export Format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("format")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("xml")
  format?: PolicyExportFormat = PolicyExportFormat.xml,
): (ArmResponse<PolicyContract> & {
  /**
   * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
   */
  @header("ETag")
  etag: string;
}) | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(WorkspacePolicy.get, WorkspacePolicyGet, "javascript");

/**
 * override for WorkspaceApiOperationPolicy.get
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op WorkspaceApiOperationPolicyGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  resourceGroupName: string,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  workspaceId: string,
  apiId: string,
  operationId: string,
  policyId: Microsoft.ApiManagement.PolicyIdName,

  /**
   * Policy Export Format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("format")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("xml")
  format?: PolicyExportFormat = PolicyExportFormat.xml,
): (ArmResponse<PolicyContract> & {
  /**
   * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
   */
  @header("ETag")
  etag: string;
}) | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(WorkspaceApiOperationPolicy.get,
  WorkspaceApiOperationPolicyGet,
  "javascript"
);

/**
 * override for WorkspaceApiPolicy.get
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op WorkspaceApiPolicyGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  resourceGroupName: string,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  workspaceId: string,
  apiId: string,
  policyId: Microsoft.ApiManagement.PolicyIdName,

  /**
   * Policy Export Format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("format")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("xml")
  format?: PolicyExportFormat = PolicyExportFormat.xml,
): (ArmResponse<PolicyContract> & {
  /**
   * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
   */
  @header("ETag")
  etag: string;
}) | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(WorkspaceApiPolicy.get, WorkspaceApiPolicyGet, "javascript");

/**
 * override for WorkspaceProductPolicy.get
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op WorkspaceProductPolicyGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  resourceGroupName: string,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  workspaceId: string,
  productId: string,
  policyId: Microsoft.ApiManagement.PolicyIdName,

  /**
   * Policy Export Format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @query("format")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("xml")
  format?: PolicyExportFormat = PolicyExportFormat.xml,
): (ArmResponse<PolicyContract> & {
  /**
   * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
   */
  @header("ETag")
  etag: string;
}) | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(WorkspaceProductPolicy.get, WorkspaceProductPolicyGet, "javascript");
