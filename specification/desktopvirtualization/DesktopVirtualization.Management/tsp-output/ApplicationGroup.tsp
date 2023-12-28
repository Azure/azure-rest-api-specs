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
model ApplicationGroup is TrackedResource<ApplicationGroupProperties> {
  @doc("The name of the application group")
  @maxLength(64)
  @minLength(3)
  @key("applicationGroupName")
  @segment("applicationGroups")
  name: string;
}

@armResourceOperations
interface ApplicationGroups {
  @doc("Get an application group.")
  get is ArmResourceRead<ApplicationGroup>;
  @doc("Create or update an applicationGroup.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApplicationGroup>;
  @doc("Update an applicationGroup.")
  update is ArmCustomPatchSync<ApplicationGroup, ApplicationGroupPatch>;
  @doc("Remove an applicationGroup.")
  delete is ArmResourceDeleteSync<ApplicationGroup>;
  @doc("List applicationGroups.")
  listByResourceGroup is ArmResourceListByParent<
    ApplicationGroup,
    {
      ...BaseParameters<ApplicationGroup>;

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
  listBySubscription is ArmListBySubscription<ApplicationGroup>;
}

@armResourceOperations
interface StartMenuItems {
  @doc("List start menu items in the given application group.")
  // FIXME: StartMenuItems_List could not be converted to a resource operation
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
