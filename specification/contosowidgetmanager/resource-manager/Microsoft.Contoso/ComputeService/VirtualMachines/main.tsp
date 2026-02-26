// VirtualMachines sub-service main.tsp
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
  title: "Contoso Virtual Machines Service",
})
@versioned(Versions)
namespace Microsoft.Contoso.ComputeService.VirtualMachines;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_01_01_preview: "2024-01-01-preview",
}

@doc("A virtual machine resource")
model VirtualMachine is TrackedResource<VirtualMachineProperties> {
  @key("vmName")
  @segment("virtualMachines")
  @doc("The name of the virtual machine")
  @path
  name: string;
}

@doc("Virtual machine properties")
model VirtualMachineProperties {
  @doc("The VM size")
  vmSize?: string;

  @doc("The OS type")
  osType?: OsType;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("OS type")
enum OsType {
  Windows,
  Linux,
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
interface VirtualMachines {
  get is ArmResourceRead<VirtualMachine>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualMachine>;
  delete is ArmResourceDeleteWithoutOkAsync<VirtualMachine>;
  listByResourceGroup is ArmResourceListByParent<VirtualMachine>;
  listBySubscription is ArmListBySubscription<VirtualMachine>;
}
