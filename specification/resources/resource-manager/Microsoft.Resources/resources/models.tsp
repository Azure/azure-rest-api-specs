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

}