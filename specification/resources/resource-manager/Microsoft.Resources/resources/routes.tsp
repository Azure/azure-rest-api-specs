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
// ================================
// ================================

interface Operations extends Azure.ResourceManager.Operations {}

// ================================
// BATCH OPERATIONS (Preview)
// ================================

@armResourceOperations
@added(Versions.v2025_08_01_preview)
interface BatchOperations {
  /** Invokes a batch of individual Azure Resource Manager requests at a subscription scope. */
  @doc("The batch API can be used to invoke multiple Azure Resource Manager requests at once. Batches are processed asynchronously and allow for more efficient handling of many concurrent requests.")
  @post
  @armResourceAction(BatchResponseStatus)
  invokeAtSubscriptionScope(
    ...Azure.ResourceManager.Foundations.SubscriptionScope<{}>,
    @doc("Specifications for all of the requests that will be invoked as part of the batch.")
    @body
    parameters: BatchRequests,
  ): ArmResponse<BatchResponseStatus> | ArmAcceptedLroResponse<"The batch was accepted and has begun processing.", BatchResponseStatus>;

  /** Invokes a batch of individual Azure Resource Manager requests at a resource group scope. */
  @doc("The batch API can be used to invoke multiple Azure Resource Manager requests at once. Batches are processed asynchronously and allow for more efficient handling of many concurrent requests.")
  @post
  @armResourceAction(BatchResponseStatus)
  invokeAtResourceGroupScope(
    ...Azure.ResourceManager.Foundations.ResourceGroupScope<{}>,
    @doc("Specifications for all of the requests that will be invoked as part of the batch.")
    @body
    parameters: BatchRequests,
  ): ArmResponse<BatchResponseStatus> | ArmAcceptedLroResponse<"The batch was accepted and has begun processing.", BatchResponseStatus>;
}

// ================================
// RESOURCE GROUP OPERATIONS (Stable)
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
// RESOURCES OPERATIONS (Stable)
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

    @doc("The API version to use for the operation.")
    @query("api-version")
    apiVersion: string,
  ): ArmResponse<GenericResource> | ErrorResponse;

  /** Creates a resource. */
  @doc("Creates a resource.")
  @put
  @OpenAPI.extension("x-ms-long-running-operation", true)
  createOrUpdateById(
    /** The fully qualified ID of the resource, including the resource name and resource type. Use the format, /subscriptions/{guid}/resourceGroups/{resource-group-name}/{resource-provider-namespace}/{resource-type}/{resource-name} */
    @doc("The fully qualified ID of the resource, including the resource name and resource type. Use the format, /subscriptions/{guid}/resourceGroups/{resource-group-name}/{resource-provider-namespace}/{resource-type}/{resource-name}")
    @path
    resourceId: string,

    @doc("The API version to use for the operation.")
    @query("api-version")
    apiVersion: string,

    @doc("Create or update resource parameters.")
    @body
    parameters: GenericResource,
  ): ArmResponse<GenericResource> | ArmAcceptedLroResponse<"Resource creation/update accepted", GenericResource> | ErrorResponse;

  /** Updates a resource. */
  @doc("Updates a resource.")
  @patch(#{implicitOptionality: true})
  @OpenAPI.extension("x-ms-long-running-operation", true)
  updateById(
    /** The fully qualified ID of the resource, including the resource name and resource type. Use the format, /subscriptions/{guid}/resourceGroups/{resource-group-name}/{resource-provider-namespace}/{resource-type}/{resource-name} */
    @doc("The fully qualified ID of the resource, including the resource name and resource type. Use the format, /subscriptions/{guid}/resourceGroups/{resource-group-name}/{resource-provider-namespace}/{resource-type}/{resource-name}")
    @path
    resourceId: string,

    @doc("The API version to use for the operation.")
    @query("api-version")
    apiVersion: string,

    @doc("Update resource parameters.")
    @body
    parameters: GenericResource,
  ): ArmResponse<GenericResource> | ArmAcceptedLroResponse<"Resource update accepted", GenericResource> | ErrorResponse;

  /** Deletes a resource. */
  @doc("Deletes a resource.")
  @delete
  @OpenAPI.extension("x-ms-long-running-operation", true)
  deleteById(
    /** The fully qualified ID of the resource, including the resource name and resource type. Use the format, /subscriptions/{guid}/resourceGroups/{resource-group-name}/{resource-provider-namespace}/{resource-type}/{resource-name} */
    @doc("The fully qualified ID of the resource, including the resource name and resource type. Use the format, /subscriptions/{guid}/resourceGroups/{resource-group-name}/{resource-provider-namespace}/{resource-type}/{resource-name}")
    @path
    resourceId: string,

    @doc("The API version to use for the operation.")
    @query("api-version")
    apiVersion: string,
  ): ArmResponse<GenericResource> | ArmAcceptedLroResponse<"Resource deletion accepted", GenericResource> | ErrorResponse;

  /** Get all the resources in a subscription. */
  @doc("Get all the resources in a subscription.")
  list is ArmListBySubscription<GenericResource>;

  /** Get all the resources for a resource group. */
  @doc("Get all the resources for a resource group.")
  listByResourceGroup is ArmResourceListByParent<GenericResource, ResourceGroup>;
}

}