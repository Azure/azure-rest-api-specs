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

@doc("The current deployment state of connectedClusters.")
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

@doc("Represents the connectivity status of the connected cluster.")
enum ConnectivityStatus {
  Connecting,
  Connected,
  Offline,
  Expired,
}

@doc("Property which describes the state of private link on a connected cluster resource.")
enum PrivateLinkState {
  Enabled,
  Disabled,
}

@doc("The type of identity that last modified the resource.")
enum LastModifiedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

@doc("The mode of client authentication.")
enum AuthenticationMethod {
  Token,
  AAD,
}

@doc("The type of identity used for the connected cluster. The type 'SystemAssigned, includes a system created identity. The type 'None' means no identity is assigned to the connected cluster.")
@fixed
enum ResourceIdentityType {
  None,
  SystemAssigned,
}

@doc("Identity for the connected cluster.")
model ConnectedClusterIdentity {
  @doc("The principal id of connected cluster identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant id associated with the connected cluster. This property will only be provided for a system assigned identity.")
  @visibility("read")
  tenantId?: string;

  @doc("The type of identity used for the connected cluster. The type 'SystemAssigned, includes a system created identity. The type 'None' means no identity is assigned to the connected cluster.")
  type: ResourceIdentityType;
}

@doc("Properties of the connected cluster.")
model ConnectedClusterProperties {
  @doc("Base64 encoded public certificate used by the agent to do the initial handshake to the backend services in Azure.")
  agentPublicKeyCertificate: string;

  @doc("The Kubernetes version of the connected cluster resource")
  @visibility("read")
  kubernetesVersion?: string;

  @doc("Number of nodes present in the connected cluster resource")
  @visibility("read")
  totalNodeCount?: int32;

  @doc("Number of CPU cores present in the connected cluster resource")
  @visibility("read")
  totalCoreCount?: int32;

  @doc("Version of the agent running on the connected cluster resource")
  @visibility("read")
  agentVersion?: string;

  @doc("Provisioning state of the connected cluster resource.")
  provisioningState?: ProvisioningState;

  @doc("The Kubernetes distribution running on this connected cluster.")
  distribution?: string;

  @doc("The infrastructure on which the Kubernetes cluster represented by this connected cluster is running on.")
  infrastructure?: string;

  @doc("Connected cluster offering")
  @visibility("read")
  offering?: string;

  @doc("Expiration time of the managed identity certificate")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  managedIdentityCertificateExpirationTime?: utcDateTime;

  @doc("Time representing the last instance when heart beat was received from the cluster")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectivityTime?: utcDateTime;

  @doc("Represents the connectivity status of the connected cluster.")
  @visibility("read")
  connectivityStatus?: ConnectivityStatus;

  @doc("Property which describes the state of private link on a connected cluster resource.")
  privateLinkState?: PrivateLinkState;

  @doc("The resource id of the private link scope this connected cluster is assigned to, if any.")
  privateLinkScopeResourceId?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("Object containing updates for patch operations.")
model ConnectedClusterPatch {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Describes the connected cluster resource properties that can be updated during PATCH operation.")
  properties?: Record<unknown>;
}

model ListClusterUserCredentialProperties {
  @doc("The mode of client authentication.")
  authenticationMethod: AuthenticationMethod;

  @doc("Boolean value to indicate whether the request is for client side proxy or not")
  clientProxy: boolean;
}

@doc("The list of credential result response.")
model CredentialResults {
  @doc("Contains the REP (rendezvous endpoint) and “Sender” access token.")
  @visibility("read")
  hybridConnectionConfig?: HybridConnectionConfig;

  @doc("Base64-encoded Kubernetes configuration file.")
  @visibility("read")
  kubeconfigs?: CredentialResult[];
}

@doc("Contains the REP (rendezvous endpoint) and “Sender” access token.")
model HybridConnectionConfig {
  @doc("Timestamp when this token will be expired.")
  @visibility("read")
  expirationTime?: int32;

  @doc("Name of the connection")
  @visibility("read")
  hybridConnectionName?: string;

  @doc("Name of the relay.")
  @visibility("read")
  relay?: string;

  @doc("Sender access token")
  @visibility("read")
  token?: string;
}

@doc("The credential result response.")
model CredentialResult {
  @doc("The name of the credential.")
  @visibility("read")
  name?: string;

  @doc("Base64-encoded Kubernetes configuration file.")
  @visibility("read")
  value?: bytes;
}
