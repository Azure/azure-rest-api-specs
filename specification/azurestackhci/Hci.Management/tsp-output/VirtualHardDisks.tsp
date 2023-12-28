import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("The virtual hard disk resource definition.")
model VirtualHardDisks is TrackedResource<VirtualHardDiskProperties> {
  @doc("Name of the virtual hard disk")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @key("virtualHardDiskName")
  @segment("virtualHardDisks")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface VirtualHardDisks {
  @doc("Gets a virtual hard disk")
  get is ArmResourceRead<VirtualHardDisks>;
  @doc("The operation to create or update a virtual hard disk. Please note some properties can be set only during virtual hard disk creation.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualHardDisks>;
  @doc("The operation to update a virtual hard disk.")
  update is ArmCustomPatchAsync<
    VirtualHardDisks,
    VirtualHardDisksUpdateRequest
  >;
  @doc("The operation to delete a virtual hard disk.")
  delete is ArmResourceDeleteWithoutOkAsync<VirtualHardDisks>;
  @doc("Lists all of the virtual hard disks in the specified resource group. Use the nextLink property in the response to get the next page of virtual hard disks.")
  list is ArmResourceListByParent<VirtualHardDisks>;
  @doc("Lists all of the virtual hard disks in the specified subscription. Use the nextLink property in the response to get the next page of virtual hard disks.")
  listAll is ArmListBySubscription<VirtualHardDisks>;
}
