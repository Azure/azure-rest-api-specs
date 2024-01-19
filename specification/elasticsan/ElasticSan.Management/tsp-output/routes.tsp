import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.OperationalInsights;

interface DeletedWorkspacesOperations {
  @doc("Gets recently deleted workspaces in a subscription, available for recovery.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.OperationalInsights/deletedWorkspaces")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ResourceListResult<Workspace>
  >;

  @doc("Gets recently deleted workspaces in a resource group, available for recovery.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/deletedWorkspaces")
  @get
  listByResourceGroup is Azure.Core.Foundations.Operation<
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
    ResourceListResult<Workspace>
  >;
}
