import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO - x-ms-azure-resource is this needed?"
@doc("The virtual hard disk resource definition.")
@extension("x-ms-azure-resource", true)
model VirtualHardDisk is TrackedResource<VirtualHardDiskProperties> {
  @doc("Name of the virtual hard disk")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("virtualHardDiskName")
  @segment("virtualHardDisks")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface VirtualHardDisks {
  @doc("Gets a virtual hard disk")
  get is ArmResourceRead<VirtualHardDisk>;

  @doc("The operation to create or update a virtual hard disk. Please note some properties can be set only during virtual hard disk creation.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualHardDisk>;

  @doc("The operation to update a virtual hard disk.")
  @removed(Versions.v2025_02_01_preview)
  @sharedRoute
  @renamedFrom(Versions.v2025_02_01_preview, "update")
  updateOld is ArmTagsPatchAsync<VirtualHardDisk>;

  @doc("The operation to update a virtual hard disk.")
  @patch(#{ implicitOptionality: false })
  @added(Versions.v2025_02_01_preview)
  @sharedRoute
  update is ArmCustomPatchAsync<VirtualHardDisk, VirtualHardDisksUpdateRequest>;

  @doc("The operation to delete a virtual hard disk.")
  delete is ArmResourceDeleteWithoutOkAsync<VirtualHardDisk>;

  @doc("Lists all of the virtual hard disks in the specified resource group. Use the nextLink property in the response to get the next page of virtual hard disks.")
  listByResourceGroup is ArmResourceListByParent<VirtualHardDisk>;

  @doc("Lists all of the virtual hard disks in the specified subscription. Use the nextLink property in the response to get the next page of virtual hard disks.")
  listAll is ArmListBySubscription<VirtualHardDisk>;

  @added(Versions.v2024_08_01_preview)
  @doc("The operation to upload a virtual hard disk.")
  upload is ArmResourceActionAsync<
    VirtualHardDisk,
    VirtualHardDiskUploadRequest,
    VirtualHardDiskUploadResponse
  >;
}
