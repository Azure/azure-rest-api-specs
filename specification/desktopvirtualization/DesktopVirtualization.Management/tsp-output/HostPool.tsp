import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
@doc("Represents a HostPool definition.")
model HostPool is TrackedResource<HostPoolProperties> {
  @doc("The name of the host pool within the specified resource group")
  @maxLength(64)
  @minLength(3)
  @path
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Expands and Lists MSIX packages in an Image, given the Image Path.")
  @operationId("MsixImages_Expand")
  expand is ArmResourceActionSync<HostPool, MsixImageURI, ExpandMsixImageList>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByHostPool")
  @doc("List the private link resources available for this hostpool.")
  // FIXME: PrivateLinkResources_ListByHostPool could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/privateLinkResources")
  @get
  listByHostPool is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScalingPlans_ListByHostPool")
  @doc("List scaling plan associated with hostpool.")
  // FIXME: ScalingPlans_ListByHostPool could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/scalingPlans")
  @get
  listByHostPool is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UserSessions_ListByHostPool")
  @doc("List userSessions.")
  // FIXME: UserSessions_ListByHostPool could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/userSessions")
  @get
  listByHostPool is Azure.Core.Foundations.Operation<
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

@@projectedName(HostPools.createOrUpdate::parameters.resource,
  "json",
  "hostPool"
);
@@extension(HostPools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "hostPool"
);
@@doc(HostPools.createOrUpdate::parameters.resource,
  "Object containing HostPool definitions."
);
@@projectedName(HostPools.update::parameters.properties, "json", "hostPool");
@@extension(HostPools.update::parameters.properties,
  "x-ms-client-name",
  "hostPool"
);
@@doc(HostPools.update::parameters.properties,
  "Object containing HostPool definitions."
);
@@projectedName(HostPools.expand::parameters.body, "json", "msixImageURI");
@@extension(HostPools.expand::parameters.body,
  "x-ms-client-name",
  "msixImageURI"
);
@@doc(HostPools.expand::parameters.body, "Object containing URI to MSIX Image");
