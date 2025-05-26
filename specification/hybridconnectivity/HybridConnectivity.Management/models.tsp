import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Microsoft.HybridConnectivity;

/**
 * The type of endpoint.
 */
union Type {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  default: "default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  custom: "custom",
}

/**
 * Name of the service.
 */
union ServiceName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SSH: "SSH",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WAC: "WAC",
}

/**
 * The resource provisioning state.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * The list of endpoints.
 */
model EndpointsList is Azure.Core.Page<EndpointResource>;

/**
 * Endpoint details
 */
model EndpointProperties {
  /**
   * The type of endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  type: Type;

  /**
   * The resource Id of the connectivity endpoint (optional).
   */
  resourceId?: armResourceIdentifier;

  /**
   * The resource provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The paginated list of serviceConfigurations
 */
model ServiceConfigurationList is Azure.Core.Page<ServiceConfigurationResource>;

/**
 * Service configuration details
 */
model ServiceConfigurationProperties {
  /**
   * Name of the service.
   */
  serviceName: ServiceName;

  /**
   * The resource Id of the connectivity endpoint (optional).
   */
  resourceId?: armResourceIdentifier;

  /**
   * The port on which service is enabled.
   */
  port?: int64;

  /**
   * The resource provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The service details under service configuration for the target endpoint resource.
 */
model ServiceConfigurationResourcePatch {
  /**
   * The service configuration properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ServiceConfigurationPropertiesPatch;
}

/**
 * Service configuration details
 */
model ServiceConfigurationPropertiesPatch {
  /**
   * The port on which service is enabled.
   */
  port?: int64;
}

/**
 * The details of the service for which credentials needs to be returned.
 */
model ListCredentialsRequest {
  /**
   * The name of the service. If not provided, the request will by pass the generation of service configuration token
   */
  serviceName?: ServiceName;
}

/**
 * The endpoint access for the target resource.
 */
model EndpointAccessResource {
  /**
   * Azure relay hybrid connection access properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  relay?: RelayNamespaceAccessProperties;
}

/**
 * Azure relay hybrid connection access properties
 */
model RelayNamespaceAccessProperties {
  /**
   * The namespace name.
   */
  @maxLength(200)
  @minLength(1)
  namespaceName: string;

  /**
   * The suffix domain name of relay namespace.
   */
  @maxLength(100)
  @minLength(1)
  namespaceNameSuffix: string;

  /**
   * Azure Relay hybrid connection name for the resource.
   */
  hybridConnectionName: string;

  /**
   * Access key for hybrid connection.
   */
  @visibility(Lifecycle.Read)
  accessKey?: string;

  /**
   * The expiration of access key in unix time.
   */
  expiresOn?: int64;

  /**
   * The token to access the enabled service.
   */
  serviceConfigurationToken?: string;
}

/**
 * The ingress gateway access credentials
 */
model IngressGatewayResource {
  /**
   * Azure relay hybrid connection access properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  relay?: RelayNamespaceAccessProperties;

  /**
   * Ingress gateway profile
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  ingress?: IngressProfileProperties;
}

/**
 * Ingress gateway profile
 */
model IngressProfileProperties {
  /**
   * The ingress hostname.
   */
  hostname: string;

  /**
   * The AAD Profile
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  aadProfile: AADProfileProperties;
}

/**
 * The AAD Profile
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AADProfileProperties {
  /**
   * The arc ingress gateway server app id.
   */
  serverId: string;

  /**
   * The target resource home tenant id.
   */
  tenantId: string;
}

/**
 * Represent ManageProxy Request object.
 */
model ManagedProxyRequest {
  /**
   * The name of the service.
   */
  service: string;

  /**
   * The target host name.
   */
  hostname?: string;

  /**
   * The name of the service. It is an optional property, if not provided, service configuration tokens issue code would be by passed.
   */
  serviceName?: ServiceName;
}

/**
 * Managed Proxy
 */
model ManagedProxyResource {
  /**
   * The short lived proxy name.
   */
  proxy: string;

  /**
   * The expiration time of short lived proxy name in unix epoch.
   */
  expiresOn: int64;
}

/**
 * Represent ListIngressGatewayCredentials Request object.
 */
model ListIngressGatewayCredentialsRequest {
  /**
   * The name of the service. If not provided, the request will by pass the generation of service configuration token.
   */
  serviceName?: ServiceName;
}

@@doc(EndpointsList.value, "The list of endpoint.");
@@doc(EndpointsList.nextLink,
  "The link used to get the next page of endpoints list."
);
@@doc(ServiceConfigurationList.value, "The list of service configuration");
@@doc(ServiceConfigurationList.nextLink,
  "The link to fetch the next page of connected cluster"
);
