import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DesktopVirtualization;
@doc("Represents a ApplicationGroup definition.")
model VirtualApplicationGroup is TrackedResource<ApplicationGroupProperties> {
  @doc("The name of the application group")
  @maxLength(64)
  @minLength(3)
  @path
  @key("applicationGroupName")
  @segment("applicationGroups")
  name: string;
}

@armResourceOperations
interface VirtualApplicationGroups {
  @doc("Get an application group.")
  get is ArmResourceRead<VirtualApplicationGroup>;
  @doc("Create or update an applicationGroup.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<VirtualApplicationGroup>;
  @doc("Update an applicationGroup.")
  update is ArmResourcePatchSync<
    VirtualApplicationGroup,
    ApplicationGroupProperties
  >;
  @doc("Remove an applicationGroup.")
  delete is ArmResourceDeleteSync<VirtualApplicationGroup>;
  @doc("List applicationGroups.")
  listByResourceGroup is ArmResourceListByParent<
    VirtualApplicationGroup,
    {
      ...BaseParameters<VirtualApplicationGroup>;

      @doc("OData filter expression. Valid properties for filtering are applicationGroupType.")
      @query("$filter")
      $filter?: string;

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
  @doc("List applicationGroups in subscription.")
  listBySubscription is ArmListBySubscription<VirtualApplicationGroup>;
  @doc("List start menu items in the given application group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}/startMenuItems")
  @get
  List is Azure.Core.Foundations.Operation<
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

      @doc("The name of the application group")
      @maxLength(64)
      @minLength(3)
      @path
      applicationGroupName: string;

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
    StartMenuItemList
  >;
}
