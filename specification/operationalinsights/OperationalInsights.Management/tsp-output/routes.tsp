import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;

interface DeletedWorkspacesOperations {
  @doc("Gets recently deleted workspaces in a subscription, available for recovery.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.OperationalInsights/deletedWorkspaces")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    WorkspaceListResult
  >;

  @doc("Gets recently deleted workspaces in a resource group, available for recovery.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/deletedWorkspaces")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    WorkspaceListResult
  >;
}
