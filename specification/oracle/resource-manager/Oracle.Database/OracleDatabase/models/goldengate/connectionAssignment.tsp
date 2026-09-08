using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Oracle.Database;

@added(Versions.v20260301_preview)
@doc("Azure resource ID of a GoldenGate Connection.")
scalar GoldenGateConnectionResourceId
  extends armResourceIdentifier<[
    {
      type: "Oracle.Database/goldenGateConnections",
    }
  ]>;

@added(Versions.v20260301_preview)
@doc("Azure resource ID of a GoldenGate Deployment.")
scalar GoldenGateDeploymentResourceId
  extends armResourceIdentifier<[
    {
      type: "Oracle.Database/goldenGateDeployments",
    }
  ]>;

@added(Versions.v20260301_preview)
@doc("The payload for assigning or unassigning a connection on a deployment.")
model AssignUnassignConnection {
  @doc("The Azure resource ID of the connection to assign or unassign.")
  connectionId: GoldenGateConnectionResourceId;
}

@added(Versions.v20260301_preview)
@doc("The payload for assigning or unassigning a deployment on a connection.")
model AssignUnassignDeployment {
  @doc("The Azure resource ID of the deployment to assign or unassign.")
  deploymentId: GoldenGateDeploymentResourceId;
}

@added(Versions.v20260301_preview)
@doc("Possible lifecycle states for connection assignments")
union GoldenGateConnectionAssignmentLifecycleState {
  @doc("Indicates that the resource is in creating state")
  Creating: "CREATING",

  @doc("Indicates that the resource is in active state")
  Active: "ACTIVE",

  @doc("Indicates that the resource is in failed state")
  Failed: "FAILED",

  @doc("Indicates that the resource is in updating state")
  Updating: "UPDATING",

  @doc("Indicates that the resource is in deleting state")
  Deleting: "DELETING",

  @doc("Indicates that the resource is in deleted state")
  Deleted: "DELETED",

  string,
}

@added(Versions.v20260301_preview)
@doc("Deployment-connection assignment properties.")
model DeploymentConnectionAssignmentProperties {
  @doc("The OCID of the connection being referenced.")
  @visibility(Lifecycle.Read)
  connectionId: Ocid;

  @doc("The OCID of the deployment being referenced.")
  @visibility(Lifecycle.Read)
  deploymentId: Ocid;

  @doc("The OCID of the compartment being referenced.")
  @visibility(Lifecycle.Read)
  compartmentId?: Ocid;

  @doc("The deployment name.")
  @visibility(Lifecycle.Read)
  deploymentName?: string;

  @doc("The connection name.")
  @visibility(Lifecycle.Read)
  connectionName?: string;

  @doc("The OCID of the assignment being referenced.")
  @visibility(Lifecycle.Read)
  ocid?: Ocid;

  @doc("The assignment lifecycle state.")
  @visibility(Lifecycle.Read)
  lifecycleState?: GoldenGateConnectionAssignmentLifecycleState;

  @doc("The time the assignment was created.")
  @visibility(Lifecycle.Read)
  timeCreated?: string;

  @doc("The time the assignment was last updated.")
  @visibility(Lifecycle.Read)
  timeUpdated?: string;

  @doc("The assignment alias name.")
  @visibility(Lifecycle.Read)
  aliasName?: string;

  @doc("Deployment-connection assignment provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;
}

@added(Versions.v20260301_preview)
@doc("Assigned Connection resource belonging to GoldenGate Deployment.")
@parentResource(GoldenGateDeployment)
model AssignedConnection
  is ProxyResource<DeploymentConnectionAssignmentProperties> {
  @doc("Assigned Connection assignment OCID.")
  @key("assignmentId")
  @segment("assignedConnections")
  @path
  @pattern(".*")
  name: Ocid;
}

@added(Versions.v20260301_preview)
@doc("Assigned Deployment resource belonging to GoldenGate Connection.")
@parentResource(GoldenGateConnection)
model AssignedDeployment
  is ProxyResource<DeploymentConnectionAssignmentProperties> {
  @doc("Assigned Deployment assignment OCID.")
  @key("assignmentId")
  @segment("assignedDeployments")
  @path
  @pattern(".*")
  name: Ocid;
}
