// ComputeService main.tsp - Service level TypeSpec project
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Contoso Compute Service",
})
@versioned(Versions)
namespace Microsoft.Contoso.ComputeService;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_01_01_preview: "2024-01-01-preview",
}

@doc("A compute resource")
model ComputeResource is TrackedResource<ComputeResourceProperties> {
  @key("computeName")
  @segment("computes")
  @doc("The name of the compute resource")
  @path
  name: string;
}

@doc("Compute resource properties")
model ComputeResourceProperties {
  @doc("The compute type")
  computeType?: string;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Provisioning state")
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Deleting,
}

@armResourceOperations
interface ComputeResources {
  get is ArmResourceRead<ComputeResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ComputeResource>;
  delete is ArmResourceDeleteWithoutOkAsync<ComputeResource>;
  listByResourceGroup is ArmResourceListByParent<ComputeResource>;
  listBySubscription is ArmListBySubscription<ComputeResource>;
}
