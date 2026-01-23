import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Discovery.Management.Shared/all.tsp";
import "./supercomputer.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using Microsoft.Discovery.Shared;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Supported Azure VM Sizes.")
union VmSize {
  @doc("Standard_NC24ads_A100_v4 GPU-optimized Azure VM Size")
  Standard_NC24ads_A100_v4: "Standard_NC24ads_A100_v4",

  @doc("Standard_NC48ads_A100_v4 GPU-optimized Azure VM Size")
  Standard_NC48ads_A100_v4: "Standard_NC48ads_A100_v4",

  @doc("Standard_NC96ads_A100_v4 GPU-optimized Azure VM Size")
  Standard_NC96ads_A100_v4: "Standard_NC96ads_A100_v4",

  @doc("Standard_NC4as_T4_v3 GPU-optimized Azure VM Size")
  Standard_NC4as_T4_v3: "Standard_NC4as_T4_v3",

  @doc("Standard_NC8as_T4_v3 GPU-optimized Azure VM Size")
  Standard_NC8as_T4_v3: "Standard_NC8as_T4_v3",

  @doc("Standard_NC16as_T4_v3 GPU-optimized Azure VM Size")
  Standard_NC16as_T4_v3: "Standard_NC16as_T4_v3",

  @doc("Standard_NC64as_T4_v3 GPU-optimized Azure VM Size")
  Standard_NC64as_T4_v3: "Standard_NC64as_T4_v3",

  @doc("Standard_NV6ads_A10_v5 GPU-optimized Azure VM Size")
  Standard_NV6ads_A10_v5: "Standard_NV6ads_A10_v5",

  @doc("Standard_NV12ads_A10_v5 GPU-optimized Azure VM Size")
  Standard_NV12ads_A10_v5: "Standard_NV12ads_A10_v5",

  @doc("Standard_NV24ads_A10_v5 GPU-optimized Azure VM Size")
  Standard_NV24ads_A10_v5: "Standard_NV24ads_A10_v5",

  @doc("Standard_NV36ads_A10_v5 GPU-optimized Azure VM Size")
  Standard_NV36ads_A10_v5: "Standard_NV36ads_A10_v5",

  @doc("Standard_NV36ads_A10_v5 GPU-optimized Azure VM Size")
  Standard_NV36adms_A10_v5: "Standard_NV36adms_A10_v5",

  @doc("Standard_NV36ads_A10_v5 GPU-optimized Azure VM Size")
  Standard_NV72ads_A10_v5: "Standard_NV72ads_A10_v5",

  @doc("Standard_ND40rs_v2 GPU-optimized Azure VM Size")
  Standard_ND40rs_v2: "Standard_ND40rs_v2",

  string,
}

@doc("Supported Virtual Machine Scale Set priorities.")
@added(Versions.v2026_02_01_preview)
union ScaleSetPriority {
  @doc("Regular priority Virtual Machine Scale Set.")
  Regular: "Regular",

  @doc("Spot priority Virtual Machine Scale Set.")
  Spot: "Spot",

  string,
}

@doc("NodePool tracked resource")
@parentResource(Supercomputer)
model NodePool is TrackedResource<NodePoolProperties> {
  ...ResourceNameParameter<NodePool>;
}

@doc("NodePool properties")
model NodePoolProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The subnet.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId: Microsoft.Discovery.Shared.SubnetId;

  @doc("The Size of the underlying Azure VM.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmSize: VmSize;

  @doc("The maximum number of nodes.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minValue(1)
  maxNodeCount: int32;

  @doc("The minimum number of nodes.")
  @minValue(0)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  minNodeCount?: int32 = 0;

  @doc("The Virtual Machine Scale Set priority. If not specified, the default is 'Regular'.")
  @added(Versions.v2026_02_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  scaleSetPriority?: ScaleSetPriority = ScaleSetPriority.Regular;
}

@armResourceOperations
interface NodePools {
  get is ArmResourceRead<NodePool>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NodePool>;
  update is ArmResourcePatchAsync<NodePool, NodePoolProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<NodePool>;
  listBySupercomputer is ArmResourceListByParent<NodePool>;

  @removed(Microsoft.Discovery.Versions.v2026_02_01_preview)
  listBySubscription is ArmListBySubscription<NodePool>;
}
