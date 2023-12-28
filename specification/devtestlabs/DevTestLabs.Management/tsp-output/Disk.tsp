import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./User.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A Disk.")
@parentResource(User)
model Disk is TrackedResource<DiskProperties> {
  @doc("The name of the disk.")
  @key("name")
  @segment("disks")
  name: string;
}

@armResourceOperations
interface Disks {
  @doc("Get disk.")
  get is ArmResourceRead<
    Disk,
    {
      ...BaseParameters<Disk>;

      @doc("Specify the $expand query. Example: 'properties($select=diskType)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing disk. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Disk>;
  @doc("Allows modifying tags of disks. All other properties will be ignored.")
  update is ArmCustomPatchSync<Disk, DiskFragment>;
  @doc("Delete disk. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<Disk>;
  @doc("List disks in a given user profile.")
  list is ArmResourceListByParent<
    Disk,
    {
      ...BaseParameters<Disk>;

      @doc("Specify the $expand query. Example: 'properties($select=diskType)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;
  @doc("Attach and create the lease of the disk to the virtual machine. This operation can take a while to complete.")
  attach is ArmResourceActionAsync<Disk, AttachDiskProperties, void>;
  @doc("Detach and break the lease of the disk attached to the virtual machine. This operation can take a while to complete.")
  detach is ArmResourceActionAsync<Disk, DetachDiskProperties, void>;
}
