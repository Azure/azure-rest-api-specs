import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataProtection;

model ResourceGuardResource is TrackedResource<ResourceGuard> {
  @doc("The name of ResourceGuard")
  @key("resourceGuardsName")
  @segment("resourceGuards")
  name: string;
}

@armResourceOperations
@projectedName("client", "ResourceGuards")
interface ResourceGuardResources_ResourceGuards {
  @doc("Returns a ResourceGuard belonging to a resource group.")
  get is ArmResourceRead<ResourceGuardResource>;

  @doc("Creates or updates a ResourceGuard resource belonging to a resource group.")
  put is ArmResourceCreateOrReplaceSync<ResourceGuardResource>;

  @doc("Updates a ResourceGuard resource belonging to a resource group. For example, updating tags for a resource.")
  patch is ArmCustomPatchSync<ResourceGuardResource, PatchResourceGuardInput>;

  @doc("Deletes a ResourceGuard resource from the resource group.")
  delete is ArmResourceDeleteSync<ResourceGuardResource>;

  @doc("Returns ResourceGuards collection belonging to a ResourceGroup.")
  getResourcesInResourceGroup is ArmResourceListByParent<ResourceGuardResource>;

  @doc("Returns ResourceGuards collection belonging to a subscription.")
  getResourcesInSubscription is ArmListBySubscription<ResourceGuardResource>;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDisableSoftDeleteRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/disableSoftDeleteRequests")
  @get
  GetDisableSoftDeleteRequestsObjects is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;
    },
    DppBaseResourceList
  >;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDeleteResourceGuardProxyRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/deleteResourceGuardProxyRequests")
  @get
  GetDeleteResourceGuardProxyRequestsObjects is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;
    },
    DppBaseResourceList
  >;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetBackupSecurityPINRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/getBackupSecurityPINRequests")
  @get
  GetBackupSecurityPINRequestsObjects is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;
    },
    DppBaseResourceList
  >;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDeleteProtectedItemRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/deleteProtectedItemRequests")
  @get
  GetDeleteProtectedItemRequestsObjects is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;
    },
    DppBaseResourceList
  >;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetUpdateProtectionPolicyRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/updateProtectionPolicyRequests")
  @get
  GetUpdateProtectionPolicyRequestsObjects is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;
    },
    DppBaseResourceList
  >;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetUpdateProtectedItemRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/updateProtectedItemRequests")
  @get
  GetUpdateProtectedItemRequestsObjects is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;
    },
    DppBaseResourceList
  >;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultDisableSoftDeleteRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/disableSoftDeleteRequests/{requestName}")
  @get
  GetDefaultDisableSoftDeleteRequestsObject is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;

      @path
      requestName: string;
    },
    ResourceGuardProtectedObjectData
  >;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultDeleteResourceGuardProxyRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/deleteResourceGuardProxyRequests/{requestName}")
  @get
  GetDefaultDeleteResourceGuardProxyRequestsObject is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;

      @path
      requestName: string;
    },
    ResourceGuardProtectedObjectData
  >;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultBackupSecurityPINRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/getBackupSecurityPINRequests/{requestName}")
  @get
  GetDefaultBackupSecurityPINRequestsObject is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;

      @path
      requestName: string;
    },
    ResourceGuardProtectedObjectData
  >;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultDeleteProtectedItemRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/deleteProtectedItemRequests/{requestName}")
  @get
  GetDefaultDeleteProtectedItemRequestsObject is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;

      @path
      requestName: string;
    },
    ResourceGuardProtectedObjectData
  >;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultUpdateProtectionPolicyRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/updateProtectionPolicyRequests/{requestName}")
  @get
  GetDefaultUpdateProtectionPolicyRequestsObject is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;

      @path
      requestName: string;
    },
    ResourceGuardProtectedObjectData
  >;

  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultUpdateProtectedItemRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/updateProtectedItemRequests/{requestName}")
  @get
  GetDefaultUpdateProtectedItemRequestsObject is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      resourceGuardsName: string;

      @path
      requestName: string;
    },
    ResourceGuardProtectedObjectData
  >;
}
