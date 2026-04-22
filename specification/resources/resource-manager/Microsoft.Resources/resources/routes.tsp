import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.Resources {
  // ================================
  // OPERATIONS INTERFACE
  // ================================

  interface Operations extends Azure.ResourceManager.Operations {}

  // ================================
  // RESOURCE GROUP OPERATIONS
  // ================================

  @armResourceOperations
  interface ResourceGroups {
    /** Gets a resource group. */
    @doc("Gets a resource group.")
    get is ArmResourceRead<ResourceGroup>;

    /** Creates or updates a resource group. */
    @doc("Creates or updates a resource group.")
    createOrUpdate is ArmResourceCreateOrReplaceSync<ResourceGroup>;

    /** Updates a resource group. */
    @doc("Updates a resource group.")
    update is ArmResourcePatchSync<ResourceGroup, ResourceGroupProperties>;

    /** Deletes a resource group. */
    @doc("When you delete a resource group, all of its resources are also deleted. Deleting a resource group deletes all of its template deployments and currently stored operations.")
    delete is ArmResourceDeleteWithoutOkAsync<ResourceGroup>;

    /** Gets all the resource groups for a subscription. */
    @doc("Gets all the resource groups for a subscription.")
    list is ArmListBySubscription<ResourceGroup>;
  }

  // ================================
  // RESOURCES OPERATIONS
  // ================================

  @armResourceOperations
  interface Resources {
    /** Gets a resource. */
    @doc("Gets a resource.")
    @get
    getById(
      /** The fully qualified ID of the resource, including the resource name and resource type. Use the format, /subscriptions/{guid}/resourceGroups/{resource-group-name}/{resource-provider-namespace}/{resource-type}/{resource-name} */
      @doc("The fully qualified ID of the resource, including the resource name and resource type. Use the format, /subscriptions/{guid}/resourceGroups/{resource-group-name}/{resource-provider-namespace}/{resource-type}/{resource-name}")
      @path
      resourceId: string,

      ...Azure.ResourceManager.ApiVersionParameter,
    ): ArmResponse<GenericResource> | ErrorResponse;

    /** Creates a resource. */
    @doc("Creates a resource.")
    createOrUpdateById is ArmResourceCreateOrReplaceAsync<GenericResource>;

    /** Updates a resource. */
    @doc("Updates a resource.")
    updateById is ArmResourcePatchAsync<
      GenericResource,
      GenericResourceProperties
    >;

    /** Deletes a resource. */
    @doc("Deletes a resource.")
    deleteById is ArmResourceDeleteWithoutOkAsync<GenericResource>;

    /** Get all the resources in a subscription. */
    @doc("Get all the resources in a subscription.")
    list is ArmListBySubscription<GenericResource>;

    /** Get all the resources for a resource group. */
    @doc("Get all the resources for a resource group.")
    @armResourceList(GenericResource)
    @get
    @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/resources")
    listByResourceGroup(
      ...Azure.ResourceManager.ApiVersionParameter,
      ...Azure.ResourceManager.SubscriptionIdParameter,
      ...Azure.ResourceManager.ResourceGroupParameter,
    ): ArmResponse<ResourceListResult> | ErrorResponse;
  }

  // ================================
  // BATCH OPERATIONS
  // ================================

  @armResourceOperations
  interface BatchOperations {
    /** Execute a batch of Azure Resource Manager operations at subscription scope. */
    @doc("Execute a batch of Azure Resource Manager operations at subscription scope.")
    @post
    @route("/subscriptions/{subscriptionId}/providers/Microsoft.Resources/batchOperations")
    invokeAtSubscriptionScope(
      /** The subscription ID. */
      @doc("The subscription ID.")
      @path
      subscriptionId: string,

      ...Azure.ResourceManager.ApiVersionParameter,

      @doc("Batch request containing multiple operations to execute.")
      @body
      batchRequest: BatchRequests,
    ): ArmResponse<BatchResponse> | ArmAcceptedLroResponse<"Batch operation accepted"> | ErrorResponse;

    /** Execute a batch of Azure Resource Manager operations at resource group scope. */
    @doc("Execute a batch of Azure Resource Manager operations at resource group scope.")
    @post
    @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Resources/batchOperations")
    invokeAtResourceGroupScope(
      /** The subscription ID. */
      @doc("The subscription ID.")
      @path
      subscriptionId: string,

      /** The resource group name. */
      @doc("The resource group name.")
      @path
      resourceGroupName: string,

      ...Azure.ResourceManager.ApiVersionParameter,

      @doc("Batch request containing multiple operations to execute.")
      @body
      batchRequest: BatchRequests,
    ): ArmResponse<BatchResponse> | ArmAcceptedLroResponse<"Batch operation accepted"> | ErrorResponse;
  }
}
