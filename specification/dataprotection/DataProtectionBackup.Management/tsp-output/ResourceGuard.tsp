import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataProtectionBackup;

model ResourceGuard is TrackedResource<ResourceGuard> {
  @doc("The name of ResourceGuard")
  @path
  @key("resourceGuardsName")
  @segment("resourceGuards")
  name: string;
}

@armResourceOperations
interface ResourceGuards {
  @doc("Returns a ResourceGuard belonging to a resource group.")
  get is ArmResourceRead<ResourceGuard>;
  @doc("Creates or updates a ResourceGuard resource belonging to a resource group.")
  put is ArmResourceCreateOrReplaceSync<ResourceGuard>;
  @doc("Updates a ResourceGuard resource belonging to a resource group. For example, updating tags for a resource.")
  patch is ArmTagsPatchSync<ResourceGuard>;
  @doc("Deletes a ResourceGuard resource from the resource group.")
  delete is ArmResourceDeleteSync<ResourceGuard>;
  @doc("Returns ResourceGuards collection belonging to a ResourceGroup.")
  getResourcesInResourceGroup is ArmResourceListByParent<ResourceGuard>;
  @doc("Returns ResourceGuards collection belonging to a subscription.")
  getResourcesInSubscription is ArmListBySubscription<ResourceGuard>;
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
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
