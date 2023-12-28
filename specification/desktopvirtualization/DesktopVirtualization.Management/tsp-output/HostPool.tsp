import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DesktopVirtualization;
@doc("Represents a HostPool definition.")
model HostPool is TrackedResource<HostPoolProperties> {
  @doc("The name of the host pool within the specified resource group")
  @maxLength(64)
  @minLength(3)
  @key("hostPoolName")
  @segment("hostPools")
  name: string;
}

@armResourceOperations
interface HostPools {
  @doc("Get a host pool.")
  get is ArmResourceRead<HostPool>;
  @doc("Create or update a host pool.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<HostPool>;
  @doc("Update a host pool.")
  update is ArmCustomPatchSync<HostPool, HostPoolPatch>;
  @doc("Remove a host pool.")
  delete is ArmResourceDeleteSync<
    HostPool,
    {
      ...BaseParameters<HostPool>;

      @doc("Force flag to delete sessionHost.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List hostPools.")
  listByResourceGroup is ArmResourceListByParent<
    HostPool,
    {
      ...BaseParameters<HostPool>;

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
  @doc("List hostPools in subscription.")
  list is ArmListBySubscription<HostPool>;
  @doc("Registration token of the host pool.")
  retrieveRegistrationToken is ArmResourceActionSync<
    HostPool,
    void,
    RegistrationInfo
  >;
}

@armResourceOperations
interface MsixImages {
  @doc("Expands and Lists MSIX packages in an Image, given the Image Path.")
  expand is ArmResourceActionSync<HostPool, MsixImageURI, ExpandMsixImageList>;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("List the private link resources available for this hostpool.")
  // FIXME: PrivateLinkResources_ListByHostPool could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/privateLinkResources")
  @get
  ListByHostPool is Azure.Core.Foundations.Operation<
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

      @doc("The name of the host pool within the specified resource group")
      @maxLength(64)
      @minLength(3)
      @path
      hostPoolName: string;

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

@armResourceOperations
interface ScalingPlans {
  @doc("List scaling plan associated with hostpool.")
  // FIXME: ScalingPlans_ListByHostPool could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/scalingPlans")
  @get
  ListByHostPool is Azure.Core.Foundations.Operation<
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

      @doc("The name of the host pool within the specified resource group")
      @maxLength(64)
      @minLength(3)
      @path
      hostPoolName: string;

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
    ResourceListResult<ScalingPlan>
  >;
}

@armResourceOperations
interface UserSessions {
  @doc("List userSessions.")
  // FIXME: UserSessions_ListByHostPool could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/userSessions")
  @get
  ListByHostPool is Azure.Core.Foundations.Operation<
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

      @doc("The name of the host pool within the specified resource group")
      @maxLength(64)
      @minLength(3)
      @path
      hostPoolName: string;

      @doc("OData filter expression. Valid properties for filtering are userprincipalname and sessionstate.")
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
    },
    ResourceListResult<UserSession>
  >;
}
