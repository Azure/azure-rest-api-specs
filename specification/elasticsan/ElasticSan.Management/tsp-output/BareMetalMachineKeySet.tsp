import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
@doc("BareMetalMachineKeySet represents the bare metal machine key set.")
@parentResource(Cluster)
model BareMetalMachineKeySet
  is TrackedResource<BareMetalMachineKeySetProperties> {
  @doc("The name of the bare metal machine key set.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("bareMetalMachineKeySetName")
  @segment("bareMetalMachineKeySets")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface BareMetalMachineKeySets {
  @doc("Get bare metal machine key set of the provided cluster.")
  get is ArmResourceRead<BareMetalMachineKeySet>;

  @doc("Create a new bare metal machine key set or update the existing one for the provided cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    BareMetalMachineKeySet,
    BaseParameters<BareMetalMachineKeySet>,
    ArmAsyncOperationHeader
  >;

  @doc("Patch properties of bare metal machine key set for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.")
  update is ArmCustomPatchAsync<
    BareMetalMachineKeySet,
    BareMetalMachineKeySetPatchParameters,
    BaseParameters<BareMetalMachineKeySet>,
    ArmAsyncOperationHeader
  >;

  @doc("Delete the bare metal machine key set of the provided cluster.")
  delete is ArmResourceDeleteAsync<
    BareMetalMachineKeySet,
    BaseParameters<BareMetalMachineKeySet>,
    ArmLroLocationHeader
  >;

  @doc("Get a list of bare metal machine key sets for the provided cluster.")
  listByCluster is ArmResourceListByParent<BareMetalMachineKeySet>;
}

@@projectedName(BareMetalMachineKeySets.createOrUpdate::parameters.resource,
  "json",
  "bareMetalMachineKeySetParameters"
);
@@extension(BareMetalMachineKeySets.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "bareMetalMachineKeySetParameters"
);
@@doc(BareMetalMachineKeySets.createOrUpdate::parameters.resource,
  "The request body."
);
@@projectedName(BareMetalMachineKeySets.update::parameters.properties,
  "json",
  "bareMetalMachineKeySetUpdateParameters"
);
@@extension(BareMetalMachineKeySets.update::parameters.properties,
  "x-ms-client-name",
  "bareMetalMachineKeySetUpdateParameters"
);
@@doc(BareMetalMachineKeySets.update::parameters.properties,
  "The request body."
);
