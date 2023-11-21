import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureVMwareSolutionAPI;

interface OperationsOperations {
  @doc("Lists all of the available operations")
  @route("/providers/Microsoft.AVS/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationList>;
}

interface LocationsOperations {
  @doc("Return trial status for subscription by region")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AVS/locations/{location}/checkTrialAvailability")
  @post
  CheckTrialAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Azure region")
      @path
      location: string;

      @doc("The sku to check for trial availability")
      @body
      sku: Sku;
    },
    Trial
  >;

  @doc("Return quota for subscription by region")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AVS/locations/{location}/checkQuotaAvailability")
  @post
  CheckQuotaAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Azure region")
      @path
      location: string;
    },
    Quota
  >;
}

interface PrivateCloudsOperations {
  @summary("List private clouds in a resource group")
  @doc("List private clouds in a resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    PrivateCloudList
  >;

  @summary("List private clouds in a subscription")
  @doc("List private clouds in a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AVS/privateClouds")
  @get
  ListInSubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    PrivateCloudList
  >;

  @summary("Get a private cloud")
  @doc("Get a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    PrivateCloud
  >;

  @summary("Create or update a private cloud")
  @doc("Create or update a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("The private cloud")
      @body
      privateCloud: PrivateCloud;
    },
    PrivateCloud
  >;

  @summary("Update a private cloud")
  @doc("Update a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("The private cloud properties to be updated")
      @body
      privateCloudUpdate: PrivateCloudUpdate;
    },
    PrivateCloud
  >;

  @summary("Delete a private cloud")
  @doc("Delete a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    void
  >;

  @summary("Rotate the vCenter password")
  @doc("Rotate the vCenter password")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/rotateVcenterPassword")
  @post
  RotateVcenterPassword is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    void
  >;

  @summary("Rotate the NSX-T Manager password")
  @doc("Rotate the NSX-T Manager password")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/rotateNsxtPassword")
  @post
  RotateNsxtPassword is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    void
  >;

  @summary("List the admin credentials for the private cloud")
  @doc("List the admin credentials for the private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/listAdminCredentials")
  @post
  ListAdminCredentials is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    AdminCredentials
  >;
}

interface ClustersOperations {
  @summary("List clusters in a private cloud")
  @doc("List clusters in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    ClusterList
  >;

  @summary("Get a cluster by name in a private cloud")
  @doc("Get a cluster by name in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;
    },
    Cluster
  >;

  @summary("Create or update a cluster in a private cloud")
  @doc("Create or update a cluster in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the private cloud.")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;

      @doc("A cluster in the private cloud")
      @body
      cluster: Cluster;
    },
    Cluster
  >;

  @summary("Update a cluster in a private cloud")
  @doc("Update a cluster in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;

      @doc("The cluster properties to be updated")
      @body
      clusterUpdate: ClusterUpdate;
    },
    Cluster
  >;

  @summary("Delete a cluster in a private cloud")
  @doc("Delete a cluster in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;
    },
    void
  >;

  @summary("List hosts by zone in a cluster")
  @doc("List hosts by zone in a cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/listZones")
  @post
  ListZones is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;
    },
    ClusterZoneList
  >;
}

interface DatastoresOperations {
  @summary("List datastores in a private cloud cluster")
  @doc("List datastores in a private cloud cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/datastores")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;
    },
    DatastoreList
  >;

  @summary("Get a datastore in a private cloud cluster")
  @doc("Get a datastore in a private cloud cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/datastores/{datastoreName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;

      @doc("Name of the datastore in the private cloud cluster")
      @path
      datastoreName: string;
    },
    Datastore
  >;

  @summary("Create or update a datastore in a private cloud cluster")
  @doc("Create or update a datastore in a private cloud cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/datastores/{datastoreName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;

      @doc("Name of the datastore in the private cloud cluster")
      @path
      datastoreName: string;

      @doc("A datastore in a private cloud cluster")
      @body
      datastore: Datastore;
    },
    Datastore
  >;

  @summary("Delete a datastore in a private cloud cluster")
  @doc("Delete a datastore in a private cloud cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/datastores/{datastoreName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;

      @doc("Name of the datastore in the private cloud cluster")
      @path
      datastoreName: string;
    },
    void
  >;
}

interface HcxEnterpriseSitesOperations {
  @summary("List HCX Enterprise Sites in a private cloud")
  @doc("List HCX Enterprise Sites in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/hcxEnterpriseSites")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    HcxEnterpriseSiteList
  >;

  @summary("Get an HCX Enterprise Site by name in a private cloud")
  @doc("Get an HCX Enterprise Site by name in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/hcxEnterpriseSites/{hcxEnterpriseSiteName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the HCX Enterprise Site in the private cloud")
      @path
      hcxEnterpriseSiteName: string;
    },
    HcxEnterpriseSite
  >;

  @summary("Create or update an HCX Enterprise Site in a private cloud")
  @doc("Create or update an HCX Enterprise Site in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/hcxEnterpriseSites/{hcxEnterpriseSiteName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the private cloud.")
      @path
      privateCloudName: string;

      @doc("Name of the HCX Enterprise Site in the private cloud")
      @path
      hcxEnterpriseSiteName: string;

      @doc("The HCX Enterprise Site")
      @body
      hcxEnterpriseSite: HcxEnterpriseSite;
    },
    HcxEnterpriseSite
  >;

  @summary("Delete an HCX Enterprise Site in a private cloud")
  @doc("Delete an HCX Enterprise Site in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/hcxEnterpriseSites/{hcxEnterpriseSiteName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the HCX Enterprise Site in the private cloud")
      @path
      hcxEnterpriseSiteName: string;
    },
    void
  >;
}

interface AuthorizationsOperations {
  @summary("List ExpressRoute Circuit Authorizations in a private cloud")
  @doc("List ExpressRoute Circuit Authorizations in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/authorizations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    ExpressRouteAuthorizationList
  >;

  @summary("Get an ExpressRoute Circuit Authorization by name in a private cloud")
  @doc("Get an ExpressRoute Circuit Authorization by name in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/authorizations/{authorizationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the ExpressRoute Circuit Authorization in the private cloud")
      @path
      authorizationName: string;
    },
    ExpressRouteAuthorization
  >;

  @summary("Create or update an ExpressRoute Circuit Authorization in a private cloud")
  @doc("Create or update an ExpressRoute Circuit Authorization in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/authorizations/{authorizationName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the private cloud.")
      @path
      privateCloudName: string;

      @doc("Name of the ExpressRoute Circuit Authorization in the private cloud")
      @path
      authorizationName: string;

      @doc("An ExpressRoute Circuit Authorization")
      @body
      authorization: ExpressRouteAuthorization;
    },
    ExpressRouteAuthorization
  >;

  @summary("Delete an ExpressRoute Circuit Authorization in a private cloud")
  @doc("Delete an ExpressRoute Circuit Authorization in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/authorizations/{authorizationName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the ExpressRoute Circuit Authorization in the private cloud")
      @path
      authorizationName: string;
    },
    void
  >;
}

interface GlobalReachConnectionsOperations {
  @summary("List global reach connections in a private cloud")
  @doc("List global reach connections in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/globalReachConnections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    GlobalReachConnectionList
  >;

  @summary("Get a global reach connection by name in a private cloud")
  @doc("Get a global reach connection by name in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/globalReachConnections/{globalReachConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the global reach connection in the private cloud")
      @path
      globalReachConnectionName: string;
    },
    GlobalReachConnection
  >;

  @summary("Create or update a global reach connection in a private cloud")
  @doc("Create or update a global reach connection in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/globalReachConnections/{globalReachConnectionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the private cloud.")
      @path
      privateCloudName: string;

      @doc("Name of the global reach connection in the private cloud")
      @path
      globalReachConnectionName: string;

      @doc("A global reach connection in the private cloud")
      @body
      globalReachConnection: GlobalReachConnection;
    },
    GlobalReachConnection
  >;

  @summary("Delete a global reach connection in a private cloud")
  @doc("Delete a global reach connection in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/globalReachConnections/{globalReachConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the global reach connection in the private cloud")
      @path
      globalReachConnectionName: string;
    },
    void
  >;
}

interface WorkloadNetworksOperations {
  @summary("Get a private cloud workload network.")
  @doc("Get a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/{workloadNetworkName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name for the workload network in the private cloud")
      @path
      workloadNetworkName: WorkloadNetworkName;
    },
    WorkloadNetwork
  >;

  @summary("List of workload networks in a private cloud.")
  @doc("List of workload networks in a private cloud.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    WorkloadNetworkList
  >;

  @summary("List of segments in a private cloud workload network.")
  @doc("List of segments in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/segments")
  @get
  ListSegments is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    WorkloadNetworkSegmentsList
  >;

  @summary("Get a segment by id in a private cloud workload network.")
  @doc("Get a segment by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/segments/{segmentId}")
  @get
  GetSegment is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX Segment identifier. Generally the same as the Segment's display name")
      @path
      segmentId: string;
    },
    WorkloadNetworkSegment
  >;

  @summary("Create a segment by id in a private cloud workload network.")
  @doc("Create a segment by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/segments/{segmentId}")
  @put
  CreateSegments is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX Segment identifier. Generally the same as the Segment's display name")
      @path
      segmentId: string;

      @doc("NSX Segment")
      @body
      workloadNetworkSegment: WorkloadNetworkSegment;
    },
    WorkloadNetworkSegment
  >;

  @summary("Create or update a segment by id in a private cloud workload network.")
  @doc("Create or update a segment by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/segments/{segmentId}")
  @patch
  UpdateSegments is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX Segment identifier. Generally the same as the Segment's display name")
      @path
      segmentId: string;

      @doc("NSX Segment")
      @body
      workloadNetworkSegment: WorkloadNetworkSegment;
    },
    WorkloadNetworkSegment | void
  >;

  @summary("Delete a segment by id in a private cloud workload network.")
  @doc("Delete a segment by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/segments/{segmentId}")
  @delete
  DeleteSegment is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX Segment identifier. Generally the same as the Segment's display name")
      @path
      segmentId: string;
    },
    void
  >;

  @summary("List dhcp in a private cloud workload network.")
  @doc("List dhcp in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dhcpConfigurations")
  @get
  ListDhcp is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    WorkloadNetworkDhcpList
  >;

  @summary("Get dhcp by id in a private cloud workload network.")
  @doc("Get dhcp by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dhcpConfigurations/{dhcpId}")
  @get
  GetDhcp is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("NSX DHCP identifier. Generally the same as the DHCP display name")
      @path
      dhcpId: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    WorkloadNetworkDhcp
  >;

  @summary("Create dhcp by id in a private cloud workload network.")
  @doc("Create dhcp by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dhcpConfigurations/{dhcpId}")
  @put
  CreateDhcp is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX DHCP identifier. Generally the same as the DHCP display name")
      @path
      dhcpId: string;

      @doc("NSX DHCP")
      @body
      workloadNetworkDhcp: WorkloadNetworkDhcp;
    },
    WorkloadNetworkDhcp
  >;

  @summary("Create or update dhcp by id in a private cloud workload network.")
  @doc("Create or update dhcp by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dhcpConfigurations/{dhcpId}")
  @patch
  UpdateDhcp is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX DHCP identifier. Generally the same as the DHCP display name")
      @path
      dhcpId: string;

      @doc("NSX DHCP")
      @body
      workloadNetworkDhcp: WorkloadNetworkDhcp;
    },
    WorkloadNetworkDhcp | void
  >;

  @summary("Delete dhcp by id in a private cloud workload network.")
  @doc("Delete dhcp by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dhcpConfigurations/{dhcpId}")
  @delete
  DeleteDhcp is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX DHCP identifier. Generally the same as the DHCP display name")
      @path
      dhcpId: string;
    },
    void
  >;

  @summary("List of gateways in a private cloud workload network.")
  @doc("List of gateways in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/gateways")
  @get
  ListGateways is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    WorkloadNetworkGatewayList
  >;

  @summary("Get a gateway by id in a private cloud workload network.")
  @doc("Get a gateway by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/gateways/{gatewayId}")
  @get
  GetGateway is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX Gateway identifier. Generally the same as the Gateway's display name")
      @path
      gatewayId: string;
    },
    WorkloadNetworkGateway
  >;

  @summary("List of port mirroring profiles in a private cloud workload network.")
  @doc("List of port mirroring profiles in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/portMirroringProfiles")
  @get
  ListPortMirroring is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    WorkloadNetworkPortMirroringList
  >;

  @summary("Get a port mirroring profile by id in a private cloud workload network.")
  @doc("Get a port mirroring profile by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/portMirroringProfiles/{portMirroringId}")
  @get
  GetPortMirroring is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("""
NSX Port Mirroring identifier. Generally the same as the Port Mirroring display
name
""")
      @path
      portMirroringId: string;
    },
    WorkloadNetworkPortMirroring
  >;

  @summary("Create a port mirroring profile by id in a private cloud workload network.")
  @doc("Create a port mirroring profile by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/portMirroringProfiles/{portMirroringId}")
  @put
  CreatePortMirroring is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("""
NSX Port Mirroring identifier. Generally the same as the Port Mirroring display
name
""")
      @path
      portMirroringId: string;

      @doc("NSX port mirroring")
      @body
      workloadNetworkPortMirroring: WorkloadNetworkPortMirroring;
    },
    WorkloadNetworkPortMirroring
  >;

  @summary("""
Create or update a port mirroring profile by id in a private cloud workload
network.
""")
  @doc("""
Create or update a port mirroring profile by id in a private cloud workload
network.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/portMirroringProfiles/{portMirroringId}")
  @patch
  UpdatePortMirroring is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("""
NSX Port Mirroring identifier. Generally the same as the Port Mirroring display
name
""")
      @path
      portMirroringId: string;

      @doc("NSX port mirroring")
      @body
      workloadNetworkPortMirroring: WorkloadNetworkPortMirroring;
    },
    WorkloadNetworkPortMirroring | void
  >;

  @summary("Delete a port mirroring profile by id in a private cloud workload network.")
  @doc("Delete a port mirroring profile by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/portMirroringProfiles/{portMirroringId}")
  @delete
  DeletePortMirroring is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
NSX Port Mirroring identifier. Generally the same as the Port Mirroring display
name
""")
      @path
      portMirroringId: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    void
  >;

  @summary("List of vm groups in a private cloud workload network.")
  @doc("List of vm groups in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/vmGroups")
  @get
  ListVMGroups is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    WorkloadNetworkVMGroupsList
  >;

  @summary("Get a vm group by id in a private cloud workload network.")
  @doc("Get a vm group by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/vmGroups/{vmGroupId}")
  @get
  GetVMGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX VM Group identifier. Generally the same as the VM Group's display name")
      @path
      vmGroupId: string;
    },
    WorkloadNetworkVMGroup
  >;

  @summary("Create a vm group by id in a private cloud workload network.")
  @doc("Create a vm group by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/vmGroups/{vmGroupId}")
  @put
  CreateVMGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX VM Group identifier. Generally the same as the VM Group's display name")
      @path
      vmGroupId: string;

      @doc("NSX VM Group")
      @body
      workloadNetworkVMGroup: WorkloadNetworkVMGroup;
    },
    WorkloadNetworkVMGroup
  >;

  @summary("Create or update a vm group by id in a private cloud workload network.")
  @doc("Create or update a vm group by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/vmGroups/{vmGroupId}")
  @patch
  UpdateVMGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX VM Group identifier. Generally the same as the VM Group's display name")
      @path
      vmGroupId: string;

      @doc("NSX VM Group")
      @body
      workloadNetworkVMGroup: WorkloadNetworkVMGroup;
    },
    WorkloadNetworkVMGroup | void
  >;

  @summary("Delete a vm group by id in a private cloud workload network.")
  @doc("Delete a vm group by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/vmGroups/{vmGroupId}")
  @delete
  DeleteVMGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("NSX VM Group identifier. Generally the same as the VM Group's display name")
      @path
      vmGroupId: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    void
  >;

  @summary("List of virtual machines in a private cloud workload network.")
  @doc("List of virtual machines in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/virtualMachines")
  @get
  ListVirtualMachines is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    WorkloadNetworkVirtualMachinesList
  >;

  @summary("Get a virtual machine by id in a private cloud workload network.")
  @doc("Get a virtual machine by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/virtualMachines/{virtualMachineId}")
  @get
  GetVirtualMachine is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Virtual Machine identifier")
      @path
      virtualMachineId: string;
    },
    WorkloadNetworkVirtualMachine
  >;

  @summary("List of DNS services in a private cloud workload network.")
  @doc("List of DNS services in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsServices")
  @get
  ListDnsServices is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    WorkloadNetworkDnsServicesList
  >;

  @summary("Get a DNS service by id in a private cloud workload network.")
  @doc("Get a DNS service by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsServices/{dnsServiceId}")
  @get
  GetDnsService is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX DNS Service identifier. Generally the same as the DNS Service's display name")
      @path
      dnsServiceId: string;
    },
    WorkloadNetworkDnsService
  >;

  @summary("Create a DNS service by id in a private cloud workload network.")
  @doc("Create a DNS service by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsServices/{dnsServiceId}")
  @put
  CreateDnsService is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX DNS Service identifier. Generally the same as the DNS Service's display name")
      @path
      dnsServiceId: string;

      @doc("NSX DNS Service")
      @body
      workloadNetworkDnsService: WorkloadNetworkDnsService;
    },
    WorkloadNetworkDnsService
  >;

  @summary("Create or update a DNS service by id in a private cloud workload network.")
  @doc("Create or update a DNS service by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsServices/{dnsServiceId}")
  @patch
  UpdateDnsService is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX DNS Service identifier. Generally the same as the DNS Service's display name")
      @path
      dnsServiceId: string;

      @doc("NSX DNS Service")
      @body
      workloadNetworkDnsService: WorkloadNetworkDnsService;
    },
    WorkloadNetworkDnsService | void
  >;

  @summary("Delete a DNS service by id in a private cloud workload network.")
  @doc("Delete a DNS service by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsServices/{dnsServiceId}")
  @delete
  DeleteDnsService is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("NSX DNS Service identifier. Generally the same as the DNS Service's display name")
      @path
      dnsServiceId: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    void
  >;

  @summary("List of DNS zones in a private cloud workload network.")
  @doc("List of DNS zones in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsZones")
  @get
  ListDnsZones is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    WorkloadNetworkDnsZonesList
  >;

  @summary("Get a DNS zone by id in a private cloud workload network.")
  @doc("Get a DNS zone by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsZones/{dnsZoneId}")
  @get
  GetDnsZone is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX DNS Zone identifier. Generally the same as the DNS Zone's display name")
      @path
      dnsZoneId: string;
    },
    WorkloadNetworkDnsZone
  >;

  @summary("Create a DNS zone by id in a private cloud workload network.")
  @doc("Create a DNS zone by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsZones/{dnsZoneId}")
  @put
  CreateDnsZone is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX DNS Zone identifier. Generally the same as the DNS Zone's display name")
      @path
      dnsZoneId: string;

      @doc("NSX DNS Zone")
      @body
      workloadNetworkDnsZone: WorkloadNetworkDnsZone;
    },
    WorkloadNetworkDnsZone
  >;

  @summary("Create or update a DNS zone by id in a private cloud workload network.")
  @doc("Create or update a DNS zone by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsZones/{dnsZoneId}")
  @patch
  UpdateDnsZone is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("NSX DNS Zone identifier. Generally the same as the DNS Zone's display name")
      @path
      dnsZoneId: string;

      @doc("NSX DNS Zone")
      @body
      workloadNetworkDnsZone: WorkloadNetworkDnsZone;
    },
    WorkloadNetworkDnsZone | void
  >;

  @summary("Delete a DNS zone by id in a private cloud workload network.")
  @doc("Delete a DNS zone by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsZones/{dnsZoneId}")
  @delete
  DeleteDnsZone is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("NSX DNS Zone identifier. Generally the same as the DNS Zone's display name")
      @path
      dnsZoneId: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    void
  >;

  @summary("List of Public IP Blocks in a private cloud workload network.")
  @doc("List of Public IP Blocks in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/publicIPs")
  @get
  ListPublicIPs is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    WorkloadNetworkPublicIPsList
  >;

  @summary("Get a Public IP Block by id in a private cloud workload network.")
  @doc("Get a Public IP Block by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/publicIPs/{publicIPId}")
  @get
  GetPublicIP is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("""
NSX Public IP Block identifier. Generally the same as the Public IP Block's
display name
""")
      @path
      publicIPId: string;
    },
    WorkloadNetworkPublicIP
  >;

  @summary("Create a Public IP Block by id in a private cloud workload network.")
  @doc("Create a Public IP Block by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/publicIPs/{publicIPId}")
  @put
  CreatePublicIP is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("""
NSX Public IP Block identifier. Generally the same as the Public IP Block's
display name
""")
      @path
      publicIPId: string;

      @doc("NSX Public IP Block")
      @body
      workloadNetworkPublicIP: WorkloadNetworkPublicIP;
    },
    WorkloadNetworkPublicIP
  >;

  @summary("Delete a Public IP Block by id in a private cloud workload network.")
  @doc("Delete a Public IP Block by id in a private cloud workload network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/publicIPs/{publicIPId}")
  @delete
  DeletePublicIP is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
NSX Public IP Block identifier. Generally the same as the Public IP Block's
display name
""")
      @path
      publicIPId: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    void
  >;
}

interface CloudLinksOperations {
  @summary("List cloud link in a private cloud")
  @doc("List cloud link in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/cloudLinks")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    CloudLinkList
  >;

  @summary("Get an cloud link by name in a private cloud")
  @doc("Get an cloud link by name in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/cloudLinks/{cloudLinkName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cloud link resource")
      @path
      cloudLinkName: string;
    },
    CloudLink
  >;

  @summary("Create or update a cloud link in a private cloud")
  @doc("Create or update a cloud link in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/cloudLinks/{cloudLinkName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the private cloud.")
      @path
      privateCloudName: string;

      @doc("Name of the cloud link resource")
      @path
      cloudLinkName: string;

      @doc("A cloud link in the private cloud")
      @body
      cloudLink: CloudLink;
    },
    CloudLink
  >;

  @summary("Delete a cloud link in a private cloud")
  @doc("Delete a cloud link in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/cloudLinks/{cloudLinkName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cloud link resource")
      @path
      cloudLinkName: string;
    },
    void
  >;
}

interface AddonsOperations {
  @summary("List addons in a private cloud")
  @doc("List addons in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/addons")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    AddonList
  >;

  @summary("Get an addon by name in a private cloud")
  @doc("Get an addon by name in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/addons/{addonName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the addon for the private cloud")
      @path
      addonName: string;
    },
    Addon
  >;

  @summary("Create or update a addon in a private cloud")
  @doc("Create or update a addon in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/addons/{addonName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the private cloud.")
      @path
      privateCloudName: string;

      @doc("Name of the addon for the private cloud")
      @path
      addonName: string;

      @doc("A addon in the private cloud")
      @body
      addon: Addon;
    },
    Addon
  >;

  @summary("Delete a addon in a private cloud")
  @doc("Delete a addon in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/addons/{addonName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the addon for the private cloud")
      @path
      addonName: string;
    },
    void
  >;
}

interface VirtualMachinesOperations {
  @summary("List of virtual machines in a private cloud cluster")
  @doc("List of virtual machines in a private cloud cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/virtualMachines")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;
    },
    VirtualMachinesList
  >;

  @summary("Get a virtual machine by id in a private cloud cluster")
  @doc("Get a virtual machine by id in a private cloud cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/virtualMachines/{virtualMachineId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;

      @doc("Virtual Machine identifier")
      @path
      virtualMachineId: string;
    },
    VirtualMachine
  >;

  @summary("Enable or disable DRS-driven VM movement restriction")
  @doc("Enable or disable DRS-driven VM movement restriction")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/virtualMachines/{virtualMachineId}/restrictMovement")
  @post
  RestrictMovement is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;

      @doc("Virtual Machine identifier")
      @path
      virtualMachineId: string;

      @doc("Whether VM DRS-driven movement is restricted (Enabled) or not (Disabled)")
      @body
      restrictMovement: VirtualMachineRestrictMovement;
    },
    void
  >;
}

interface PlacementPoliciesOperations {
  @summary("List placement policies in a private cloud cluster")
  @doc("List placement policies in a private cloud cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/placementPolicies")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;
    },
    PlacementPoliciesList
  >;

  @summary("Get a placement policy by name in a private cloud cluster")
  @doc("Get a placement policy by name in a private cloud cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/placementPolicies/{placementPolicyName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;

      @doc("Name of the VMware vSphere Distributed Resource Scheduler (DRS) placement policy")
      @path
      placementPolicyName: string;
    },
    PlacementPolicy
  >;

  @summary("Create or update a placement policy in a private cloud cluster")
  @doc("Create or update a placement policy in a private cloud cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/placementPolicies/{placementPolicyName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;

      @doc("Name of the VMware vSphere Distributed Resource Scheduler (DRS) placement policy")
      @path
      placementPolicyName: string;

      @doc("A placement policy in the private cloud cluster")
      @body
      placementPolicy: PlacementPolicy;
    },
    PlacementPolicy
  >;

  @summary("Update a placement policy in a private cloud cluster")
  @doc("Update a placement policy in a private cloud cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/placementPolicies/{placementPolicyName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;

      @doc("Name of the VMware vSphere Distributed Resource Scheduler (DRS) placement policy")
      @path
      placementPolicyName: string;

      @doc("The placement policy properties that may be updated")
      @body
      placementPolicyUpdate: PlacementPolicyUpdate;
    },
    PlacementPolicy
  >;

  @summary("Delete a placement policy in a private cloud cluster")
  @doc("Delete a placement policy in a private cloud cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/clusters/{clusterName}/placementPolicies/{placementPolicyName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the cluster in the private cloud")
      @path
      clusterName: string;

      @doc("Name of the VMware vSphere Distributed Resource Scheduler (DRS) placement policy")
      @path
      placementPolicyName: string;
    },
    void
  >;
}

interface ScriptPackagesOperations {
  @doc("List script packages available to run on the private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/scriptPackages")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    ScriptPackagesList
  >;

  @doc("Get a script package available to run on a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/scriptPackages/{scriptPackageName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the script package in the private cloud")
      @path
      scriptPackageName: string;
    },
    ScriptPackage
  >;
}

interface ScriptCmdletsOperations {
  @doc("""
List script cmdlet resources available for a private cloud to create a script
execution resource on a private cloud
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/scriptPackages/{scriptPackageName}/scriptCmdlets")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the script package in the private cloud")
      @path
      scriptPackageName: string;
    },
    ScriptCmdletsList
  >;

  @doc("""
Return information about a script cmdlet resource in a specific package on a
private cloud
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/scriptPackages/{scriptPackageName}/scriptCmdlets/{scriptCmdletName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the script package in the private cloud")
      @path
      scriptPackageName: string;

      @doc("Name of the script cmdlet resource in the script package in the private cloud")
      @path
      scriptCmdletName: string;
    },
    ScriptCmdlet
  >;
}

interface ScriptExecutionsOperations {
  @summary("List script executions in a private cloud")
  @doc("List script executions in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/scriptExecutions")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;
    },
    ScriptExecutionsList
  >;

  @summary("Get an script execution by name in a private cloud")
  @doc("Get an script execution by name in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/scriptExecutions/{scriptExecutionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the user-invoked script execution resource")
      @path
      scriptExecutionName: string;
    },
    ScriptExecution
  >;

  @summary("Create or update a script execution in a private cloud")
  @doc("Create or update a script execution in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/scriptExecutions/{scriptExecutionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the private cloud.")
      @path
      privateCloudName: string;

      @doc("Name of the user-invoked script execution resource")
      @path
      scriptExecutionName: string;

      @doc("A script running in the private cloud")
      @body
      scriptExecution: ScriptExecution;
    },
    ScriptExecution
  >;

  @summary("Cancel a ScriptExecution in a private cloud")
  @doc("Cancel a ScriptExecution in a private cloud")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/scriptExecutions/{scriptExecutionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the user-invoked script execution resource")
      @path
      scriptExecutionName: string;
    },
    void
  >;

  @doc("Return the logs for a script execution resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/scriptExecutions/{scriptExecutionName}/getExecutionLogs")
  @post
  GetExecutionLogs is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the private cloud")
      @path
      privateCloudName: string;

      @doc("Name of the user-invoked script execution resource")
      @path
      scriptExecutionName: string;

      @doc("""
Name of the desired output stream to return. If not provided, will return all.
An empty array will return nothing
""")
      @body
      scriptOutputStreamType: ScriptOutputStreamType[];
    },
    ScriptExecution
  >;
}
