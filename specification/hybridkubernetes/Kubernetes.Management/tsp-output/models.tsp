import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ConnectedKubernetesClient;

enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

enum ConnectivityStatus {
  Connecting,
  Connected,
  Offline,
  Expired,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum LastModifiedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum AuthenticationMethod {
  Token,
  AAD,
}
@Azure.Core.fixed
enum ResourceIdentityType {
  None,
  SystemAssigned,
}

@doc("Represents a connected cluster.")
model ConnectedCluster {
  ...TrackedResource;

  @doc("The identity of the connected cluster.")
  identity: ConnectedClusterIdentity;

  @doc("Describes the connected cluster resource properties.")
  properties: ConnectedClusterProperties;

  @doc("Metadata pertaining to creation and last modification of the resource")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Identity for the connected cluster.")
model ConnectedClusterIdentity {
  @doc("""
The principal id of connected cluster identity. This property will only be
provided for a system assigned identity.
""")
  @visibility("read")
  principalId?: string;

  @doc("""
The tenant id associated with the connected cluster. This property will only be
provided for a system assigned identity.
""")
  @visibility("read")
  tenantId?: string;

  @doc("""
The type of identity used for the connected cluster. The type 'SystemAssigned,
includes a system created identity. The type 'None' means no identity is
assigned to the connected cluster.
""")
  type: ResourceIdentityType;
}

@doc("Properties of the connected cluster.")
model ConnectedClusterProperties {
  @doc("""
Base64 encoded public certificate used by the agent to do the initial handshake
to the backend services in Azure.
""")
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

  @doc("""
The infrastructure on which the Kubernetes cluster represented by this
connected cluster is running on.
""")
  infrastructure?: string;

  @doc("Connected cluster offering")
  @visibility("read")
  offering?: string;

  @doc("Expiration time of the managed identity certificate")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  managedIdentityCertificateExpirationTime?: utcDateTime;

  @doc("""
Time representing the last instance when heart beat was received from the
cluster
""")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectivityTime?: utcDateTime;

  @doc("Represents the connectivity status of the connected cluster.")
  @visibility("read")
  connectivityStatus?: ConnectivityStatus;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: LastModifiedByType;

  @doc("The timestamp of resource modification (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;
}

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("Object containing updates for patch operations.")
model ConnectedClusterPatch {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("""
Describes the connected cluster resource properties that can be updated during
PATCH operation.
""")
  properties?: unknown;
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

@doc("The paginated list of connected Clusters")
model ConnectedClusterList is Azure.Core.Page<ConnectedCluster>;

@doc("The paginated list of connected cluster API operations.")
model OperationList is Azure.Core.Page<Operation>;

@doc("The Connected cluster API operation")
model Operation {
  @doc("Operation name: {Microsoft.Kubernetes}/{resource}/{operation}")
  @visibility("read")
  name?: string;

  @doc("The object that represents the operation.")
  @visibility("read")
  display?: OperationDisplay;
}

@doc("The object that represents the operation.")
model OperationDisplay {
  @doc("Service provider: Microsoft.connectedClusters")
  provider?: string;

  @doc("Connected Cluster Resource on which the operation is performed")
  resource?: string;

  @doc("Operation type: Read, write, delete, etc.")
  operation?: string;

  @doc("Description of the operation.")
  description?: string;
}
