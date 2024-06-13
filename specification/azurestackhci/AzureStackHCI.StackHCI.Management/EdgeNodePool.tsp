import "@typespec/openapi";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("An EdgePoolNodeResource")
@includeInapplicableMetadataInPayload(false)
model EdgeNodePoolResource is TrackedResource<EdgeNodePoolResourceProperties> {
  @doc("An edge node pool resource")
  @key("nodePoolName")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("edgeNodePools")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface EdgeNodePool {
  @doc("Gets an Edge Node Pool Resource.")
  get is ArmResourceRead<EdgeNodePoolResource>;

  @doc("The operation to create or update an Edge Node Pool Resource.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeNodePoolResource>;

  @doc("The operation to update an Edge Node Pool Resource.")
  update is ArmResourcePatchAsync<
    EdgeNodePoolResource,
    EdgeNodePoolResourceProperties
  >;

  @doc("The operation to delete an Edge Node Pool Resource.")
  delete is ArmResourceDeleteWithoutOkAsync<EdgeNodePoolResource>;

  @doc("The operation to list all the Edge Node Pool Resources by specified resource group.")
  listByResourceGroup is ArmResourceListByParent<EdgeNodePoolResource>;

  @doc("The operation to list all the Edge Node Pool Resources by specified subscription.")
  listBySubscription is ArmListBySubscription<EdgeNodePoolResource>;
}
