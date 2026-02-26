// Disks sub-service main.tsp
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
  title: "Contoso Disks Service",
})
@versioned(Versions)
namespace Microsoft.Contoso.ComputeService.Disks;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_01_01_preview: "2024-01-01-preview",
}

@doc("A disk resource")
model Disk is TrackedResource<DiskProperties> {
  @key("diskName")
  @segment("disks")
  @doc("The name of the disk")
  @path
  name: string;
}

@doc("Disk properties")
model DiskProperties {
  @doc("The disk size in GB")
  diskSizeGB?: int32;

  @doc("The disk type")
  diskType?: DiskType;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Disk type")
enum DiskType {
  Standard_LRS,
  Premium_LRS,
  StandardSSD_LRS,
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
interface Disks {
  get is ArmResourceRead<Disk>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Disk>;
  delete is ArmResourceDeleteWithoutOkAsync<Disk>;
  listByResourceGroup is ArmResourceListByParent<Disk>;
  listBySubscription is ArmListBySubscription<Disk>;
}
