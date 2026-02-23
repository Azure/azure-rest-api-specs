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
// HTTP METHOD ENUMS
// ================================

/** HTTP method enumeration for batch requests */
@doc("The HTTP method associated with the request.")
union HttpMethod {
  string,
  /** HTTP GET method */
  GET: "GET",
  /** HTTP PUT method */
  PUT: "PUT",
  /** HTTP PATCH method */
  PATCH: "PATCH",
  /** HTTP DELETE method */
  DELETE: "DELETE",
  /** HTTP POST method */
  POST: "POST",
}

// ================================
// BATCH API MODELS (Preview)
// ================================

/** Specifications for all of the requests that will be invoked as part of the batch. */
@doc("Specifications for all of the requests that will be invoked as part of the batch.")
model BatchRequests {
  /** The requests that will be invoked. */
  @doc("The requests that will be invoked.")
  requests: BatchRequest[];
}

/** The specification for one request that will be part of a larger batch. */
@doc("The specification for one request that will be part of a larger batch.")
model BatchRequest {
  /** The identifier for the request. Must be unique within a batch. */
  @doc("The identifier for the request. Must be unique within a batch.")
  id: string;

  /** The HTTP method associated with the request. */
  @doc("The HTTP method associated with the request.")
  method: HttpMethod;

  /** The request's absolute path. */
  @doc("The request's absolute path.")
  url: string;

  /** Headers that are specific to the request. */
  @doc("Headers that are specific to the request.")
  headers?: Record<string>;

  /** The body of the request. Not allowed for requests with an method of GET or DELETE. */
  @doc("The body of the request. Not allowed for requests with an method of GET or DELETE.")
  body?: unknown;
}

/** Responses for all requests contained in the batch. */
@doc("Responses for all requests contained in the batch.")
model BatchResponses {
  /** Responses for all requests contained in the batch. */
  @doc("Responses for all requests contained in the batch.")
  responses?: BatchResponse[];
}

/** The response received for one request in the batch. */
@doc("The response received for one request in the batch.")
model BatchResponse {
  /** The identifier of the request that generated the response. */
  @doc("The identifier of the request that generated the response.")
  id?: string;

  /** The HTTP status code of the response. */
  @doc("The HTTP status code of the response.")
  httpStatusCode?: int32;

  /** The status of the batch request. */
  @doc("The status of the batch request. The request is complete when the status is set to Succeeded, Failed, or Canceled.")
  status?: string;

  /** Headers that are specific to this response. */
  @doc("Headers that are specific to this response.")
  headers?: Record<string>;

  /** The body of the response. */
  @doc("The body of the response.")
  body?: unknown;
}

/** The result of the batch operation and each request within it. */
@doc("The result of the batch operation and each request within it.")
model BatchResponseStatus {
  ...Azure.Core.Foundations.OperationStatus;

  /** The final result of the batch operation. */
  @doc("The final result of the batch operation.")
  batchResult?: BatchResponses;

  /** If present, a GET on this URL will return the next page of results. */
  @doc("If present, a GET on this URL will return the next page of results.")
  nextLink?: string;
}

// ================================
// RESOURCE MODELS (Stable)
// ================================

/** Generic resource information. */
@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model GenericResource is Azure.ResourceManager.TrackedResource<GenericResourceProperties> {
  /** The name of the resource */
  @doc("The name of the resource")
  @path
  @key("resourceName")
  @segment("resources")
  name: string;
}

/** The resource properties. */
@doc("The resource properties.")
model GenericResourceProperties {
  /** The resource properties. */
  @doc("The resource properties.")
  properties?: unknown;
}

/** Resource group information. */
@doc("Resource group information.")
model ResourceGroup is Azure.ResourceManager.ExtensionResource<ResourceGroupProperties> {
  /** The name of the resource group. */
  @doc("The name of the resource group.")  
  @path
  @key("resourceGroupName")
  @segment("resourceGroups")
  name: string;

  /** Location of the resource group. It cannot be changed after the resource group has been created. It must be one of the supported Azure locations. */
  @doc("Location of the resource group. It cannot be changed after the resource group has been created. It must be one of the supported Azure locations.")
  location: string;

  /** The tags attached to the resource group. */
  @doc("The tags attached to the resource group.")
  tags?: Record<string>;

  /** The ID of the resource that manages this resource group. */
  @doc("The ID of the resource that manages this resource group.")  
  managedBy?: string;
}

/** The resource group properties. */
@doc("The resource group properties.")
model ResourceGroupProperties {
  /** The provisioning state. */
  @doc("The provisioning state.")
  provisioningState?: string;
}

/** List of resource groups. */
@doc("List of resource groups.")
model ResourceGroupListResult is Azure.Core.Page<ResourceGroup>;

/** List of resources. */
@doc("List of resources.")  
model ResourceListResult is Azure.Core.Page<GenericResource>;

// ================================
// OPERATIONS INTERFACE
// ================================

interface Operations extends Azure.ResourceManager.Operations {}

// ================================
// BATCH OPERATIONS (Preview)
// ================================

@armResourceOperations
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
  @patch
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