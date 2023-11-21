import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ElasticSanManagement;

interface OperationsOperations {
  @doc("Gets a list of ElasticSan operations.")
  @route("/providers/Microsoft.ElasticSan/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface SkusOperations {
  @summary("List all the available Skus in the region and information related to them")
  @doc("List all the available Skus in the region and information related to them")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ElasticSan/skus")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Specify $filter='location eq <location>' to filter on location.")
      @query
      $filter: string;
    },
    SkuInformationList
  >;
}

interface ElasticSansOperations {
  @doc("Gets a list of ElasticSans in a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ElasticSan/elasticSans")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ElasticSanList
  >;

  @doc("Gets a list of ElasticSan in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans")
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
    ElasticSanList
  >;

  @doc("Create ElasticSan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("Elastic San object.")
      @body
      parameters: ElasticSan;
    },
    ElasticSan
  >;

  @doc("Update a Elastic San.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("Elastic San object.")
      @body
      parameters: ElasticSanUpdate;
    },
    ElasticSan | void
  >;

  @doc("Delete a Elastic San.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;
    },
    void
  >;

  @doc("Get a ElasticSan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;
    },
    ElasticSan
  >;
}

interface VolumeGroupsOperations {
  @doc("List VolumeGroups.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumeGroups")
  @get
  ListByElasticSan is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;
    },
    VolumeGroupList
  >;

  @doc("Create a Volume Group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;

      @doc("Volume Group object.")
      @body
      parameters: VolumeGroup;
    },
    VolumeGroup
  >;

  @doc("Update an VolumeGroup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;

      @doc("Volume Group object.")
      @body
      parameters: VolumeGroupUpdate;
    },
    VolumeGroup | void
  >;

  @doc("Delete an VolumeGroup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;
    },
    void
  >;

  @doc("Get an VolumeGroups.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;
    },
    VolumeGroup
  >;
}

interface VolumesOperations {
  @doc("Create a Volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/volumes/{volumeName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;

      @doc("The name of the Volume.")
      @path
      volumeName: string;

      @doc("Volume object.")
      @body
      parameters: Volume;
    },
    Volume
  >;

  @doc("Update an Volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/volumes/{volumeName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;

      @doc("The name of the Volume.")
      @path
      volumeName: string;

      @doc("Volume object.")
      @body
      parameters: VolumeUpdate;
    },
    Volume | void
  >;

  @doc("Delete an Volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/volumes/{volumeName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;

      @doc("The name of the Volume.")
      @path
      volumeName: string;

      @doc("""
Optional, used to delete snapshots under volume. Allowed value are only true or
false. Default value is false.
""")
      @header
      `x-ms-delete-snapshots`: XMsDeleteSnapshots;

      @doc("""
Optional, used to delete volume if active sessions present. Allowed value are
only true or false. Default value is false.
""")
      @header
      `x-ms-force-delete`: XMsForceDelete;
    },
    void
  >;

  @doc("Get an Volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/volumes/{volumeName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;

      @doc("The name of the Volume.")
      @path
      volumeName: string;
    },
    Volume
  >;

  @doc("List Volumes in a VolumeGroup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/volumes")
  @get
  ListByVolumeGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;
    },
    VolumeList
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("""
Update the state of specified private endpoint connection associated with the
Elastic San
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the Private Endpoint connection.")
      @path
      privateEndpointConnectionName: string;

      @doc("Private Endpoint Connection Approval object.")
      @body
      parameters: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @doc("Gets the specified private endpoint connection associated with the Elastic San")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the Private Endpoint connection.")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Deletes the specified private endpoint connection associated with the Elastic
San
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the Private Endpoint connection.")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;

  @doc("List all Private Endpoint Connections associated with the Elastic San.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/privateEndpointConnections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;
    },
    PrivateEndpointConnectionListResult
  >;
}

interface PrivateLinkResourcesOperations {
  @doc("Gets the private link resources that need to be created for a elastic San.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/privateLinkResources")
  @get
  ListByElasticSan is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;
    },
    PrivateLinkResourceListResult
  >;
}

interface VolumeSnapshotsOperations {
  @doc("""
List Snapshots in a VolumeGroup or List Snapshots by Volume (name) in a
VolumeGroup using filter
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/snapshots")
  @get
  ListByVolumeGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;

      @doc("Specify $filter='volumeName eq <volume name>' to filter on volume.")
      @query
      $filter: string;
    },
    SnapshotList
  >;

  @doc("Create a Volume Snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/snapshots/{snapshotName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;

      @doc("The name of the volume snapshot within the given volume group.")
      @path
      snapshotName: string;

      @doc("Snapshot object.")
      @body
      parameters: Snapshot;
    },
    Snapshot
  >;

  @doc("Delete a Volume Snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/snapshots/{snapshotName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;

      @doc("The name of the volume snapshot within the given volume group.")
      @path
      snapshotName: string;
    },
    void
  >;

  @doc("Get a Volume Snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/volumegroups/{volumeGroupName}/snapshots/{snapshotName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @path
      elasticSanName: string;

      @doc("The name of the VolumeGroup.")
      @path
      volumeGroupName: string;

      @doc("The name of the volume snapshot within the given volume group.")
      @path
      snapshotName: string;
    },
    Snapshot
  >;
}
