import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Quantum;
@doc("The resource proxy definition object for quantum workspace.")
model QuantumWorkspace is TrackedResource<WorkspaceResourceProperties> {
  @doc("The name of the quantum workspace resource.")
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface QuantumWorkspaces {
  @doc("Returns the Workspace resource associated with the given name.")
  get is ArmResourceRead<QuantumWorkspace>;
  @doc("Creates or updates a workspace resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<QuantumWorkspace>;
  @doc("Updates an existing workspace's tags.")
  updateTags is ArmTagsPatchSync<QuantumWorkspace>;
  @doc("Deletes a Workspace resource.")
  delete is ArmResourceDeleteAsync<QuantumWorkspace>;
  @doc("Gets the list of Workspaces within a resource group.")
  listByResourceGroup is ArmResourceListByParent<QuantumWorkspace>;
  @doc("Gets the list of Workspaces within a Subscription.")
  listBySubscription is ArmListBySubscription<QuantumWorkspace>;
}
