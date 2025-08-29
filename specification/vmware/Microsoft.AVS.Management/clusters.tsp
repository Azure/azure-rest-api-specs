namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

@armResourceOperations
interface Clusters {
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

  @Azure.Core.useFinalStateVia("location")
  update is ArmCustomPatchAsync<
    Cluster,
    ClusterUpdate,
    Response = Cluster | ArmResourceCreatedResponse<
      Cluster,
      LroHeaders = ArmLroLocationHeader<FinalResult = Cluster> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<Cluster>;

  @doc("List hosts by zone in a cluster")
  listZones is ArmResourceActionSyncNoRequestBody<Cluster, ClusterZoneList>;
}

@@clientName(Clusters.createOrUpdate::parameters.resource, "cluster");
@@clientName(Clusters.update::parameters.properties, "clusterUpdate");

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
  @visibility(Lifecycle.Read)
  provisioningState?: ClusterProvisioningState;

  @doc("The identity")
  @visibility(Lifecycle.Read)
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
  @identifiers(#[])
  zones?: ClusterZone[];
}

@doc("Zone and associated hosts info")
model ClusterZone {
  @doc("List of hosts belonging to the availability zone in a cluster")
  @visibility(Lifecycle.Read)
  hosts?: string[];

  @doc("Availability zone identifier")
  @visibility(Lifecycle.Read)
  zone?: string;
}
