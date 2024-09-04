import "@typespec/openapi";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./hciCommon.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

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

////////models//////////////////

@doc("The Pool Type")
union PoolTypeEnum {
  @doc("The type is Mariner")
  Mariner: "Mariner",

  @doc("The type is WindowsIOT")
  WindowsIOT: "WindowsIOT",

  string,
}

@doc("The status of the resource")
union StatusEnum {
  @doc("The resource is healthy")
  Healthy: "Healthy",

  @doc("The resource needs attention")
  NeedAttention: "NeedAttention",

  string,
}

@doc("Allowed Node Categories for this Pool, based on the pool type")
model NodeModelDetails {
  @doc("The manufacturer of the node")
  manufacturer: string;

  @doc("The model name of the node")
  modelName: string;
}

@doc("Node property for the category")
model NodePropertyForTheCategory {
  @doc("The UID of the edge node category")
  edgeNodeCategoryUid: string;

  @doc("The list of node models")
  @extension("x-ms-identifiers", [])
  nodeModels: NodeModelDetails[];

  @doc("The count of nodes")
  nodeCount: int32;

  @doc("The number of cores")
  coreCount: int32;
}

@doc("The properties of Edge Node Pool")
model EdgeNodePoolResourceProperties {
  @doc("Pool Type")
  poolType: PoolTypeEnum;

  @doc("Properties of the pool")
  @extension("x-ms-identifiers", [])
  poolProperties: NodePropertyForTheCategory[];

  @doc("Allowed node categories for the pool based on the pool type")
  allowedNodeCategoriesUid: string[];

  @doc("Aggregated status of the node pool")
  status: StatusEnum;

  @doc("ArmIds of the nodes")
  nodeList: string[];

  @doc("ArmIds of the k8s configured using the Node Pool's Edge devices")
  k8sClusterList: string[];

  @doc("Provisioning state of the storage container")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
