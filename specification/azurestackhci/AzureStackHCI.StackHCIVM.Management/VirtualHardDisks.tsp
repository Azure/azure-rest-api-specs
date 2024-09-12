import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-azure-resource legacy"
@doc("The virtual hard disk resource definition.")
@extension("x-ms-azure-resource", true)
model VirtualHardDisk is TrackedResource<VirtualHardDiskProperties> {
  @doc("Name of the virtual hard disk")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("virtualHardDiskName")
  @segment("virtualHardDisks")
  @visibility("read")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface VirtualHardDisks {
  @doc("Gets a virtual hard disk")
  get is ArmResourceRead<VirtualHardDisk>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("The operation to create or update a virtual hard disk. Please note some properties can be set only during virtual hard disk creation.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualHardDisk,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("The operation to update a virtual hard disk.")
  update is ArmTagsPatchAsync<VirtualHardDisk>;

  @doc("The operation to delete a virtual hard disk.")
  delete is ArmResourceDeleteWithoutOkAsync<VirtualHardDisk>;

  @doc("Lists all of the virtual hard disks in the specified resource group. Use the nextLink property in the response to get the next page of virtual hard disks.")
  listByResourceGroup is ArmResourceListByParent<VirtualHardDisk>;

  @doc("Lists all of the virtual hard disks in the specified subscription. Use the nextLink property in the response to get the next page of virtual hard disks.")
  listAll is ArmListBySubscription<VirtualHardDisk>;
}
