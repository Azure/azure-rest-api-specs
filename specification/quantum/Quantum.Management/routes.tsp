import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.Quantum;

interface WorkspacesOperations {
  @doc("Returns the Workspace resource associated with the given name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the quantum workspace resource.")
      @path
      workspaceName: string;
    },
    QuantumWorkspace
  >;

  @doc("Creates or updates a workspace resource.")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [QuantumWorkspace]
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the quantum workspace resource.")
      @path
      workspaceName: string;

      @doc("Workspace details.")
      @body
      QuantumWorkspace: QuantumWorkspace;
    },
    QuantumWorkspace
  >;

  @doc("Updates an existing workspace's tags.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}")
  @patch
  UpdateTags is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the quantum workspace resource.")
      @path
      workspaceName: string;

      @doc("Parameters supplied to update tags.")
      @body
      workspaceTags: TagsObject;
    },
    QuantumWorkspace
  >;

  @doc("Deletes a Workspace resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the quantum workspace resource.")
      @path
      workspaceName: string;
    },
    void
  >;

  @doc("Gets the list of Workspaces within a Subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Quantum/workspaces")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    WorkspaceListResult
  >;

  @doc("Gets the list of Workspaces within a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    WorkspaceListResult
  >;
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
