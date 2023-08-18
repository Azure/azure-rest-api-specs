import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.Quantum;

@armResourceOperations
interface WorkspacesOperations {
  @doc("Returns the Workspace resource associated with the given name.")
  get is ArmResourceRead<QuantumWorkspace>;

  @doc("Creates or updates a workspace resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<QuantumWorkspace>;

  @doc("Deletes a Workspace resource.")
  delete is ArmResourceDeleteSync<QuantumWorkspace>;

  @doc("Updates an existing workspace's tags.")
  updateTags is ArmResourcePatchSync<QuantumWorkspace, WorkspaceResourceProperties>;

  @doc("Gets the list of Workspaces within a Subscription.")
  listByResourceGroup is ArmResourceListByParent<QuantumWorkspace>;

  @doc("Gets the list of Workspaces within a Subscription.")
  listBySubscription is ArmListBySubscription<QuantumWorkspace>;
}

@armResourceOperations
interface OfferingsOperations {
}

@armResourceOperations
interface WorkspaceOperations {
  @doc("Check the availability of the resource name.")
  checkNameAvailability is checkLocalNameAvailability<QuantumWorkspace>;
}
