namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface Clusters {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("Clusters_List")
  list is ArmResourceListByParent<
    Cluster,
    Response = ArmResponse<ResourceList<Cluster>>
  >;

  get is ArmResourceRead<Cluster>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Cluster,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  // This could be modeled with ArmCustomPatchAsync if a 202 response with no body is used instead of a 201.
  // update is ArmCustomPatchAsync<Cluster, ClusterUpdate>;
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @doc("Update a Cluster")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @armResourceUpdate(Cluster)
  @patch
  update(
    ...ResourceInstanceParameters<Cluster>,

    @bodyRoot
    @doc("The cluster properties to be updated.")
    clusterUpdate: ClusterUpdate,
  ): ArmResponse<Cluster> | {
    // @doc("Resource update request created.")
    ...CreatedResponse;

    ...Azure.Core.Foundations.RetryAfterHeader;
    ...LocationHeader;

    @bodyRoot
    @doc("The updated cluster.")
    cluster: Cluster;
  } | ErrorResponse;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<Cluster>;

  @doc("List hosts by zone in a cluster")
  listZones is ArmResourceActionSyncNoRequestBody<Cluster, ClusterZoneList>;
}

@@clientName(Clusters.createOrUpdate::parameters.resource, "cluster");

@doc("Cluster provisioning state")
union ClusterProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is cancelled")
  Cancelled: "Cancelled",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is updating")
  Updating: "Updating",
}

@doc("The common properties of a cluster")
model CommonClusterProperties {
  @doc("The cluster size")
  clusterSize?: int32;

  @doc("The state of the cluster provisioning")
  @visibility("read")
  provisioningState?: ClusterProvisioningState;

  @doc("The identity")
  @visibility("read")
  clusterId?: int32;

  @doc("The hosts")
  hosts?: string[];

  @doc("Name of the vsan datastore associated with the cluster")
  vsanDatastoreName?: string;
}

@doc("A cluster resource")
@parentResource(PrivateCloud)
model Cluster is ProxyResource<ClusterProperties> {
  ...ResourceSkuRequired;

  @doc("Name of the cluster")
  @pattern("^[-\\w\\._]+$")
  @key("clusterName")
  @path
  @segment("clusters")
  name: string;
}

@doc("The properties of a cluster")
model ClusterProperties {
  ...CommonClusterProperties;
}

@doc("An update of a cluster resource")
model ClusterUpdate {
  ...ResourceSkuProperty;

  #suppress "deprecated" "Legacy flatten"
  @doc("The properties of a cluster resource that may be updated")
  @Azure.ClientGenerator.Core.flattenProperty
  properties?: ClusterUpdateProperties;
}

@doc("The properties of a cluster that may be updated")
model ClusterUpdateProperties {
  @doc("The cluster size")
  clusterSize?: int32;

  @doc("The hosts")
  hosts?: string[];
}

@doc("List of all zones and associated hosts for a cluster")
model ClusterZoneList {
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("Zone and associated hosts info")
  zones?: ClusterZone[];
}

@doc("Zone and associated hosts info")
model ClusterZone {
  @doc("List of hosts belonging to the availability zone in a cluster")
  @visibility("read")
  hosts?: string[];

  @doc("Availability zone identifier")
  @visibility("read")
  zone?: string;
}
