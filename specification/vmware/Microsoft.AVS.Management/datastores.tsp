namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface Datastores {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("Datastores_List")
  list is ArmResourceListByParent<
    Datastore,
    Response = ArmResponse<ResourceList<Datastore>>
  >;

  get is ArmResourceRead<Datastore>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Datastore,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<Datastore>;
}

@@clientName(Datastores.createOrUpdate::parameters.resource, "datastore");

@doc("datastore provisioning state")
union DatastoreProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is cancelled")
  Cancelled: "Cancelled",

  @doc("is pending")
  Pending: "Pending",

  @doc("is creating")
  Creating: "Creating",

  @doc("is updating")
  Updating: "Updating",

  @doc("is deleting")
  Deleting: "Deleting",
}

@doc("mount option")
union MountOptionEnum {
  string,

  @doc("is mount")
  MOUNT: "MOUNT",

  @doc("is attach")
  ATTACH: "ATTACH",
}

@doc("datastore status")
union DatastoreStatus {
  string,

  @doc("is unknown")
  Unknown: "Unknown",

  @doc("is accessible")
  Accessible: "Accessible",

  @doc("is inaccessible")
  Inaccessible: "Inaccessible",

  @doc("is attached")
  Attached: "Attached",

  @doc("is detached")
  Detached: "Detached",

  @doc("is lost communication")
  LostCommunication: "LostCommunication",

  @doc("is dead or error")
  DeadOrError: "DeadOrError",
}

@doc("A datastore resource")
@parentResource(Cluster)
model Datastore is ProxyResource<DatastoreProperties> {
  @doc("Name of the datastore")
  @pattern("^[-\\w\\._]+$")
  @key("datastoreName")
  @path
  @segment("datastores")
  name: string;
}

@doc("The properties of a datastore")
model DatastoreProperties {
  @doc("The state of the datastore provisioning")
  @visibility("read")
  provisioningState?: DatastoreProvisioningState;

  @doc("An Azure NetApp Files volume")
  netAppVolume?: NetAppVolume;

  @doc("An iSCSI volume")
  diskPoolVolume?: DiskPoolVolume;

  @doc("An Elastic SAN volume")
  elasticSanVolume?: ElasticSanVolume;

  @doc("The operational status of the datastore")
  @visibility("read")
  status?: DatastoreStatus;
}

@doc("An Azure NetApp Files volume from Microsoft.NetApp provider")
model NetAppVolume {
  @doc("Azure resource ID of the NetApp volume")
  id: string;
}

@doc("An iSCSI volume from Microsoft.StoragePool provider")
model DiskPoolVolume {
  @doc("Azure resource ID of the iSCSI target")
  targetId: string;

  @doc("Name of the LUN to be used for datastore")
  lunName: string;

  @doc("""
    Mode that describes whether the LUN has to be mounted as a datastore or
    attached as a LUN
    """)
  mountOption?: MountOptionEnum = MountOptionEnum.MOUNT;

  @doc("Device path")
  @visibility("read")
  path?: string;
}

@doc("An Elastic SAN volume from Microsoft.ElasticSan provider")
model ElasticSanVolume {
  @doc("Azure resource ID of the Elastic SAN Volume")
  targetId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ElasticSan/elasticSans/volumeGroups/volumes";
    }
  ]>;
}
