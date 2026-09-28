import "@azure-tools/typespec-azure-resource-manager";
import "../commons.tsp";
import "../../models/goldengate/deployment.tsp";
import "../../models/goldengate/connectionAssignment.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;
using TypeSpec.Rest;

namespace Oracle.Database;

@added(Versions.v20260301_preview)
@armResourceOperations(GoldenGateDeployment)
interface GoldenGateDeployments
  extends OracleTrackedResource<GoldenGateDeployment, DeploymentProperties> {
  @doc("Assign a GoldenGate connection to a deployment.")
  assignConnection is ArmResourceActionAsync<
    GoldenGateDeployment,
    AssignUnassignConnection,
    AssignedConnection
  >;

  @doc("Unassign a GoldenGate connection from a deployment.")
  unassignConnection is ArmResourceActionAsync<
    GoldenGateDeployment,
    AssignUnassignConnection,
    AssignedConnection
  >;

  @doc("List assigned connections by GoldenGate deployment.")
  listAssignedConnectionsByParent is ArmResourceListByParent<AssignedConnection>;

  @doc("Get assigned connection by GoldenGate deployment.")
  getAssignedConnection is ArmResourceRead<AssignedConnection>;
}
