import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace StoragePoolManagement;

interface OperationsOperations {
  @doc("Gets a list of StoragePool operations.")
  @route("/providers/Microsoft.StoragePool/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, StoragePoolOperationListResult>;
}

interface DiskPoolsOperations {
  @doc("Gets a list of Disk Pools in a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StoragePool/diskPools")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    DiskPoolListResult
  >;

  @doc("Gets a list of DiskPools in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    DiskPoolListResult
  >;

  @doc("""
Create or Update Disk pool. This create or update operation can take 15 minutes
to complete. This is expected service behavior.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;

      @doc("Request payload for Disk Pool create operation")
      @body
      diskPoolCreatePayload: DiskPoolCreate;
    },
    DiskPool
  >;

  @doc("Update a Disk pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;

      @doc("Request payload for Disk Pool update operation.")
      @body
      diskPoolUpdatePayload: DiskPoolUpdate;
    },
    DiskPool | void
  >;

  @doc("""
Delete a Disk pool; attached disks are not affected. This delete operation can
take 10 minutes to complete. This is expected service behavior.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;
    },
    void
  >;

  @doc("Get a Disk pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;
    },
    DiskPool
  >;

  @doc("Gets the network endpoints of all outbound dependencies of a Disk Pool")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}/outboundNetworkDependenciesEndpoints")
  @get
  ListOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;
    },
    OutboundEnvironmentEndpointList
  >;

  @doc("""
The operation to start a Disk Pool. This start operation can take 10 minutes to
complete. This is expected service behavior.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}/start")
  @post
  Start is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;
    },
    void
  >;

  @doc("""
Shuts down the Disk Pool and releases the compute resources. You are not billed
for the compute resources that this Disk Pool uses. This operation can take 10
minutes to complete. This is expected service behavior.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}/deallocate")
  @post
  Deallocate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;
    },
    void
  >;

  @doc("""
Upgrade replaces the underlying virtual machine hosts one at a time. This
operation can take 10-15 minutes to complete. This is expected service
behavior.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}/upgrade")
  @post
  Upgrade is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;
    },
    void
  >;
}

interface DiskPoolZonesOperations {
  @doc("Lists available Disk Pool Skus in an Azure location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StoragePool/locations/{location}/diskPoolZones")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The location of the resource.")
      @path
      location: string;
    },
    DiskPoolZoneListResult
  >;
}

interface ResourceSkusOperations {
  @doc("Lists available StoragePool resources and skus in an Azure location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StoragePool/locations/{location}/skus")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The location of the resource.")
      @path
      location: string;
    },
    ResourceSkuListResult
  >;
}

interface IscsiTargetsOperations {
  @doc("Get iSCSI Targets in a Disk pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}/iscsiTargets")
  @get
  ListByDiskPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;
    },
    IscsiTargetList
  >;

  @doc("Create or Update an iSCSI Target.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}/iscsiTargets/{iscsiTargetName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;

      @doc("The name of the iSCSI Target.")
      @path
      iscsiTargetName: string;

      @doc("Request payload for iSCSI Target create operation.")
      @body
      iscsiTargetCreatePayload: IscsiTargetCreate;
    },
    IscsiTarget
  >;

  @doc("Update an iSCSI Target.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}/iscsiTargets/{iscsiTargetName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;

      @doc("The name of the iSCSI Target.")
      @path
      iscsiTargetName: string;

      @doc("Request payload for iSCSI Target update operation.")
      @body
      iscsiTargetUpdatePayload: IscsiTargetUpdate;
    },
    IscsiTarget | void
  >;

  @doc("Delete an iSCSI Target.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}/iscsiTargets/{iscsiTargetName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;

      @doc("The name of the iSCSI Target.")
      @path
      iscsiTargetName: string;
    },
    void
  >;

  @doc("Get an iSCSI Target.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StoragePool/diskPools/{diskPoolName}/iscsiTargets/{iscsiTargetName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Disk Pool.")
      @path
      diskPoolName: string;

      @doc("The name of the iSCSI Target.")
      @path
      iscsiTargetName: string;
    },
    IscsiTarget
  >;
}
