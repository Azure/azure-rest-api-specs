import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Resources {

// ================================
// RESOURCE MODELS 
// ================================

/** Generic resource information. */
@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model GenericResource is Azure.ResourceManager.TrackedResource<GenericResourceProperties> {
  /** The name of the resource */
  @doc("The name of the resource")
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
  @key("resourceGroupName")
  @segment("resourceGroups")
  name: string;

  /** The location of the resource group. */
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
// BATCH OPERATION MODELS
// ================================

/** Batch request definition. */
@doc("Batch request definition.")
model BatchRequest {
  /** The HTTP method for the request. */
  @doc("The HTTP method for the request.")
  httpMethod: "GET" | "PUT" | "PATCH" | "DELETE" | "POST";

  /** The relative URL for the request. */
  @doc("The relative URL for the request.")
  relativeUrl: string;

  /** Optional name to identify this request within the batch. */
  @doc("Optional name to identify this request within the batch.")
  name?: string;

  /** The request body (for PUT/PATCH/POST operations). */
  @doc("The request body (for PUT/PATCH/POST operations).")
  body?: unknown;

  /** Request headers. */
  @doc("Request headers.")
  headers?: Record<string>;

  /** List of request names that this request depends on. */
  @doc("List of request names that this request depends on.")
  dependsOn?: string[];
}

/** Collection of batch requests. */
@doc("Collection of batch requests.")
model BatchRequests {
  /** The batch requests to execute. */
  @doc("The batch requests to execute.")
  requests: BatchRequest[];
}

/** Batch response status enumeration. */
@doc("Batch response status enumeration.")
union BatchResponseStatus {
  /** The request succeeded. */
  "Succeeded",

  /** The request failed. */
  "Failed",

  /** The request was processed but failed validation. */
  "ValidationFailed",

  /** The request was skipped due to dependency failure. */
  "Skipped",

  string,
}

/** Individual response within a batch response. */
@doc("Individual response within a batch response.")
model BatchResponseItem {
  /** The name of the request (if provided in the batch request). */
  @doc("The name of the request (if provided in the batch request).")
  name?: string;

  /** The HTTP status code of the response. */
  @doc("The HTTP status code of the response.")
  statusCode: int32;

  /** The status of the batch response item. */
  @doc("The status of the batch response item.")
  status: BatchResponseStatus;

  /** The response body. */
  @doc("The response body.")
  body?: unknown;

  /** Response headers. */
  @doc("Response headers.")
  headers?: Record<string>;
}

/** Batch operation response. */
@doc("Batch operation response.")
model BatchResponse {
  /** Individual responses within the batch. */
  @doc("Individual responses within the batch.")
  responses: BatchResponseItem[];
}

}