import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureStackHCI;

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

@doc("The Provisioning state of the resource")
union ProvisioningState {
  ResourceProvisioningState,

  @doc("The resource provisioning is in progress")
  InProgress: "InProgress",

  @doc("The request has been accepted")
  Accepted: "Accepted",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

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
