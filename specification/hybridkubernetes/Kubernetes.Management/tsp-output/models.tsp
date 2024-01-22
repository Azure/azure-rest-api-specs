import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Kubernetes;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The current deployment state of connectedClusters.
 */
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

/**
 * Represents the connectivity status of the connected cluster.
 */
enum ConnectivityStatus {
  Connecting,
  Connected,
  Offline,
  Expired,
}

/**
 * Property which describes the state of private link on a connected cluster resource.
 */
enum PrivateLinkState {
  Enabled,
  Disabled,
}

/**
 * The type of identity that last modified the resource.
 */
enum LastModifiedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

/**
 * The mode of client authentication.
 */
enum AuthenticationMethod {
  Token,
  AAD,
}

/**
 * The type of identity used for the connected cluster. The type 'SystemAssigned, includes a system created identity. The type 'None' means no identity is assigned to the connected cluster.
 */
@fixed
enum ResourceIdentityType {
  None,
  SystemAssigned,
}

/**
 * Identity for the connected cluster.
 */
model ConnectedClusterIdentity {
  /**
   * The principal id of connected cluster identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant id associated with the connected cluster. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The type of identity used for the connected cluster. The type 'SystemAssigned, includes a system created identity. The type 'None' means no identity is assigned to the connected cluster.
   */
  type: ResourceIdentityType = ResourceIdentityType.SystemAssigned;
}

/**
 * Properties of the connected cluster.
 */
model ConnectedClusterProperties {
  /**
   * Base64 encoded public certificate used by the agent to do the initial handshake to the backend services in Azure.
   */
  agentPublicKeyCertificate: string;

  /**
   * The Kubernetes version of the connected cluster resource
   */
  @visibility("read")
  kubernetesVersion?: string;

  /**
   * Number of nodes present in the connected cluster resource
   */
  @visibility("read")
  totalNodeCount?: int32;

  /**
   * Number of CPU cores present in the connected cluster resource
   */
  @visibility("read")
  totalCoreCount?: int32;

  /**
   * Version of the agent running on the connected cluster resource
   */
  @visibility("read")
  agentVersion?: string;

  /**
   * Provisioning state of the connected cluster resource.
   */
  provisioningState?: ProvisioningState;

  /**
   * The Kubernetes distribution running on this connected cluster.
   */
  distribution?: string;

  /**
   * The infrastructure on which the Kubernetes cluster represented by this connected cluster is running on.
   */
  infrastructure?: string;

  /**
   * Connected cluster offering
   */
  @visibility("read")
  offering?: string;

  /**
   * Expiration time of the managed identity certificate
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  managedIdentityCertificateExpirationTime?: utcDateTime;

  /**
   * Time representing the last instance when heart beat was received from the cluster
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectivityTime?: utcDateTime;

  /**
   * Represents the connectivity status of the connected cluster.
   */
  @visibility("read")
  connectivityStatus?: ConnectivityStatus;

  /**
   * Property which describes the state of private link on a connected cluster resource.
   */
  privateLinkState?: PrivateLinkState = PrivateLinkState.Disabled;

  /**
   * The resource id of the private link scope this connected cluster is assigned to, if any.
   */
  privateLinkScopeResourceId?: string;
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
 * Object containing updates for patch operations.
 */
model ConnectedClusterPatch {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * Describes the connected cluster resource properties that can be updated during PATCH operation.
   */
  properties?: Record<unknown>;
}

model ListClusterUserCredentialProperties {
  /**
   * The mode of client authentication.
   */
  authenticationMethod: AuthenticationMethod;

  /**
   * Boolean value to indicate whether the request is for client side proxy or not
   */
  clientProxy: boolean;
}

/**
 * The list of credential result response.
 */
model CredentialResults {
  /**
   * Contains the REP (rendezvous endpoint) and “Sender” access token.
   */
  @visibility("read")
  hybridConnectionConfig?: HybridConnectionConfig;

  /**
   * Base64-encoded Kubernetes configuration file.
   */
  @visibility("read")
  kubeconfigs?: CredentialResult[];
}

/**
 * Contains the REP (rendezvous endpoint) and “Sender” access token.
 */
model HybridConnectionConfig {
  /**
   * Timestamp when this token will be expired.
   */
  @visibility("read")
  expirationTime?: int64;

  /**
   * Name of the connection
   */
  @visibility("read")
  hybridConnectionName?: string;

  /**
   * Name of the relay.
   */
  @visibility("read")
  relay?: string;

  /**
   * Sender access token
   */
  @visibility("read")
  token?: string;
}

/**
 * The credential result response.
 */
model CredentialResult {
  /**
   * The name of the credential.
   */
  @visibility("read")
  name?: string;

  /**
   * Base64-encoded Kubernetes configuration file.
   */
  @visibility("read")
  value?: bytes;
}
