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

namespace Microsoft.DataProtection;

model ResourceGuardResource is TrackedResource<ResourceGuard> {
  @doc("The name of ResourceGuard")
  @path
  @key("resourceGuardsName")
  @segment("resourceGuards")
  name: string;
}

@armResourceOperations
interface ResourceGuardResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a ResourceGuard belonging to a resource group.")
  @operationId("ResourceGuards_Get")
  get is ArmResourceRead<ResourceGuardResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a ResourceGuard resource belonging to a resource group.")
  @operationId("ResourceGuards_Put")
  put is ArmResourceCreateOrReplaceSync<ResourceGuardResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates a ResourceGuard resource belonging to a resource group. For example, updating tags for a resource.")
  @operationId("ResourceGuards_Patch")
  patch is ArmCustomPatchSync<ResourceGuardResource, PatchResourceGuardInput>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a ResourceGuard resource from the resource group.")
  @operationId("ResourceGuards_Delete")
  delete is ArmResourceDeleteSync<ResourceGuardResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns ResourceGuards collection belonging to a ResourceGroup.")
  @operationId("ResourceGuards_GetResourcesInResourceGroup")
  getResourcesInResourceGroup is ArmResourceListByParent<ResourceGuardResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns ResourceGuards collection belonging to a subscription.")
  @operationId("ResourceGuards_GetResourcesInSubscription")
  getResourcesInSubscription is ArmListBySubscription<ResourceGuardResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetDisableSoftDeleteRequestsObjects")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDisableSoftDeleteRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/disableSoftDeleteRequests")
  @get
  getDisableSoftDeleteRequestsObjects is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetDeleteResourceGuardProxyRequestsObjects")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDeleteResourceGuardProxyRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/deleteResourceGuardProxyRequests")
  @get
  getDeleteResourceGuardProxyRequestsObjects is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetBackupSecurityPINRequestsObjects")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetBackupSecurityPINRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/getBackupSecurityPINRequests")
  @get
  getBackupSecurityPINRequestsObjects is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetDeleteProtectedItemRequestsObjects")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDeleteProtectedItemRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/deleteProtectedItemRequests")
  @get
  getDeleteProtectedItemRequestsObjects is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetUpdateProtectionPolicyRequestsObjects")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetUpdateProtectionPolicyRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/updateProtectionPolicyRequests")
  @get
  getUpdateProtectionPolicyRequestsObjects is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetUpdateProtectedItemRequestsObjects")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetUpdateProtectedItemRequestsObjects could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/updateProtectedItemRequests")
  @get
  getUpdateProtectedItemRequestsObjects is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetDefaultDisableSoftDeleteRequestsObject")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultDisableSoftDeleteRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/disableSoftDeleteRequests/{requestName}")
  @get
  getDefaultDisableSoftDeleteRequestsObject is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetDefaultDeleteResourceGuardProxyRequestsObject")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultDeleteResourceGuardProxyRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/deleteResourceGuardProxyRequests/{requestName}")
  @get
  getDefaultDeleteResourceGuardProxyRequestsObject is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetDefaultBackupSecurityPINRequestsObject")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultBackupSecurityPINRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/getBackupSecurityPINRequests/{requestName}")
  @get
  getDefaultBackupSecurityPINRequestsObject is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetDefaultDeleteProtectedItemRequestsObject")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultDeleteProtectedItemRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/deleteProtectedItemRequests/{requestName}")
  @get
  getDefaultDeleteProtectedItemRequestsObject is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetDefaultUpdateProtectionPolicyRequestsObject")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultUpdateProtectionPolicyRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/updateProtectionPolicyRequests/{requestName}")
  @get
  getDefaultUpdateProtectionPolicyRequestsObject is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceGuards_GetDefaultUpdateProtectedItemRequestsObject")
  @summary("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  @doc("Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.")
  // FIXME: ResourceGuards_GetDefaultUpdateProtectedItemRequestsObject could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/resourceGuards/{resourceGuardsName}/updateProtectedItemRequests/{requestName}")
  @get
  getDefaultUpdateProtectedItemRequestsObject is Azure.Core.Foundations.Operation<
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

@@projectedName(ResourceGuardResources.put::parameters.resource,
  "json",
  "parameters"
);
@@extension(ResourceGuardResources.put::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ResourceGuardResources.put::parameters.resource,
  "Request body for operation"
);
@@projectedName(ResourceGuardResources.patch::parameters.properties,
  "json",
  "parameters"
);
@@extension(ResourceGuardResources.patch::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ResourceGuardResources.patch::parameters.properties,
  "Request body for operation"
);
