import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.KubernetesConfiguration;

/**
 * The network access policy to determine if Azure Arc agents can use public Azure Arc service endpoints. Defaults to disabled (access to Azure Arc services only via private link).
 */
union PublicNetworkAccessType {
  string,

  /**
   * Allows Azure Arc agents to communicate with Azure Arc services over both public (internet) and private endpoints.
   */
  Enabled: "Enabled",

  /**
   * Does not allow Azure Arc agents to communicate with Azure Arc services over public (internet) endpoints. The agents must use the private link.
   */
  Disabled: "Disabled",
}

/**
 * The provisioning state of the resource.
 */
union ProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Properties that define a Azure Arc PrivateLinkScope resource.
 */
model KubernetesConfigurationPrivateLinkScopeProperties {
  /**
   * Indicates whether machines associated with the private link scope can also use public Azure Arc service endpoints.
   */
  publicNetworkAccess?: PublicNetworkAccessType = PublicNetworkAccessType.Disabled;

  /**
   * Current state of this PrivateLinkScope: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Provisioning ,Succeeded, Canceled and Failed.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Managed Cluster ARM ID for the private link scope  (Required)
   */
  clusterResourceId: string;

  /**
   * The Guid id of the private link scope.
   */
  @visibility(Lifecycle.Read)
  privateLinkScopeId?: string;

  /**
   * The collection of associated Private Endpoint Connections.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on a PrivateLinkScope instance.
 */
model TagsResource {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}
