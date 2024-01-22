import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridConnectivity;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The type of endpoint.
 */
enum EndpointType {
  default,
  custom,
}

/**
 * Endpoint details
 */
model EndpointProperties {
  /**
   * The type of endpoint.
   */
  @projectedName("json", "type")
  endpointType: EndpointType;

  /**
   * The resource Id of the connectivity endpoint (optional).
   */
  resourceId?: string;

  @visibility("read")
  provisioningState?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * The endpoint access for the target resource.
 */
model TargetResourceEndpointAccess {
  /**
   * Azure relay hybrid connection access properties
   */
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
  @visibility("read")
  accessKey?: string;

  /**
   * The expiration of access key in unix time.
   */
  expiresOn?: int64;
}
