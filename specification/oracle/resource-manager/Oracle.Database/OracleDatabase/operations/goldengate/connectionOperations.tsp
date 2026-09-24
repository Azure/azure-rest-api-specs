import "@azure-tools/typespec-azure-resource-manager";
import "../../models/goldengate/connection.tsp";
import "../../models/goldengate/connectionAssignment.tsp";
import "../commons.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20260301_preview)
@armResourceOperations(GoldenGateConnection)
interface GoldenGateConnections
  extends OracleTrackedResource<GoldenGateConnection, ConnectionProperties> {
  @doc("Assign a GoldenGate deployment to a connection.")
  assignDeployment is ArmResourceActionAsync<
    GoldenGateConnection,
    AssignUnassignDeployment,
    AssignedDeployment
  >;

  @doc("Unassign a GoldenGate deployment from a connection.")
  unassignDeployment is ArmResourceActionAsync<
    GoldenGateConnection,
    AssignUnassignDeployment,
    AssignedDeployment
  >;

  @doc("List assigned deployments by GoldenGate connection.")
  listAssignedDeploymentsByParent is ArmResourceListByParent<AssignedDeployment>;

  @doc("Get assigned deployment by GoldenGate connection.")
  getAssignedDeployment is ArmResourceRead<AssignedDeployment>;
}
