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

interface OfferingsOperations {
  @doc("Returns the list of all provider offerings available for the given location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Quantum/locations/{locationName}/offerings")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Location.")
      @path
      locationName: string;
    },
    OfferingsListResult
  >;
}

interface OperationsOperations {
  @doc("Returns list of operations.")
  @route("/providers/Microsoft.Quantum/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationsList>;
}

interface WorkspaceOperations {
  @doc("Check the availability of the resource name.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Quantum/locations/{locationName}/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Location.")
      @path
      locationName: string;

      @doc("The name and type of the resource.")
      @body
      checkNameAvailabilityParameters: CheckNameAvailabilityParameters;
    },
    CheckNameAvailabilityResult
  >;
}
