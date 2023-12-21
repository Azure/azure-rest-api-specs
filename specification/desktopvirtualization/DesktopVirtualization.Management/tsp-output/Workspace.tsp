import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DesktopVirtualization;
@doc("Represents a Workspace definition.")
model Workspace is TrackedResource<WorkspaceProperties> {
  @doc("The name of the workspace")
  @maxLength(64)
  @minLength(3)
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;
}

@armResourceOperations
interface Workspaces {
  @doc("Get a workspace.")
  get is ArmResourceRead<Workspace>;
  @doc("Create or update a workspace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Workspace>;
  @doc("Update a workspace.")
  update is ArmResourcePatchSync<Workspace, WorkspaceProperties>;
  @doc("Remove a workspace.")
  delete is ArmResourceDeleteSync<Workspace>;
  @doc("List workspaces.")
  listByResourceGroup is ArmResourceListByParent<
    Workspace,
    {
      ...BaseParameters<Workspace>;

      @doc("Number of items per page.")
      @query("pageSize")
      pageSize?: int32;

      @doc("Indicates whether the collection is descending.")
      @query("isDescending")
      isDescending?: boolean;

      @doc("Initial number of items to skip.")
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;
  @doc("List workspaces in subscription.")
  listBySubscription is ArmListBySubscription<Workspace>;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("List the private link resources available for this workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateLinkResources")
  @get
  ListByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace")
      @maxLength(64)
      @minLength(3)
      @path
      workspaceName: string;

      @doc("Number of items per page.")
      @query("pageSize")
      pageSize?: int32;

      @doc("Indicates whether the collection is descending.")
      @query("isDescending")
      isDescending?: boolean;

      @doc("Initial number of items to skip.")
      @query("initialSkip")
      initialSkip?: int32;
    },
    PrivateLinkResourceListResult
  >;
}
