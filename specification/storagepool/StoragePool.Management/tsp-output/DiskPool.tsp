import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.StoragePool;
@doc("Response for Disk Pool request.")
model DiskPool is TrackedResource<DiskPoolProperties> {
  @doc("The name of the Disk Pool.")
  @key("diskPoolName")
  @segment("diskPools")
  name: string;

  @doc("List of Azure resource ids that manage this resource.")
  @visibility("read")
  managedByExtended?: string[];

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ManagedBy;
}

@armResourceOperations
interface DiskPools {
  @doc("Get a Disk pool.")
  get is ArmResourceRead<DiskPool>;

  @doc("Create or Update Disk pool. This create or update operation can take 15 minutes to complete. This is expected service behavior.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DiskPool>;

  @doc("Update a Disk pool.")
  update is ArmCustomPatchAsync<DiskPool, DiskPoolUpdate>;

  @doc("Delete a Disk pool; attached disks are not affected. This delete operation can take 10 minutes to complete. This is expected service behavior.")
  delete is ArmResourceDeleteAsync<DiskPool>;

  @doc("Gets a list of DiskPools in a resource group.")
  listByResourceGroup is ArmResourceListByParent<DiskPool>;

  @doc("Gets a list of Disk Pools in a subscription")
  listBySubscription is ArmListBySubscription<DiskPool>;

  @doc("The operation to start a Disk Pool. This start operation can take 10 minutes to complete. This is expected service behavior.")
  start is ArmResourceActionAsync<DiskPool, void, void>;

  @doc("Shuts down the Disk Pool and releases the compute resources. You are not billed for the compute resources that this Disk Pool uses. This operation can take 10 minutes to complete. This is expected service behavior.")
  deallocate is ArmResourceActionAsync<DiskPool, void, void>;

  @doc("Upgrade replaces the underlying virtual machine hosts one at a time. This operation can take 10-15 minutes to complete. This is expected service behavior.")
  upgrade is ArmResourceActionAsync<DiskPool, void, void>;

  @doc("Gets the network endpoints of all outbound dependencies of a Disk Pool")
  // FIXME: DiskPools_ListOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}/outboundNetworkDependenciesEndpoints")
  @get
  ListOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]*[0-9A-Za-z]$")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;
    },
    OutboundEnvironmentEndpointList
  >;
}
