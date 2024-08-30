namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface Datastores {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
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

@@encodedName(Datastores.createOrUpdate::parameters.resource,
  "application/json",
  "datastore"
);
@@clientName(Datastores.createOrUpdate::parameters.resource, "datastore");
@@OpenAPI.extension(Datastores.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "datastore"
);

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
